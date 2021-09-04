#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();



contactDamage = 3;

var spd;
spd = 2;
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
