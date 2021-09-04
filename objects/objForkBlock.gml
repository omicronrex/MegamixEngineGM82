#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();

isSolid = 1;

canHit = false;
bubbleTimer = -1;

healthpointsStart = 1;
healthpoints = healthpointsStart;
contactDamage = 4;

grav = 0;

// Enemy specific code
action = 1;
actionTimer = 0;

init = 1;
dir = 1;
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if (init)
{
    if (dir == -1)
    {
        image_index = 3;
        actionTimer = 25;
    }
    init = 0;
}

event_inherited();

if (!global.frozen && !dead && !global.timeStopped)
{
    actionTimer += 1;
    iaction = action;
    switch (action)
    {
        case 1: // wait
            if (actionTimer == 100)
            {
                action += 1;
            }
            break;
        case 2:
        case 4:
        case 6:
        case 8: // Blink
            if (actionTimer == 5)
            {
                action += 1;
                image_index += 1;
            }
            break;
        case 3:
        case 5:
        case 7: // Blink off
            if (actionTimer == 5)
            {
                action += 1;
                image_index -= 1;
            }
            break;
        case 9: // Retract
            if (actionTimer == 5)
            {
                action += 1;
                image_index += 1;
            }
            break;
        case 10: // Detract
            if (actionTimer == 10)
            {
                action += 1;
                if (image_index == 2)
                {
                    image_index += 3;
                }
                else
                {
                    image_index -= 3;
                }
            }
            break;
        case 11: // Full out
            if (actionTimer == 10)
            {
                action = 1;
                image_index -= 2;
            }
            break;
    }

    if (action != iaction)
    {
        actionTimer = 0;
    }

    var bx = 0;
    var by = 0;
    if (image_index == 0 || image_index == 1)
    {
        bx = 6;
    }
    else if (image_index == 3 || image_index == 5)
    {
        by = 6;
    }

    if (bx != 0 || by != 0)
    {
        with (objMegaman)
        {
            with (other)
            {
                if (collision_rectangle(x - bx, y - by, x + 15 + bx, y + 15 + by, other.id, false, true))
                {
                    if (other.iFrames == 0 && other.canHit)
                    {
                        entityEntityCollision();
                    }
                }
            }
        }
    }
}
else if (dead)
{
    action = 1;
    if (dir == -1)
    {
        image_index = 3;
        actionTimer = 25;
    }
    else
    {
        image_index = 0;
        actionTimer = 0;
    }
}
