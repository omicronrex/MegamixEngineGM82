#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();
canHit = false;

canDrop = true;
phase = 0;
timer = 0;
timeri = 0;

respawnRange = -1;
despawnRange = -1;
blockCollision = 0;
grav = 0;
bubbleTimer = -1;

initImageIndex = -1;
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if initImageIndex == -1
{
    initImageIndex = image_index;
}

event_inherited();

if (entityCanStep() && insideSection(x, y))
{
    if (image_index == 0)
    {
        ys = -1;
    }
    else
    {
        ys = 1;
    }

    switch (phase)
    {
        case 0: // Idle
            if (place_meeting(x, y + ys, target))
            {
                phase = 4;
                timer = 0;
            }
            break;
        case 1: // Preparing to rotate
            timer += 1;
            if (timer >= 30)
            {
                timer = 0;
                if (image_index == 0)
                {
                    phase = 2;
                }
                else
                {
                    phase = 3;
                }
            }
            break;
        case 2: // First rotation
            timer += 1;
            if (timer == 4)
            {
                image_index += 1;
                if (image_index == 4)
                {
                    phase = 0;
                }
                timer = 0;
            }
            break;
        case 3: // Second Rotation
            timer += 1;
            if (timer == 4)
            {
                image_index += 1;
                if (image_index >= image_number)
                {
                    image_index = 0;
                }
                if (image_index == 0)
                {
                    phase = 0;
                }
                timer = 0;
            }
            break;
        case 4: // Mega man check
        /* if (!place_meeting(x, y + ys, target))
            {*/
            phase = 1;

            //}
            break;
    }

    if ((place_meeting(x, y + 1, target) && image_index == 0)
        || (place_meeting(x, y - 1, target) && image_index == 4))
    {
        if (target.canHit && target.iFrames == 0)
        {
            with (target)
            {
                with (other)
                {
                    entityEntityCollision(2);
                }
            }
        }
    }

    isSolid = (image_index == 0 || image_index == 4);
}
else if (!insideSection(x,y))
{
    phase = 0;
    timer = 0;
    image_index = initImageIndex;
}
