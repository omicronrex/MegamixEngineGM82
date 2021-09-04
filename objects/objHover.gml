#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
// A platform from Pharaoh Man's stage. It will float there and occasionally shoot two bullets to
// the left and right, until it is stepped on, when it will then fall down and start travelling
// in the set direction.

event_inherited();
canHit = false;

grav = 0;
dieToSpikes = false;

isSolid = 2;

phase = 0;
timer = 0;
dropped = 0;

//@cc speed in pixels per frame. default is 1 (going to the right).
travelSpeed = 1;
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();

if (!global.frozen && !dead && !global.timeStopped)
{
    timer += 1;
    switch (phase)
    {
        case 0: // Resting
            if (timer == 60)
            {
                yspeed = 1;
            }
            if (timer == 61)
            {
                yspeed = 0;
                if (image_index == 1)
                {
                    i = instance_create(bbox_left, y + 14, objEnemyBullet);
                    i.xspeed = -2;
                    i = instance_create(bbox_right, y + 14, objEnemyBullet);
                    i.xspeed = 2;
                }
            }
            if (timer == 120)
            {
                yspeed = -1;
            }
            if (timer == 121)
            {
                if (image_index == 0)
                {
                    image_index = 1;
                }
                else
                {
                    image_index = 0;
                }
                yspeed = 0;
                timer = 0;
            }
            with (objMegaman)
            {
                if (ground)
                {
                    with (other)
                    {
                        if (place_meeting(x, y - image_yscale, other.id)
                            && !place_meeting(x, y, other.id))
                        {
                            phase = 1;
                            grav = 0.25;
                        }
                    }
                }
            }
            break;
        case 1: // Fall
            if (!dropped)
            {
                image_index = 2;
            }
            if (ground)
            {
                phase = 2;
                yspeed = 0;
                grav = 0;
                if (!dropped)
                {
                    instance_create(x, y + 23, objHoverSmoke);
                }
                dropped = 1;
            }
            break;
        case 2: // Rise
            if (checkSolid(0, 3))
            {
                yspeed = -1;
            }
            else
            {
                yspeed = 0;
                xspeed = travelSpeed;
                phase = 3;
            }
            image_index = 1;
            break;
        case 3: // Move
            if (!checkSolid(0, 5))
            {
                phase = 1;
                xspeed = 0;
                grav = 0.25;
            }
            else
            {
                if (xcoll != 0)
                {
                    instance_create(x, y + 16, objExplosion);
                    dead = true;
                }
            }
            break;
    }
}
else if (dead)
{
    grav = 0;
    phase = 0;
    timer = 0;
    image_index = 0;
    dropped = 0;
}
