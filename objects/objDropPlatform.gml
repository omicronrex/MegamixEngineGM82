#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
/// A platform that drops players if they stand on it for too long
event_inherited();
canHit = false;

grav = 0;
blockCollision = 0;
bubbleTimer = -1;

isSolid = 2;

canDrop = true;
phase = 0; // 0 = idle; 1 = preparing to drop down; 2 = dropping down animation; 3 = dropped down; 4 = rebuilding animation
timer = 0;
dropTimerMax = 15;
rebuildTimerMax = 10;
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
                if (place_meeting(x, y + 1, other.id) && ground)
                {
                    if (!place_meeting(x, y, other.id))
                    {
                        other.phase = 1;
                        other.timer = 0;
                    }
                }
            }
            break;
        case 1: // Preparing to drop down
            timer += 1;
            if (timer >= dropTimerMax)
            {
                timer = 0;
                phase = 2;
            }
            break;
        case 2: // Dropping down animation
            timer += 1;
            if (timer mod 3 == 1)
            {
                image_index += 1;
                if (image_index == 4)
                {
                    isSolid = 0;
                    phase = 3;
                    timer = 0;
                }
            }
            break;
        case 3: // Dropped down
            timer += 1;
            if (timer >= rebuildTimerMax)
            {
                timer = 0;
                phase = 4;
            }
            break;
        case 4: // Rebuilding animation
            timer += 1;
            if (timer == 1)
            {
                isSolid = 2;
            }
            if (timer mod 3 == 1)
            {
                image_index -= 1;
                if (image_index == 0)
                {
                    timer = 0;
                    phase = 0;
                }
            }
            break;
    }
}
else if (dead)
{
    image_index = 0;
    phase = 0;
    timer = 0;
    isSolid = 2;
}
