#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();

healthpointsStart = 1;
healthpoints = healthpointsStart;
contactDamage = 4;

category = "flying";

grav = 0;
blockCollision = 0;

facePlayerOnSpawn = true;

// Enemy specific code
ground = 1;
hovering = 1;

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
        iaction = action;
        actionTimer += 1;
        switch (action)
        {
            case 1:
                if (!(actionTimer mod 4))
                {
                    if (image_index == 0)
                    {
                        image_index = 1;
                    }
                    else
                    {
                        image_index = 0;
                    }
                }
                if (hovering)
                {
                    if (instance_exists(target))
                    {
                        correctDirection(point_direction(bboxGetXCenter(),
                            bboxGetYCenter(),
                            bboxGetXCenterObject(target),
                            bboxGetYCenterObject(target)),
                            2); // Speed at which it changes it's angle
                    }
                    speed = 0.75;
                    if (actionTimer >= 200)
                    {
                        if (!checkSolid(0, 0))
                        {
                            hovering = 0;
                            grav = 0.25;
                            blockCollision = 1;
                            speed = 0;
                        }
                    }
                }
                break;
            case 2:
                if (actionTimer == 6)
                {
                    action += 1;
                    image_index = 3;
                }
                break;
            case 3:
                if (actionTimer == 6)
                {
                    action += 1;
                    image_index = 4;
                }
                break;
            case 4:
                if (actionTimer == 6)
                {
                    action += 1;
                    image_index = 5;
                }
                break;
            case 5:
                if (actionTimer == 6)
                {
                    action += 1;
                    image_index = 6;
                }
                break;
            case 6:
                if (actionTimer == 6)
                {
                    action += 1;
                    image_index = 7;
                }
                break;
            case 7:
                if (actionTimer == 40)
                {
                    action += 1;
                    image_index = 8;
                }
                break;
            case 8:
                if (actionTimer == 5)
                {
                    action += 1;
                    image_index = 9;
                }
                break;
            case 9:
                if (actionTimer == 5)
                {
                    action += 1;
                    image_index = 10;
                }
                break;
            case 10:
                if (actionTimer == 8)
                {
                    action += 1;
                    i = instance_create(x + 5 * image_xscale, bbox_top + 1,
                        objEnemyBullet);
                    i.xspeed = image_xscale * 2;
                    i.contactDamage = 2;
                }
                break;
            case 11:
                if (actionTimer == 8)
                {
                    action += 1;
                    image_index = 9;
                }
                break;
            case 12:
                if (actionTimer == 5)
                {
                    action += 1;
                    image_index = 8;
                }
                break;
            case 13:
                if (actionTimer == 5)
                {
                    action = 7;
                    image_index = 7;
                }
                break;
        }
        if (action != iaction)
        {
            actionTimer = 0;
        }
    }

    if (image_index >= 7)
    {
        facePlayer = true;
    }
    else
    {
        facePlayer = false;
    }

    if (!hovering)
    {
        if (action == 1)
        {
            if (ground && yspeed == 0)
            {
                image_index = 2;
                action = 2;
                actionTimer = 0;
            }
        }
    }
}
else if (dead)
{
    direction = 60;
    if (image_xscale == -1)
    {
        direction += 60;
    }

    actionTimer = 0;
    action = 1;

    grav = 0;
    blockCollision = 0;
    hovering = 1;
    image_index = 0;
    speed = 0;
}
#define Other_25
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
// spawn event
event_inherited();

if (spawned)
{
    direction = 60;
    if (image_xscale == -1)
    {
        direction += 60;
    }
}
