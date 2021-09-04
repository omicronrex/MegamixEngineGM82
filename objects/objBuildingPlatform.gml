#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();
canHit = false;

grav = 0;
blockCollision = 0;
bubbleTimer = -1;

timer = 0;

for (i = 1; i <= 4; i += 1)
{
    block[i - 1] = noone;
}

wait = 600;
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();

if (!global.frozen && !dead && !global.timeStopped)
{
    timer += 1;
    for (i = 1; i <= 4; i += 1)
    {
        if (timer == 30 * i)
        {
            block[i - 1] = instance_create(x + ((((i - 1) mod 2)) * 16),
                y + floor((i - 1) / 2) * 16, objBuildingPlatformPiece);
            block[i - 1].image_index = i - 1;
        }
    }

    if (wait > 0)
    {
        visible = true;
    }

    for (i = 1; i <= 4; i += 1)
    {
        if (instance_exists(block[i - 1]))
        {
            if (block[i - 1].y > block[i - 1].ystart)
            {
                visible = false;
            }
        }
        else
        {
            visible = false;
        }
    }
    if (visible && wait >= 0)
    {
        if (image_index <= 7 && wait > 0)
        {
            image_index += 0.2;
        }
        if (wait > 0)
        {
            wait -= 1;
        }
        if (wait <= 0)
        {
            if (image_index > 3)
            {
                image_index = 3;
            }
            else if (image_index > 0.2)
            {
                image_index -= 0.2;
            }
            else
            {
                wait = -1;
            }
        }
    }
    else if (wait <= 0)
    {
        wait -= 1;
        for (i = 1; i <= 4; i += 1)
        {
            if (abs(wait) >= 30 * i && instance_exists(block[4 - i]))
            {
                block[4 - i].yspeed = 2;
                visible = false;
            }
        }
    }
}
else if (dead)
{
    timer = 0;
    image_index = 0;
    wait = 600;
    for (i = 1; i <= 4; i += 1)
    {
        if (instance_exists(block[i - 1]))
        {
            with (block[i - 1])
                instance_destroy();
        }
    }
}
