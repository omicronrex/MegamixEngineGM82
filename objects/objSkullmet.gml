#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();

healthpointsStart = 3;
healthpoints = healthpointsStart;
contactDamage = 6;

category = "shielded";

// Enemy specific code
actionTimer = 0;
action = 1;
phase = 5;
triggered = 0;
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
        switch (action)
        {
            case 1:
                if (actionTimer == 6)
                {
                    action += 1;
                    actionTimer = 0;
                    image_index += 1;
                    if (!triggered && phase == 5)
                    {
                        if (instance_exists(target))
                        {
                            if ((image_xscale == 1 && target.x > x)
                                || (image_xscale == -1 && target.x < x))
                            {
                                triggered = 1;
                            }
                        }
                    }
                    if (triggered || phase < 5)
                    {
                        phase += 0.5;
                    }
                    switch (phase)
                    {
                        case 5.5:
                            action -= 1;
                            break;
                        case 6:
                            image_index += 1;
                            break;
                        case 7:
                            image_index -= 2;
                            break;
                        case 8:
                            image_index += 2;
                            break;
                        case 9:
                            image_index -= 2;
                            break;
                        case 10:
                            image_index += 4;
                            break;
                        case 11:
                            image_index -= 4;
                            break;
                    }
                }
                break;
            case 2:
                if (actionTimer == 6)
                {
                    action -= 1;
                    actionTimer = 0;
                    image_index -= 1;
                    if (triggered || phase < 5)
                    {
                        phase += 0.5;
                    }
                    if (phase == 10.5)
                    {
                        i = instance_create(x + 12 * image_xscale, y - 28,
                            objEnemyBullet);
                        i.sprite_index = sprEnemyBullet;
                        i.image_speed = 0;
                        i.contactDamage = 3;
                        i.xspeed = 2 * image_xscale;
                        if (instance_exists(target))
                        {
                            i.yspeed = -abs((target.x - x) / 20 + 1);
                        }
                        else
                        {
                            i.yspeed = -3;
                        }
                        i.grav = 0.25;
                        i.image_xscale = image_xscale;
                    }
                    if (phase == 11.5)
                    {
                        phase = 0;
                        image_index = 0;
                        action = 1;
                        triggered = 0;
                    }
                }
                break;
        }
    }
}
else if (dead)
{
    actionTimer = 0;
    action = 1;
    phase = 5;
    triggered = 0;
    image_index = 0;
}
#define Other_21
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if (collision_rectangle(x - 16 * image_xscale, y - 29, x, y + 1, other.id,
    false, false))
{
    other.guardCancel = 1;
}
