#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();

healthpointsStart = 8;
healthpoints = healthpointsStart;
contactDamage = 6;

category = "semi bulky";

facePlayerOnSpawn = true;

// Enemy specific code
calibrated = 0;
delay = 0;

actionTimer = 0;
action = 1;
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
                if (actionTimer == 64 + delay)
                {
                    action += 1;
                    actionTimer = 0;
                    image_index += 1;
                    delay = choose(0, 0, 0, 16, 16, 32);
                }
                break;
            case 2:
                if (actionTimer == 8)
                {
                    action += 1;
                    actionTimer = 0;
                    image_index += 1;
                }
                break;
            case 3:
                if (actionTimer == 8)
                {
                    action += 1;
                    actionTimer = 0;
                    image_index -= 1;
                }
                break;
            case 4:
                if (actionTimer == 8)
                {
                    action += 1;
                    actionTimer = 0;
                    image_index -= 1;
                }
                break;
            case 5:
                if (actionTimer == 24)
                {
                    action += 1;
                    actionTimer = 0;
                    image_index += choose(3, 4, 5, 6);
                }
                break;
            case 6:
                if (actionTimer == 16)
                {
                    action += 1;
                    actionTimer = 0;
                    i = instance_create(x + 3 * image_xscale,
                        y - 11 + (image_index - 6) * 16, objEnemyBullet);
                    i.sprite_index = sprTotemPolenProjectile;
                    i.xspeed = image_xscale * 2;
                    i.contactDamage = 2;
                }
                break;
            case 7:
                if (actionTimer == 8)
                {
                    action = 0;
                    actionTimer = 0;
                    image_index = 0;
                }
                break;
        }
        if (image_index == 0)
        {
            if (instance_exists(target))
            {
                with (target)
                {
                    if (bboxGetXCenter() > other.bbox_left
                        && bboxGetXCenter() < other.bbox_right)
                    {
                        other.yspeed = -5.5;
                        other.actionTimer = 0;
                        other.action = 0;
                    }
                }
            }
        }
    }

    if (action == 0)
    {
        if (ground)
        {
            action = 1;
        }
    }
}
else if (dead)
{
    actionTimer = 0;
    action = 1;

    image_index = 0;
}
