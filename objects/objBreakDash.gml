#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();

bulletLimitCost = 1;

contactDamage = 2;

penetrate = 3; // obviously we don't want to destroy the control for the dash
pierces = 2;
attackDelay = 8;
killOverride = true;

visible = 0;

shiftVisible = 3;
despawnRange = -1;

playSFX(sfxBreakDash); // needs its own sfx later

flashTimer = 0;
flashOffset = 0;

animTimer = 0;
animFrame = 0;

dashTimer = 35;
dashSpeed = 2.5;

breakDashLock = false;
#define Destroy_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();

if (instance_exists(parent))
{
    with(parent)
    {
        lockPoolRelease(other.breakDashLock);
        hitTimer = 0;
        iFrames = 50;
    }
}
#define Step_2
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();

// check for parent
if (!instance_exists(parent))
{
    instance_destroy();
    exit;
}
else
{
    image_xscale = parent.image_xscale * 1.2;

    x = parent.x; // stay attached to MM
    y = parent.y;
}

if (!global.frozen)
{
    // iFrames fist/dash
    flashTimer += 1;
    if (flashTimer == 3)
    {
        flashOffset = !flashOffset;
        flashTimer = 0;
    }

    // real anim
    animTimer += 1;
    if (animTimer == 4)
    {
        animFrame += 2;
        if (animFrame >= 6)
        {
            animFrame = 0;
        }
        animTimer = 0;
    }

    with (parent) // Mega Man anim + movement forcing
    {
        if (!other.breakDashLock && ground)
        {
            other.breakDashLock = lockPoolLock(
                localPlayerLock[PL_LOCK_MOVE],
                localPlayerLock[PL_LOCK_SHOOT],
                localPlayerLock[PL_LOCK_SLIDE],
                localPlayerLock[PL_LOCK_TURN]);
            xspeed=0;
            yspeed=0;
        }

        if (!ground) // No air break dashes, sorry :c
        {
            other.dashTimer = 0;
        }
        else
        {
            playerHandleSprites("Break");
            xspeed = other.dashSpeed * other.image_xscale; // movement force
            iFrames = -1;
        }
    }
    if(isLocked(global.playerLock[PL_LOCK_MOVE])&&
    isLocked(global.playerLock[PL_LOCK_TURN]))
    {
        dashTimer=0;
        with(parent)
            xspeed=0;
    }


    // Destroy timer
    dashTimer -= 1;
    if (dashTimer <= 0)
    {
        xspeed = 0;
        instance_destroy();
    }
}
else if (global.switchingSections)
{
    with (parent)
    {
        playerHandleSprites("Break");
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
if (global.damage != 0 && instance_exists(parent))
{
    var xs; xs = dashSpeed * parent.image_xscale * 1.5;

    with (other)
    {
        if (healthpoints - global.damage <= 0)
        {
            par = object_get_parent(object_index);
            if (par == prtMiniBoss || par == prtBoss || par == prtPickup)
            {
                exit;
            }

            var _i;
            _i = instance_create(x, y, objSlashEffect);
            if (object_index == objMM2Mech)
            {
                _i.sprite_index = sprMM2SniperJoeMechEmpty;
            }
            else
            {
                _i.sprite_index = sprite_index;
            }
            _i.image_index = image_index;
            _i.image_xscale = image_xscale;
            _i.image_yscale = image_yscale;
            _i.half = 'whole';
            _i.grav = 0.125;
            _i.xspeed = xs;
            _i.yspeed = -2;
        }
        else
        {
            /* if (grav != 0)
            {
                shiftObject(xs * 2, 0, blockCollision);
            }*/
        }
    }
}
#define Other_22
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
weaponSetup("BREAK DASH", make_color_rgb(107, 74, 255), make_color_rgb(222, 189, 255), sprWeaponIconsBreakDash);
#define Other_23
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
specialDamageValue("grounded", 3);
specialDamageValue(objSpine, 3);
#define Other_24
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
var chargeTime; chargeTime = 40; // Set charge time for this weapon
var initChargeTime; initChargeTime = 20;

// Shooting buster shots if not charged.
if (global.keyShootPressed[playerID] && !playerIsLocked(PL_LOCK_SHOOT) && !instance_exists(objBreakDash))
{
    i = fireWeapon(16, 0, objNormalBusterShot, 3, 0, 1, 0);
    if (i)
    {
        i.xspeed = image_xscale * 5; // zoom
    }
}

//////////////
// Charging //
//////////////

if (global.ammo[playerID, global.weapon[playerID]] > 0)
{
    if ((global.keyShoot[playerID] || (isSlide && chargeTimer > 0))
        && !playerIsLocked(PL_LOCK_CHARGE))
    {
        if (!isShoot)
        {
            isCharge = true;
            if (!isSlide)
            {
                initChargeTimer += 1;
            }
            if (initChargeTimer >= initChargeTime)
            {
                chargeTimer += 1;
                if (chargeTimer == 1)
                {
                    playSFX(sfxCharging);
                }
                if (chargeTimer < chargeTime)
                {
                    var chargeTimeDiv, chargeCol;
                    chargeTimeDiv = round(chargeTime / 3);
                    if (chargeTimer < chargeTimeDiv)
                    {
                        chargeCol = make_color_rgb(168, 0, 32); // Dark red
                    }
                    else if (chargeTimer < chargeTimeDiv * 2)
                    {
                        chargeCol = make_color_rgb(228, 0,
                            88); // Red (dark pink)
                    }
                    else
                    {
                        chargeCol = make_color_rgb(248, 88,
                            152); // Light red (pink)
                    }
                    if (chargeTimer mod 6 >= 0 && chargeTimer mod 6 < 3)
                    {
                        global.outlineCol[playerID] = chargeCol;
                    }
                    else
                    {
                        global.outlineCol[playerID] = c_black;
                    }
                }
                else
                {
                    if (chargeTimer == chargeTime)
                    {
                        audio_stop_sound(sfxCharging);
                        playSFX(sfxCharged);
                    }
                    breakdash=ds_map_get(global.weaponID,objBreakDash)
                    switch (floor(chargeTimer / 3 mod 3))
                    {
                        case 0:
                            global.primaryCol[playerID] = global.weaponSecondaryColor[breakdash];
                            global.secondaryCol[playerID] = c_black;
                            global.outlineCol[playerID] = global.weaponPrimaryColor[breakdash];
                            break;
                        case 1:
                            global.primaryCol[playerID] = c_black;
                            global.secondaryCol[playerID] = global.weaponPrimaryColor[breakdash];
                            global.outlineCol[playerID] = global.weaponSecondaryColor[breakdash];
                            break;
                        case 2:
                            global.primaryCol[playerID] = global.weaponPrimaryColor[breakdash];
                            global.secondaryCol[playerID] = global.weaponSecondaryColor[breakdash];
                            global.outlineCol[playerID] = c_black;
                            break;
                    }
                }
            }
        }
    }
    else // Release the charge shot
    {
        if (chargeTimer != 0 && !playerIsLocked(PL_LOCK_SHOOT) && !isHit)
        {
            // Climbing constantly flips your xscale, so here just rely on a seperate variable set w/ direction keys and stuff in playerStep
            if (climbing)
            {
                image_xscale = climbShootXscale;
            }

            /////////////////////
            // ACTUAL SHOOTING //
            /////////////////////

            // full charge
            if (chargeTimer >= chargeTime && ground)
            {
                a = instance_create(x, y, objBreakDash);
                a.image_xscale = image_xscale;
                global.ammo[playerID, global.weapon[playerID]] = max(0,
                    global.ammo[playerID, global.weapon[playerID]] - 3);
            }

            // reset all charging stuff
            chargeTimer = 0;
            initChargeTimer = 0;
            audio_stop_sound(sfxCharged);
            audio_stop_sound(sfxCharging);
            playerPalette(); // Reset the colors
        }
    }
}
