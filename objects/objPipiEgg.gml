#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();

healthpointsStart = 1;
healthpoints = healthpointsStart;
contactDamage = 4;

yspeed = -1;
xspeed = 0;
col = 0;

respawn = false;
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();

if (entityCanStep())
{
    if (ground)
    {
        instance_destroy();
        repeat (8)
        {
            var ID = instance_create(x, y, objCopipi);
            ID.col = col;
        }
    }
}
