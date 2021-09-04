#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
/// It can shoot straight shots in both directions, and arc shots when Mega Man gets close to it.
event_inherited();

healthpointsStart = 3;
healthpoints = healthpointsStart;
contactDamage = 4;

category = "cannons";

// Enemy specific code
shootTimer1 = 0;
shootTimer2 = 0;
shooting2 = false;
spriteTimer = 0;

image_speed = 8 / 60;
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();

if (entityCanStep())
{
    // Shooting normal bullets
    shootTimer1 += 1;
    var shootTimerInterval;
    shootTimerInterval = 30;
    if (shootTimer1 == shootTimerInterval
        || shootTimer1 == shootTimerInterval * 2
        || shootTimer1 == shootTimerInterval * 3)
    {
        i = instance_create(bbox_left - 4, y - 12, objEnemyBullet);
        i.xspeed = -2;
        i.dir = 180;
        i = instance_create(bbox_right + 4, y - 12, objEnemyBullet);
        i.xspeed = 2;
        i.dir = 0;
    }

    if (shootTimer1 >= shootTimerInterval * 4.5)
    {
        shootTimer1 = 0;
    }

    // Shooting gravity bullets
    if (instance_exists(target))
    {
        var dist;
        dist = point_distance(spriteGetXCenter(), spriteGetYCenter(),
            spriteGetXCenterObject(target),
            spriteGetYCenterObject(target));
        if (dist <= 100)
        {
            shootTimer2 += 1;
            var shootTimerInterval2;
            shootTimerInterval2 = 20;
            if (shootTimer2 == shootTimerInterval2
                || shootTimer2 == shootTimerInterval2 * 2)
            {
                i = instance_create(x, y - 16, objNewShotmanBullet);
                i.grav = 0.25;
                i.destX = spriteGetXCenterObject(target);
                i.destY = spriteGetYCenterObject(target);
                i.yspeed = -5;
                i.stopAtSolid = 1;

                spriteTimer = 5;
                sprite_index = sprNewShotmanShoot;
            }

            if (shootTimer2 >= shootTimerInterval2 * 6)
            {
                shootTimer2 = 0;
            }
        }
    }

    // Sprites
    if (spriteTimer > 0)
    {
        spriteTimer -= 1;
        if (spriteTimer <= 0)
        {
            sprite_index = sprNewShotman;
        }
    }
}
else if (dead)
{
    shootTimer1 = 0;
    shootTimer2 = 0;
    shooting2 = 0;
    spriteTimer = 0;
    sprite_index = sprNewShotman;
    image_index = 0;
}
