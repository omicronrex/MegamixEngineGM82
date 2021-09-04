#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();
doesIntro = false;

healthpointsStart = 9;
healthpoints = healthpointsStart;
contactDamage = 6;

blockCollision = false;
grav = 0;

category = "flying";
facePlayer = true;

// Enemy specific code
phase = 0;
image_speed = 1;
moveTimer = 120;
shootTimer = 60;
accel = 0.05;
cosCounter = 0;
sinCounter = 0;
dives = 0;
ySpePrev = 0;
missile = noone;
safety = 0;
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
            if (dives > 0)
            {
                sinCounter += .065;
                ySpePrev = sign(yspeed);
                yspeed = sin(sinCounter) * 1.3;

                if (sign(yspeed) != ySpePrev)
                {
                    dives--;
                }
            }
            else
            {
                cosCounter += .135;
                yspeed = -(cos(cosCounter) * 0.5);

                moveTimer--;
                if (moveTimer <= 0)
                {
                    xspeed += accel * image_xscale;
                    yspeed = 0;
                    phase = 1;
                }
            }
            break;
        case 1: // Bob up and down
            cosCounter += .135;
            yspeed = -(cos(cosCounter) * 0.5);

            // Move horizontally
            if (xspeed != 2 * image_xscale)
            {
                xspeed += accel * image_xscale;
            }

            // Failsafes against going offscreen
            if ((bbox_left < view_xview + 32) && (image_xscale == -1))
            {
                if (xspeed != 0)
                {
                    xspeed += 0.10;
                }
            }

            if ((bbox_right > (view_xview + view_wview) - 32) && (image_xscale == 1))
            {
                if (xspeed != 0)
                {
                    xspeed -= 0.10;
                }
            }

            // If not moving, attack
            if (xspeed == 0)
            {
                phase = 0;
                moveTimer = 60;
                if (sign(yspeed) == 1)
                {
                    dives = 6;
                }
                else
                {
                    dives = 7;
                }
            }
            break;
    }

    shootTimer--;
    if (shootTimer == 0)
    {
        var i = instance_create(x + 10 * image_xscale, y + 10, objEnemyBullet);
        i.xspeed = 2 * image_xscale;
        i.yspeed = 2;
        playSFX(sfxEnemyShootClassic);
    }
    if (shootTimer == -10)
    {
        var i = instance_create(x + 10 * image_xscale, y + 10, objEnemyBullet);
        i.xspeed = 2 * image_xscale;
        i.yspeed = 2;
        playSFX(sfxEnemyShootClassic);
    }
    if (shootTimer == -20)
    {
        var i = instance_create(x + 10 * image_xscale, y + 10, objEnemyBullet);
        i.xspeed = 2 * image_xscale;
        i.yspeed = 2;
        playSFX(sfxEnemyShootClassic);
    }

    if (shootTimer == -60)
    {
        if (!instance_exists(missile)) && (instance_exists(target))
        {
            var i = instance_create(x + 10 * image_xscale, y + 10, objHyoeyMissile);
            if (image_index == -1)
            {
                i.image_index = 5;
            }
            else
            {
                i.image_index = 7;
            }
            missile = i.id;
            i.parent = id;
            i.direction = point_direction(x, y, target.x, target.y);
            playSFX(sfxMissileLaunch);
        }
        shootTimer = 180;
    }

    // Play audio as long as Hyoey can move
    if (!audio_is_playing(sfxHeliButonHover))
    {
        loopSFX(sfxHeliButonHover);
    }
}
else
{
    // Stop audio if time is stopped/Hyoey is dead
    audio_stop_sound(sfxHeliButonHover);
}
