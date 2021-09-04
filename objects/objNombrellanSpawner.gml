#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
// Creation code (all optional):

event_inherited();

respawn = true;

blockCollision = 0;
grav = 0;

healthpointsStart = 99;
healthpoints = healthpointsStart;
contactDamage = 0;
canHit = false;

i = noone;

// Enemy specific code
delay = 30;

shoottimer = -1;
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();

if (entityCanStep())
{
    if (shoottimer == -1)
    {
        shoottimer = delay;
        y = view_yview[0];
    }

    if (!instance_exists(i))
    {
        shoottimer -= 1;
        if (shoottimer <= 0)
        {
            i = instance_create(x, y, objNombrellan);
            i.respawn = 0;
            shoottimer = delay;
        }
    }
}
else if (dead)
{
    shoottimer = 0;
}
#define Draw_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
// No
