#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();

blockCollision = 0;

respawn = false;

healthpointsStart = 1;
healthpoints = healthpointsStart;
contactDamage = 4;

col = 0;
dead = false;

yspeed = -6.5;

if (instance_exists(target))
{
    xspeed = xSpeedAim(x, y, target.x, target.y, yspeed, grav);
}

explod = false;
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();
image_index = col;
