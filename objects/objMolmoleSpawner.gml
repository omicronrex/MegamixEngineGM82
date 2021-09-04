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
molelimit = 8;
for (i = 1; i <= molelimit; i += 1)
{
    mole[i] = 0;
}
yscale = 1;

preyy = 0;
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
            xx = target.x + choose(1, -1) * irandom_range(20, 64);
            yy = 0;
            while (preyy == yy || yy == 0)
            {
                yy = (view_yview[0] + view_hview * 0.5) + yscale
                    * (view_hview * 0.5 + 6);
            }
            preyy = yy;
            m = instance_create(xx, yy, objMolmole);
            m.respawn = 0;
            yscale *= -1;
            for (i = 1; i <= molelimit; i += 1)
            {
                if (mole[i] == 0)
                {
                    mole[i] = m;
                    break;
                }
            }
        }
        if (shoottimer <= 0)
        {
            for (i = 1; i <= molelimit; i += 1)
            {
                if (mole[i] != 0)
                {
                    if (!instance_exists(mole[i]))
                    {
                        mole[i] = 0;
                        shoottimer = 10;
                        break;
                    }
                }
                else
                {
                    shoottimer = 10;
                    break;
                }
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
#define Draw_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
// No
