#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();
canHit = false;

grav = 0;
bubbleTimer = -1;

isSolid = 1;
faction = 7;

//@cc The vertical acceleration
acc = 0.15;

// Because moving in sub-pixels messed up collision, we need a value that keeps track of the sub-pixels, and only use real pixels for yspeed
subY = 0;
subYspeed = 0;
maxSpeed = 3;
decendSpeed = 1;
phase = 0; // 0 = not moving; 1 = moving up; 2 = moving down

test = 0;
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();

if (!global.frozen && !dead && !global.timeStopped)
{
    if (phase == 0)
    {
        with (objMegaman)
        {
            if (place_meeting(x, y + gravDir, other.id))
            {
                if (ground)
                {
                    with (other)
                    {
                        yspeed = acc * -sign(image_yscale);
                        phase = 1;
                    }
                }
            }
        }
    }

    if (phase == 1) // Moving up
    {
        yspeed -= (acc * sign(image_yscale));
        if (yspeed * sign(image_yscale) <= -maxSpeed)
        {
            yspeed = -maxSpeed * sign(image_yscale);
        }

        if (ycoll != 0 || place_meeting(x, y, objSparkmanPlatformStop))
        {
            yspeed = 0;
            phase = 2;
        }
    }
    else if (phase == 2) // Moving down
    {
        yspeed = decendSpeed * sign(image_yscale);
        if ((y >= ystart && sign(image_yscale) == 1) || (y <= ystart && sign(image_yscale) == -1))
        {
            yspeed = ystart - y;
            yspeed = 0;
            phase = 0;
        }
    }
}
else if (dead)
{
    phase = 0;
    subYspeed = 0;
}
