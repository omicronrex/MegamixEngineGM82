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

isSolid = 2;
subX = 0; // Because moving in sub-pixels messed up collision, we need a value that keeps track of the sub-pixels, and only use real pixels for yspeed
maxSpeed = 0.75;
phase = 0; // 0 = not moving; 1 = moving up; 2 = moving down
test = 0;
resetDelay = 32;
delayTimer = resetDelay;
distanceTimer = 0;
moveDist = 78;
storeDir = image_xscale;
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
            if (ground)
            {
                if (place_meeting(x, y + gravDir, other.id))
                {
                    with (other)
                    {
                        phase = 5;
                    }
                }
            }
        }
    }
    if (phase == 1) // Moving forwards
    {
        xspeed = maxSpeed * sign(image_xscale);
        distanceTimer += maxSpeed;
        if (xcoll != 0 || distanceTimer >= moveDist)
        {
            image_xscale *= -1;
            distanceTimer = 0;
            xspeed = 0;
            phase = 3;
        }
    }
    else if (phase == 2) // Moving back
    {
        xspeed = maxSpeed * sign(image_xscale);
        distanceTimer += maxSpeed;
        if (xcoll != 0 || distanceTimer >= moveDist)
        {
            image_xscale *= -1;
            distanceTimer = 0;
            xspeed = 0;
            phase = 4;
        }
    }
    else if (phase == 3 || phase == 4 || phase == 5) // delay movement
    {
        delayTimer -= 1;
        if (delayTimer <= 0)
        {
            delayTimer = resetDelay;
            if (phase == 3)
            {
                phase = 2;
            }
            else if (phase == 5)
            {
                phase = 1;
            }
            else
            {
                phase = 0;
            }
        }
    }
}
else if (dead)
{
    image_xscale = storeDir;
    phase = 0;
    distanceTimer = 0;
    delayTimer = resetDelay;
}
#define Draw_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
var xs = image_xscale;
image_xscale = 1;
event_inherited();
image_xscale = xs;
