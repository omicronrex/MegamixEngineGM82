#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();

respawn = true;

healthpointsStart = 4;
healthpoints = healthpointsStart;
contactDamage = 3;

facePlayerOnSpawn = true;

category = "nature, bird";

// Enemy specific code
phase = 0;
timer = 0;
boostWait = 100;
bounced = false;

xSpd = 2;
decel = 0.02;
xspeed = 0;
yspeed = 0;
prevXSpeed = 0;

animCount = 0;
imgSpd = 0.3;
imgIndex = 0;
image_speed = 0;
image_index = 0;
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();

if (entityCanStep())
{
    // bounce
    if (phase == 0 || phase == 4)
    {
        // bounce off walls
        if (xspeed == 0 && abs(prevXSpeed) > decel)
        {
            xspeed = -prevXSpeed;
            bounced = true;
        }

        // ram other Penpen EVs
        penpen = collision_rectangle(bbox_left, bbox_top, bbox_right, bbox_bottom, objPenpenEV, false, true);
        if (instance_exists(penpen))
        {
            if (xspeed != 0 && (penpen.phase == 0 || penpen.phase == 4))
            {
                myX = bboxGetXCenterObject(id);
                theirX = bboxGetXCenterObject(penpen);

                if ((myX < theirX && xspeed > 0 && penpen.xspeed < 0) || (myX > theirX && xspeed < 0 && penpen.xspeed > 0))
                {
                    // both coming towards each other
                    if ((myX < theirX && xspeed > 0) || (myX > theirX && xspeed < 0))
                    {
                        // hitting each other
                        aa = xspeed;
                        xspeed = penpen.xspeed;
                        penpen.xspeed = aa;
                        bounced = true;
                    }
                    else
                    {
                        // moving past each other
                        // do nothing
                    }
                }
                else if (abs(xspeed) > abs(penpen.xspeed)) // only the one moving faster will do anything
                {
                    // moving the same direction
                    if ((myX < theirX && xspeed > 0) || (myX > theirX && xspeed < 0)) // behind the slower penpen
                    {
                        penpen.xspeed += xspeed;
                        xspeed = 0;
                        bounced = true;
                    }
                }
            }
        }

        // decelerate
        if (phase == 0 || (phase == 4 && bounced))
        {
            if (xspeed != 0 && xspeed < decel && xspeed > -decel) // round to 0 so the value doesn't swing back and forth around 0
            {
                xspeed = 0;
            }

            if (xspeed > 0)
            {
                xspeed -= decel;
            }
            else if (xspeed < 0)
            {
                xspeed += decel;
            }
        }
    }

    // pattern
    switch (phase)
    {
        // spin twice
        case 0: // bouncing done near the top
        // animate
            imgIndex += imgSpd / 2 + (abs(xspeed) / 4);
            if (imgIndex >= 8)
            {
                imgIndex = imgIndex - 8;

                if (xspeed == 0 && yspeed == 0)
                {
                    animCount += 1;
                }
            }

            // check for phase transition (after two spins, and facing player)
            if (instance_exists(target))
            {
                myX = bboxGetXCenterObject(id);
                theirX = bboxGetXCenterObject(target);
                if (animCount >= 2 // <-=1 number of spins in place until readying for rocketing off here
                && ((theirX < myX && imgIndex div 1 == 6 && image_xscale == 1)
                    || (theirX < myX && imgIndex div 1 == 2 && image_xscale == -1)
                    || (theirX >= myX && imgIndex div 1 == 2 && image_xscale == 1)
                    || (theirX >= myX && imgIndex div 1 == 6 && image_xscale == -1)))
                {
                    phase = 1;
                    xspeed = 0;
                    animCount = 0;
                    imgIndex = 2;
                    calibrateDirection();
                    bounced = false;
                }
            }

            break;

        // small wait before turning on the side
        case 1:
            timer += 1;
            if (timer >= 20) // <-=1 time in grace period before turning on his side here
            {
                phase = 2;
                timer = 0;
                imgIndex = 8;
            }

            break;

        // go on the side and wait a bit
        case 2:
            if (imgIndex < 9)
            {
                imgIndex += imgSpd;
            }
            else
            {
                imgIndex = 9;

                if (timer == 0)
                {
                    playSFX(sfxClamp);
                }

                timer += 1;
                if (timer >= 30)
                {
                    phase = 3;
                    timer = 0;
                    imgIndex = 10;
                }
            }

            break;

        // extend booster
        case 3:
            imgIndex += imgSpd;
            if (imgIndex >= 14)
            {
                phase = 4;
                xspeed = 3 * image_xscale;
                imgIndex = 14;
                playSFX(sfxEnemyBoost);
            }

            break;

        // boost
        case 4: // bouncing done near the top
            imgIndex += imgSpd;
            if (imgIndex >= 17)
            {
                imgIndex = 14 + imgIndex mod 17;
            }

            // show_debug_message("bounced: " + string(bounced));

            if (timer < boostWait && !bounced)
            {
                timer += 1;
            }
            else if (ground && xspeed == 0)
            {
                phase = 5;
                timer = 0;
                xspeed = 0;
                imgIndex = 13;
                bounced = false;
            }

            break;

        // retract booster and get back up
        case 5:
            imgIndex -= imgSpd;
            if (imgIndex < 8)
            {
                phase = 0;
                imgIndex = 2;
            }

            break;
    }

    prevXSpeed = xspeed;
}
else if (dead)
{
    phase = 0;
    timer = 0;
    animCount = 0;
    imgIndex = 0;
    xspeed = 0;
    yspeed = 0;
    prevXSpeed = 0;
    bounced = false;
}

image_index = imgIndex div 1;
#define Other_19
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
/// gain momentum from shots
event_inherited();

if (phase == 0)
{
    animCount = 0;

    if (other.x < x)
    {
        image_xscale = -1;
    }
    else
    {
        image_xscale = 1;
    }

    xspeed += (global.damage * 0.75) * -image_xscale;
}
