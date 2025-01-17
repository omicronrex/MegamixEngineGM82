#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
global.nextRoom = -1;
visible = 0;

if (!instance_number(object_index) > 1)
{
    instance_destroy();
    visible = 0;
    exit;
}

cursorImgIndex = 0;
cursorImgSpd = 0.2;

arrowBlinkTimer = 20;
showArrow = true;

phase = 0;
option = 0;
selected = 0;
buffer = 0;

visibleOptions = 9;
optionOffset = 0;

verticalQuickScrollTimer = 25;
horizontalQuickScrollTimer = 25;

// Control settings
newControls = 0;
current = 'NONE';
press = 1;
currentKeys[40]=-1;
keyID = 0;
key = -1;

// Option text
optionText[0] = 'CLOSE';
optionText[1] = 'CONFIGURE CONTROLS';
optionText[2] = 'CONFIGURE GAMEPAD';
optionText[3] = 'RESOLUTION';
optionText[4] = 'V-SYNC';
optionText[5] = 'MUSIC VOLUME';
optionText[6] = 'SOUND VOLUME';
optionText[7] = 'PLAYER COUNT';
optionText[8] = 'SHOW FPS';
optionText[9] = 'SHOW CONTROLLER';
optionText[10] = 'DAMAGE POPUP';
optionText[11] = 'CHARGE BAR';
optionText[12] = 'MM COLOR';
optionText[13] = 'MOVING TEXT';
optionText[14] = 'PICKUP EFFECT';
optionText[15] = 'ESC KEY BEHAVIOR';
optionText[16] = 'COLORED TEXT OVERLAYS';
optionText[17] = 'ITEM GRAPHICS';
optionText[18] = 'DEATH EFFECT';
optionText[19] = 'JUMP SOUND';
optionText[20] = 'TELEPORT SOUND';
#define Alarm_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
buffer = 0;
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
/// Open and close behavior
switch (phase)
{
    // Fading out
    case 0:
        if (objGlobalControl.fadeAlpha == 1)
        {
            global.nextRoom = 0;
            objGlobalControl.showhealth = 0;
            visible = 1;
            phase+=1;
        }
        break;

    // Fading in
    case 1:
        if (objGlobalControl.fadeAlpha == 0)
        {
            phase+=1;
        }
        break;

    // Doing menu selections
    case 2: // done elsewhere
        break;

    // Fading out
    case 3:
        if (room == rmOptions)
        {
            var ID;
            if (global.nextRoom != rmTitleScreen)
            {
                saveLoadOptions(true);
            }
            global.nextRoom = rmTitleScreen;
        }
        else
        {
            global.nextRoom = -1;
            phase+=1;
        }
        break;

    // End fading out
    case 4:
        if (objGlobalControl.fadeAlpha == 1 && global.nextRoom != 0)
        {
            global.nextRoom = 0;
            visible = 0;
        }
        else if (objGlobalControl.fadeAlpha == 0 && global.nextRoom == 0)
        {
            global.frozen = true;
            instance_destroy();
        }
        break;
}
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
/// Most menu selections

if (instance_exists(objColoredTextOverlaysMenu))
{
    exit;
}

if (phase == 2 && !selected)
{
    // var maxplayers; maxplayers = min(4+gamepad_get_device_count(),4);

    // left / right controlled selections
    dir = (global.keyRightPressed[0] || (global.keyRight[0] && horizontalQuickScrollTimer <= 0)) - (global.keyLeftPressed[0] || (global.keyLeft[0] && horizontalQuickScrollTimer <= 0));
    if (dir != 0)
    {
        switch (option)
        {
            // Screensize
            case 3:
                pre = global.screensize;
                setScreenSize(global.screensize + dir);
                if (global.screensize != pre)
                {
                    playSFX(sfxMenuMove);
                }
                break;

            // V-Sync
            case 4:
                global.vsync = !global.vsync;
                playSFX(sfxMenuMove);
                break;

            // Music volume
            case 5:
                pre = global.musicvolume;
                global.musicvolume = max(0, min(100, global.musicvolume + 10 * dir));

                // adjust current music volume to reflect change
                switch (global.levelSongType)
                {
                    default:
                    case "OGG":
                        FMODInstanceSetVolume(global.songMemory, global.musicvolume * 0.01);
                        break;
                    case "VGM":
                        if (instance_exists(objMusicControl))
                        {
                            audio_sound_gain(objMusicControl.sound_index, global.levelVolume * (global.musicvolume * 0.01), 0);
                        }
                        break;
                }
                if (global.musicvolume != pre)
                {
                    playSFX(sfxMenuMove);
                }
                break;

            // Sound volume
            case 6:
                pre = global.soundvolume;
                global.soundvolume = max(0, min(100, global.soundvolume + 10 * dir));
                if (global.soundvolume != pre)
                {
                    playSFX(sfxMenuMove);
                }
                break;

            // Players (co-op)
            case 7:
                pre = global.playerCount;
                global.playerCount = max(1, min(4, global.playerCount + dir));
                if (global.playerCount != pre)
                {
                    playSFX(sfxMenuMove);
                }
                if (global.playerCount > pre)
                {
                    resetPlayerState(pre);

                    // allow player to respawn:
                    global.respawnTimer[pre] = 0;
                }

                // delete removed players
                with (objMegaman)
                {
                    if (playerID >= global.playerCount)
                    {
                        instance_destroy();
                    }
                }
                break;

            // FPS
            case 8:
                pre = global.showFPS;
                global.showFPS = min(max(0, global.showFPS + dir), 1);
                if (global.showFPS != pre)
                {
                    playSFX(sfxMenuMove);
                }
                break;

            // Controller Overlay
            case 9:
                pre = global.showControllerOverlay;
                global.showControllerOverlay = min(max(0, global.showControllerOverlay + dir), 2);
                if (global.showControllerOverlay != pre)
                {
                    playSFX(sfxMenuMove);
                }
                break;

            // Damage popup
            case 10:
                pre = global.damagePopup;
                global.damagePopup = min(max(0, global.damagePopup + dir), 1);
                if (global.damagePopup != pre)
                {
                    playSFX(sfxMenuMove);
                }
                break;

            // Charge Bar
            case 11:
                pre = global.chargeBar;
                global.chargeBar = min(max(0, global.chargeBar + dir), 1);
                if (global.chargeBar != pre)
                {
                    playSFX(sfxMenuMove);
                }
                break;

            // MM Color
            case 12:
                pre = global.mmColor;
                global.mmColor = min(max(0, global.mmColor + dir), 1);
                if (global.mmColor != pre)
                {
                    playSFX(sfxMenuMove);
                }
                break;

            // moving text effects
            case 13:
                pre = global.showMovingText;
                global.showMovingText = min(max(0, global.showMovingText + dir), 1);
                if (global.showMovingText != pre)
                {
                    playSFX(sfxMenuMove);
                }
                break;

            // Instant refills
            case 14:
                pre = global.healthEffect;
                global.healthEffect = min(max(0, global.healthEffect + dir), 1);
                if (global.healthEffect != pre)
                {
                    playSFX(sfxMenuMove);
                }
                break;

            // Escape key behavior
            case 15:
                pre = global.escapeBehavior;
                global.escapeBehavior = min(max(0, global.escapeBehavior - dir), 2);
                if (global.escapeBehavior != pre)
                {
                    playSFX(sfxMenuMove);
                }
                break;

            // Pickup Graphics
            case 17:
                pre = global.pickupGraphics;
                global.pickupGraphics = min(max(0, global.pickupGraphics + dir), 1);
                if (global.pickupGraphics != pre)
                {
                    playSFX(sfxMenuMove);
                }
                break;

            // Death Effect
            case 18:
                pre = global.deathEffect;
                global.deathEffect = min(max(0, global.deathEffect + dir), 1);
                if (global.deathEffect != pre)
                {
                    playSFX(sfxMenuMove);
                }
                break;

            // Jump Sound
            case 19:
                pre = global.jumpSound;
                global.jumpSound = min(max(0, global.jumpSound + dir), 1);
                if (global.jumpSound != pre)
                {
                    playSFX(sfxMenuMove);
                }
                break;

            // Teleport Sound
            case 20:
                pre = global.teleportSound;
                global.teleportSound = min(max(0, global.teleportSound + dir), 1);
                if (global.teleportSound != pre)
                {
                    playSFX(sfxMenuMove);
                }
                break;
        }
    }

    // pause controlled selections
    var pausePressed; pausePressed = false;
    for (i = 0; i < global.playerCount; i+=1)
        if (global.keyPausePressed[i])
            pausePressed = i + 1;

    if (pausePressed)
    {
        switch (option)
        {
            // exit
            case 0:
                selected = true;
                phase+=1;
                playSFX(sfxMenuSelect);
                break;

            // set keyboard controls
            case 1:
                if (buffer)
                {
                    exit;
                }
                newControls = 1;
                selected = 1;
                current = 'LEFT';
                keyID=0;
                pID = pausePressed - 1;
                for(i =0;i<40;i+=1)
                    currentKeys[i]=-1;
                break;

            // set gamepad controls
            case 2:
                if (buffer)
                {
                    exit;
                }
                if (!objGlobalControl.joystick_connected)
                {
                    objGlobalControl.joystick_connected = joystick_count() > 0;
                }
                if (!objGlobalControl.joystick_connected)
                {
                    playSFX(sfxError);
                    exit;
                }
                newControls = 2;
                keyID=0;
                selected = 1;
                current = 'JUMP';
                pID = pausePressed - 1;
                for(i =0;i<40;i+=1)
                    currentKeys[i]=-1;
                break;

            // colored text overlays
            case 16:
                playSFX(sfxPause);
                instance_create(x, y, objColoredTextOverlaysMenu);
                break;
        }
    }

    // Up / down controls
    if (global.keyUpPressed[0] || (global.keyUp[0] && verticalQuickScrollTimer <= 0))
    {
        // up
        option -= 1;
        if (option < 0)
        {
            // loop
            option = array_length_1d(optionText) - 1;
            optionOffset = array_length_1d(optionText) - visibleOptions;
        }
        else if (option < optionOffset)
        {
            optionOffset-=1;
        }

        playSFX(sfxMenuMove);
    }
    else if (global.keyDownPressed[0] || (global.keyDown[0] && verticalQuickScrollTimer <= 0))
    {
        // down
        option += 1;
        if (option >= array_length_1d(optionText))
        {
            // loop
            option = 0;
            optionOffset = 0;
        }
        else if (option >= optionOffset + visibleOptions)
        {
            optionOffset+=1;
        }

        playSFX(sfxMenuMove);
    }

    // vertical quick scroll timer handling
    if (horizontalQuickScrollTimer == 25 // don't quick scroll vertically if doing it horizontally
    && (global.keyUp[0] ^^ global.keyDown[0]) // only activate quick scroll if one button is being held
    && !(option <= 0 && global.keyUp[0]) && !(option >= array_length_1d(optionText) - 1 && global.keyDown[0])) // don't wrap around with quick scroll
    {
        if (verticalQuickScrollTimer <= 0)
        {
            // slight pause between scrolls
            verticalQuickScrollTimer = 9;
        }

        verticalQuickScrollTimer-=1;
    }
    else
    {
        verticalQuickScrollTimer = 25; // <-=1 time until quick scroll here
    }

    // horizontal quick scroll timer handling
    if (verticalQuickScrollTimer == 25 // don't quick scroll horizontally if doing it vertically
    && (global.keyLeft[0] ^^ global.keyRight[0]))
    {
        if (horizontalQuickScrollTimer <= 0)
        {
            // slight pause between scrolls
            horizontalQuickScrollTimer = 9;
        }

        horizontalQuickScrollTimer-=1;
    }
    else
    {
        horizontalQuickScrollTimer = 25; // <-=1 time until quick scroll here
    }
}
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
/// Setup controls
if (!newControls)
{
    exit;
}

// control configuration
key = -1;

// control configuration
var skip; skip = newControls && (keyboard_key == vk_delete);

if (newControls == 1)
{
    if (keyboard_check_pressed(vk_anykey))
    {
        // illegal keys
        key = keyboard_key;
        switch (key)
        {
            case vk_f1:
            case vk_f2:
            case vk_f3:
            case vk_f4:
            case vk_f5:
            case vk_f6:
            case vk_f7:
            case vk_f8:
            case vk_f9:
            case vk_f10:
            case vk_f11:
            case vk_f12:
            case vk_escape:
            case vk_alt:
            case vk_nokey:
            case vk_printscreen:
                exit;
        }
    }
    else
    {
        // no keys pressed
        press = 0;
    }

    event_user(0);

    if (key != -1 && !press)
    {
        if(skip)
            key=-1;
        currentKeys[keyID + pID*10]=key;
        keyID+=1;
        // assign key
        press = 1;
        switch (current)
        {
            case 'LEFT':
                if(!skip)
                    global.leftKey[pID] = key;
                current = 'RIGHT';
                break;
            case 'RIGHT':
                if(!skip)
                    global.rightKey[pID] = key;
                current = 'UP';
                break;
            case 'UP':
                if(!skip)
                    global.upKey[pID] = key;
                current = 'DOWN';
                break;
            case 'DOWN':
                if(!skip)
                    global.downKey[pID] = key;
                current = 'JUMP';
                break;
            case 'JUMP':
                if(!skip)
                    global.jumpKey[pID] = key;
                current = 'SHOOT';
                break;
            case 'SHOOT':
                if(!skip)
                    global.shootKey[pID] = key;
                current = 'SLIDE';
                break;
            case 'SLIDE':
                if(!skip)
                    global.slideKey[pID] = key;
                current = 'PREV WPN';
                break;
            case 'PREV WPN':
                if(!skip)
                    global.weaponSwitchLeftKey[pID] = key;
                current = 'NEXT WPN';
                break;
            case 'NEXT WPN':
                if(!skip)
                    global.weaponSwitchRightKey[pID] = key;
                current = 'PAUSE';
                break;
            case 'PAUSE':
                if(!skip)
                    global.pauseKey[pID] = key;
                current = 'LEFT';
                pID += 1;
                if (pID >= global.playerCount)
                {
                    selected = 0;
                    buffer = 1;
                    alarm[0] = 10;
                    newControls = 0;
                }

                break;
        }

        playSFX(sfxMenuMove);
    }
}

// gamepad configuration
if (newControls == 2)
{
    if (!objGlobalControl.joystick_connected)
    {
        newControls = 0;
        selected = 0;
        press = 1;
        buffer = 1;
        alarm[0] = 10;
        exit;
    }
    if(!skip)
    {
        var i, b;
        var jID; jID = pID;
        if (!joystick_exists(jID))
            jID += 4 - objGlobalControl.xinputDeviceCount;
        b = joystick_buttons(jID);

        for (i = 0; i < b; i += 1)
        {
            if (joystick_check_button(jID, i))
            {
                key = i;
                break;
            }
        }
    }
    else
    {
        key=vk_delete;
    }
    if (key == -1)
    {
        press = 0;
    }
    else{
        event_user(0);
    }
    if (key != -1 && !press)
    {
        if(skip)
            key=-1;
        currentKeys[keyID + pID*10]=key;
        keyID+=1;
        press = 1;
        switch (current)
        {
            case 'JUMP':
                if(!skip)
                    global.joystick_jumpKey[pID] = key;
                current = 'SHOOT';
                break;
            case 'SHOOT':
                if(!skip)
                    global.joystick_shootKey[pID] = key;
                current = 'SLIDE';
                break;
            case 'SLIDE':
                if(!skip)
                    global.joystick_slideKey[pID] = key;
                current = 'PREV WPN';
                break;
            case 'PREV WPN':
                if(!skip)
                    global.joystick_weaponSwitchLeftKey[pID] = key;
                current = 'NEXT WPN';
                break;
            case 'NEXT WPN':
                if(!skip)
                    global.joystick_weaponSwitchRightKey[pID] = key;
                current = 'PAUSE';
                break;
            case 'PAUSE':
                 if(!skip)
                    global.joystick_pauseKey[pID] = key;
                current = 'JUMP';
                pID += 1;
                if (pID >= 1 && joystick_count() > pID) // global.playerCount
                {
                    selected = 0;
                    buffer = 1;
                    alarm[0] = 10;
                    newControls = 0;
                }
                break;
        }

        playSFX(sfxMenuMove);
    }
}
#define Other_10
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
///Validate inputs

if(key != -1 && !press)
{
    var i; for(i =0;i<10 && currentKeys[i+pID*10]!=-1;i+=1)
    {
        if(currentKeys[i+pID*10]==key)
        {
            key=-1;
            break;
        }
    }
}
#define Draw_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
draw_set_color(c_white);

// center display on non-standard resolutions
drawXPosition = view_xview[0] + view_wview[0] / 2 - 128;
drawYPosition = view_yview[0] + view_hview[0] / 2 - 112;

// draw menu bg
draw_sprite(sprite_index, 0, drawXPosition, drawYPosition);

// animate cursor
cursorImgIndex += cursorImgSpd;
if (cursorImgIndex >= 5)
{
    cursorImgIndex -= 5;
}

// draw cursor
draw_sprite(sprOptionsCursor, cursorImgIndex, drawXPosition + 34, drawYPosition + 52 + (option) * 14 - (optionOffset) * 14);

// animate arrows
arrowBlinkTimer -= 1;
if (arrowBlinkTimer == 0)
{
    arrowBlinkTimer = 20;
    showArrow = !showArrow;
}

// draw arrows
draw_set_halign(fa_middle);
draw_set_valign(fa_middle);

if (optionOffset == 0)
{
    draw_text(drawXPosition + 128, drawYPosition + 42, "- OPTIONS -");
}
else if (showArrow)
{
    draw_sprite(sprArrow, 2, drawXPosition + 128, drawYPosition + 42);
}

if (optionOffset == array_length_1d(optionText) - visibleOptions)
{
    draw_text(drawXPosition + 128, drawYPosition + 182, "- OPTIONS -");
}
else if (showArrow)
{
    draw_sprite(sprArrow, 3, drawXPosition + 128, drawYPosition + 182);
}

// draw options
draw_set_halign(fa_left);
draw_set_valign(fa_top);
var j; for (j = 0; j < visibleOptions; j+=1)
{
    draw_text_ext(drawXPosition + 48, drawYPosition + 52 + j * 14, optionText[optionOffset + j], 14, 256);
}

// draw current option status'
opt = '';
for (j = 0; j < visibleOptions; j+=1)
{
    switch (optionOffset + j)
    {
        // Resolution
        case 3:
            if (!window_get_fullscreen())
            {
                opt += string(global.screensize) + 'X';
            }
            else
            {
                opt += 'FULL';
            }

            break;

        // V-Sync
        case 4:
            if (global.vsync)
            {
                opt += 'ON';
            }
            else
            {
                opt += 'OFF';
            }

            break;

        // Music volume
        case 5:
            opt += string(global.musicvolume) + '%';

            break;

        // Sound volume
        case 6:
            opt += string(global.soundvolume) + '%';

            break;

        // Co-op
        case 7:
            opt += string(global.playerCount);

            break;

        // FPS dispaly
        case 8:
            if (global.showFPS == 1)
            {
                opt += 'ON';
            }
            else
            {
                opt += 'OFF';
            }

            break;

        // controller overlay
        case 9:
            switch (global.showControllerOverlay)
            {
                case 0:
                    opt += 'OFF';
                    break;
                case 1:
                    opt += 'WIDE';
                    break;
                case 2:
                    opt += 'THIN';
                    break;
            }

            break;

        // damage popup
        case 10:
            if (global.damagePopup == 1)
            {
                opt += 'ON';
            }
            else
            {
                opt += 'OFF';
            }

            break;

        // charge bar
        case 11:
            if (global.chargeBar == 1)
            {
                opt += 'ON';
            }
            else
            {
                opt += 'OFF';
            }

            break;

        // mega man colors
        case 12:
            if (global.mmColor)
            {
                opt += 'MM9/MM10';
            }
            else
            {
                opt += 'MM1-MM6';
            }

            break;

        // moving text effects
        case 13:
            if (global.showMovingText)
            {
                opt += 'ON';
            }
            else
            {
                opt += 'OFF';
            }

            break;

        // health effect
        case 14:
            switch (global.healthEffect)
            {
                case 0:
                    opt += 'FILL';
                    break;
                case 1:
                    opt += 'INSTANT';
                    break;
            }

            break;

        // esc key function
        case 15:
            switch (global.escapeBehavior)
            {
                case 0:
                    opt += 'QUIT';
                    break;
                case 1:
                    opt += 'PAUSE';
                    break;
                case 2:
                    opt += 'N/A';
                    break;
            }

            break;

        // Pickup graphics
        case 17:
            if (global.pickupGraphics)
            {
                opt += 'MM1';
            }
            else
            {
                opt += 'MM2+';
            }
            break;

        // Death effect
        case 18:
            if (global.deathEffect)
            {
                opt += 'MM1/MM2';
            }
            else
            {
                opt += 'MM3+';
            }
            break;

        // Jump sound
        case 19:
            if (global.jumpSound)
            {
                opt += 'MM1/MM2';
            }
            else
            {
                opt += 'MM3-6';
            }
            break;

        // Teleport sound
        case 20:
            if (global.teleportSound)
            {
                opt += 'MM1/MM2';
            }
            else
            {
                opt += 'MM3-MM6';
            }
            break;
    }

    // next line
    opt += '#';
}

draw_set_halign(fa_right);
draw_text_ext(drawXPosition + 224, drawYPosition + 52, opt, 14, 256);


// draw configure controls popup
if (newControls)
{
    draw_sprite(sprControlconfigureScreen, 0, drawXPosition + 64, drawYPosition + 64);
    draw_set_halign(fa_center);
    if(newControls == 1)
        draw_text(drawXPosition + 128, drawYPosition + 88, 'PRESS KEY FOR');
    else
        draw_text(drawXPosition + 128, drawYPosition + 88, 'PRESS KEY FOR#(PRESS DEL TO SKIP)');
    var playerMod; playerMod = "";
    playerMod = " (P" + string(pID + 1) + ")";
    draw_text(drawXPosition + 128, drawYPosition + 104, current + playerMod);
}

// colored text overlays
if (global.showColoredTextOverlays)
{
    draw_set_color(make_color_rgb(global.coloredTextOverlaysRed, global.coloredTextOverlaysGreen, global.coloredTextOverlaysBlue));
    draw_set_alpha(global.coloredTextOverlaysOpacity / 255);

    draw_rectangle(drawXPosition + 28, drawYPosition + 36, drawXPosition + view_wview[0] - 28, drawYPosition + view_hview[0] - 36, false);

    draw_set_color(c_white);
    draw_set_alpha(1);
}
