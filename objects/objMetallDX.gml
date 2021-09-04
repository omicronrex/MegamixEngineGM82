#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
/// They fly up to Mega Man and shoot three bullets down on him.
event_inherited();

healthpointsStart = 1;
healthpoints = healthpointsStart;
contactDamage = 4;

category = "mets, flying";

facePlayerOnSpawn = true;

// Enemy specific code
radius = 5 * 16; // Five blocks; the radius that MM needs to enter to trigger the shooting of the met
cooldownTimer = 0;
canShoot = true;

animTimer = 0;
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
        if (xspeed == 0)
        {
            calibrateDirection();
        }
        if (distance_to_object(target) <= radius)
        {
            if (canShoot)
            {
                canShoot = false;
                image_index = 1;
            }
        }
    }

    if (!canShoot)
    {
        if (animTimer == 0 && cooldownTimer <= 120)
        {
            animTimer = 6;
            if (image_index == 5)
            {
                image_index = 6;
            }
            else if (image_index == 6)
            {
                image_index = 5;
            }
        }
        else
        {
            animTimer -= 1;
        }

        cooldownTimer += 1;

        if (cooldownTimer == 6 && image_index < 5)
        {
            cooldownTimer = 0;
            image_index += 1;
        }
        else if (cooldownTimer == 8)
        {
            yspeed = -2;
            grav = 0;
            blockCollision = 0;
        }
        else if (cooldownTimer == 30)
        {
            yspeed = 0;
            xspeed = 2 * image_xscale;
        }
        else if (cooldownTimer == 32 && !collision_line(x, y - 224, x, y + 224,
            target, false, true))
        {
            cooldownTimer -= 1;
        }
        else if (cooldownTimer == 33)
        {
            xspeed = 0;

            // Shoot
            var ID;
            ID = instance_create(x, spriteGetYCenter(), objMetallDXBullet);
            ID.dir = 45;
            ID.sprite_index = sprEnemyBullet;
            ID = instance_create(x, spriteGetYCenter(), objMetallDXBullet);
            ID.dir = 0;
            ID.sprite_index = sprEnemyBullet;
            ID = instance_create(x, spriteGetYCenter(), objMetallDXBullet);
            ID.dir = -45;
            ID.sprite_index = sprEnemyBullet;

            //playSFX(sfxEnemyShoot);
        }
        else if (cooldownTimer == 60)
        {
            xspeed = 0;
            yspeed = 2;
        }
        else if (cooldownTimer == 62 && !collision_line(x - 256, y, x + 256, y, target, false, true))
        {
            cooldownTimer -= 1;
        }
        else if (cooldownTimer == 63)
        {
            yspeed = 0;
            xspeed = 2 * image_xscale;
        }
    }
}
else if (dead)
{
    grav = 0.25;
    blockCollision = 1;
    cooldownTimer = 0;
    canShoot = true;
    image_index = 0;
}
#define Other_21
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if (image_index == 0)
{
    other.guardCancel = 1;
}
