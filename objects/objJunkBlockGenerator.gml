#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();

grav = 0;
blockCollision = 0;
bubbleTimer = -1;

canHit = false;

// @cc speed at which junk blocks fall down
timer = 120;
startTimer = timer;

// @cc sprite for the spawned junk block
junkBlockSprite = sprJunkBlock;

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
    startTimer = timer;
}

event_inherited();

if (!global.frozen && !dead && !global.timeStopped)
{
    if (timer > 0)
    {
        timer -= 1;
    }
    else
    {
        if (!place_meeting(x, y, objJunkBlock))
        {
            ID = instance_create(x, y, objJunkBlock);
            ID.respawn = false;
            ID.sprite_index = junkBlockSprite;
        }
        timer = startTimer;
    }
}
