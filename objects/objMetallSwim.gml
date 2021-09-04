#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();

healthpointsStart = 1;
healthpoints = healthpointsStart;
contactDamage = 3;

category = "mets, aquatic";

facePlayerOnSpawn = true;

grav = 0.1;

// Enemy specific code
radius = 4 * 16; // Four blocks; the radius that MM needs to enter to trigger the shooting of the met
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
                if (cooldownTimer >= 0)
                {
                    image_index = 1;
                }
            }
        }
    }

    if (yspeed > 0 && image_index == 5)
    {
        image_index = 4;
    }

    if (ground && image_index > 3)
    {
        canShoot = true;
        cooldownTimer = -70;
        xspeed = 0;
        animTimer = 24;
        image_index = 3;
    }
    if (animTimer > 0)
    {
        animTimer -= 1;
    }
    if (animTimer == 16 || animTimer == 8 || animTimer == 1)
    {
        image_index -= 1;
    }

    if (!canShoot)
    {
        cooldownTimer += 1;
        if (cooldownTimer == 1)
        {
            image_index = 1;
        }
        else if (cooldownTimer == 8)
        {
            image_index = 2;
        }
        else if (cooldownTimer == 16)
        {
            image_index = 3;
            yspeed = -2.5;
            if (distance_to_object(target) > 48)
            {
                xspeed = 0.75 * image_xscale;
            }
        }
        else if (cooldownTimer == 24)
        {
            image_index = 4;
        }
        else if (cooldownTimer == 32)
        {
            image_index = 5;

            // Shoot
            for (i = -1; i < 2; i += 1)
            {
                ID = instance_create(x + image_xscale * 8, spriteGetYCenter(), objMM4MetBullet);
                ID.dir = 45 * i;
                ID.xscale = image_xscale;
                ID.sprite_index = sprEnemyBullet;
            }
            //playSFX(sfxEnemyShoot);
        }
        else if (cooldownTimer == 90)
        {
            image_index = 4;
            yspeed = -1.5;
            if (distance_to_object(target) > 48)
            {
                xspeed = .75 * image_xscale;
            }
            cooldownTimer = 25;
        }
    }

    if (!inWater && yspeed < 0)
    {
        yspeed = 0;
    }
}
else if (dead)
{
    animTimer = 0;
    cooldownTimer = 0;
    canShoot = true;
    image_index = 0;
    image_speed = 0;
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
