/// playerSwitchWeapons()
// Allows for quick weapon switching
// If you do not want quick weapon switching in your game, simply remove the script from objMegaman's step event

var dir; dir = (global.keyWeaponSwitchRight[playerID] - global.keyWeaponSwitchLeft[playerID]);
var oldWeapon; oldWeapon = global.weapon[playerID];

if (dir != 0)
{
    // Switching to the left
    if (instance_exists(vehicle))
    {
        if (!vehicle.weaponsAllowed)
        {
            playSFX(sfxError);
            exit;
        }
    }

    quickWeaponScrollTimer-=1;

    if (!quickWeaponScrollTimer)
    {
        while (true)
        {
            var wpn; wpn = indexOf(global.weaponHotbar, global.weapon[playerID]);
            wpn = (wpn + global.totalWeapons + dir + 1) mod (global.totalWeapons + 1);

            global.weapon[playerID] = global.weaponHotbar[wpn];
            if (!global.weaponLocked[global.weapon[playerID]])
            {
                break;
            }
        }
    }
}
else
{
    // reset to mega buster
    if ((global.keyWeaponSwitchLeft[playerID] && global.keyWeaponSwitchRight[playerID]) && !global.lockBuster)
    {
        global.weapon[playerID] = 0;
    }
    else
    {
        quickWeaponScrollTimer = 0;
    }
}

if (global.weapon[playerID] != oldWeapon)
{
    // slight pause between scrolls
    quickWeaponScrollTimer = 8 + (10 * (quickWeaponScrollTimer < 0));

    chargeTimer = 0;

    // For the dashing effect of Tengu Blade to not activate mid-slide.
    notDashing = false;

    drawWeaponIcon = 32;
    playerPalette();

    with (prtPlayerProjectile)
    {
        if (playerID == other.playerID)
        {
            instance_destroy();
        }
    }

    playSFX(sfxWeaponSwitch);

    audio_stop_sound(sfxCharging);
    audio_stop_sound(sfxCharged);
    audio_stop_sound(sfxWheelCutter1);
    audio_stop_sound(sfxWheelCutter2);
}

// Timer
drawWeaponIcon = max(drawWeaponIcon - 1, 0);
