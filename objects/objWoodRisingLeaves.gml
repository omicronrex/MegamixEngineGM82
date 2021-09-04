#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();

blockCollision = 0;
grav = 0;

contactDamage = 4;

xspeed = 0;
yspeed = -3.5;
image_speed = 0;
stopOnFlash = true;

reflectable = 0;
if (other.image_xscale > 0)
{
    image_index = 0;
}
else if (other.image_xscale < 0)
{
    image_index = 3;
}
