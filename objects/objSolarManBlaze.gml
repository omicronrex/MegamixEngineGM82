#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();
grav = 0;
itemDrop = -1;
respawn = false;
despawnRange = sprite_height + 1;
stopOnFlash = false;
image_speed = 0.2;
size = 0;
isWave = 0;
isFlying = 0;
isBomb = 0; // Detonate when at Mega Man's Y?
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();
if (entityCanStep())
{
    if ((!isWave) && (!isFlying))
    {
        y += 3;
    }
    else if (isFlying)
    {
        y -= 6;
        if ((bbox_bottom < view_yview) && (instance_exists(target)))
        {
            // Fire Solar Blaze
            var i; i = instance_create(target.x, view_yview, objSolarManBlaze);
            i.size = size;
            i.isBomb = true;
            i.blockCollision = true;
            instance_destroy();
        }
    }

    if (size == 0)
    {
        if (isWave == 0)
        {
            sprite_index = sprSolarSunSmall;
        }
        else
        {
            sprite_index = sprSolarBlazeSmall;
        }
        contactDamage = 4;
    }
    else if (size == 2)
    {
        if (isWave == 0)
        {
            sprite_index = sprSolarSunLarge;
        }
        else
        {
            sprite_index = sprSolarBlazeLarge;
        }
        contactDamage = 6;
    }
    else
    {
        if (isWave == 1)
        {
            sprite_index = sprSolarBlazeMedium;
        }
        contactDamage = 5;
    }

    if (checkSolid(0, 0, 1, 1) && (!isWave) && (!isFlying)
        || (instance_exists(target)) && (y >= target.y) && (isBomb))
    {
        repeat (2)
        {
            image_xscale *= -1;

            var i; i = instance_create(x, y, objSolarManBlaze);
            i.isWave = true;
            i.size = size;
            i.image_xscale = image_xscale;
            i.contactDamage = contactDamage;
            i.blockCollision = 0;
            i.xspeed = 4 * image_xscale;
        }

        // Play sound effects
        switch (size)
        {
            case 0:
                playSFX(sfxSolarBlazePopSmall);
                break;
            case 1:
                playSFX(sfxSolarBlazePop);
                break;
            case 2:
                playSFX(sfxSolarBlazePopLarge);
                break;
        }
        instance_create(x, y, objExplosion);
        instance_destroy();
    }
}
#define Other_21
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if (other.object_index == objWaterShield)
{
    instance_create(x, y, objExplosion);
    event_user(EV_DEATH);
}
else if ((other.object_index != objTornadoBlow) && (other.object_index != objRainFlush))
{
    with (other)
    {
        if ((penetrate <= 2) && (pierces <= 2))
        {
            guardCancel = 2;
        }
    }
}
