#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();

respawn = true;

healthpointsStart = 5;
healthpoints = healthpointsStart;
contactDamage = 4;
category = "cannons";

blockCollision = 0;
grav = 0;

// Enemy specific code
xspeed = 0;
yspeed = 0;
timer = 0;

currentAngle = 90;

animTimer = 0;
animImage = 0;

shootTimer = 0;
shootTimerMax = 120;
shooting = false;
shootCount = 0;
shootImage = 0;
currentShootCount = 0;

image_speed = 0;
image_index = 0;

init = 0;
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
// Setup
if (init == 0)
{
    dir = image_xscale;
    angle = 90;
    init = 1;
}

event_inherited();

if (entityCanStep())
{
    // Animation
    animTimer += 1;
    if (animTimer >= 7)
    {
        animTimer = 0;
        if (animImage == 0)
            animImage = 1;
        else
            animImage = 0;
    }


    // Determine angle
    if (instance_exists(target))
    {
        if ((spriteGetXCenterObject(target) <= x && image_xscale == -1)
            || (spriteGetXCenterObject(target) >= x && image_xscale == 1))
        {
            var newAngle = point_direction(x, spriteGetYCenter(), spriteGetXCenterObject(target),
                spriteGetYCenterObject(target));
            var angleSpd = 5;

            if (abs(newAngle - currentAngle) > angleSpd && abs(abs(newAngle - currentAngle) - 360) > angleSpd)
            {
                var angleDir;
                if ((newAngle > currentAngle && !(currentAngle < 270 && newAngle >= 270)) || (newAngle <= 90 && currentAngle >= 270))
                    angleDir = 1;
                else
                    angleDir = -1;

                currentAngle += angleDir * angleSpd;
            }
            else
                currentAngle = newAngle;

            currentAngle = wrapAngle(currentAngle);
        }
    }


    // Start shooting
    if (shooting == false)
    {
        if (instance_exists(target))
        {
            if ((spriteGetXCenterObject(target) <= x && image_xscale == -1)
                || (spriteGetXCenterObject(target) >= x && image_xscale == 1))
            {
                timer += 1;
                if (timer >= shootTimerMax)
                {
                    timer = 0;
                    shooting = true;
                    shootTimer = 0;
                    currentShootCount = 0;

                    shootCount = choose(3, 3, 3, 3, 3, 2, 2, 1, 1);
                    shootTimerMax = irandom_range(60, 120);
                }
            }
            else
                timer = 0;
        }
    }


    // Shooting
    if (shooting == true)
    {
        var interval = 30;
        if (shootTimer % interval == 0)
        {
            if (currentShootCount >= shootCount)
                shooting = false;
            else
            {
                // Create the bullet
                var useImage = floor(image_index / 4);

                var xx, yy;
                switch (useImage)
                {
                    case 0:
                        xx = 13;
                        yy = -3;
                        break;
                    case 1:
                        xx = 18;
                        yy = 3;
                        break;
                    case 2:
                        xx = 24;
                        yy = 8;
                        break;
                    case 3:
                        xx = 27;
                        yy = 19;
                        break;
                    case 4:
                        xx = 24;
                        yy = 30;
                        break;
                    case 5:
                        xx = 18;
                        yy = 35;
                        break;
                    case 6:
                        xx = 13;
                        yy = 41;
                        break;
                    default:
                        xx = 27;
                        yy = 19;
                        break;
                }

                var ID = instance_create(x + image_xscale * (-sprite_get_xoffset(sprite_index) + xx), y - sprite_get_yoffset(sprite_index) + yy, objEnemyBullet);
                ID.dir = wrapAngle(90 - ((useImage + 1) * 22.5));
                ID.spd = 2;

                ID.xspeed = cos(degtorad(ID.dir)) * ID.spd * image_xscale;
                ID.yspeed = -sin(degtorad(ID.dir)) * ID.spd;

                currentShootCount += 1;
            }
        }

        if (shooting == true)
        {
            if (shootTimer % interval < interval / 2)
                shootImage = 1;
            else
                shootImage = 0;

            shootTimer += 1;
        }
    }
    else
        shootImage = 0;


    // Determine animation frame
    var angleImage, interval = 180 / 7;
    if (image_xscale == 1)
    {
        var useAngle;
        if (currentAngle >= 0 && currentAngle < 270)
            useAngle = 90 - currentAngle;
        else
            useAngle = 360 - currentAngle + 90;

        angleImage = floor(useAngle / interval);
    }
    else
    {
        var useAngle = currentAngle - 90;
        angleImage = floor(useAngle / interval);
    }

    image_index = (min(angleImage, 6) * 4) + animImage + (shootImage * 2);
}
else
{
    if (dead == true)
    {
        timer = 0;
        currentAngle = 90;
        animTimer = 0;
        animImage = 0;
        shooting = false;
        shootTimer = 0;
        shootTimerMax = 120;
        currentShootCount = 0;
        shootCount = 0;
        shootImage = 0;
        image_speed = 0;
        image_index = 0;
    }
}
