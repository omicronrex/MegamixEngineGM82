#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
// Creation code (all optional):

event_inherited();

healthpointsStart = 3;
healthpoints = healthpointsStart;
contactDamage = 0;

blockCollision = 0;
grav = 0;

respawn = true;

// Enemy specific code
delay = 256;
shoottimer = delay / 4;
col = 0; // 0 is Red; 1 is Blue
image_speed = 0;
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();

if (entityCanStep())
{
    shoottimer -= 1;
    if (shoottimer <= 0)
    {
        var tel; tel = instance_number(objTellyXSpawner);
        if (tel < 3)
        {
            tel = 3;
        }
        if (instance_number(objTellyX) < tel)
        {
            i = instance_create(x, y, objTellyX);
            i.respawn = 0;
            i.col = col;
        }
        shoottimer = delay;
    }
}

canHit = false;
#define Draw_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
// No
