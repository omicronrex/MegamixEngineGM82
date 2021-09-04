#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();

healthpointsStart = 2;
healthpoints = healthpointsStart;
contactDamage = 4;

category = "mets";

facePlayer = true;

// Enemy specific code
radius = 72; // Four blocks; the radius that MM needs to enter to trigger the shooting of the met
cooldownTimer = 0;
canShoot = true;
hasFired = false;
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();
if (entityCanStep())
{
    if (canShoot)
    {
        if (instance_exists(target))
        {
            if (distance_to_object(target) <= radius && ground)
            {
                canShoot = false;
                yspeed = -2.5;
            }
        }
    }
    if (!ground)
    {
        image_index = 1;
    }
    if (ground && image_index == 1)
    {
        image_index = 0;
    }
    if (!canShoot)
    {
        if (ground)
        {
            cooldownTimer += 1;
        }
        if (yspeed > -1.5 && !hasFired)
        {
            hasFired = true;
            i = instance_create(x + image_xscale * 8, spriteGetYCenter() + 4, objMM2MetBullet);
            i.dir = 0;
            i.image_xscale = image_xscale;
            playSFX(sfxEnemyShootClassic);
        }
        if (cooldownTimer < 10 && ground)
        {
            image_index = 2;
        }
        else if (cooldownTimer == 10)
        {
            image_index = 0;
        }
        else if (cooldownTimer >= 80)
        {
            canShoot = true;
            cooldownTimer = 0;
            hasFired = false;
        }
    }
}
else if (dead)
{
    cooldownTimer = 0;
    canShoot = true;
    image_index = 0;
    hasFired = false;
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
