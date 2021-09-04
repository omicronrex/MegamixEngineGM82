#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
// A spinning plarform that moves either up or down, making players standing on it wave horizontally
event_inherited();
canHit = false;

grav = 0;
blockCollision = 0;
bubbleTimer = -1;

isSolid = 2;

image_speed = 0.4;

respawn = false;

alarmTurn = 16;
turnSpeed = 0.76;

yspeed = 1;

//@cc -1: up; 1:down;
dir = -1;
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();

if (!global.frozen && !dead && !global.timeStopped)
{
    alarmTurn -= 1;
    if (alarmTurn <= 0)
    {
        alarmTurn = 16;
        dir *= -1;
    }

    var exsp; exsp = turnSpeed * dir;

    if (exsp != 0)
    {
        with (objMegaman)
        {
            if (ground)
            {
                with (other)
                {
                    if (place_meeting(x - dir, y - image_yscale, other))
                    {
                        if (!place_meeting(x, y, other))
                        {
                            with (other)
                            {
                                shiftObject(exsp, 0, 1);
                            }
                        }
                    }
                }
            }
        }
    }
}
