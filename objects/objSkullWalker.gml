#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();

healthpointsStart = 2;
healthpoints = healthpointsStart;
contactDamage = 2;

category = "semi bulky";

grav = 0.2;

facePlayerOnSpawn = true;

// Enemy specific code
phase = 0;
waitTimer = 0;

spd = 1.7;

animBack = false;
imgSpd = 0.2;
imgIndex = 0;
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
    switch (phase)
    {
        // wait
        case 0:
            waitTimer += 1;
            if (waitTimer >= 10)
            {
                waitTimer = 0;
                phase = 1;
            }
            break;

        // look around
        case 1:
            if (!animBack)
            {
                imgIndex += imgSpd * 0.7;
                if (imgIndex >= 3)
                {
                    imgIndex = 2 - imgIndex mod 3;
                    animBack = true;
                }
            }
            else
            {
                imgIndex -= imgSpd;
                if (imgIndex < 0)
                {
                    phase = 2;
                    imgIndex = 3;
                    animBack = false;
                    calibrateDirection();
                    xspeed = image_xscale; // so it doesn't trigger phase 4 when it starts
                }
            }
            break;

        // run around
        case 2: // animation
            if (!animBack)
            {
                imgIndex += imgSpd;
                if (imgIndex >= 6)
                {
                    imgIndex = 5 - imgIndex mod 6;
                    animBack = true;
                }
            }
            else
            {
                imgIndex -= imgSpd;
                if (imgIndex < 3)
                {
                    imgIndex = 4;
                    animBack = false;
                }
            }

            // detection
            if (ground&&xspeed == 0 || checkSolid(sprite_width / 2, 0, 1, 1))
            {
                // jump
                phase = 3;
                yspeed = -3.8; // <-- jump speed here
                imgIndex = 6;
                animBack = false;
            }
            else if (instance_exists(target))
            {
                // turn around
                if (abs(x - target.x) > 40)
                {
                    calibrateDirection();
                }
            }
            xspeed = spd * image_xscale;
            break;

        // jump
        case 3:
            if (ground)
            {
                xspeed = 0;

                // I used wait timer as a boolean    :P
                if (waitTimer == 0)
                {
                    waitTimer = 1;
                    playSFX(sfxClamp);
                }
                imgIndex += imgSpd;
                if (imgIndex >= 8)
                {
                    phase = 0;
                    imgIndex = 0;
                }
            }
            else
            {
                xspeed = spd * image_xscale;
            }
            break;
    }
}
else if (dead)
{
    phase = 0;
    waitTimer = 0;
    xspeed = 0;
    yspeed = 0;
    animBack = false;
    imgIndex = 0;
}

image_index = imgIndex div 1;
