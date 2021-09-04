#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
// An enemy from Burst Man's stage. It'll float up and down in the water, or flop around otherwise.

// Creation code (all optional):

event_inherited();

healthpointsStart = 1;
healthpoints = healthpointsStart;
contactDamage = 2;

category = "aquatic, nature";

blockCollision = 0;
grav = 0;

facePlayerOnSpawn = true;

// Enemy specific code
sinCounter = 0;

animTimer = 0;
blinkTimer = 0;

outtaWaterTimer = 0;

image_speed = 0;
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();

if (entityCanStep())
{
    if (inWater)
    {
        blockCollision = 0;
        grav = 0;

        // wave movement
        sinCounter += .045;
        yspeed = (sin(sinCounter));

        // fish tail animation
        animTimer++;

        if (animTimer mod 8 == 0)
        {
            image_index += 1;
            if (image_index > 7 + ((blinkTimer > 110) * 8))
            {
                image_index -= 8;
            }
        }

        // blinking
        blinkTimer++;

        if (blinkTimer == 110)
        {
            image_index += 8;
        }

        if (blinkTimer == 120)
        {
            image_index -= 8;
            blinkTimer = 0;
        }

        // for some reason, it turns back after travelling a full screen, and never turns back afterwards.
        // mm7.....
        if (abs(x - xstart) > (view_wview[0] - 32))
        {
            x -= xspeed;
            xspeed = -xspeed;
            image_xscale = -image_xscale;
        }
    }
    else
    {
        blockCollision = 1;

        // force into flopping animation
        if (image_index < 16)
        {
            image_index = 16;
            xspeed = 0;
            yspeed = 0;
            grav = gravAccel;
        }

        // flop anim
        animTimer++;

        if (animTimer mod 6 == 0)
        {
            if (image_index == 17)
            {
                image_index = 16;
            }
            else
            {
                image_index = 17;
            }
        }

        // it dies if its outside water for too long
        outtaWaterTimer++;

        if (outtaWaterTimer >= 360)
        {
            playSFX(sfxEnemyHit);
            healthpoints = 0;
            event_user(EV_DEATH);
        }

        // jump on ground/water
        if (ycoll > 0 || place_meeting(x, y - 1, objWater))
        {
            playSFX(sfxSplash);
            yspeed = choose(-4.5, -3.5);

            // sometimes it flips
            if (irandom_range(1, 2) == 1)
            {
                image_xscale = -image_xscale;
            }
        }
    }
}
#define Other_25
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();

image_index = 0;
grav = 0;
if (inWater)
{
    xspeed = image_xscale;
}
sinCounter = 0;

animTimer = 0;
blinkTimer = 0;

outtaWaterTimer = 0;
