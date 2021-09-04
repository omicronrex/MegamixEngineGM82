#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();

healthpoints = 999;
contactDamage = 1;

isTargetable = false;

blockCollision = 0;
grav = 0;

image_index = 2;
yspeed = -3;
#define Collision_objBlocky
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if (y < other.y)
{
    other.catchTimes += 1;
    instance_destroy();
}
#define Other_21
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=other
*/
other.guardCancel = 3;
