#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();

blockCollision = false;
canHit = false;
respawn = false;
contactDamage = 3;
grav = 0;

parent = noone;
waitTimer = 10;
#define Destroy_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if (instance_exists(objTKhamen))
{
    objTKhamen.selectTime = 60;
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
    waitTimer--;

    if (waitTimer <= 0)
    {
        grav = 0.25;
    }
}
else if (dead)
{
    if (instance_exists(objTKhamen))
        objTKhamen.selectTime = 60;
}
