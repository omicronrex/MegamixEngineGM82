#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
/// A walking grenade that can jump over obstacles
event_inherited();

calibrateDirection();

healthpointsStart = 1;
healthpoints = healthpointsStart;
contactDamage = 3;

category = "grounded";

facePlayerOnSpawn = true;

// Enemy specific code
animTimer = 0;
jumpTimes = 0;
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
    if (ground)
    {
        animTimer += 1;
        if (animTimer == 5)
        {
            animTimer = 0;
            if (image_index == 1)
            {
                image_index = 0;
            }
            else
            {
                image_index = 1;
            }
        }
    }
    else
    {
        image_index = 2;
    }

    if (collision_rectangle(x - 20, y - 12, x + 20, y - 12, objSolid, false, true)
        && yspeed == 0 && ground)
    {
        jumpTimes += 1;
        yspeed = -4;
        xspeed = 0;
    }
    else
    {
        xspeed = 1.25 * image_xscale;
    }

    if (ground && jumpTimes >= 4)
    {
        calibrateDirection();
        jumpTimes = 0;
    }
}
else if (dead)
{
    animTimer = 0;
    jumpTimes = 0;
    image_index = 0;
}
#define Other_20
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
dead = 1;

instance_create(bboxGetXCenter(), bboxGetYCenter(), objHarmfulExplosion);
playSFX(sfxMM3Explode);
