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
shoottimer = 0;
crab[1] = 0;
crab[2] = 0;
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
 event_inherited();

if (!dead)
{
    x = view_xview[0] + 16;
    y = view_yview[0] + 16;
}

if (entityCanStep())
{
    if (instance_exists(target))
    {
        shoottimer -= 1;
        if (shoottimer == 0)
        {
            i = instance_create(target.x, view_yview[0] + 8, objClaw);
            i.respawn = 0;
            if (crab[1] == 0)
            {
                crab[1] = i;
                crab[1].x -= 32;
            }
            else if (crab[2] == 0)
            {
                crab[2] = i;
                crab[2].x += 48;
            }
        }
        if (shoottimer <= 0)
        {
            if (crab[1] != 0)
            {
                if (!instance_exists(crab[1]))
                {
                    crab[1] = 0;
                    shoottimer = 60;
                }
            }
            else
            {
                shoottimer = 60;
            }
            if (crab[2] != 0)
            {
                if (!instance_exists(crab[2]))
                {
                    crab[2] = 0;
                    shoottimer = 60;
                }
            }
            else
            {
                shoottimer = 60;
            }
        }
    }
}

visible = 0;
#define Other_21
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
other.guardCancel = 2;
