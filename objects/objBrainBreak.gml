#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();

healthpointsStart = 2;
healthpoints = healthpointsStart;
contactDamage = 4;
category = "grounded, semi bulky";

facePlayerOnSpawn = true;

// Enemy specific code
phase = 1;
smokeTimer = 0;
explodeTimer = 0;

xSpd = 1.2;
jumpXSpd = 0;
ySpd = 5;

imgSpd = 0.1;
imgIndex = 0;
animBack = false;
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();

if (entityCanStep())
{
    xSpeedTurnaround();

    switch (phase)
    {
        // Walk around casually
        case 1: // Animation
            if (!animBack)
            {
                imgIndex += imgSpd;
                if (imgIndex >= 3)
                {
                    imgIndex = 2 - imgIndex mod 3;
                    animBack = true;
                }
            }
            else
            {
                imgIndex -= imgSpd;
                if (imgIndex <= 0)
                {
                    imgIndex = 1 - imgIndex;
                    animBack = false;
                }
            }

            // Turn around
            if (ground)
            {
                if (xspeed == 0 || checkFall(16 * image_xscale, 0)) //! positionCollision(x + sprite_width * 0.4 + xspeed, bbox_bottom + 1))
                {
                    image_xscale *= -1;
                    xspeed *= -1;
                }
            }
            break;

        // ATTACK THE SHIT OUTA MEGA MEONG BWOBWOBWOBWOBWOBWO
        case 2: // Animation
            if (!animBack)
            {
                imgIndex += imgSpd * 2;
                if (imgIndex >= 6)
                {
                    imgIndex = 5 - imgIndex mod 6;
                    animBack = true;
                }
            }
            else
            {
                imgIndex -= imgSpd * 2;
                if (imgIndex <= 3)
                {
                    imgIndex = 4; // Not sure how to carry over the extra value. Oh well.
                    animBack = false;
                }
            }

            // Give off smoke
            smokeTimer += 1;
            if (smokeTimer >= 8) // <-=1 Smoke spawn time here
            {
                smokeTimer = 0;
                instance_create(x - sprite_width * 0.4, bbox_top + 8, objBrainBreakSmoke);
            }

            // Turn around stuff
            if (ground && instance_exists(target))
            {
                if (xspeed == 0 || !positionCollision(x + sprite_width * 0.375 + xspeed, bbox_bottom + 1))
                {
                    if ((image_xscale > 0 && target.x < x)
                        || (image_xscale < 0 && target.x > x))
                    {
                        image_xscale *= -1;
                    }
                    else
                    {
                        yspeed = -ySpd;
                        xspeed = xSpeedAim(x, y, target.x, target.y, yspeed, grav, xSpd);
                        ground = false;

                        jumpXSpd = xspeed;
                    }
                }
            }

            // Set speed
            if (ground)
            {
                xspeed = xSpd * 2 * image_xscale;
            }
            else
            {
                xspeed = jumpXSpd; // So he can't be completely unable to jump over walls and stuff
            }

            // Explode
            explodeTimer += 1;
            if (explodeTimer >= 800) // <-=1 time until exploding here
            {
                dead = true;
                instance_create(bboxGetXCenter(), bboxGetYCenter(), objHarmfulExplosion);
            }
            break;
    }
}
else if (dead)
{
    phase = 1;

    smokeTimer = 0;
    explodeTimer = 0;
    imgIndex = 0;
    animBack = false;
}

image_index = imgIndex div 1;
#define Other_19
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();

if phase != 2
{
    phase = 2;
    imgIndex = 3;
    animBack = false;

    calibrateDirection();

    with (instance_create(x, y, objBrainBreakGlasses))
    {
        image_xscale = other.image_xscale;
        xspeed = -other.image_xscale;
    }
}
#define Other_25
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();

if (spawned)
{
    xspeed = xSpd * image_xscale;
}
