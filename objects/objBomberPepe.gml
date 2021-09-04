#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
/// A penguin that attacks by launching explosive eggs
event_inherited();

calibrateDirection();

healthpointsStart = 6;
healthpoints = healthpointsStart;
contactDamage = 6;

category = "semi bulky, nature, bird";

facePlayerOnSpawn = true;

// enemy specific
imgSpd = 0.2;
imgIndex = 0;
jumpWait = 40;
jumpWaitTimer = jumpWait;
shootWaitTimer = 0;
event_user(0); // set jumpWaitTimer to a random number within a range

xspeed = 0;
yspeed = 0;
xs = 0;
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();

if (entityCanStep())
{
    // face player when first coming on screen
    if (jumpWaitTimer == jumpWait)
    {
        calibrateDirection();
    }

    // movement
    if (jumpWaitTimer > 0)
    {
        // waiting to jump
        jumpWaitTimer -= 1;
    }
    else
    {
        // jumping
        if (jumpWaitTimer == 0)
        {
            // start jump
            jumpWaitTimer = -1; // I reused waitTimer as a boolean  xP
            calibrateDirection();
            xspeed = 1 * image_xscale;
            xs = xspeed;
            yspeed = -3.5; // <-- jump height
            imgIndex = 1;
        }
        else if (ground)
        {
            // landing
            if (jumpWaitTimer == -1)
            {
                jumpWaitTimer = -2; // I reused it as a boolean again
                xspeed = 0;
                yspeed = 0;
                xs = 0;
                imgIndex = 2;
            }
            imgIndex += imgSpd;
            if (imgIndex >= 3)
            {
                jumpWaitTimer = jumpWait;
                imgIndex = 0;
            }
        }
    }

    if (xs != 0)
    {
        xspeed = xs;
    }

    // shooting (completely independent from jumping)
    if (shootWaitTimer > 0)
    {
        shootWaitTimer -= 1;
    }
    else
    {
        instance_create(x, y, objBomberPepeEgg);
        event_user(0); // set shootWaitTimer to a random number within a range
    }
}
else if (dead)
{
    imgIndex = 0;
    jumpWaitTimer = jumpWait;
    event_user(0); // set shootWaitTimer to a random time within a range
    xs = 0;
}

image_index = imgIndex div 1;
#define Other_10
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=605
invert=0
arg0=get random time to wait until shooting an egg
*/
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
shootWaitTimer = random_range(30, 140);
