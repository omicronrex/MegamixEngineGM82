#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();
blockCollision = 1;
grav = 0;
stopOnFlash = false;
contactDamage = 3;
var spd;
spd = 4;
if (instance_exists(target))
{
    var angle;
    angle = point_direction(spriteGetXCenter(), spriteGetYCenter(),
        spriteGetXCenterObject(target),
        spriteGetYCenterObject(target));
    xspeed = cos(degtorad(angle)) * spd;
    yspeed = -sin(degtorad(angle)) * spd;
}
else
{
    xspeed = spd;
    yspeed = 0;
}
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();
if (!global.frozen)
{
    if (xcoll != 0)
        grav = 0.35;
    if (ground)
    {
        instance_create(x, y + 6, objOilManPuddle);
        instance_destroy();
    }
}
