#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
// A robot tanuki that fires large spheres from a hatch down below. Obvious joke is obvious.

event_inherited();

healthpointsStart = 4;
healthpoints = healthpointsStart;
contactDamage = 4;

category = "semi bulky, nature";

facePlayerOnSpawn = true;

// Enemy specific code
phase = 0;
shootWait = 128;
shootTimer = 100;
startFacingPlayer = true;

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

if (entityCanStep())
{
    if (instance_exists(target))
    {
        if (shootTimer == shootWait)
        {
            calibrateDirection();
            shootTimer += 1;
        }
        else if (shootTimer < shootWait)
        {
            shootTimer += 1;
        }
        else
        {
            if (!animBack)
            {
                imgIndex += imgSpd;
                if (imgIndex >= 3)
                {
                    imgIndex = 2 - imgIndex mod 3;
                    animBack = true;
                    a = instance_create(x + sprite_width * 0.3, y + 8, objShigarakyBall);
                    a.xspeed = image_xscale;
                    a.image_xscale = image_xscale;
                }
            }
            else
            {
                imgIndex -= imgSpd;
                if (imgIndex < 1)
                {
                    imgIndex = 0;
                    animBack = false;
                    shootTimer = 0;
                }
            }
        }
    }
}
else if (dead)
{
    shootTimer = 100;
    animBack = false;
    imgIndex = 0;
}

image_index = imgIndex div 1;
