#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();

contactDamage = 3;
grav = 0;
blockCollision = false;

respawnRange = 0;
despawnRange = 0;

stopOnFlash = false;

spd = 3;

image_speed = 0;
strMMX = 0;

attackTimer = 0;
hasFired = false;

aimAtTarget(spd);
image_xscale = sign(xspeed);
if (instance_exists(target))
{
    moveToY = target.y;
}
else
    moveToY = y - 16;
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
        strMMX = target.x;
    }

    if (!hasFired && ((xspeed > 0 && x >= strMMX + 32 /* 8 */ || xspeed < 0 && x <= strMMX - 32 /* 8 */ ) ||
        (xspeed == 0 && (yspeed > 0 && y >= moveToY + 8 || yspeed < 0 && y <= moveToY - 8))))
    {
        xspeed = 0;
        yspeed = 0;
        image_index = 1;
    }

    if (image_index == 1)
    {
        attackTimer+=1;
    }

    if (attackTimer == 10 && xspeed == 0)
    {
        image_index = 0;
        aimAtTarget(spd);
        image_xscale = sign(xspeed);
        hasFired = true;
    }
}
