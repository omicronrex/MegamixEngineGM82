#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
// A girder that remains stationary until Mega Man is under or over it, at which point, it will drop down.
event_inherited();

canHit = false;
isSolid = true;
blockCollision = false;
grav = 0;
bubbleTimer = -1;
contactDamage = 4;
faction = 0;

phase = 0;
moveTimer = 60;
origX = x;
shakeDir = 0;
shakeTimer = 4;
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();

if ((!global.frozen) && (!dead) && (!global.timeStopped))
{
    switch (phase)
    {
        case 0:
            with (objMegaman) // if (instance_exists(target))
            {
                if (distance_to_point(other.x, y) < other.sprite_width / 2)
                {
                    with (other)
                    {
                        phase = 1;
                        x-=1;
                        shakeDir = 'left';
                    }
                }
            }
            break;
        case 1:
            moveTimer-=1;
            if (moveTimer > 0)
            {
                shakeTimer-=1;
                if (shakeTimer == 0)
                {
                    if (shakeDir == 'left')
                    {
                        x += 2;
                        shakeDir = 'right';
                    }
                    else
                    {
                        x -= 2;
                        shakeDir = 'left';
                    }
                    shakeTimer = 4;
                }
            }
            else
            {
                x = origX;
                yspeed = abs(yspeed);
                grav = gravAccel;

                with (objMegaman)
                {
                    if (place_meeting(x, y - gravDir * 4 - (other.yspeed * (other.yspeed > 0)), other))
                    {
                        if ((canHit == true) && (iFrames == 0))
                        {
                            with (other)
                            {
                                entityEntityCollision();
                            }
                        }
                    }
                }
            }
            break;
    }
}
else if (dead)
{
    phase = 0;
    moveTimer = 60;
    shakeDir = 0;
    shakeTimer = 4;
    grav = 0;
}
