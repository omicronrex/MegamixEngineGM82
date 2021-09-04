#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
// A platform from Cossack Stage 3 in MM4. Unless set otherwise, it stays still until touched, at which
// it will then sink when you're standing on it and rise when you're not.

// Creation code (all optional):
// standSpeed = <number>. speed it travels when MM is on it, in pixels per frame
// airSpeed = <number>. speed it travels when MM is not on it, in pixels per frame

event_inherited();

isSolid = 2;
canHit = false;
bubbleTimer = -1;

grav = 0;
blockCollision = 0;

// Customizeable variables
standSpeed = 0.5;
airSpeed = -1;
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();

if (!global.frozen && !dead && !global.timeStopped)
{
    // if it's onscreen, play the fadein animation.
    if (image_index < 8.5)
    {
        image_index += 0.2;
    }

    // reset the variable for standing on it every frame
    ontop = 0;

    // Check for MM and if he's standing on it
    with (target)
    {
        if (ground && !isSlide)
        {
            if (place_meeting(x, y + 2*gravDir, other.id))
            {
                if (!place_meeting(x, y, other.id))
                {
                    other.yspeed = other.standSpeed * gravDir;
                    other.ontop = 1;
                }
            }
        }
    }

    // float up if it's not being stood on
    if (!ontop && yspeed != 0)
    {
        yspeed = airSpeed;
    }
}
else if (dead)
{
    // reset images
    image_index = 0;
}
