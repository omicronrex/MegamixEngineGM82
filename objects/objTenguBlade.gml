#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();

bulletLimitCost = 1;

contactDamage = 1;

image_speed = 0.35;

penetrate = 3;
pierces = 2;
attackDelay = 4;
killOverride = true;

despawnRange = 64; // don't be despawned by scrolling offscreen

xst = image_xscale;

playSFX(sfxSlashClaw);

slashLock = false;

nothingStruck = true;
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

    with (other)
    {
        slashLock = lockPoolRelease(slashLock);
        extraLock = lockPoolRelease(extraLock);
    }
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
        playerHandleSprites("Tengu1");
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
        // Creates the Tengu Blade disk.
        if (nothingStruck)
        {
            var activeDisk = instance_create(x + (6 * image_xscale), y, objTenguDisk);
            activeDisk.image_xscale = image_xscale;
            activeDisk.image_yscale = image_yscale;
            activeDisk.xspeed = activeDisk.xSpdConst * image_xscale;
        }
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
        par = object_get_parent(object_index);
        if (par == prtMiniBoss || par == prtBoss || !canHit)
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

nothingStruck = false;
#define Other_22
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
weaponSetup("TENGU BLADE", make_color_rgb(128, 128, 136), make_color_rgb(224, 224, 248), sprWeaponIconsTenguBlade);
#define Other_24
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if (global.keyShootPressed[playerID] && !playerIsLocked(PL_LOCK_SHOOT))
{
    i = fireWeapon(5, -2, objTenguBlade, 1, 1, 1, 1);
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

if (global.ammo[playerID, global.weapon[playerID]] > 0)
{
    if (isSlide && notDashing)
    {
        slideSpeed = 3;
        a = instance_create(x, y, objTenguDash);
        a.image_xscale = image_xscale;
        global.ammo[playerID, global.weapon[playerID]] = max(0,
            global.ammo[playerID, global.weapon[playerID]] - 1);
        notDashing = false;
    }
    else if (!isSlide)
    {
        notDashing = true;
    }
}
