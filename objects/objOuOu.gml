#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
// A robot seal that blows a ball on its nose, bounces it, then throws it at Mega Man.
// Don't get close, or it'll run after you.

event_inherited();

healthpointsStart = 9;
contactDamage = 3;
facePlayerOnSpawn = true;

category = "aquatic, bulky, nature";

// @cc - How fast Ou-Ou's ball moves when thrown
ballSpeed = 3

// Enemy specific code
imgIndex = 0;
imgSpd = 0.2;
radius = 4 * 16;

moveTimer = 60;
phase = 0;
animBack = false;
attackTimer = 30;
bounces = 0;
hasAttacked = false;
ball = noone;
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
        // Throw Ball
        case 0:
            moveTimer-=1;
            if (moveTimer <= 0)
            {
                if (imgIndex < 7)
                {
                    imgIndex += imgSpd;

                    if (imgIndex == 1)
                    {
                        imgIndex = 4;
                    }
                } // Create ball
                else
                {
                    if (hasAttacked == false)
                    {
                        attackTimer-=1;

                        if (attackTimer <= 0)
                        {
                            if (!instance_exists(ball))
                            {
                                imgIndex = 8;
                                var i; i = instance_create(x + 4 * image_xscale, y - 11, objOuOuBall);
                                i.yspeed = -2;
                                i.yStart = i.y;
                                ball = i.id;
                            }
                            else
                            {
                                if (imgIndex < 10)
                                {
                                    imgIndex += imgSpd;
                                }

                                if (ball.y >= ball.yStart)
                                {
                                    if (bounces < 3)
                                    {
                                        imgIndex = 8;
                                        ball.y -= 2;
                                        ball.yspeed = -2;
                                        bounces+=1;
                                        playSFX(sfxBallBounce);
                                    }
                                    else
                                    {
                                        ball.y = y - 6;
                                        ball.yspeed = 0;
                                        ball.grav = 0;
                                        ball.xspeed = ballSpeed * image_xscale;
                                        hasAttacked = true;
                                        attackTimer = 10;
                                        playSFX(sfxBallBounce);
                                    }
                                }

                                if (bounces == 3)
                                {
                                    if ((imgIndex < 12) && (ball.yspeed >= 1))
                                    {
                                        imgIndex += imgSpd;
                                    }
                                }
                            }
                        }
                    }
                    else
                    {
                        if (!instance_exists(ball))
                        {
                            attackTimer-=1;
                            if (attackTimer <= 0)
                            {
                                calibrateDirection();

                                moveTimer = 60;
                                imgIndex = 0;
                                attackTimer = 30;
                                bounces = 0;
                                hasAttacked = false;
                            }
                        }
                    }
                }
            }
            else
            {
                if (instance_exists(target))
                {
                    if (distance_to_object(target) < radius)
                    {
                        imgIndex = 1;
                        phase = 1;
                    }
                }
            }
            break;
        // Walk forwards
        case 1:
            if (instance_exists(target))
            {
                if (distance_to_object(target) < radius + 16)
                {
                    xspeed = 1 * image_xscale;
                }
                else
                {
                    calibrateDirection();
                    imgIndex = 0;
                    xspeed = 0;
                    phase = 0;
                    moveTimer = 60;
                }
            }

            // Animation
            if (animBack == false)
            {
                imgIndex += imgSpd;
                if (imgIndex >= 4)
                {
                    imgIndex = 3;
                    animBack = true;
                }
            }
            else
            {
                imgIndex -= imgSpd;
                if (imgIndex < 1)
                {
                    imgIndex = 2;
                    animBack = false;
                }
            }
            if ((xcoll != 0) || (!positionCollision(x + 11 * image_xscale, bbox_bottom + 2)))
            {
                image_xscale *= -1;
                xspeed = 1 * image_xscale;
            }
            break;
    }
}
else if (dead)
{
    healthpoints = healthpointsStart;
    imgIndex = 0;
    moveTimer = 60;
    phase = 0;
    attackTimer = 30;
    bounces = 0;
    hasAttacked = false;
    if (instance_exists(ball))
    {
        with (ball)
        {
            instance_destroy();
        }
    }
}

image_index = imgIndex div 1;
#define Other_21
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if ((image_index > 3) && (image_index < 10))
{
    other.guardCancel = 1;
}
