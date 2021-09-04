#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
// totalTimer = ;
// bubbleInterval = ;
// isSmall = ;
// smallBubbleTimer = ;
// bubblesPerInterval = ;

event_inherited();

inWater = -1;

contactDamage = 0;
canHit = false;

grav = 0;
blockCollision = 0;
bubbleTimer = -1;

totalTimer = 60 * 6;
bubbleInterval = floor((60 * 6) / 6);
isSmall = true;
smallBubbleTimer = 60 * 1;
bubblesPerInterval = 3;

bubbleCount = 0;
timer = 0;

respawnRange = -1;
despawnRange = -1;
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();

if (entityCanStep() && y > global.sectionTop)
{
    if (timer < totalTimer)
    {
        timer += 1;
    }
    else
    {
        timer = 0;
        bubbleCount = 0;
    }

    if (timer == floor(timer / bubbleInterval) * bubbleInterval
        && timer > 0)
    {
        if (bubbleCount < bubblesPerInterval)
        {
            if (isSmall)
            {
                i = instance_create(x, y + 14, objBubblePlatformSmall);
                i.popTime = smallBubbleTimer;
            }
            else
            {
                i = instance_create(x, y + 0.25, objBubblePlatformLarge);
                i.popTime = smallBubbleTimer;
            }
            bubbleCount += 1;
        }
    }
}
else
{
    bubbleCount = 0;
    timer = 0;
}
