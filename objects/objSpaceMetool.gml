#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();

healthpointsStart = 1;
healthpoints = healthpointsStart;
contactDamage = 3;

category = "mets, cluster, flying";

blockCollision = 0;
grav = 0;

// Enemy specific code
col = 0;

chgPhases = 0;
lockMovement = 0;
xLock = 0;
yLock = 0;
xCont = 0;
yCont = 0;
toggle = 0;
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();

if (entityCanStep())
{
    image_index += 0.25;

    // timer

    chgPhases += 1;
    if (chgPhases >= 32)
    {
        chgPhases = 0;
        lockMovement = 0;
    }

    // lock movement
    if (lockMovement == 0)
    {
        lockMovement = 1;
        if (instance_exists(target))
        {
            xLock = ceil(target.x / 16) * 16;
            yLock = ceil(target.y / 16) * 16;

            // Set whether or not xContinue is set or not. This means that Pukapelly will continue moving if he reaches Mega Man's x co-ordinate.
            if (x >= target.x - 3 && x <= target.x + 3)
                xCont = 0;
            else
                xCont = target.x - x;

            // Set whether or not yContinue is set or not. This means that Pukapelly will continue moving if he reaches Mega Man's y co-ordinate.
            if (y >= target.y - 3 && y <= target.y + 3)
                yCont = 0;
            else
                yCont = target.y - y;
        }
    }

    // lock onto xLock and yLock.
    if (instance_exists(target))
    {
        if (abs(target.x - x) > 16 || abs(target.y - y) > 16)
        {
            if (x > xLock)
                xspeed = -1.2;
            else if (x < xLock)
                xspeed = 1.2;
            else
                xspeed = 0;

            if (y > yLock)
                yspeed = -1.2;
            else if (y < yLock)
                yspeed = 1.2;
            else
                yspeed = 0;
        }
        else
        {
            xspeed = 0;
            yspeed = 0;
        }
    }

    // follow mega man
    if (x <= xLock && xCont <= -1)
        xLock = x - 16;
    if (x >= xLock && xCont >= 1)
        xLock = x + 16;
    if (y <= yLock && yCont <= -1)
        yLock = y - 16;
    if (y >= yLock && yCont >= 1)
        yLock = y + 16;



    // Set direction of sprite
    if (xspeed < 0)
        image_xscale = -1;
    else if (xspeed > 0)
        image_xscale = 1;
}

// reset default values whilst ded.
if (dead == true && respawn == true)
{
    chgPhases = 0;
    xLock = 0;
    yLock = 0;
    yCont = 0;
    xCont = 0;
    lockMovement = 0;
    image_index = 0;
}
