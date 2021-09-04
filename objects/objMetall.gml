#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
/// It's an upgrade of the Neo Metall from Mega Man 2. It now has feet and can walk.
event_inherited();

healthpointsStart = 1;
healthpoints = healthpointsStart;
contactDamage = 4;

category = "mets";

facePlayerOnSpawn = true;

// Enemy specific code
radius = 4
    * 16; // Four blocks; the radius that MM needs to enter to trigger the shooting of the met
cooldownTimer = 0;
canShoot = true;
canBounce = true;

animTimer = 0;
isFromMiniboss = false;
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();

xs = xspeed;
if (!ground)
{
    xspeed = 0;
}

if (entityCanStep())
{
    xspeed = xs;

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
        if (animTimer == 0 && cooldownTimer <= 120 && image_index > 1)
        {
            animTimer = 6;
            if (image_index == 3)
            {
                image_index = 4;
            }
            else if (image_index == 4)
            {
                image_index = 3;
            }
        }
        else
        {
            animTimer -= 1;
        }

        cooldownTimer += 1;

        if (cooldownTimer == 8)
        {
            image_index = 2;

            // Shoot
            var ID;
            ID = instance_create(x + image_xscale * 8, spriteGetYCenter(), objMM3MetBullet);
            ID.dir = sign(image_xscale) * 45;
            ID.xscale = image_xscale;
            ID.sprite_index = sprEnemyBullet;
            ID = instance_create(x + image_xscale * 8, spriteGetYCenter(), objMM3MetBullet);
            ID.dir = 0;
            ID.xscale = image_xscale;
            ID.sprite_index = sprEnemyBullet;
            ID = instance_create(x + image_xscale * 8, spriteGetYCenter(), objMM3MetBullet);
            ID.dir = sign(image_xscale) * -45;
            ID.xscale = image_xscale;
            ID.sprite_index = sprEnemyBullet;

            //playSFX(sfxEnemyShoot);
        }
        else if (cooldownTimer == 60)
        {
            image_index = 3;
            animTimer = 6;
            xspeed = 1.5 * image_xscale;
        }
        else if (cooldownTimer == 100)
        {
            image_index = 0;
            xspeed = 0;
            animTimer = 6;
        }
        else if (cooldownTimer == 160)
        {
            canShoot = true;
            cooldownTimer = 0;
        }
    }

    if (isFromMiniboss)
    {
        if (checkSolid(xspeed, 0))
        {
            instance_create(bboxGetXCenter(), bboxGetYCenter(), objExplosion);
            instance_destroy();
        }

        if (ground)
        {
            if (canBounce)
            {
                yspeed = -3;
                canBounce = false;
            }
            else
            {
                xspeed = 2.5 * image_xscale;
            }
        }
    }
}
else if (dead)
{
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
