#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();
canHit = false;
isSolid = 1;

hasSwitch = false;

respawnRange = -1;
despawnRange = -1;

blockCollision = 0;

grav = 0;
faction = 0;
behaviourType = 3;

freeFalling = false;

distance = 64;
magnetizing = false;
magnetJunkTarget = noone;
magnetPlayerTarget = noone;

myFlag = 0;

xspeed = 0;
yspeed = 0;

mySpeed = 0;
xOffset = 0;
yOffset = -9;
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();
faction = 3;
setTargetStep();
faction = 0;
if (false)
{
    if (false /* place_meeting(x, y - 8, prtRail )*/ )
    {
        ystart -= 8;
        y = ystart;
    }
    else if (false /* positionCollision(x, y - 1) && !positionCollision(x, y + 3 )*/ )
    {
        ystart -= 4;
        y = ystart;
    }
}
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

if (!global.frozen && !dead && !global.timeStopped)
{
    isSolid = 1;

    if (false /* positionCollision(x, y - 9) && !freeFalling */ )
    {
        yspeed = 0;
        dir = "onsolid";
    }
    else
    {
        if (dir == "fall")
        {
            isSolid = 2;
            mySpeed = 0;
            freeFalling = true;
        }
        else
        {
            freeFalling = false;
            mySpeed = 0.8;
        }
    }
    if (hasSwitch)
    {
        if (global.flagParent[myFlag].active)
        {
            mySpeed = 0.8;

            // Image stuff.
            image_speed = 1 / 4;
            if (magnetizing)
            {
                if (image_index <= 5 || image_index >= 8)
                {
                    image_index = 6;
                }
            }
            else
            {
                if (image_index <= 0 || image_index >= 6)
                {
                    image_index = 1;
                }
            }

            // Movement stuff.
            /* if (xcoll != 0)
            {
                image_xscale *= -1;
            }
            */
            if (place_meeting(x, y, objJunkMagnet))
            {
                if (dir == "left")
                    dir = "right";
                else if (dir == "right")
                    dir = "left";
                else if (dir == "up")
                    dir = "down";
                else if (dir == "down")
                    dir = "up";
                xspeed = -xspeed;
                yspeed = -yspeed;
            }

            /*
            if (positionCollision(x, y))
            {
                if (!positionCollision(x + 8 * image_xscale, y)
                    && !place_meeting(x + 8 * image_xscale, y, prtRail))
                {
                    image_xscale *= -1;
                }
                if (place_meeting(x + 4 * image_xscale, y objLiftEnd))
                {
                    image_xscale *= -1;
                }
                xspeed = 0.8 * image_xscale;
            }
            else if (place_meeting(x, y-9, prtRail))
            {
                if (place_meeting(x + 4 * image_xscale, y, objLiftEnd))
                {
                    image_xscale *= -1;
                }
                if (dir == "left")
                {
                    image_xscale = -1;
                }
                else if (dir == "right")
                {
                    image_xscale = 1;
                }
            }
            */


            // Magnetizing Mega Man.
            if (!instance_exists(magnetPlayerTarget))
            {
                with (objMegaman)
                {
                    if (!dead && bbox_top >= other.bbox_bottom + 2
                        && distance_to_object(other) < other.distance
                        && abs(x - other.x) <= 16 && !ground)
                    {
                        other.magnetizing = true;
                        other.magnetPlayerTarget = id;
                    }
                }
            }

            // Magnetism.
            if (magnetizing)
            {
                if (instance_exists(magnetPlayerTarget)
                    && (instance_exists(lastRail) && !lastRail.drop)
                    && dir != "fall")
                {
                    // Player magnetism.
                    with (magnetPlayerTarget)
                    {
                        if (!dead && bbox_top >= other.bbox_bottom + 2
                            && distance_to_object(other) < other.distance
                            && abs(x - other.x) <= 16 && !ground)
                        {
                            if (other.bbox_bottom + 2 - bbox_top < -(yspeed + 2))
                            {
                                shiftObject(0, abs(yspeed + 2) * -1, true);
                            }
                            else
                            {
                                shiftObject(0, other.bbox_bottom + 2 - bbox_top, true);
                            }
                            if ((x - other.x) * other.xspeed < 0)
                            {
                                shiftObject(1.2 * sign(other.x - x), 0, true);
                            }
                            else if (other.xspeed == 0)
                            {
                                if (abs(x - other.x) > 1.2)
                                {
                                    shiftObject(1.2 * sign(other.x - x), 0, true);
                                }
                                else
                                {
                                    shiftObject(abs(x - other.x) * sign(other.x - x), 0, true);
                                }
                            }
                            yspeed = 0;
                        }
                        else
                        {
                            other.magnetPlayerTarget = noone;
                        }
                    }
                }
                else
                {
                    magnetPlayerTarget = noone;
                }

                // Junk magnetism.
                if (instance_exists(magnetJunkTarget)
                    && (instance_exists(lastRail) && !lastRail.drop)
                    && dir != "fall")
                {
                    with (magnetJunkTarget)
                    {
                        mp_linear_step(other.x, other.bbox_bottom + 2, 2, false);
                    }
                    if (magnetJunkTarget.magnetState >= 3)
                    {
                        magnetJunkTarget = noone;
                    }
                }
                else
                {
                    magnetJunkTarget = noone;
                }

                // No magnetism.
                if (!instance_exists(magnetPlayerTarget)
                    && !instance_exists(magnetJunkTarget))
                {
                    magnetizing = false;
                }
            }
            else if (instance_exists(lastRail) && !lastRail.drop
                && dir != "fall")
            {
                // Magnetizing junk.
                if (!instance_exists(magnetPlayerTarget))
                {
                    if (!instance_exists(magnetJunkTarget))
                    {
                        with (objJunkMagDebris)
                        {
                            if (!dead && bbox_top > other.bbox_bottom + 2
                                && distance_to_object(other) < other.distance
                                && !place_meeting(x, y - 1, objMegaman)
                                && !instance_exists(myMagnet) && magnetState == 0)
                            {
                                other.magnetJunkTarget = id;
                                other.magnetizing = true;
                                magnetState = 1;
                                myMagnet = other.id;
                            }
                        }
                    }
                }
            }
        }
        else
        {
            image_index = 0;
            image_speed = 0;
            xspeed = 0;
            magnetizing = false;
            magnetPlayerTarget = noone;
            magnetJunkTarget = noone;
            mySpeed = 0;
        }
    }
    else
    {
        image_index = 0;
        image_speed = 0;
        xspeed = 0;
        magnetizing = false;
        magnetPlayerTarget = noone;
        magnetJunkTarget = noone;
    }
}
else if (dead)
{
    image_index = 0;
    image_speed = 0;
    xspeed = 0;
    magnetizing = false;
    magnetPlayerTarget = noone;
    magnetJunkTarget = noone;
}
