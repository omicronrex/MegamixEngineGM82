#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();

sprite_index = sprMinoanMount;

image_xscale = -1;
dir = 1;

respawn = true;

healthpointsStart = 1;
healthpoints = healthpointsStart;
contactDamage = 4;
category = "nature, shielded";

// Enemy specific code
xspeed = 0;
yspeed = 0;
grav = 0;
minoanID = -20;
canCreateMinoan = true;
prevDead = false;
image_speed = 7 / 60;
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();

if (entityCanStep())
{
    image_speed = (7 / 60);

    if (canCreateMinoan == true)
    {
        if (minoanID == -20 || !instance_exists(minoanID))
        {
            canCreateMinoan = false;
            minoanID = instance_create(x, y + 15, objMinoanFan);
            minoanID.mountID = id;
        }
    }
}
else
{
    image_speed = 0;
    if (dead == true)
    {
        image_index = 0;
        canCreateMinoan = true;

        if (prevDead == false && insideView())
        {
            if (minoanID != -20 && instance_exists(minoanID))
                minoanID.phase = 1;
        }
    }
}

prevDead = dead;
