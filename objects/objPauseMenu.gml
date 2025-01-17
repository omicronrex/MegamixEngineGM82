#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
global.nextRoom = -1;
visible = 0;

phase = 0; // 0: increasing the black rectangle's alpha

option = 0;
oldOption = 0;
weaponOffset = 0;
offsetTimer = -1;

// get currently visible weapons
weaponVisibleN = 0;
var i; for ( i = 0; i <= global.totalWeapons; i+=1)
{
    if (global.weaponLocked[global.weaponHotbar[i]] < 2)
    {
        weaponVisible[weaponVisibleN] = i; weaponVisibleN+=1
    }
}
visibleWeapons = min(10, weaponVisibleN); // up to 10 visible

var i; for ( i = 0; i < weaponVisibleN; i+=1)
{
    if (global.weapon[0] == global.weaponHotbar[weaponVisible[i]])
    {
        option = i;
        oldOption = i;
    }
}
woption = i;

visibleWeapons = 10;

oldWeapon = global.weapon[0];
resetWeapon = false; // Should we, after exiting the menu, reset our weapon to the weapon that was used before the pause menu was opened?

wtank = 0;
mtank = 0;

retryConfirm = 0;
exitConfirm = 0;
hotBarArrangeMode = false;

playerID = 0;
costumeID = 0;

// Stop charging
with (objMegaman)
{
    playerPalette();
}

// set these here. makes everyone's lives easier.

etankPositionX = 148;
etankPositionY = 10;
wtankPositionX = 178;
wtankPositionY = 10;
mtankPositionX = 210;
mtankPositionY = 10;

optionsPositionX = 136;
optionsPositionY = 208;
checkPositionX = 158;
checkPositionY = 208;
exitPositionX = 204;
exitPositionY = 208;

arrowTimer = 20;

quickScrollTimer = 0; // 24;
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
// Can't control while options menu is open
if (instance_exists(objOptionsMenu))
{
    exit;
}

// do pause menu
switch (phase)
{
    // Fading out
    case 0:
        with (objGlobalControl)
        {
            if (fadeAlpha == 1)
            {
                global.nextRoom = 0;
                other.visible = 1;
                other.phase = 1;
                showhealth = 0;
            }
        }
        break;

    // Fading in
    case 1:
        with (objGlobalControl)
        {
            if (fadeAlpha == 0)
            {
                other.phase = 2;
            }
        }
        event_user(0); // Moving the selection

        break;

    // Idle
    case 2:
        event_user(0); // Moving the selection

        // Select the weapon/tank
        if (global.keyJumpPressed[playerID] || global.keyPausePressed[playerID])
        {
            if (option <= weaponVisibleN)
            {
                if (instance_exists(objMegaman.vehicle) && option != 0)
                {
                    if (!objMegaman.vehicle.weaponsAllowed)
                    {
                        playSFX(sfxError);
                        exit;
                    }
                }

                global.nextRoom = -1;
                phase = 3;

                global.weapon[playerID] = global.weaponHotbar[weaponVisible[option]];
                playSFX(sfxMenuSelect);
            }
            else if (option == weaponVisibleN + 1) // E-Tank
            {
                if (global.eTanks && global.playerHealth[playerID] < 28)
                {
                    option = 99; // Nothing selected
                    phase = 5;
                    wtank = 0;
                    mtank = 0;
                    global.eTanks -= 1;
                    eTankTimer = 0;
                    loopSFX(sfxEnergyRestore);
                }
                else
                {
                    playSFX(sfxError);
                }
            }
            else if (option == weaponVisibleN + 2) // W-Tank
            {
                // Check if weapon energy actually needs filling
                var proceed;
                proceed = false;
                for (i = 0; i < weaponVisibleN; i += 1)
                {
                    if (ceil(global.ammo[playerID, global.weaponHotbar[weaponVisible[i]]]) < 28)
                    {
                        proceed = true;
                    }
                }

                if (global.wTanks && proceed)
                {
                    option = 0; // Go back to weapon column
                    phase = 6;
                    mtank = 0;
                    wtank = 1;
                    global.wTanks -= 1;
                    playSFX(sfxMenuSelect);
                }
                else
                {
                    playSFX(sfxError);
                }
            }
            else if (option == weaponVisibleN + 3) // M-Tank
            {
                if (global.mTanks > 0) // Check if health or weapon energy actually needs filling
                {
                    var proceed; proceed = false;
                    for (i = 0; i < weaponVisibleN; i += 1)
                    {
                        if (ceil(global.ammo[playerID, global.weaponHotbar[weaponVisible[i]]]) < 28)
                        {
                            proceed = true;
                        }
                    }

                    if (ceil(global.playerHealth[playerID]) < 28)
                    {
                        proceed = true;
                    }

                    if (proceed) // If proceed is still false after the past calculations, it seems there is nothing to fill
                    {
                        option = 99; // Nothing selected
                        phase = 5;
                        mtank = 1;
                        wtank = 0;
                        global.mTanks -= 1;
                        eTankTimer = 0;
                        loopSFX(sfxEnergyRestore);
                    }
                    else
                    {
                        playSFX(sfxError);
                    }
                }
                else
                {
                    playSFX(sfxError);
                }
            }
            else if (option == weaponVisibleN + 4) // Options
            {
                instance_create(x, y, objOptionsMenu);
                playSFX(sfxMenuSelect);
                exit;
            }
            else if (option == weaponVisibleN + 5) // Retry
            {
                if (!retryConfirm)
                {
                    retryConfirm = true;
                    playSFX(sfxMenuSelect);
                    exit;
                }
            }
            else if (option == weaponVisibleN + 6) // Exit
            {
                if (!exitConfirm)
                {
                    exitConfirm = true;
                    playSFX(sfxMenuSelect);
                    exit;
                }
            }
        }

        // Confirming exit
        if (exitConfirm && !global.nextRoom)
        {
            if (option == weaponVisibleN + 6)
            {
                if (global.keyJumpPressed[playerID]
                    || global.keyPausePressed[playerID])
                {
                    returnFromLevel();
                    playSFX(sfxMenuSelect);
                }
            }
            else
            {
                exitConfirm = false;
            }
        }

        // Confirming retry
        if (retryConfirm && !global.nextRoom)
        {
            if (option == weaponVisibleN + 5)
            {
                if (global.keyJumpPressed[playerID]
                    || global.keyPausePressed[playerID])
                {
                    global.nextRoom = room;
                    playSFX(sfxMenuSelect);
                }
            }
            else
            {
                retryConfirm = false;
            }
        }

        break;

    // Fading out
    case 3:
        with (objGlobalControl)
        {
            if (fadeAlpha == 1 && global.nextRoom != 0)
            {
                showhealth = 1;
                with (other)
                {
                    if (resetWeapon)
                    {
                        global.weapon[playerID] = oldWeapon;
                        with (objMegaman)
                        {
                            playerPalette();
                        }
                    }

                    if (global.weapon[playerID] != oldWeapon)
                    {
                        with (prtPlayerProjectile)
                        {
                            instance_destroy();
                        }
                    }

                    global.nextRoom = 0;
                    visible = 0;
                }
            }
            else if (fadeAlpha == 0 && global.nextRoom == 0)
            {
                with (other)
                {
                    audio_resume_all();
                    instance_destroy();
                    global.frozen = 0;
                }
            }
        }

        break;

    // E/M-Tank restoring health
    case 5:
        eTankTimer += 1;
        if (eTankTimer >= 3)
        {
            eTankTimer = 0;

            var proceed;
            proceed = false;

            // Fill selected weapon w/ W Tank
            if (wtank)
            {
                if (global.ammo[playerID, global.weaponHotbar[weaponVisible[option]]] < 28)
                {
                    global.ammo[playerID, global.weaponHotbar[weaponVisible[option]]] = min(28,
                        global.ammo[playerID, global.weaponHotbar[weaponVisible[option]]] + 1);
                    proceed = true;
                }
            }

            // Fill all weapons - M-Tank only
            if (mtank)
            {
                for (i = 1; i < weaponVisibleN; i += 1)
                {
                    if (global.ammo[playerID, global.weaponHotbar[weaponVisible[i]]] < 28)
                    {
                        global.ammo[playerID, global.weaponHotbar[weaponVisible[i]]] = min(28,
                            global.ammo[playerID, global.weaponHotbar[weaponVisible[i]]] + 1);
                        proceed = true;
                    }
                }
            }

            // Fill health
            if ((global.playerHealth[playerID] < 28) && (!wtank))
            {
                global.playerHealth[playerID] = min(28,
                    global.playerHealth[playerID] + 1);
                proceed = true;
            }

            if (!proceed)
            {
                eTankTimer = 0;
                phase = 2;
                if (!wtank)
                {
                    option = oldOption;
                    global.weapon[playerID] = oldWeapon;
                    with (objMegaman)
                    {
                        playerPalette();
                    }
                }

                audio_stop_sound(sfxEnergyRestore);
            }
        }

        break;

    // W-Tank weapon selection
    case 6:
        event_user(0); // Moving the selection

        if (option > 0 && option < weaponVisibleN)
        {
            if (global.keyJumpPressed[playerID] || global.keyPausePressed[playerID])
            {
                if (global.ammo[playerID, global.weaponHotbar[weaponVisible[option]]] < 28)
                {
                    phase = 5;
                    eTankTimer = 0;
                    loopSFX(sfxEnergyRestore);
                }
                else
                {
                    playSFX(sfxError);
                }
            }
        }

        break;
}

// update stored player sprite
if (instance_exists(objMegaman))
{
    with (objMegaman)
    {
        if (playerID == other.playerID)
        {
            other.costumeID = costumeID;
        }
    }
}
#define Other_10
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
hotBarArrangeMode = (global.keyShoot[playerID]) * (hotBarArrangeMode + 1);

var xDir; xDir = (global.keyRightPressed[playerID] - global.keyLeftPressed[playerID]);

var yDir; yDir = ((global.keyDownPressed[playerID] || (global.keyDown[playerID] && quickScrollTimer <= 0))
    - (global.keyUpPressed[playerID] || (global.keyUp[playerID] && quickScrollTimer <= 0)));

if (yDir != 0)
{
    playSFX(sfxMenuMove);

    if (option < weaponVisibleN)
    {
        woption = option;

        if (hotBarArrangeMode) // swap weapons:
        {
            if (option + yDir < weaponVisibleN && option + min(yDir, 0) >= 1)
            {
                option += yDir;
                swap(global.weaponHotbar, weaponVisible[option], weaponVisible[option - yDir]);
            }
        }
        else
        {
            do
            {
                option += yDir;
                if (option >= weaponVisibleN)
                {
                    option = 0;
                }
                else if (option < 0)
                {
                    option = weaponVisibleN - 1;
                }
            }
                until (!global.weaponLocked[global.weaponHotbar[weaponVisible[option]]])
        }
    }
    else
    {
        option -= 3 * (1 - ((option <= weaponVisibleN + 3) * 2));
    }
}

if (xDir != 0 && phase != 6)
{
    playSFX(sfxMenuMove);

    if (option < weaponVisibleN) // horizontal movements while on the weapon list
    {
        option = weaponVisibleN + 2 - xDir;
    }
    else // horizontal movements while on the misc selections
    {
        if ((option == weaponVisibleN + 1 && xDir < 0) // loop back to weapon list
        || (option == weaponVisibleN + 3 && xDir > 0)
            || (option == weaponVisibleN + 4 && xDir < 0)
            || (option == weaponVisibleN + 6 && xDir > 0))
        {
            option = 0;
        }
        else
        {
            option += xDir;
        }
    }
}

// do quick scroll timer
if ((global.keyDown[playerID] && option < weaponVisibleN - 1)
    - (global.keyUp[playerID] && option) != 0)
{
    if (quickScrollTimer <= 0) // slight pause between scrolls
    {
        quickScrollTimer = 6; // <-=1 time until quick scroll here
    }

    quickScrollTimer-=1;
}
else
{
    quickScrollTimer = 24; // <-=1 time until quick scroll here
}

// L + R resets weapon order

// it only checks for one pressed because if it checked both you'd have to press both
// buttons on the same frame, but if you could just hold the two buttons you would get
// a very loud screeching noise every time you reset + it'd be easier to accidentally
// sort
if ((global.keyWeaponSwitchLeft[playerID] && global.keyWeaponSwitchRightPressed[playerID])
    || (global.keyWeaponSwitchLeftPressed[playerID] && global.keyWeaponSwitchRight[playerID]))
{
    var i; for ( i = 0; i <= global.totalWeapons; i+=1)
    {
        if global.weaponHotbar[i] != i
        {
            global.weaponHotbar[i] = i;
            playSFX(sfxMenuSelect);
        }
    }

    weaponVisibleN = 0;
    var i; for ( i = 0; i <= global.totalWeapons; i+=1)
    {
        if (global.weaponLocked[global.weaponHotbar[i]] < 2)
        {
            weaponVisible[weaponVisibleN] = i; weaponVisibleN+=1
        }
    }
    visibleWeapons = min(10, weaponVisibleN); // up to 10 visible
    oldOption = 0;
}

// Set weapon
global.weapon[playerID] = 0;
if (option < weaponVisibleN)
{
    global.weapon[playerID] = global.weaponHotbar[weaponVisible[option]];
}

with (objMegaman)
{
    playerPalette();
}
#define Draw_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
// center in screen on nonstandard resolutions
x = view_xview + (view_wview[0] - 256) / 2;
y = view_yview + (view_hview[0] - 224) / 2;

// Menu
if (phase != 0)
{
    draw_set_halign(fa_left);
    draw_set_valign(fa_top);
    draw_set_color(c_white);
    draw_clear(c_black);

    var col;
    col[0, 0] = global.nesPalette[0];
    col[1, 0] = global.nesPalette[13];
    col[0, 1] = global.primaryCol[0];
    col[1, 1] = global.secondaryCol[0];
    col[0, 2] = make_color_rgb(255, 228, 164);
    col[1, 2] = c_white;

    if (option < weaponVisibleN)
    {
        weaponOffset = clamp(option - floor(visibleWeapons * 0.5), 0, weaponVisibleN - visibleWeapons - 1);
    }

    if (abs(weaponOffset - offsetTimer) < 0.05 || offsetTimer < 0)
    {
        offsetTimer = weaponOffset;
    }
    offsetTimer += (weaponOffset - offsetTimer) / 8;

    // these actually go 'under' the pause menu, so they go before drawSelf.

    // Options
    draw_sprite_ext(sprGotoOptions, (option == weaponVisibleN + 4), x + optionsPositionX, y + optionsPositionY, 1, 1, 0, c_white, 1);

    // Checkpoint
    draw_sprite_ext(sprGotoCheckpoint, (option == weaponVisibleN + 5) + retryConfirm * 2, x + checkPositionX, y + checkPositionY, 1, 1, 0, c_white, 1);

    // Exit
    draw_sprite_ext(sprExit, (option == weaponVisibleN + 6) + exitConfirm * 2, x + exitPositionX, y + exitPositionY, 1, 1, 0, c_white, 1);

    // NOW draw itself
    drawSelf();

    // Icons, ammo bars and names
    var wSep; wSep = 18; // Seperation between icons
    var yOff; yOff = -round((offsetTimer mod 1) * wSep);

    var surface; surface = surface_create(112, (visibleWeapons + 1) * wSep);
    surface_set_target(surface);
    draw_clear_alpha(c_white, 0);

    draw_set_halign(fa_left);
    for (i = max(0, floor(offsetTimer)); i <= min(ceil(offsetTimer) + visibleWeapons, weaponVisibleN - 1); i+=1)
    {
        var w; w = global.weaponHotbar[weaponVisible[i]];
        var cl; cl = (option == i);

        // Icon
        draw_sprite_ext(global.weaponIcon[w], 0, 0, yOff, 1, 1, 0, col[!cl, 2], 1);
        draw_sprite_ext(global.weaponIcon[w], 1, 0, yOff, 1, 1, 0, col[0, cl], 1);
        draw_sprite_ext(global.weaponIcon[w], 2, 0, yOff, 1, 1, 0, col[1, cl], 1);
        draw_sprite_ext(global.weaponIcon[w], 3, 0, yOff, 1, 1, 0, col[1, 2], cl);

        if (!global.weaponLocked[w])
        {
            // Drawing ammo bars
            ammo = ceil(global.playerHealth[playerID] * (i == 0) + global.ammo[playerID, w] * (i != 0));

            draw_sprite_ext(sprPauseMenuBarPrimary, ammo, 18, yOff + 8, 1, 1, 0, col[0, cl * (1 + (i == 0))], 1);
            draw_sprite_ext(sprPauseMenuBarSecondary, ammo, 18, yOff + 8, 1, 1, 0, col[1, cl * (1 + (i == 0))], 1);

            // Draw infinite energy mark over relevant bars
            if (global.infiniteEnergy[w])
            {
                draw_sprite_ext(sprInfinityMark, 0, 18 + 28, yOff + 8, 1, 1, 0, c_white, 1);
                draw_sprite_ext(sprInfinityMark, 1, 18 + 28, yOff + 8, 1, 1, 0, col[0, cl], 1);
                draw_sprite_ext(sprInfinityMark, 2, 18 + 28, yOff + 8, 1, 1, 0, col[1, cl], 1);
            }

            // Name
            draw_set_color(col[!cl, (cl * 2) - (cl * !(hotBarArrangeMode mod 8 < 4))]);

            wname = global.weaponName[w];
            dot = string_pos(" ", wname);
            if (dot)
            {
                wname = string_insert(".", string_delete(wname, 2, dot - 1), 2);
            }

            draw_text(18, yOff, wname);
            draw_set_color(c_white);
        }
        else // draw the disabled stuff
        {
            draw_sprite_ext(sprPauseMenuWeaponDisabled, 0, 18, yOff, 1, 1, 0, c_white, 1);
        }

        yOff += wSep;
    }

    surface_reset_target();
    draw_surface(surface, x + 22, y + 14);
    surface_free(surface);

    arrowTimer+=1;

    draw_set_halign(fa_center);

    // draw arrows
    if (weaponOffset > 0)
    {
        draw_sprite_ext(sprArrow, 2, x + 74, y + 8, 1, 1, 0, c_white, arrowTimer mod 40 < 20); // Up
    }
    else
    {
        draw_text(x + 78, y + 4, "- WEAPONS -");
    }

    if (weaponOffset < weaponVisibleN - visibleWeapons - 1)
    {
        draw_sprite_ext(sprArrow, 3, x + 74, y + 215, 1, 1, 0, c_white, arrowTimer mod 40 < 20); // Down
    }
    else
    {
        draw_text(x + 78, y + 212, "- WEAPONS -");
    }

    // mega man
    with (objMegaman)
    {
        if (playerID == other.playerID)
        {
            drawPlayer(playerID, costumeID, 0, 0, other.x + 172, other.y + 62, -1, 1);
        }
    }

    // health
    draw_sprite_ext(sprPauseMenuBarPrimary, global.playerHealth[playerID], x + 144, y + 81, 1, 1, 0, col[0, 2], 1);
    draw_sprite_ext(sprPauseMenuBarSecondary, global.playerHealth[playerID], x + 144, y + 81, 1, 1, 0, col[1, 2], 1);

    // E-Tank
    draw_sprite_ext(sprETank, 2, x + etankPositionX, y + etankPositionY, 1, 1, 0, col[0, option == weaponVisibleN + 1], 1);
    draw_sprite_ext(sprETank, 4, x + etankPositionX, y + etankPositionY, 1, 1, 0, col[1, option == weaponVisibleN + 1], 1);

    draw_text(x + etankPositionX + 8, y + etankPositionY + 18, string_pad(global.eTanks, 2));

    // W-Tank
    draw_sprite_ext(sprWTank, 2, x + wtankPositionX, y + wtankPositionY, 1, 1, 0, col[0, option == weaponVisibleN + 2], 1);
    draw_sprite_ext(sprWTank, 4, x + wtankPositionX, y + wtankPositionY, 1, 1, 0, col[1, option == weaponVisibleN + 2], 1);

    draw_text(x + wtankPositionX + 8, y + wtankPositionY + 18, string_pad(global.wTanks, 2));

    // M-Tank
    draw_sprite_ext(sprMTank, 2, x + mtankPositionX, y + mtankPositionY, 1, 1, 0, col[0, option == weaponVisibleN + 3], 1);
    draw_sprite_ext(sprMTank, 4, x + mtankPositionX, y + mtankPositionY, 1, 1, 0, col[1, option == weaponVisibleN + 3], 1);

    draw_text(x + mtankPositionX + 8, y + mtankPositionY + 18, string_pad(global.mTanks, 2));

    // Bolts
    draw_sprite_ext(sprBoltBig, 0, x + 210, y + 54, 1, 1, 0, c_white, 1);
    draw_sprite_ext(sprBoltBig, 1, x + 210, y + 54, 1, 1, 0, col[0, 1], 1);
    draw_sprite_ext(sprBoltBig, 2, x + 210, y + 54, 1, 1, 0, col[1, 1], 1);

    draw_text(x + 210 + 8, y + 54 + 18, string_pad(global.bolts, 4));

    // Energy Elements
    draw_sprite_ext(sprEnergyElement, 0, x + 148, y + 92, 1, 1, 0, c_white, 1);

    draw_text(x + 148 + 8, y + 92 + 18, string_pad(global.energyElements, 3));

    // Side Collectible
    draw_sprite_ext(sprKey, 0, x + 178, y + 92, 1, 1, 0, c_white, 1);

    draw_text(x + 178 + 8, y + 92 + 18, string_pad(0, 3));

    with (objMegaman)
    {
        if (playerID == other.playerID)
        {
            drawPlayer(playerID, costumeID, 16, 12, other.x + 216, other.y + 92, 1, 1);
        }
    }

    // lives remaining
    var livesText; livesText = string_pad(global.livesRemaining, 2);
    if (!global.livesEnabled)
    {
        livesText = "-=1";
    }

    draw_text(x + 216, y + 92 + 18, livesText);

    // energy saver
    if (global.energySaver)
    {
        draw_sprite(sprEnergySaver, 0, x + 180, y + 160);
    }

    // colored text overlays
    if (global.showColoredTextOverlays)
    {
        draw_sprite_ext(sprDot, 0, view_xview[0] + 16, view_yview[0], view_wview[0] - 32, view_hview[0], 0,
            make_color_rgb(global.coloredTextOverlaysRed, global.coloredTextOverlaysGreen, global.coloredTextOverlaysBlue),
            global.coloredTextOverlaysOpacity / 255);
    }
}
