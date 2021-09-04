#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
// Creation code (all optional):

event_inherited();

healthpointsStart = 1;
healthpoints = healthpointsStart;
contactDamage = 0;

blockCollision = 0;
grav = 0;

// Enemy specific code
canHit = 0;
dir = -1;

i = noone;

timer = 0;
delay = 64;

obj = objKillerBullet;
col = 0; // 0 = red; 1 = blue; 2 = orange
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();

if (entityCanStep())
{
    if (dir == -1)
    {
        x = view_xview + view_wview;
    }
    if (dir == 1)
    {
        x = view_xview;
    }

    if (!instance_exists(i))
    {
        timer++;
        if (timer >= delay)
        {
            i = instance_create(x, y, obj);
            i.respawn = 0;
            i.col = col;

            timer = 0;
        }
    }
}
else if (dead)
{
    timer = 0;
}
