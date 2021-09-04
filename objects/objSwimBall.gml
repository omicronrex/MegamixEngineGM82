#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
// An aquatic enemy that swims slowly towards the player.
event_inherited();

healthpointsStart = 2;
contactDamage = 3;
grav = 0;

category = "aquatic";
facePlayerOnSpawn = true;

imgIndex = 0;
imgSpd = 0.2;
phase = 0;

xs = 0;
targY = 0;
decel = 0.05; // By how much does Swim Ball slow down?
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();

if (entityCanStep())
{
    switch (phase)
    {
        case 0:
            if (xspeed != 0)
            {
                xspeed -= decel * image_xscale;
            }
            else
            {
                phase = 1;
                calibrateDirection();
                if (image_xscale == 1)
                {
                    xs = bbox_right + 1;
                }
                else
                {
                    xs = bbox_left - 1;
                }
            }
            break;
        case 1:
            if (instance_exists(target))
            {
                targY = target.y;
            }

            if (yspeed < 0)
            {
                yspeed += decel;
            }
            else
            {
                yspeed = 0.3;
            }

            if (!positionCollision(xs, y))
            {
                imgIndex += imgSpd;
                if (imgIndex > 7)
                {
                    phase = 0;
                    imgIndex = 0;
                    xspeed = 3 * image_xscale;

                    // Set yspeed
                    if (targY > y)
                    {
                        yspeed = 0.5;
                    }
                    else
                    {
                        yspeed = -0.5;
                    }
                }
            }
            else
            {
                phase = 0;
            }
            break;
    }

    if (ycoll != 0)
    {
        yspeed *= -ycoll;
    }
}
else if (dead)
{
    healthpoints = healthpointsStart;
    imgIndex = 0.1;
    targY = 0;
    xs = 0;
    phase = 0;
    xspeed = 3 * image_xscale;
}

image_index = imgIndex div 1;
#define Other_25
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
/// On spawn
xspeed = 3 * image_xscale;
