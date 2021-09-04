#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
// An obstacle from Wave Man's stage. It swings back and forth, and only the ball damages you.

// Creation code (all optional):
// col = ; 0 blue, 1 orange
// wait = ; time it waits between slams, in frames

event_inherited();

blockCollision = 0;
grav = 0;
isTargetable = false;
bubbleTimer = -1;

col = 0;

wait = 60;
waitStart = wait;
init = 1;
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
// Set color and timers properly
if (init)
{
    init = 0;
    waitStart = wait;
    if (col == 1)
    {
        sprite_index = sprTeckyunOrange;
    }
}

event_inherited();

// Actual code
if (!global.frozen && !dead && !global.timeStopped)
{
    // Decrement timer
    if (wait > 0)
    {
        wait -= 1;
    }
    else
    {
        // animation
        if (image_index < image_number - 1)
        {
            image_index += 0.1;
        } // slamming
        else
        {
            image_xscale = -image_xscale;
            image_index = 0;
            wait = waitStart;
            playSFX(sfxTeckyun);
        }
    }

    // hit the target
    if (place_meeting(x, y, target))
    {
        with (target)
        {
            // manual damage to player
            if (iFrames == 0 && canHit)
            {
                with (other)
                {
                    entityEntityCollision(4);
                }
            }
        }
    }
}
#define Other_21
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
other.guardCancel = 2;
