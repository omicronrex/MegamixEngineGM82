#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
// Creation code (all optional):
// gravityFlip = true;   -  determine the direction of where this sits. if true, it starts on the cieling.)

event_inherited();

respawn = true;

healthpointsStart = 3;
healthpoints = healthpointsStart;
contactDamage = 4;
category = "grounded, semi bulky";
enemyDamageValue(objThunderBeam, 5);

grav = gravAccel * image_yscale;

facePlayer = true;

// Enemy specific code
shooting = false;
cooldownTimer = 0;
cooldownTimerMax = 80;
flipOverTimer = 0;

ground = false;
hasFired = false;

imageOffset = 0;

gravityFlip = false;

myGrav = 1;
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();

image_yscale = sign(grav);
image_index = imageOffset;

if (entityCanStep() && instance_exists(target))
{
    if (instance_exists(target))
    {
        grav = gravAccel * sign(target.image_yscale);
    }

    y += yspeed;

    if (yspeed != 0)
    {
        flipOverTimer += 1;
        if (flipOverTimer > 4)
            imageOffset = 4;
        else
            imageOffset = 3;
    }
    else
    {
        flipOverTimer = 0;
        cooldownTimer += 1;
        if (cooldownTimer < cooldownTimerMax - 10)
            imageOffset = 0;
        else if (cooldownTimer >= cooldownTimerMax - 10
            && cooldownTimer < cooldownTimerMax - 5)
            imageOffset = 1;
        else
            imageOffset = 2;

        if (cooldownTimer == cooldownTimerMax)
        {
            cooldownTimer = 0;
            hasFired = false;
        }

        if (imageOffset == 1 && hasFired == false)
        {
            hasFired = true;
            var ID;
            ID = instance_create(x, spriteGetYCenter() + (3 * sign(grav)),
                objMM2MetBullet);
            {
                ID.dir = 180;
                ID.image_xscale = image_xscale;
                ID.sprite_index = sprEnemyBullet;
            }
            ID = instance_create(x, spriteGetYCenter() + (3 * sign(grav)),
                objMM2MetBullet);
            {
                ID.dir = 0;
                ID.image_xscale = image_xscale;
                ID.sprite_index = sprEnemyBullet;
            }

            playSFX(sfxEnemyShoot);
        }
    }
}
else if (dead)
{
    shootTimer = 0;
    image_index = 0;
    grav = gravAccel * image_yscale; // Note: gravAccel is a macro
}
