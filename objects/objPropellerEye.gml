#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();

healthpointsStart = 3;
healthpoints = healthpointsStart;
contactDamage = 3;

category = "cluster, flying, shielded";

blockCollision = false;
grav = 0;

facePlayerOnSpawn = true;

// Enemy specific code
phase = 0;
waitTimer = 0;
chase = false;

propellerTimer = 0;
animBack = false;
imgSpd = 0.25;
imgIndex = 0;
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();

if (entityCanStep())
{
    switch (phase)
    {
        // wait to chase mega man
        case 0:
            if (instance_exists(target))
            {
                waitTimer += 1;
                if (waitTimer >= 90)
                {
                    phase = 1;
                    waitTimer = 0;
                    imgIndex = 1;
                }
            }

            break;

        // look around once, and then chase mega man on the second look
        case 1:
            if (!animBack)
            {
                imgIndex += imgSpd;
                if (imgIndex >= 7)
                {
                    imgIndex = 6 - imgIndex mod 7;
                    animBack = true;
                }
            }
            else
            {
                imgIndex -= imgSpd;
                if (imgIndex < 1)
                {
                    if (!chase)
                    {
                        imgIndex = 2;
                        animBack = false;
                        chase = true;
                        calibrateDirection();

                        if (instance_exists(target))
                        {
                            direction = point_direction(x, y, target.x, target.y);
                        }
                    }
                    else
                    {
                        phase = 0;
                        chase = false;
                        direction = 0;
                        animBack = false;
                        imgIndex = 0;
                    }
                }
            }

            if (chase)
            {
                speed = 1.5;
            }
            else
            {
                speed = 0;
            }

            break;
    }

    // animate propeller
    propellerTimer += 1;
    if (propellerTimer >= 3) // <-=1 propeller animation speed here
    {
        if (sprite_index == sprPropellerEyePropeller1)
        {
            sprite_index = sprPropellerEyePropeller2;
        }
        else
        {
            sprite_index = sprPropellerEyePropeller1;
        }

        propellerTimer = 0;
    }
}
else
{
    speed = 0;

    if (dead)
    {
        phase = 0;
        waitTimer = 0;
        chase = false;

        direction = 0;

        animBack = false;
        imgIndex = 0;
        propellerTimer = 0;
    }
}

image_index = imgIndex div 1;
#define Other_21
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if (phase != 1)
{
    other.guardCancel = 1;
}
