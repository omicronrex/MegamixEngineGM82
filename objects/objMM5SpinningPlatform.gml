#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
// X = ;
// Y = ;
// length = ;
// wait = ;

event_inherited();
canHit = false;

isSolid = 2; // Is it solid?
blockCollision = 0;
grav = 0;
bubbleTimer = -1;

respawn = true;

image_speed = 0.2;

X = x; // Target X - where does it go?
Y = y; // Target Y - where does it go?

length = 64;
wait = 64;

phase = 0; // What state (idle, moving, dropping) is it in
waitMemory = wait;
alarmTimer = -1; // Countdown until movement stops

init = 1;
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if (init)
{
    waitMemory = wait;
    init = 0;
}

event_inherited();

if (!global.frozen && !dead) // If not frozen and dead...
{
    switch (phase) // Do stuff based on phase
    {
        case 0:
            with (objMegaman)
            {
                if (place_meeting(x, y + 1, other.id)
                    && !place_meeting(x, y, other.id) && ground)
                {
                    with (other)
                    {
                        /* xs = x;
                        ys = y;
                        xspeed = X / length;
                        yspeed = Y / length ;*/
                        xspeed = distance_to_point(X, y) / length;
                        if (X < x)
                        {
                            xspeed = -xspeed;
                        }
                        yspeed = distance_to_point(x, Y) / length;
                        if (Y < y)
                        {
                            yspeed = -yspeed;
                        }
                        alarmTimer = -1;
                        phase = 1;
                    }
                }
            }
            break;
        case 1:
            alarmTimer += 1;
            if (alarmTimer == length)
            {
                xspeed = 0;
                yspeed = 0;
                phase = 2;
            }
            break;
        case 2:
            if (x == xstart && y == ystart)
            {
                wait = waitMemory;
                xspeed = 0;
                yspeed = 0;
                phase = 0;
            }
            if (wait > 0)
            {
                wait -= 1;
            }
            else
            {
                yspeed += 0.3;
            }
            break;
    }
}
else if (dead)
{
    wait = waitMemory;
    alarmTimer = -1;
    phase = 0;
}
#define Step_2
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
// event_inherited();

if (!global.frozen)
{
    with (target)
    {
        if (!place_meeting(x, y, other.id))
        {
            if (place_meeting(x, y + 2, other.id))
            {
                if (ground && xspeed == 0 && !isShoot
                    && !instance_exists(objWireAdapter))
                {
                    playerHandleSprites("Spin");
                }
            }
        }
    }
}
