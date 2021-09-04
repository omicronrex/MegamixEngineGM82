#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
/// A spawner from Cut Man's stage. After a short time, this object will hurl cutters at
// Mega Man at a constant rate.

event_inherited();

canHit = false;
bubbleTimer = -1;

//@cc the amount of delay in between spawning the cutters, in frames.
delay = 36;
timer = 0;

grav = 0;
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();

if (!dead && !global.frozen && !global.timeStopped)
{
    // increment timer + check if it's at the max
    timer += 1;
    if (timer == delay)
    {
        if (instance_exists(target) && insideView())
        {
            if (abs(target.x - x) <= 80) // Getting only the horizontal distance between player and object
            {
                instance_create(x, y, objSuperCutter);
            }
        }
        timer = 0;
    }
}
else if (dead)
{
    timer = 0;
}
#define Draw_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
// Nothing
