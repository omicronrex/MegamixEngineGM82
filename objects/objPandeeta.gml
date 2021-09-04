#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();

healthpointsStart = 6;
healthpoints = healthpointsStart;
contactDamage = 4;

category = "semi bulky, nature";

facePlayerOnSpawn = true;

// Enemy specific code
phase = 0;
shootTimer = 0;
shootWait = 80;
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();

if (entityCanStep())
{
    if (instance_exists(target))
    {
        if (shootTimer <= 0)
        {
            shootTimer = shootWait;

            if (abs(target.x - x)
                < abs(sprite_width) / 2 + 32)
            {
                // straight bullet
                bullet = instance_create(x + sprite_width * 0.3, y - 8, objEnemyBullet);
                bullet.sprite_index = sprPandeetaStraightShot;
                bullet.xspeed = 2.5 * image_xscale;
                playSFX(sfxEnemyShoot);
            }
            else
            {
                // arc bullet
                bullet = instance_create(x + sprite_width * 0.3, y - 8, objEnemyBullet);
                bullet.contactDamage = 3;
                bullet.sprite_index = sprPandeetaArcShot;
                bullet.grav = 0.15;
                bullet.yspeed = -4;
                bullet.target = target;
                bullet.xspeed = xSpeedAim(bullet.x, bullet.y, bullet.target.x, bullet.target.y, bullet.yspeed, bullet.grav);

                playSFX(sfxEnemyDrop);
            }

            image_index = 1;
        }
    }

    if (shootTimer <= shootWait - 30)
    {
        image_index = 0;
        calibrateDirection();
    }

    shootTimer -= 1;
}
else if (dead)
{
    phase = 0;
    shootTimer = shootWait;
}
