#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();

healthpointsStart = 2;
healthpoints = healthpointsStart;
contactDamage = 3;

category = "cluster, flying, nature";

blockCollision = 0;
grav = 0;

// Enemy specific code
action = 1;
actionTimer = 0;
animTimer = 0;
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();

if (entityCanStep())
{
    switch (action)
    {
        case 1:
            if (image_index > 0 || actionTimer > 0 || instance_exists(target))
            {
                actionTimer += 1;
            }
            if (image_index == 0)
            {
                if (actionTimer == 128)
                {
                    image_index += 1;
                    actionTimer = 0;
                }
            }
            else
            {
                if (actionTimer == 6)
                {
                    image_index += 1;
                    actionTimer = 0;
                }
            }
            if (image_index == 3)
            {
                action = 2;
                y += 3;
            }
            break;
        case 2:
            if (actionTimer == 0 && instance_exists(target))
            {
                yspeed = 0;
                move_towards_point(target.x, target.y + 8, 0.5);
            }
            actionTimer += 1;
            if (actionTimer > 128)
            {
                actionTimer = 0;
            }
            if (place_meeting(x, y, target))
            {
                if (!target.canHit)
                {
                    action = 3;
                    actionTimer = 0;
                    yspeed = -2;
                    speed = 0;
                }
            }
            break;
        case 3:
            if (!checkSolid(0, 0))
            {
                blockCollision = 1;
            }
            if (yspeed == 0)
            {
                image_index = 2;
                action = 4;
                blockCollision = 0;
            }
            break;
        case 4:
            actionTimer += 1;
            if (actionTimer == 6)
            {
                image_index -= 1;
                actionTimer = 0;
                if (image_index == 0)
                {
                    action = 1;
                    actionTimer = 64;
                }
            }
            break;
    }

    if (action == 2 || action == 3)
    {
        animTimer += 1;
        if (animTimer == 6)
        {
            animTimer = 0;
            image_index += 1;
            if (image_index == 7)
            {
                image_index = 3;
            }
        }
    }
}
else if (dead)
{
    action = 1;
    actionTimer = 0;
    image_index = 0;
    animTimer = 0;
    blockCollision = 0;
}
#define Other_21
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if (image_index == 0)
{
    other.guardCancel = 1;
}
