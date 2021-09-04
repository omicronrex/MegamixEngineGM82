#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();

bulletLimitCost = 1;

contactDamage = 3;

penetrate = 3; // obviously we don't want to destroy the control for the dash
pierces = 2;
attackDelay = 16;

playSFX(sfxTopSpin); // needs its own sfx later

animTimer = 0;
animFrame = 0;

shiftVisible = 2;
despawnRange = -1;
#define Destroy_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();

if (instance_exists(parent))
{
    topLock = lockPoolRelease(topLock);
    with (parent)
    {
        if (!isHit)
        {
            iFrames = 0;
        }
    }
}
#define Step_2
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();

if (!global.frozen)
{
    // check for parent
    if (!instance_exists(parent))
    {
        instance_destroy();
        exit;
    }

    image_xscale = parent.image_xscale * 1.2;
    image_yscale = parent.image_yscale * 1.5;

    x = parent.x - (1); // stay attached to MM
    y = parent.y - (1);

    // real anim
    animTimer += 1;
    if (animTimer == 3)
    {
        animFrame += 1;
        if (animFrame >= 4)
        {
            animFrame = 0;
        }
        animTimer = 0;
    }

    // Mega Man anim + movement forcing
    with (parent)
    {
        playerHandleSprites("Top");

        iFrames = -1;
        climbing = false;
    }

    if (parent.ground)
    {
        instance_destroy();
    }
}
#define Other_17
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
playSFX(sfxReflect);
#define Other_18
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if (global.damage != 0)
{
    if (global.ammo[playerID, global.weapon[playerID]] > 0)
    {
        global.ammo[playerID, global.weapon[playerID]] -= (2 / (global.energySaver + 1));
    }
}
#define Other_22
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
weaponSetup("TOP SPIN", make_color_rgb(124, 124, 124), make_color_rgb(240, 208, 176), sprWeaponIconsTopSpin);
#define Other_24
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if (global.keyShootPressed[playerID] && !playerIsLocked(PL_LOCK_SHOOT) && !ground && !climbing
    && global.ammo[playerID, global.weapon[playerID]] > 0)
{
    i = fireWeapon(0, 0, objTopSpin, 1, 0, 0, 0);
    if (i)
    {
        i.topLock = lockPoolLock(localPlayerLock[PL_LOCK_CLIMB],
            localPlayerLock[PL_LOCK_SLIDE]);
    }
}
