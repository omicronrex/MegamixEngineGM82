#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
// Yes, that's really his name. Don't make fun of it; he had a rough childhood. :( Mama Birdy
// had other Chuncos to feed, and now he takes his aggression out on Mega Man via
// shooting projectiles and chasing him.

event_inherited();

healthpointsStart = 1;

contactDamage = 4;
grav = 0;
imgSpd = 0.16;
facePlayerOnSpawn = true;
shootTimer = 120;
moveTimer = 120;
phase = 0;

category = "nature, bird";

blockCollision = false;
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();

if (entityCanStep())
{
    image_index += imgSpd;

    if (instance_exists(target))
    {
        switch (phase)
        {
            case 0:
                moveTimer-=1;
                if (moveTimer > 120)
                {
                    xspeed = 1 * image_xscale;
                    yspeed = -2;
                }
                else
                {
                    xspeed = 0;
                    yspeed = 0;
                }
                if (moveTimer == 0)
                {
                    phase = 1;
                    xspeed = 1 * image_xscale;
                    if (y > target.y)
                    {
                        yspeed = -1;
                    }
                    else if (y < target.y)
                    {
                        yspeed = 1;
                    }
                    else
                    {
                        yspeed = 0;
                    }

                    moveTimer = 70;
                }
                break;
            case 1:
                moveTimer-=1;
                shootTimer-=1;
                if (shootTimer == 0)
                {
                    var getAngle; getAngle = point_direction(x, y, target.x, target.y);

                    i = instance_create(x, y, objMM5AimedBullet);
                    i.dir = getAngle + 30;
                    i.xscale = image_xscale;
                    i = instance_create(x, y, objMM5AimedBullet);
                    i.dir = getAngle - 30;
                    i.xscale = image_xscale;
                    playSFX(sfxEnemyShootClassic);

                    shootTimer = 120;
                }
                if (moveTimer == 0)
                {
                    calibrateDirection();
                    xspeed = 1 * image_xscale;
                    if (y > target.y)
                    {
                        if (y <= target.y - 32)
                        {
                            yspeed = -0.5;
                        }
                        else
                        {
                            yspeed = -1;
                        }
                    }
                    else if (y < target.y)
                    {
                        if (y >= target.y + 16)
                        {
                            yspeed = 0.5;
                        }
                        else
                        {
                            yspeed = 1;
                        }
                    }
                    else
                    {
                        yspeed = 0;
                    }
                    moveTimer = 70;
                }
                break;
        }
    }
}
else if (dead)
{
    image_index = 0;
    healthpoints = healthpointsStart;
    xspeed = 0;
    yspeed = 0;
    moveTimer = 120;
    shootTimer = 120;
}
