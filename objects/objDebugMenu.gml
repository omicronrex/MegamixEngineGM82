#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
// this boy is about to pop up and be a menu
global.frozen = true;

// playSFX(sfxDebugMenu); 2 cr3epy 4 me
global.levelRunValid = false;
global.levelRunInvalidReason = "debug menu";

playerID = 0;

// controls
pauseLock = lockPoolLock(global.playerLock[PL_LOCK_PAUSE]);
option = 0;
quickScrollTimer = 25;
endy = 10;
mode = 0; // 0: normal. 1: record input menu

optionText = "ROOM SELECT#
AMMO REFILL#
INVINCIBILITY#
INFINITE HEALTH#
SWAP GRAVITY#
COSTUME CHANGE#
RECORD INPUT#
VISIBLE COLLISION#
PRESS 2#
KILL ONSCREEN ENTITIES";
#define Destroy_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
lockPoolRelease(pauseLock);
global.frozen = false;
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
var _endy; _endy = endy;
if (mode == 1)
{
    _endy = 3;
}

// change option up or down
if (global.keyUpPressed[playerID] || (global.keyUp[playerID] && quickScrollTimer <= 0))
{
    option -= 1;
    if (option < 0)
    {
        option = _endy - 1;
    }

    playSFX(sfxMenuMove);
}

if (global.keyDownPressed[playerID] || (global.keyDown[playerID] && quickScrollTimer <= 0))
{
    option += 1;
    if (option >= _endy)
    {
        option = 0;
    }

    playSFX(sfxMenuMove);
}

// do quick scroll timer
if ((global.keyUp[playerID] ^^ global.keyDown[playerID]) // only do quick scroll when pressing one direction
&& !(option <= 0 && global.keyUp[playerID]) && !(option >= _endy - 1 && global.keyDown[0])) // don't loop with quick scroll
{
    if (quickScrollTimer <= 0) // slight pause between scrolls
    {
        quickScrollTimer = 8; // <-=1 time until quick scroll here
    }

    quickScrollTimer-=1;
}
else
{
    quickScrollTimer = 25; // <-=1 time until quick scroll here
}

// Functions for each option
if (mode == 0)
{
    if (global.keyPausePressed[playerID] || global.keyLeftPressed[playerID] || global.keyRightPressed[playerID])
    {
        switch (option)
        {
            // Room Select
            case 0:
                if (global.keyPausePressed[playerID])
                {
                    playSFX(sfxMenuSelect);
                    global.roomReturn = rmRoomSelect;
                    global.roomReturnIsHub = false;
                    returnFromLevel();
                }
                instance_destroy();
                break;

            // Ammo Refill
            case 1:
                if (global.keyPausePressed[playerID])
                {
                    playSFX(sfxYasichi);
                    for (i = 0; i <= global.totalWeapons; i += 1)
                    {
                        global.ammo[i] = 28;
                    }
                }
                break;

            // Invincibility
            case 2:
                if (instance_exists(objMegaman))
                {
                    if (objMegaman.canHit == true)
                    {
                        playSFX(sfxImportantItem);
                        objMegaman.canHit = false;
                    }
                    else
                    {
                        playSFX(sfxHit);
                        objMegaman.canHit = true;
                    }
                }
                else
                {
                    playSFX(sfxError);
                }
                break;

            // Infinite Health
            case 3:
                global.alwaysHealth = !global.alwaysHealth;
                if (!global.alwaysHealth)
                {
                    playSFX(sfxHit);
                }
                else
                {
                    playSFX(sfxEnergyRestore);
                }
                break;

            // Swap Gravity
            case 4:
                if (instance_exists(objMegaman))
                {
                    with (objMegaman)
                    {
                        gravDir *= -1;
                        yspeed = yspeed / 2;
                        image_yscale = gravDir;
                        y += sprite_get_yoffset(mask_index) * -gravDir;
                        playSFX(sfxGravityFlip);
                    }
                }
                else
                {
                    playSFX(sfxError);
                }
                break;

            // Costumes
            case 5:
                if (global.keyLeftPressed[playerID] && !global.keyRightPressed[playerID])
                {
                    // Costumes
                    playSFX(sfxUnlocked);
                    with (objMegaman)
                    {
                        costumeID-=1;
                        if (costumeID < 0)
                        {
                            costumeID = global.playerSpriteMax - 1;
                        }
                        playerPalette();
                    }
                }
                else if (global.keyRightPressed[playerID] && !global.keyLeftPressed[playerID])
                {
                    playSFX(sfxUnlocked);
                    with (objMegaman)
                    {
                        costumeID+=1;
                        if (costumeID >= global.playerSpriteMax)
                        {
                            costumeID = 0;
                        }
                        playerPalette();
                    }
                }
                break;

            // record input
            case 6:
                switch (global.recordInputMode)
                {
                    case 0:
                        if (instance_exists(objMegaman))
                        {
                            mode = 1;
                            playSFX(sfxMenuSelect);
                            option = 0;
                            exit;
                        }
                        break;
                    case 1:
                        global.recordInputEnd = true;
                        break;
                    default:
                        playSFX(sfxError);
                }
                break;

            // visible solids
            case 7:
                with (objSolid)
                    visible ^= true;
                with (objLadder)
                    visible ^= true;
                with (objTopSolid)
                    visible ^= true;
                with (objBossDoor)
                    visible ^= true;
                with (objFallingTower)
                    visible ^= true;
                break;

            // PRESS 2
            case 8:
                for (i = 0; i <= 8; i += 1)
                {
                    global.playerHealth[i] = 0;
                }
                instance_destroy();
                break;

            // instakill entities
            case 9:
                playSFX(sfxExplosion2);
                with prtEntity
                {
                    if canHit && object_index != objMegaman
                    {
                        healthpoints = 0;
                        event_user(EV_DEATH);
                    }
                }
                break;
        }
    }
}
else if (mode == 1)
{

}

// close the debug menu
if (keyboard_check_pressed(ord('2')))
{
    instance_destroy();
}
#define Draw_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
draw_set_valign(fa_top);
draw_sprite_ext(sprDot, 0, view_xview, view_yview, view_wview, view_hview, 0, c_gray, 0.5);

// text time
draw_set_color(c_white);
draw_set_halign(fa_center);
draw_text(view_xview[0] + 128, view_yview[0] + 4, "DEBUG MENU");
draw_set_halign(fa_left);
if (mode == 0)
    draw_text(view_xview[0] + 20, view_yview[0] + 24, optionText);
else
    draw_text(view_xview[0] + 20, view_yview[0] + 24, "RECORD-HERE [UNSTABLE!]##RECORD-RESET [SAFE]##BACK####'RECORD HERE' MUST ONLY#BE USED IN A SCREEN#WITHOUT GIMMICKS OR ENEMIES");
draw_sprite(sprOptionsCursor, 0, view_xview[0] + 8, view_yview[0] + 24 + (option * 16));

// specific text for options
draw_set_halign(fa_right);
if (mode == 0)
    for (i = 24; i <= endy * 16; i += 16)
    {
        switch ((i - 24) / 16)
        {
            // invincibility
            case 2:
                if (objMegaman.canHit)
                {
                    draw_text(view_xview[0] + 256 - 8, view_yview[0] + i, "OFF");
                }
                else
                {
                    draw_text(view_xview[0] + 256 - 8, view_yview[0] + i, "ON");
                }
                break;
            // infinite health
            case 3:
                if (global.alwaysHealth)
                {
                    draw_text(view_xview[0] + 256 - 8, view_yview[0] + i, "ON");
                }
                else
                {
                    draw_text(view_xview[0] + 256 - 8, view_yview[0] + i, "OFF");
                }
                break;
            // grav dir
            case 4:
                draw_text(view_xview[0] + 256 - 8, view_yview[0] + i, string(objMegaman.gravDir));
                break;
            // costumes
            case 5:
                draw_text(view_xview[0] + 256 - 8, view_yview[0] + i, string(objMegaman.costumeID));
                break;
        }
    }
draw_set_halign(fa_left);

draw_text(view_xview[0] + 256 - 8, view_yview[0] + 224 - 8, string(global.aliveBosses));
