#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();

respawn = false;

contactDamage = 4;
blockCollision = false;

grav = 0;
#define Other_21
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if (other.object_index == objTornadoBlow)
{
    other.guardCancel = 0;
}
else
{
    other.guardCancel = 2;
}
