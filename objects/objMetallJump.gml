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

category = "mets";

facePlayerOnSpawn = true;

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
if(xcoll!=0)
{
    xspeed=xcoll;
}
if (entityCanStep())
{
    // trigger shooting variable if the target is near
    if (instance_exists(target))
    {
        // if not moving, face the player
        if (xspeed == 0)
        {
            calibrateDirection();
        }

        // check if the target is in range
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

    // landing animation
    if (ground && image_index == 5)
    {
        canShoot = true;
        cooldownTimer = -40;
        xspeed = 0;
        animTimer = 16;
        image_index = 4;
    }
    if (animTimer > 0)
    {
        animTimer -= 1;
    }
    if (animTimer == 12 || animTimer == 8 || animTimer == 4 || animTimer == 1)
    {
        image_index -= 1;
    }

    // canShoot = false is telling the met to do its shooting animation basically
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
        else if (cooldownTimer == 12)
        {
            image_index = 3;
        }
        else if (cooldownTimer == 16)
        {
            image_index = 4;

            // Shoot
            var ID;
            for (i = -1; i <= 1; i += 1)
            {
                ID = instance_create(x + image_xscale * 8, spriteGetYCenter(), objMM4MetBullet);
                ID.dir = 45 * i;
                ID.xscale = image_xscale;
                ID.sprite_index = sprEnemyBullet;
            }
            //playSFX(sfxEnemyShoot);
        }
        else if (cooldownTimer == 35)
        {
            image_index = 5;

            // jump jump
            if (ground)
            {
                yspeed = choose(-2.5, -4.5);
            }
            xspeed = 1 * image_xscale;
        }
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
