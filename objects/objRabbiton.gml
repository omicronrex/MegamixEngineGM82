#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
// creation code (all optional)
// back = <boolean> (false = appears in front; true = appears behind you)

event_inherited();

respawn = true;

healthpointsStart = 3;
healthpoints = healthpointsStart;
contactDamage = 3;
category = "nature";

despawnRange = 32;

// Enemy specific code
back = false;

chasing = false;
phase = 0;
range = 64;
timer = 0;

xSpd = 1.5;
ySpd = 4;

animBack = 0;
animPauseTimer = 0;
imgSpd = 0.2;
imgIndex = 0;
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();
if(xcoll!=0)
{
    xspeed=xcoll;
}


if (entityCanStep())
{
    switch (phase)
    {
        // skii, and wait to do stuff
        case 0: // turn around if we hit a wall
            if (xspeed == 0)
            {
                phase = 2;
            }

            // animation
            if (animPauseTimer <= 0)
            {
                if (!animBack)
                {
                    imgIndex += imgSpd;
                    if (imgIndex >= 5)
                    {
                        imgIndex = 4;
                        animBack = true;
                        animPauseTimer = 6;
                    }
                }
                else
                {
                    imgIndex -= imgSpd;
                    if (imgIndex < 0)
                    {
                        imgIndex = 0;
                        animBack = false;
                        animPauseTimer = 6;
                    }
                }
            }
            else
            {
                animPauseTimer -= 1;
            }

            // trigger actions
            timer += 1;
            if (timer >= 50) // decide whether to do an action after a certain amount of time
            {
                timer = 0;

                if (choose(false, false, true) && instance_exists(target)) // chance to do an action
                {
                    if ((image_xscale == 1 && x <= target.x - range)
                        || (image_xscale == -1 && x >= target.x + range))
                    {
                        // jump
                        phase = 1;
                        imgIndex = 8;
                        animPauseTimer = 0;
                        yspeed = -ySpd;
                        ground = false;

                        if (chasing)
                        {
                            xSpd += image_xscale * 2.5;
                        }
                        else
                        {
                            xSpd += image_xscale;
                        }

                        xspeed = xSpd;
                    }
                    else if ((image_xscale == 1 && target.x < x)
                        || (image_xscale == -1 && target.x > x))
                    {
                        // turn
                        phase = 2;
                        animPauseTimer = 0;
                        imgIndex = 5;

                        if (chasing)
                        {
                            if (xspeed != 0)
                            {
                                xspeed -= image_xscale;
                            }
                        }
                        else
                        {
                            xspeed /= 3;
                        }
                    }
                }
            }
            break;

        // twirl and jump
        case 1:
            imgIndex += imgSpd * 2;
            if (imgIndex >= 12)
            {
                imgIndex = 8 + imgIndex mod 12;
            }
            if (ground)
            {
                if (timer < 1)
                {
                    yspeed = -ySpd;
                    ground = false;
                    timer += 1;
                }
                else
                {
                    phase = 0;
                    timer = 0;

                    if (chasing)
                    {
                        xSpd -= image_xscale * 2.5;
                    }
                    else
                    {
                        xSpd -= image_xscale;
                    }
                }
            }
            xspeed = xSpd; // don't lose all speed by hitting a wall
            break;

        // turn
        case 2: // loop animaion
            imgIndex += imgSpd * 2;
            if (imgIndex >= 7)
            {
                imgIndex = 5 + imgIndex mod 7;
            }

            // wait to turn
            timer += 1;
            if (timer >= 30)
            {
                phase = 0;
                imgIndex = 0;

                image_xscale = -image_xscale;

                if (chasing)
                {
                    if (xspeed != 0)
                    {
                        // drift the other way
                        xspeed += image_xscale;
                    }
                    else
                    {
                        // go at a slow speed backwards
                        xspeed = image_xscale;
                    }
                }
                else
                {
                    xSpd = abs(xSpd) * image_xscale;
                    xspeed = xSpd;
                }
            }
            break;
    }
}

image_index = imgIndex div 1;
#define Other_25
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();

if (spawned)
{
    // reset variables
    chasing = false;
    phase = 0;
    timer = 0;
    animPauseTimer = 0;
    imgIndex = 0;

    // match speed of the vehicle
    if (instance_exists(target))
    {
        if (instance_exists(target.vehicle))
        {
            chasing = true;

            if (target.vehicle.x > view_xview[0] && target.vehicle.x < view_xview[0] + view_wview[0]
                && target.vehicle.y > view_yview[0]
                && target.vehicle.y < view_yview[0] + view_hview[0])
            {
                if (target.vehicle.object_index == objMegaman8Sled)
                    xSpd = target.vehicle.maxSpeed * target.vehicle.image_xscale;
                else
                    xSpd = abs(target.vehicle.xspeed) * target.vehicle.image_xscale;

                // set drift speed
                if (back)
                {
                    xSpd += target.vehicle.image_xscale;
                }
                else
                {
                    xSpd -= target.vehicle.image_xscale;
                }
            }
        }
    }

    // other speed stuff
    if (!chasing)
    {
        // not on a vehicle
        calibrateDirection();

        if (back)
        {
            image_xscale = -image_xscale;
        }

        xSpd = 1.5 * image_xscale;
    }
    else if (xSpd == 0)
    {
        // bro, you can't skate in place. That's silly. This is a very serious fan project, obviously.
        xSpd = target.vehicle.image_xscale / 2;
    }

    // determine facing direction (done like this so you don't get any moon-skating rabbiton if the vehicle is slow enough)
    if (xSpd > 0)
    {
        image_xscale = 1;
    }
    else
    {
        image_xscale = -1;
    }

    // back position setup
    if (back)
    {
        if (x < view_xview[0] + view_wview[0] / 2)
        {
            x = view_xview[0] + view_wview[0];
        }
        else
        {
            x = view_xview[0];
        }
    }

    xspeed = xSpd;
}
