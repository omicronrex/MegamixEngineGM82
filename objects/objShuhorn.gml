#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();

healthpointsStart = 3;
healthpoints = healthpointsStart;
contactDamage = 6;

category = "big eye, bulky, shielded";
facePlayerOnSpawn = true;

// Enemy Specific Code
imgIndex = 0;
imgSpd = 0.2;
phase = 0;
moveTimer = 60;
shootTimer = 30;
canShoot = true;
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
        // wait/Shoot
        case 0:
            if (instance_exists(target) && ((target.x > x + 85) || (target.x < x - 85))
                || (!instance_exists(target)))
                {
                    moveTimer--;
                    if (moveTimer <= 0)
                    {
                        if ((imgIndex < 2) && (canShoot == true))
                        {
                            imgIndex += imgSpd;
                            calibrateDirection();
                        }
                        else
                        {
                            if (canShoot == true)
                            {
                                shootTimer--;
                                if ((shootTimer <= 0) && (shootTimer > -10))
                                {
                                    imgIndex = 3;
                                }
                                else
                                {
                                    imgIndex = 2;
                                }

                                if (shootTimer == 0)
                                {
                                    var i = instance_create(x + 12 * image_xscale, y + 9, objEnemyBullet);
                                    i.xspeed = 2 * image_xscale;
                                    i.contactDamage = 3;
                                    playSFX(sfxEnemyShootClassic);
                                }

                                if (shootTimer <= -30)
                                {
                                    canShoot = false;
                                }
                            }
                            else
                            {
                                imgIndex -= imgSpd;
                                if (imgIndex == 0)
                                {
                                    moveTimer = 60;
                                    shootTimer = 30;
                                    canShoot = true;
                                }
                            }
                        }
                    }
                }
                else
                {
                    phase = 1;
                    moveTimer = 60;
                    shootTimer = 30;
                    canShoot = true;
                    calibrateDirection();
                }
                break;
        // Jump
        case 1:
            imgIndex += imgSpd;
            if (imgIndex == 3)
            {
                imgIndex = 4;
                phase = 2;
                xspeed = 1 * image_xscale;
                yspeed = -5;
            }
            break;
        case 2:
            if (!ground)
            {
                if (imgIndex < 5)
                {
                    imgIndex += imgSpd;
                }
            }
            else
            {
                xspeed = 0;
                if (imgIndex == 5)
                {
                    screenShake(4, 1, 3);
                    with (objMegaman)
                    {
                        if (ground) // shunt mega man off the floor to prevent sliding and break dash
                        {
                            y -= 1.5 * 3; //( irandom(3) + 1);
                        }
                    }
                    playSFX(sfxBikkyLand);
                }
                if (imgIndex > 2)
                {
                    imgIndex--;
                    if (imgIndex == 3)
                    {
                        imgIndex = 2;
                    }
                }
                else
                {
                    moveTimer--;
                    if (moveTimer <= 50)
                    {
                        imgIndex = 0;

                        if (moveTimer == 0)
                        {
                            phase = 0;
                        }
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
    moveTimer = 60;
    shootTimer = 30;
    canShoot = true;
}
image_index = imgIndex div 1;
#define Other_21
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();
if (floor(imgIndex > 1))
{
    if ((floor(imgIndex == 2)) || (floor(imgIndex == 3)))
    {
        if (!collision_rectangle(x - 11 * image_xscale, y-7, x+9 * image_xscale, y+4, other, false, true))
        {
            other.guardCancel = 1;
        }
    }
    else if (floor(imgIndex == 4))
    {
        if (collision_rectangle(x - 11 * image_xscale, y-14, x + 9 * image_xscale, y-4, other, false, true))
        {
            other.guardCancel = 0;
        }
        else
        {
            other.guardCancel = 1;
        }
    }
    else if (floor(imgIndex == 5))
    {
        if (collision_rectangle(x - 11 * image_xscale, y-22, x + 9 * image_xscale, y-12, other, false, true))
        {
            other.guardCancel = 0;
        }
        else
        {
            other.guardCancel = 1;
        }
    }
}
else
{
    other.guardCancel = 1;
}
