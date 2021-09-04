#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
/// A famous enemy that appears in plenty of levels. It will slowly inch towards Mega Man on a grid pattern.

event_inherited();

healthpointsStart = 1;
healthpoints = healthpointsStart;
contactDamage = 2;

category = "cluster, floating";

grav = 0;
blockCollision = 0;
canHit = true;

// Enemy specific code
left = true;
cycleHold = false;

//@cc Speed the telly will come at the player in pixels per frame.
travelSpeed = 0.25;
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
/* you know, I'm pretty sure the difference with the tracking methods in the original game was actually just the same tracking method, but having number
errors with the nes limitations when the player was far away. but whatever */

event_inherited();

// Animation
if (image_index < 0)
{
    image_index = (image_number) + (image_index mod (image_number - 1));
}

if (entityCanStep())
{
    if (instance_exists(target))
    {
        pDistX = target.x - x;
        pDistY = target.y - y;

        // If the player is really close, target them directly.
        if (distance_to_object(target) <= 32)
        {
            xspeed = 0;
            yspeed = 0;

            if (cycleHold)
            {
                cycleHold = false;
            }

            mp_linear_step(target.x, target.y, travelSpeed, false);
        }
        else
        {
            // if coming off of being close to mega man, or the telly is facing straight towards us or straight away, then update movement
            if ((xspeed == 0 && yspeed == 0)
                || (!cycleHold && (((image_index div 1) == 0)
                || ((image_index div 1) == 2)
                || ((image_index div 1) == 4))))
            {
                cycleHold = true;

                xspeed = 0;
                yspeed = 0;

                pDistX = target.x - x;
                pDistY = target.y - y;

                // move in the axis that has more distance between this and mega man
                if (abs(pDistX) > abs(pDistY))
                {
                    xspeed = travelSpeed * sign(pDistX);
                }
                if (abs(pDistX) < abs(pDistY))
                {
                    yspeed = travelSpeed * sign(pDistY);
                }
            }
            else if (cycleHold && !(((image_index div 1) == 0)
                || ((image_index div 1) == 2)
                || ((image_index div 1) == 4)))
            {
                cycleHold = false;
            }
        }

        if ((pDistX) != 0)
        {
            image_speed = -0.125 * sign(pDistX);
        }
    }
}
else
{
    image_speed = 0;
}
