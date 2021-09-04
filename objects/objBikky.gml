#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
/// A large hopping press robot, the equivalent of a big eye in Megaman 3
event_inherited();

healthpointsStart = 6;
healthpoints = healthpointsStart;
contactDamage = 8;

category = "big eye, bulky, shielded";

facePlayerOnSpawn = true;

// enemy specific
imgSpd = 0.1;
imgIndex = 0;
waitTime = 50;
waitTimer = waitTime;
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();
if(xcoll!=0)
{
    xspeed=xcoll;
}

if (entityCanStep())
{
    // face player when first coming on screen
    if (waitTimer == waitTime)
    {
        calibrateDirection();
    }

    if (waitTimer > 0)
    {
        // waiting to jump
        waitTimer -= 1;
        imgIndex += imgSpd;
        if (imgIndex >= 2)
        {
            imgIndex = imgIndex mod 1;
        }
    }
    else
    {
        // jumping
        if (waitTimer == 0)
        {
            // jumping animation
            if (imgIndex < 2)
            {
                imgIndex = 2;
            }

            if (imgIndex < 3)
            {
                // don't loop animation
                imgIndex += imgSpd;
            }
            else
            {
                // start jump
                waitTimer = -1; // I reused waitTimer as a boolean  xP
                calibrateDirection();
                xspeed = 1 * image_xscale;
                yspeed = -4.5;
                imgIndex = 3;
                ground = false;
            }
        }
        else if (ground)
        {
            // landing
            if (waitTimer == -1)
            {
                waitTimer = -2; // I reused it as a boolean again
                xspeed = 0;
                yspeed = 0;
                imgIndex = 3;
                playSFX(sfxBikkyLand);
            }

            imgIndex -= imgSpd * 2; // he closes faster than he opens

            if (imgIndex <= 1)
            {
                waitTimer = waitTime;
                imgIndex = 0;
            }
        }
    }
}
else if (dead)
{
    imgIndex = 0;
    waitTimer = waitTime;
}

image_index = imgIndex div 1;
#define Other_21
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if (round(image_index) != 3)
{
    other.guardCancel = 1;
}
