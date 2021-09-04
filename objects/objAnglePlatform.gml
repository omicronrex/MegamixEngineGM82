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
bubbleTimer = -1;

inWater = -1;

canDrop = true;
phase = 0;
timer = 0;
timeri = 0;
touched=false;

respawnRange = -1;
despawnRange = -1;

isSolid = 1;

//@cc 0 = green; 1 = orange
col = 0;

init = 1;
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if (init)
{
    init = 0;
    switch (col)
    {
        case 0:
            sprite_index = sprAnglePlatformGreen;
            break;
        case 1:
            sprite_index = sprAnglePlatformOrange;
            break;
        default:
            sprite_index = sprAnglePlatformGreen;
            break;
    }
}

event_inherited();

if (entityCanStep())
{
    with(objMegaman)
    {
        if(!place_meeting(x, y + gravDir, other.id))
        {
           other.touched = false;
        }
    }

    switch (phase)
    {
        case 0: // Idle
            with (objMegaman)
            {
                if (ground)
                {
                    if (!other.touched && (place_meeting(x, y + gravDir, other.id)&& !place_meeting(x, y, other.id)))
                    {
                        with (other)
                        {
                            touched = true;
                            phase = 1;
                            timer = 0;

                            if (image_index == 0)
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
                if (image_index == 2)
                {
                    with (objMegaman)
                    {
                        if (ground)
                        {
                            if (place_meeting(x, y + gravDir, other.id)
                                && !place_meeting(x, y, other.id))
                            {
                                y -= gravDir;
                            }
                        }
                    }
                }

                image_index += 1;

                if (image_index == 4)
                {
                    phase = 0;
                    isSolid = 1;
                }

                timer = 0;
            }
            break;
        case 3:
            timer += 1;
            if (timer == 4)
            {
                if (image_index == 2)
                {
                    with (objMegaman)
                    {
                        if (ground)
                        {
                            if (place_meeting(x, y + gravDir, other.id)
                                && !place_meeting(x, y, other.id))
                            {
                                shiftObject(0, -gravDir, true);
                            }
                        }
                    }
                }

                image_index -= 1;

                if (image_index == 0)
                {
                    phase = 0;
                    isSolid = 1;
                }

                timer = 0;
            }
            break;
    }
}
#define Other_25
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();
if(spawned)
{
    isSolid = 1;
    image_index = 0;
    canDrop = true;
    phase = 0;
    timer = 0;
    spawned = false;
    timeri = 0;
    touched = false;
}
