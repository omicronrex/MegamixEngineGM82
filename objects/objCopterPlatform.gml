#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();
canHit = false;

isSolid = 1;

blockCollision = 0;
grav = 0;
bubbleTimer = -1;

phase = 0; // 0 = not moving; 1 = moving up; 2 = moving down
timer = 0;

doesTransition = false;
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();

if (!global.frozen && !dead && !global.timeStopped)
{
    // bottom
    if (phase == 0)
    {
        // check if our friend the tornado is goin
        if (instance_exists(objTornadoBlow))
        {
            phase = 1;
        }
    }

    // GO UP BOY
    if (phase == 1)
    {
        if (yspeed > -3)
        {
            yspeed -= 0.01;
        }
        if (image_speed < 0.5)
        {
            image_speed += 0.01;
        }

        if (instance_place(x, y, objCopterPlatformStop))
        {
            yspeed = 0;
            phase = 2;
            timer = 150;
        }
    }

    // wait
    if (phase == 2)
    {
        timer -= 1;
        if (timer == 0)
        {
            phase = 3;
        }
    }

    // go back to original position
    if (phase == 3)
    {
        if (image_speed > 0)
        {
            image_speed -= 0.02;
        }

        if (yspeed < 2)
        {
            yspeed += 0.025;
        }

        if (y > ystart)
        {
            y = ystart;
            yspeed = 0;
            phase = 0;
            image_speed = 0;
            image_index = 0;
        }
    }
}
else if (dead)
{
    phase = 0;
}
