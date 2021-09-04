#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();

healthpointsStart = 5;
healthpoints = healthpointsStart;
contactDamage = 4;


category = "semi bulky";

facePlayer = true;

// Enemy specific code
phase = 0;
shootWait = 60;
shots = 0;
shootTimer = 0;

sinCounter = 0;

imgSpd = 0.05;
imgIndex = 0;

image_speed = 0.1;
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
        case 0: // idle
        // animation
            imgIndex = (imgIndex + imgSpd) mod 2;

            // detect when a player projectile is approaching
            with (prtEntity)
            {
                if (!dead)
                {
                    if (contactDamage)
                    {
                        if (global.factionStance[faction, other.faction])
                        {
                            if (abs(other.x - x) < 40)
                            {
                                if (bbox_bottom >= other.bbox_top && bbox_top <= other.bbox_bottom
                                    && (sign(xspeed + hspeed) == sign(other.x - x)))
                                {
                                    with (other)
                                    {
                                        phase = 2;
                                        shootTimer = 0;
                                        imgIndex = 2;
                                        xspeed = 2 * image_xscale;
                                        yspeed = -3.2; // <-- jump speed here
                                        break;
                                    }
                                }
                            }
                        }
                    }
                }
            }

            // wait to shoot
            shootTimer += 1;
            if (shots < 3)
            {
                if (shootTimer >= shootWait)
                {
                    phase = 1;
                    imgIndex = 3;
                    shootTimer = 0;
                }
            }
            else
            {
                if (shootTimer >= 130)
                {
                    shots = 0;
                    shootTimer = 0;
                }
            }

            break;
        case 1: // shoot
        // animation
            imgIndex = min(4, imgIndex + (imgSpd * 6));

            if (instance_exists(target))
            {
                shootTimer += 1;
            }

            if (shootTimer >= 30)
            {
                phase = 0;
                shootTimer = 0;
                imgIndex = 0;
                shots += 1;

                var projectileX = x + sprite_width * 0.3;
                var projectileY = y - 14;
                var projectileDirection = point_direction(projectileX, projectileY, target.x, target.y);

                var directionMax = 75; // <-- projectile angle limits here

                if (abs(((image_xscale < 0) * 180) - abs(projectileDirection - (projectileDirection > 180) * 360)) <= directionMax)
                {
                    var projectile = instance_create(projectileX, projectileY, objEnemyBullet);
                    projectile.xspeed = 0;
                    projectile.yspeed = 0;

                    projectile.spd = 2; // <-- speed here
                    projectile.dir = projectileDirection;

                    projectile.sprite_index = sprEnemyBulletMM6;

                    playSFX(sfxEnemyShoot);
                }
            }
            break;
        case 2: // jump
            if (ground)
            {
                phase = 0;
                imgIndex = 0;
                xspeed = 0;
            }
            break;
    }

    facePlayer = (phase != 2);
}
else if (dead)
{
    phase = 0;
    shootTimer = 0;
    shots = 0;
    imgIndex = 0;
}

image_index = imgIndex div 1;
