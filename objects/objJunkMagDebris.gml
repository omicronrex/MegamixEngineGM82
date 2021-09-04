#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();
isSolid = 1;

hasSwitch = false;

blockCollision = 0;
faction = 7;

grav = 0;
bubbleTimer = -1;

yspeed = -0.8;
despawnRange = -1;

myMagnet = noone;
magnetDir = 0;
magnetState = 0; // 0 = Going up; 1 = Going to the magnet

// 2 = Magnetized and dropping dust; 3 = Falling

timer = 0;
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if (!hasSwitch)
{
    with (objSwitchHandler)
    {
        if (myFlag == other.myFlag)
        {
            other.hasSwitch = true;
        }
    }
}

event_inherited();

if (!global.frozen && !dead && !global.timeStopped)
{
    if (hasSwitch)
    {
        if (global.flagParent[myFlag].active)
        {
            // Going up.
            if (magnetState == 0)
            {
                yspeed = -0.8;
            }

            // Going to the magnet.
            if (magnetState == 1)
            {
                if (instance_exists(myMagnet))
                {
                    yspeed = 0;
                    if (x == myMagnet.x && y == myMagnet.bbox_bottom + 2)
                    {
                        magnetState = 2;
                        magnetDir = myMagnet.image_xscale;
                    }
                }
                else
                {
                    magnetState = 3;
                }
            }

            // Magnetized and dropping dust.
            if (magnetState == 2)
            {
                isSolid = 0;
                if (instance_exists(myMagnet))
                {
                    timer += 1;

                    /* if (timer < 120)
                    {*/
                    if (timer mod 40 == 0)
                    {
                        instance_create(x, y, objJunkDust);
                    }

                    /*}
                    else
                    {
                        magnetState = 3;
                    }*/
                    if (magnetDir != myMagnet.xspeed)
                    {
                        if (timer > 40)
                        {
                            magnetState = 3;
                        }
                        else
                        {
                            magnetDir = myMagnet.xspeed;
                        }
                    }
                }
                else
                {
                    magnetState = 3;
                }
            }
        }
        else
        {
            yspeed = 0;
            if (magnetState != 0)
            {
                magnetState = 3;
            }
        }
    }
    else
    {
        yspeed = 0;
        if (magnetState != 0)
        {
            magnetState = 3;
        }
    }

    // Falling.
    if (magnetState == 3)
    {
        isSolid = 0;
        yspeed = 4;
    }

    // Went above the top of the room or below the bottom of the room.
    if (y + 32 < global.sectionTop || y > global.sectionBottom)
    {
        instance_destroy();
    }
}
else if (dead)
{
    instance_destroy();
}
