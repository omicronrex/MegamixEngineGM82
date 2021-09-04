#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
// A robot armadillo from Mars's stage that fires homing missiles and slides around in a
// hard, nigh impervious shell. Also Armored Armadillo's ancestor?! :connection_to_the_x_series:

event_inherited();

healthpointsStart = 8;
contactDamage = 4;
facePlayerOnSpawn = true;

category = "nature, semi bulky";
missile = noone;
radius = 4 * 16;

imgIndex = 0;
imgSpd = 0.2;
animBack = false;
phase = 0;
shotsFired = 0;
moveTimer = 30;
spinTimer = 120;
hasLooped = 0;
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
        // Shoot
        case 0:
            if (instance_exists(target)) && (distance_to_object(target) > radius)
                && (distance_to_object(target) <= radius * 2)
            {
                imgIndex += 0.1;
                if (imgIndex == 1)
                {
                    imgIndex = 3;
                    var i = instance_create(x - 16 * image_xscale, y - 16, objArmaroidMissile);
                    missile = i.id;
                    if (image_index == -1)
                    {
                        i.image_index = 1;
                        i.direction = 135;
                    }
                    else
                    {
                        i.image_index = 3;
                        i.direction = 45;
                    }
                    i.parent = id;
                    playSFX(sfxMissileLaunch);
                    shotsFired++;
                }
                else if (imgIndex == 4)
                {
                    imgIndex = 0;
                    phase = 1;
                }

            }
            else
                phase = 1;
            break;
        // Idle
        case 1:
            if (animBack == false)
            {
                imgIndex += 0.1;
                if (imgIndex == 3)
                {
                    imgIndex = 2;
                    animBack = true;
                }
            }
            else
            {
                imgIndex -= 0.1;
                if (imgIndex < 0)
                {
                    imgIndex = 0;
                    animBack = false;
                    hasLooped = 1;
                }
            }
            if (instance_exists(target))
            {
                if ((!instance_exists(missile)) && (imgIndex < 1))
                {
                    phase = 0;
                }
                if (distance_to_object(target) <= radius)
                {
                    if ((imgIndex == 0) && (hasLooped == 1) || (imgIndex == 0) && (shotsFired == 2))
                    {
                        imgIndex = 3;
                        phase = 2;
                        animBack = false;
                    }
                }
            }
            break;
        // Go into shell
        case 2:
            if (imgIndex < 5)
            {
                imgIndex += imgSpd;
            }
            else
            {
                phase = 3;
                hasLooped = 0;
                shotsFired = 0;
            }
            break;
        // Spin
        case 3:
            moveTimer--;
            if (moveTimer <= 0)
            {
                spinTimer--;
                if (spinTimer > 0)
                {
                    if (spinTimer <= 90)
                    {
                        xspeed = 2 * image_xscale;
                    }

                    if ((xcoll != 0) || (!positionCollision(x + 10 * image_xscale, bbox_bottom + 2)))
                    {
                        image_xscale *= -1;
                    }

                    if (animBack == false)
                    {
                        imgIndex += imgSpd;
                        if (imgIndex == 8)
                        {
                            imgIndex = 7;
                            animBack = true;
                        }
                    }
                    else
                    {
                        imgIndex -= imgSpd;
                        if (imgIndex == 5)
                        {
                            imgIndex = 6;
                            animBack = false;
                        }
                    }
                }
                else
                {
                    calibrateDirection();
                    xspeed = 0;
                    imgIndex -= imgSpd;

                    if (imgIndex >= 7)
                    {
                        image_xscale *= -1;
                        imgIndex = 4;
                    }

                    if (imgIndex < 3)
                    {
                        imgIndex = 0;
                        if (instance_exists(missile))
                        {
                            phase = 1;
                        }
                        else
                        {
                            phase = 0;
                        }
                        moveTimer = 30;
                        spinTimer = 120;
                    }
                }
            }
                break;
    }
}
else if (dead)
{
    healthpoints = healthpointsStart;
    imgIndex = 0;
    phase = 0;
    animBack = false;
    shotsFired = 0;
    hasLooped = 0;
    moveTimer = 30;
    spinTimer = 120;
}
image_index = imgIndex div 1;
#define Other_21
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if (phase == 3)
{
    other.guardCancel = 1;
}
