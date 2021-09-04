#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
/// Launches missiles from his mouth and waits, usually placed over Kabatoncue Platform

event_inherited();

introSprite = sprKabatoncueTeleport;
dead = false;
healthpointsStart = 16;
healthpoints = healthpointsStart;
contactDamage = 4;
category = "bulky, nature, rocky";

// Enemy specific code
dir = image_xscale;
init = 1;

cooldownTimer = 0;
cooldownMax = 64;

earJiggle = 0;
canCreateMissiles = 0;
missilesCreated = 0;
imageOffset = 0;
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();
if (entityCanStep())
{
    if (canCreateMissiles > 0)
    {
        canCreateMissiles -= 1;
    }

    // Set current image of hippo.
    image_index = (4 * earJiggle) + imageOffset;

    // Hippo animation setup.
    if (cooldownTimer > (cooldownMax * (missilesCreated + 1)) - 32)
    {
        imageOffset += 0.125;
    }
    if (cooldownTimer >= (cooldownMax * (missilesCreated + 1)))
    {
        imageOffset = 0;
    }

    // create hippo missiles.
    if (canCreateMissiles == 0 || (cooldownTimer >= cooldownMax && missilesCreated == 1))
    {
        cooldownTimer += 1;
        if (cooldownTimer == cooldownMax * (missilesCreated + 1))
        {
            inst = instance_create(x + (image_xscale * 22), y + 20, objKabatoncueMissile);
            with (inst)
            {
                direction = 180 * (other.image_xscale < 0);
                missileID = other.id;
            }

            missilesCreated += 1;

            if (cooldownTimer >= cooldownMax * 2)
            {
                cooldownTimer = 0;
                missilesCreated = 0;
                imageOffset = 0;
            }
        }
    }
}
else if (dead)
{
    calibrateDirection();
    image_index = 0;
    cooldownTimer = 0;
    earJiggle = 0;
}
