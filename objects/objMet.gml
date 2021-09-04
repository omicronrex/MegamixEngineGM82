#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
// Another one of the early Mets. When Megaman approaches it, it will shoot its bullets,
// then charge at the player, before stopping and repeating the process again.

event_inherited();


healthpointsStart = 1;
healthpoints = healthpointsStart;
contactDamage = 4;

category = "mets";

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
        // Face player
        if (xspeed == 0 && ground)
        {
            calibrateDirection();
        }

        // check if the player is near
        if (distance_to_object(target) <= radius)
        {
            // only start animations if canShoot == true
            if (canShoot)
            {
                canShoot = false;
                image_index = 1;
                animTimer = 8;
            }
        }
    }

    // If it's been approached, start going through the animations
    if (!canShoot)
    {
        // Animation timers, etc
        if (animTimer == 0 && cooldownTimer <= 120)
        {
            animTimer = 6;
            if (image_index == 2)
            {
                image_index = 3;
            }
            else if (image_index == 1 || image_index == 3)
            {
                image_index = 2;
            }
            else
            {
                image_index = 0;
            }
        }
        else
        {
            animTimer -= 1;
        }

        cooldownTimer += 1;

        // Action timers
        switch (cooldownTimer)
        {
            case 8: // Shoot
            // bullet shooting!
                var ID;
                for (i = -1; i <= 1; i += 1)
                {
                    ID = instance_create(x + image_xscale * 8, spriteGetYCenter(), objMM2MetBullet);
                    ID.dir = 45 * i;
                    ID.image_xscale = image_xscale;
                    ID.sprite_index = sprEnemyBullet;
                }
                playSFX(sfxEnemyShootClassic);
                break;
            case 60: // run towards player
                xspeed = 2 * image_xscale;
                break;
            case 100: // reset xspeed and imagespeed
                image_index = 0;
                xspeed = 0;
                animTimer = 8;
                break;
            case 180: // resetting canShoot is later to allow a cooldown
                canShoot = true;
                cooldownTimer = 0;
                break;
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
