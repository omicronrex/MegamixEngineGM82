#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();
canHit = false;

blockCollision = 0;
grav = 0;

inWater = -1;

canDrop = true;
phase = 0;
timer = 0;
timeri = 0;

respawnRange = -1;
despawnRange = -1;

isSolid = 2;
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();

if (!global.frozen && !dead && !global.timeStopped)
{
    switch (phase)
    {
        case 0: // Idle
            with (target)
            {
                if (ground)
                {
                    if (place_meeting(x, y + gravDir, other.id)
                        && !place_meeting(x, y, other.id))
                    {
                        with (other)
                        {
                            phase = 1;
                            timer = 0;

                            if (image_index <= 1)
                            {
                                iphase = 2;
                            }
                            else
                            {
                                iphase = 3;
                            }
                        }
                        break;
                    }
                }
            }
            break;
        case 1: // Preparing to drop down
            timer += 1;
            if (timer >= 12)
            {
                timer = 0;
                phase = iphase;
            }
            break;
        case 2: // Dropping down animation
            timer += 1;
            if (timer == 4)
            {
                image_index += 1;
                x += 2;

                if (image_index == 1)
                {
                    image_index += 1;
                }
                if (image_index == 2)
                {
                    isSolid = 0;
                    mask_index = mskFlipPlatformRight;
                }
                if (image_index == 5)
                {
                    phase = 0;
                    isSolid = 2;
                }

                timer = 0;
            }
            break;
        case 3:
            timer += 1;
            if (timer == 4)
            {
                image_index -= 1;
                x -= 2;

                if (image_index == 5)
                {
                    image_index -= 1;
                }
                if (image_index == 4)
                {
                    isSolid = 0;
                    mask_index = mskFlipPlatformLeft;
                }
                if (image_index == 1)
                {
                    phase = 0;
                    isSolid = 2;
                }

                timer = 0;
            }
            break;
    }

    if (image_index >= 5 || image_index <= 1) // Blinking
    {
        timeri += 1;
        if (timeri >= 15)
        {
            if (image_index == 0 || image_index == 5)
            {
                image_index += 1;
            }
            else if (image_index == 1 || image_index == 6)
            {
                image_index -= 1;
            }
            timeri = 0;
        }
    }
    else
    {
        timeri = 0;
    }
}
else if (dead)
{
    isSolid = 2;
    image_index = 0;
    mask_index = mskFlipPlatformLeft;
    canDrop = true;
    phase = 0;
    timer = 0;
    timeri = 0;
}
