#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();

facePlayerOnSpawn = true;

healthpointsStart = 4;
healthpoints = healthpointsStart;

contactDamage = 3;

// Enemy specific code
imgSpd = 0.16;
phase = 0;
canShoot = false;
radius = 4 * 16;
shotsLeft = 4;
jumps = 2;
animTimer = 8;
xspeed = 0;
yspeed = 0;
jumpTimer = 40;
shootTimer = 60;
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
        case 0: // Jump/Shoot
            if (ground)
            {
                if (canShoot == false)
                {
                    jumpTimer -= 1;
                    if (jumpTimer <= 0)
                    {
                        calibrateDirection();
                        image_index += imgSpd;
                        if (image_index >= 3)
                        {
                            y -= 4;
                            yspeed = -4.5;
                            jumps-=1;
                            phase = 1;
                        }
                    }
                }

                // Shoot
                if (instance_exists(target))
                {
                    if (canShoot == true)
                    {
                        shootTimer-=1;
                        if (shootTimer <= 5)
                        {
                            image_index = 4;
                        }

                        if (shootTimer == 0)
                        {
                            i = instance_create(x + 8 * image_xscale, y, objPalmHopperMissile);
                            playSFX(sfxMissileLaunch);
                            i.xspeed = 2 * image_xscale;
                            i.image_xscale = image_xscale;
                            shotsLeft-=1;
                            if (shotsLeft > 0)
                            {
                                shootTimer = 60;
                                image_index = 0;
                            }
                            else
                            {
                                canShoot = false;
                                image_index = 0;
                            }
                        }
                    }
                }
            }
            break;
        case 1: // Jumping
            xspeed = image_xscale * 2;

            // Landing
            if (ground)
            {
                xspeed = 0;
                image_index = 1;
                animTimer-=1;

                if (animTimer <= 0)
                {
                    image_index = 0;
                    if (instance_exists(target))
                    {
                        if ((distance_to_object(target) <= radius) || (jumps == 0))
                        {
                            canShoot = true;
                            shotsLeft = 4;
                            shootTimer = 60;
                        }
                    }
                    jumpTimer = 40;
                    phase = 0;
                    animTimer = 8;
                }
            }
            break;
    }
}
else if (dead)
{
    phase = 0;
    jumpTimer = 40;
    shootTimer = 60;
    jumps = 2;
    shotsLeft = 4;
    canShoot = false;
    xspeed = 0;
    yspeed = 0;
    image_index = 0;
    animTimer = 8;
}
