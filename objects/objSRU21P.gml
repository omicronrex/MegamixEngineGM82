#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();

healthpointsStart = 1;
healthpoints = healthpointsStart;
contactDamage = 4;

category = "aquatic";

grav = 0; // moves at a constant speed when falling

// Enemy specific code
phase = 0;
explodeTimer = 0;
explodeWait = 130;
waterY = 0;

imgSpd = 0.3;
imgIndex = 0;

visible = false;
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
        // wait for mega man
        case 0:
            visible = false;
            canHit = false;
            if (instance_exists(target))
            {
                if (abs(target.x - x) < 64)
                {
                    phase = 1;
                    yspeed = 2.4;
                    visible = true;
                    canHit = true;
                }
            }
            break;

        // fall
        case 1:
            water = instance_place(x, y + yspeed, objWater);
            if (!instance_exists(water))
            {
                if (ground)
                {
                    instance_create(x, y, objExplosion);
                    healthpoints = 0;
                    event_user(EV_DEATH);
                    playSFX(sfxEnemyHit);
                }
            }
            else
            {
                phase = 2;
                waterY = water.y;
            }
            break;

        // bob down
        case 2:
            yspeed -= 0.15;
            if (yspeed < 0 && y < waterY)
            {
                phase = 3;
            }
            else if (yspeed <= 0)
            {
                imgIndex = 1;
            }
            break;

        // bob up
        case 3:
            yspeed += 0.21;
            if (y >= waterY)
            {
                phase = 4;
                yspeed = 0;
            }

        // count down to explode
        case 4:
            explodeTimer += 1;
            if (explodeTimer >= explodeWait - 80)
            {
                if (explodeTimer < explodeWait - 40)
                {
                    imgIndex += imgSpd;
                }
                else
                {
                    imgIndex += imgSpd * 2;
                }

                if (imgIndex >= 3)
                {
                    imgIndex = 1;
                }
            }

            // slight bob from the water
            if (explodeTimer mod 40 == 0)
            {
                y -= 1;
            }
            else if (explodeTimer mod 20 == 0)
            {
                y += 1;
            }
            if (explodeTimer >= explodeWait)
            {
                offset = 45;

                d = instance_create(x, y, objSRU21PDebris);
                d.direction = 90 + offset;
                d.image_index = 0;

                d = instance_create(x, y, objSRU21PDebris);
                d.direction = 90;
                d.image_index = 1;

                d = instance_create(x, y, objSRU21PDebris);
                d.direction = 90 - offset;
                d.image_index = 2;

                instance_create(x, y, objExplosion);

                healthpoints = 0;
                event_user(EV_DEATH);
                playSFX(sfxEnemyHit);
            }
            break;
    }
}
else if (dead)
{
    phase = 0;
    explodeTimer = 0;
    yspeed = 0;
    imgIndex = 0;
    visible = false;
    inWater = false;
    canHit = false;
}

image_index = imgIndex div 1;
