#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
// creation code (all optional)
// col = <number> (0 = red and green; 1 = green and red; 2 = orange and green)
// dir = <number> (1 = face right (default); -1 = face left (default);

event_inherited();

healthpointsStart = 3;
healthpoints = healthpointsStart;
contactDamage = 3;

category = "cannons";

grav = 0;
blockCollision = false;

// creation code
col = 0;

// enemy specific code
phase = 0;
shootTimer = 0;

turnSet = 1;
imgSpd = 0.2;
imgIndex = 0;

delay = 75;
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
        case 0:
            if (instance_exists(target))
            {
                if (sign(image_xscale) == sign(target.x - x))
                {
                    shootTimer += 1;
                    if (shootTimer >= delay) // <-=1 wait time between shots here
                    {
                        phase = 1;
                        shootTimer = 0;
                        imgIndex = 1 * turnSet;
                    }

                    megaDir = point_direction(x, y, target.x, target.y);

                    if (image_xscale > 0)
                    {
                        if (megaDir > 22.5 && megaDir < 180)
                        {
                            turnSet = 0;
                        }
                        else if (megaDir < 337.5 && megaDir >= 180)
                        {
                            turnSet = 2;
                        }
                        else
                        {
                            turnSet = 1;
                        }
                    }
                    else
                    {
                        if (megaDir < 157.5)
                        {
                            turnSet = 0;
                        }
                        else if (megaDir > 202.5)
                        {
                            turnSet = 2;
                        }
                        else
                        {
                            turnSet = 1;
                        }
                    }
                }
            }
            imgIndex = turnSet * 3;
            break;
        case 1:
            imgIndex += imgSpd;
            if (imgIndex >= 3 * turnSet + 2 && shootTimer == 0)
            {
                shootTimer = 1; // I used shootTimer as a boolean   :P

                shotX = x;
                if (turnSet == 1)
                {
                    shotX += sprite_width * 0.5;
                }
                else
                {
                    shotX += sprite_width * 0.3;
                }

                shotY = y;
                if (turnSet == 0)
                {
                    shotY -= sprite_height * 0.4;
                }
                else if (turnSet == 2)
                {
                    shotY += sprite_height * 0.4;
                }

                shotDir = 0;
                if (image_xscale > 0)
                {
                    if (turnSet == 0)
                    {
                        shotDir = 45;
                    }
                    if (turnSet == 1)
                    {
                        shotDir = 0;
                    }
                    if (turnSet == 2)
                    {
                        shotDir = 315;
                    }
                }
                else
                {
                    if (turnSet == 0)
                    {
                        shotDir = 135;
                    }
                    if (turnSet == 1)
                    {
                        shotDir = 180;
                    }
                    if (turnSet == 2)
                    {
                        shotDir = 225;
                    }
                }

                i = instance_create(shotX, shotY, objEnemyBullet);
                i.sprite_index = sprEnemyBulletMM6;
                i.speed = 1.3;
                i.direction = shotDir;
                playSFX(sfxEnemyShoot);
            }
            if (imgIndex >= 3 * turnSet + 3 && shootTimer == 1)
            {
                phase = 0;
                imgIndex = 3 * turnSet;
                shootTimer = 0;
            }
            break;
    }
}
else if (dead)
{
    phase = 0;
    shootTimer = 0;
    turnSet = 0;
    imgIndex = 0;
}

image_index = imgIndex div 1;
#define Other_4
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
/// creation code setup
switch (col)
{
    case 0:
        sprite_index = sprWallBlaster2Col1;
        break;
    case 1:
        sprite_index = sprWallBlaster2Col2;
        break;
    case 2:
        sprite_index = sprWallBlaster2Col3;
        break;
}
