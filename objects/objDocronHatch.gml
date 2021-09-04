#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
// Creation code (all optional):
// limit = <number> (the number of Docrons that can be on the screen at once before the hatch stops spawning more; -1 is an unlimited Docron buffet)

event_inherited();

healthpointsStart = 4;
healthpoints = healthpointsStart;
contactDamage = 4;

grav = 0;

// Enemy specific code
action = 1;
actionTimer = 195;
limit = 5;

inWater = -1;

// this is so it can be placed on the edge of a screen and not have tellies leak over.
despawnRange = 0;
respawnRange = 0;
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();

if (entityCanStep())
{
    if (action)
    {
        actionTimer += 1;
        if (image_index == 0)
        {
            if (actionTimer == 200 && ((instance_number(objDocron) <= limit) || limit == -1))
            {
                actionTimer = 0;
                image_index = 1;
                i = instance_create(x, y + 32, objDocron);
                i.sprite_index = sprDocronDropping;
                i.action = 0;
                i.respawn = 0;
            }
        }
        else if (image_index == 1)
        {
            if (actionTimer == 8)
            {
                actionTimer = 0;
                image_index = 0;
            }
        }
    }
}
else if (dead)
{
    actionTimer = 190;
    image_index = 0;
}
