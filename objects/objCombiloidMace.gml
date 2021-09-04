#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();

respawn = true;

healthpointsStart = 999;
healthpoints = healthpointsStart;
contactDamage = 4;

isTargetable = false;

blockCollision = 1;
grav = 0;
image_speed = 0;
image_index = 0;

facePlayerOnSpawn = false;

// Enemy specific code
attackTimer = 0;
attackTimerMax = 4;
shotsFired = 0;
strMMX = -1;
spd = 0;
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();
if (entityCanStep())
{
    if(ycoll!=0)
    {
        yspeed=ycoll;
    }
    if(xcoll!=0)
    {
        xspeed=xcoll;
    }
    if (instance_exists(parent))
    {
        attackTimer++;
        if (instance_exists(target))
        {
            strMMX = target.x;
        }

        if (image_index < 2)
        {
            image_index += 0.25;
            attackTimer = 0;
        }
        else
        {
            if (attackTimer >= 40 && shotsFired == 0)
            {
                shotsFired = 1;
                spd = clamp((strMMX - x) / 8, -4, 4);
                xspeed = spd;
                yspeed = 4 * image_yscale;
            }

            if (ycoll != 0 && shotsFired == 1)
            {
                aimAtPoint(4, parent.x, parent.y + 8 * parent.image_yscale);
                shotsFired = 2;
                playSFX(sfxLargeClamp);
            }
            if ((image_yscale == 1 && y <= parent.y + 8 * parent.image_yscale || image_yscale == -1 && y >= parent.y + 8 * parent.image_yscale)
                && ((sign(spd) == 1 && x <= parent.x || sign(spd) == -1 && x >= parent.x) || sign(spd) == 0) && shotsFired == 2)
            {
                with (parent)
                {
                    phase = 4;
                }
                event_user(EV_DEATH);
            }
        }
    }
    else
    {
        event_user(EV_DEATH);
    }
}
#define Other_20
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
playSFX(sfxExplosion2);
instance_create(x, y + 20, objBigExplosion);
instance_destroy();
#define Other_21
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
other.guardCancel = 3;
