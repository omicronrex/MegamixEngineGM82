#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();

calibrateDirection();

blockCollision = 0;

contactDamage = 2;


yspeed = -6;

if (instance_exists(target))
{
    xspeed = xSpeedAim(x, y, target.x, target.y, yspeed, grav);
}
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();

if (entityCanStep())
{
    image_speed = 1 / 6;
}
else
    image_speed = 0;
