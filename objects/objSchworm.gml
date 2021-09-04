#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
/// A machine that makes worms
event_inherited();

respawn = true;

healthpointsStart = 5;
healthpoints = healthpointsStart;
contactDamage = 2;
category = "grounded";

// Enemy specific code
actionTimer = 0;
shooting = false;

enemy[1] = 0;
enemy[2] = 0;
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();

if (entityCanStep())
{
    for (i = 1; i <= 2; i += 1)
    {
        if (enemy[i])
        {
            if (!instance_exists(enemy[i]))
            {
                enemy[i] = 0;
            }
        }
        else if (!shooting)
        {
            shooting = true;
            image_index = 0;
        }
    }
    if (shooting)
    {
        animTimer = -1;
        actionTimer += 1;
        if (actionTimer == 8 && image_index < 3)
        {
            actionTimer = 0;
            image_index += 1;
        }
        if (actionTimer == 9)
        {
            if (enemy[1])
            {
                i = 2;
            }
            else
            {
                i = 1;
            }
            enemy[i] = instance_create(x + 8, bbox_bottom - 1, objSchwormWorm);
            enemy[i].yspeed = -4.5;
            image_index = 0;
        }
        if (actionTimer == 40)
        {
            shooting = false;
            actionTimer = 0;
        }
    }
}
else if (dead)
{
    image_index = 0;
    shooting = false;
    actionTimer = 0;
}
