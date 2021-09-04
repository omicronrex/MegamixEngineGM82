#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();

bulletLimitCost = 1;

contactDamage = 1;

image_speed = 0.3;

penetrate = 3;
pierces = 2;
attackDelay = 4;
killOverride = true;

despawnRange = 64; // don't be despawned by scrolling offscreen

xst = image_xscale;

// sfx playing
playSFX(sfxSlashClaw);

// lock pools
slashLock = false;
#define Destroy_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();

with (parent)
{
    if (isShoot)
    {
        isShoot = false;
    }
    other.slashLock = lockPoolRelease(other.slashLock);
    other.extraLock = lockPoolRelease(other.extraLock);
}
#define Step_2
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();

if (instance_exists(parent))
{
    with (parent)
    {
        if (isHit)
        {
            with (other)
            {
                instance_destroy();
                exit;
            }
        }
        playerHandleSprites("Slash");
        other.image_xscale = image_xscale;
        other.image_yscale = abs(other.image_yscale) * image_yscale;
    }

    xxs = xs;
    if (image_xscale != xst)
    {
        xxs *= -1;
    }
    x = parent.x + xxs + (image_xscale * 4 * image_index);
    y = parent.y + ys * image_yscale;

    if (image_index >= 5)
    {
        instance_destroy();
    }
}
else
{
    instance_destroy();
}
#define Other_18
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if (global.damage != 0)
{
    with (other)
    {
        par = object_is_ancestor(object_index, prtMiniBoss) || (boss == 1);
        if (par || !canHit)
        {
            exit;
        }
        if (healthpoints - global.damage <= 0)
        {
            var _i;
            _i = instance_create(x, y, objSlashEffect);
            _i.sprite_index = sprite_index;
            _i.image_index = image_index;
            _i.image_xscale = image_xscale;
            _i.image_yscale = image_yscale;
            _i.half = 'top';
            _i = instance_create(x, y, objSlashEffect);
            _i.sprite_index = sprite_index;
            _i.image_index = image_index;
            _i.image_xscale = image_xscale;
            _i.image_yscale = image_yscale;
            _i.half = 'bottom';
        }
    }
}
#define Other_22
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
weaponSetup("SLASH CLAW", make_color_rgb(72, 168, 16), make_color_rgb(232, 208, 32), sprWeaponIconsSlashClaw);
#define Other_23
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
specialDamageValue("joes", 4);
specialDamageValue("mets", 4);
specialDamageValue("shield attackers", 4);
#define Other_24
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if (global.keyShootPressed[playerID] && !playerIsLocked(PL_LOCK_SHOOT))
{
    i = fireWeapon(5, -2, objSlashClaw, 1, 1, 1, 1);
    if (instance_exists(i))
    {
        i.xs = i.x - x;
        i.ys = i.y - y;
        i.xst = i.image_xscale;

        i.slashLock = lockPoolLock(
            localPlayerLock[PL_LOCK_GROUND],
            localPlayerLock[PL_LOCK_SHOOT],
            localPlayerLock[PL_LOCK_TURN],
            localPlayerLock[PL_LOCK_SLIDE]);
        i.extraLock = false;

        if (ground)
        {
            i.extraLock = lockPoolLock(localPlayerLock[PL_LOCK_JUMP]);
        }
    }
}
