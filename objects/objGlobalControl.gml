#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
/// initialization

//// global initialization ////

// set random seed
randomize();

// engine configuration options
engineConfig();

/// global variable setup
globalInit();

//// instance variables private to objGlobalControl ////

// fade in/out
fadeAlpha = 0;
fadestep = 0.2;
fadeinterval = 3;
fadetimer = 0;

// health bar
showhealth = 0;
increaseHealth = false;
increaseAmmo = false;
increaseTimer = 0;
increaseWeapon = 0;
depthstart = depth;
depthAlter = 0;

// save icon
saveTimer = -1;
saveFrame = 0;

// list of pickups (prevents pickup respawning)
pickups = ds_list_create();

// used for pausing
setfrozen = 0;

// pause list
obj[0] = prtEntity;
obj[1] = prtEffect;

/// User-specific globals ////

// new save file
freshSaveFile();

// default options
freshOptions();

// load user's options (if they exist)
saveLoadOptions(false);

/// set up display ///

setScreenSize(global.screensize);
display_reset(0, global.vsync);

//// Create other control objects ////
instance_create(0, 0, objMusicControl);
instance_create(0, 0, objDebugControl);
instance_create(0, 0, objMobileControl);

//Used to load a room passed as parameter
init=1;

// show disclaimer
room_goto(rmDisclaimer);
#define Alarm_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
/// death -- restart
global.nextRoom = global.checkpoint;

// game over
if (global.livesRemaining <= 0 && global.livesEnabled && global.inGame)
{
    // recordings should stop
    if (global.recordInputMode != 0)
    {
        global.recordInputDeath = true;
    }
    else
    {
        global.nextRoom = rmGameOver;
    }
}
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
/// energy handling and screen shake

x = view_xview[0] + 16;
y = view_yview[0] + 16;

// Infinite energy handling
for (i = 0; i <= global.totalWeapons; i += 1)
{
    if (global.infiniteEnergy[i])
    {
        for (j = 0; j < global.playerCount; j += 1)
        {
            global.ammo[j, i] = 28;
        }
    }
}

if (increaseHealth || increaseAmmo) // Increase Health and/or Ammo
{
    if (global.healthEffect) // Instant
    {
        if (increaseHealth)
        {
            global.playerHealth[increasePID] = ceil(global.playerHealth[increasePID] + increaseHealth);
            playSFX(sfxEnergyRestore);

            increaseHealth = 0;
        }
        if (increaseAmmo)
        {
            global.ammo[increasePID, increaseWeapon] = ceil(global.ammo[increasePID, increaseWeapon] + increaseAmmo);
            playSFX(sfxEnergyRestore);

            increaseAmmo = 0;
        }
    }
    else
    {
        increaseTimer += 1;

        if (!(increaseTimer mod 3))
        {
            increaseHealth *= (global.playerHealth[increasePID] < 28);
            if (increaseHealth)
            {
                global.playerHealth[increasePID] = floor(global.playerHealth[increasePID]) + 1;
                increaseHealth = max(increaseHealth - 1, 0);
            }
            increaseAmmo *= (global.ammo[increasePID, increaseWeapon] < 28);
            if (increaseAmmo)
            {
                global.ammo[increasePID, increaseWeapon] = floor(global.ammo[increasePID, increaseWeapon]) + 1;
                increaseAmmo = max(increaseAmmo - 1, 0);
            }
        }
    }

    if (!increaseHealth && !increaseAmmo)
    {
        global.frozen = false;
        increaseTimer = 0;
        if (!global.healthEffect)
        {
            audio_stop_sound(sfxEnergyRestore);
        }
    }

    // make sure ammo never goes past 28
    if (global.playerHealth[increasePID] > 28)
    {
        global.playerHealth[increasePID] = 28;
    }

    if (global.ammo[increasePID, increaseWeapon] > 28)
    {
        global.ammo[increasePID, increaseWeapon] = 28;
    }
}

// Screen shake handling
if (!global.frozen)
{
    if (global.shakeTimer > 0)
    {
        global.shakeTimer -= 1;
    }
    else
    {
        global.shakeFactorX = 0;
        global.shakeFactorY = 0;
    }
}
#define Step_1
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
///Load room from parameter
if(init && room == rmDisclaimer)
{
    init=0;
    if(parameter_count()>1)
    {
        var filename = "+" + parameter_string(1);
        if(filename!="+" && stringEndsWith(filename,".room.gmx"))
        {

            var nrm = roomExternalLoad(filename);
            goToLevel(nrm);
            exit;
        }
    }
}
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
/// revert camera effects

if (!instance_exists(objSectionSwitcher) && global.inGame)
{
    view_xview[0] = global.cachedXView;
    view_yview[0] = global.cachedYView;
}
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
/// game timers

global.roomTimer += 1;
global.gameTimer += 1;
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
/// player input
// Inputs

// Gamepad info
xinputDeviceCount = 0;
for (var i = 0; i < 4; i++)
{
    if (gamepad_is_connected(i))
        xinputDeviceCount++;
}

var n_connected = 0;
for (var i = 0; i < gamepad_get_device_count(); i += 1)
{
    if (gamepad_is_connected(i))
        n_connected += 1;
}
n_connected = min(n_connected, global.playerCount);
for (i = 0; i < global.playerCount; i += 1)
{
    // Input
    keyLeftHold = global.keyLeft[i];
    keyRightHold = global.keyRight[i];
    keyUpHold = global.keyUp[i];
    keyDownHold = global.keyDown[i];
    keyJumpHold = global.keyJump[i];
    keyShootHold = global.keyShoot[i];
    keySlideHold = global.keySlide[i];
    keyPauseHold = global.keyPause[i];
    keyWeaponSwitchLeftHold = global.keyWeaponSwitchLeft[i];
    keyWeaponSwitchRightHold = global.keyWeaponSwitchRight[i];

    // Check keys
    global.keyLeft[i] = keyboard_check(global.leftKey[i]);
    global.keyRight[i] = keyboard_check(global.rightKey[i]);
    global.keyUp[i] = keyboard_check(global.upKey[i]);
    global.keyDown[i] = keyboard_check(global.downKey[i]);
    global.keyJump[i] = keyboard_check(global.jumpKey[i]);
    global.keyShoot[i] = keyboard_check(global.shootKey[i]);
    global.keySlide[i] = keyboard_check(global.slideKey[i]);
    global.keyPause[i] = keyboard_check(global.pauseKey[i])
        || (keyboard_check_pressed(vk_escape)
        && global.escapeBehavior == 1);
    global.keyWeaponSwitchLeft[i] = keyboard_check(
        global.weaponSwitchLeftKey[i]);
    global.keyWeaponSwitchRight[i] = keyboard_check(
        global.weaponSwitchRightKey[i]);

    jp = i;

    if (n_connected > 0)
    {
        if (!gamepad_is_connected(jp))
        {
            jp += 4 - xinputDeviceCount;
        }
        if (gamepad_is_connected(jp))
        {
            if (gamepad_axis_count(jp) >= 2)
            {
                // Check D-Pad first

                var dPad = false;
                if (joystick_has_pov(jp))
                {
                    var angle = joystick_pov(jp);
                    if (angle != -1)
                        dPad = true;
                    switch (angle)
                    {
                        case 0:
                            global.keyUp[i] += 1;
                            break;
                        case 45:
                            global.keyRight[i] += 1;
                            global.keyUp[i] += 1;
                            break;
                        case 90:
                            global.keyRight[i] += 1;
                            break;
                        case 135:
                            global.keyDown[i] += 1;
                            global.keyRight[i] += 1;
                            break;
                        case 180:
                            global.keyDown[i] += 1;
                            break;
                        case 225:
                            global.keyLeft[i] += 1;
                            global.keyDown[i] += 1;
                            break;
                        case 270:
                            global.keyLeft[i] += 1;
                            break;
                        case 315:
                            global.keyLeft[i] += 1;
                            global.keyUp[i] += 1;
                            break;
                    }
                }

                // Analog Stick position
                if (!dPad)
                {
                    var axX = gamepad_axis_value(jp, gp_axislh);
                    var axY = gamepad_axis_value(jp, gp_axislv);
                    if ((abs(axY) > 0.4) || (abs(axX) > 0.36))
                    {
                        gamepadStick = point_direction(0, 0, axX, axY);
                        global.keyLeft[i] += (gamepadStick >= 120
                            && gamepadStick <= 240);
                        global.keyRight[i] += ((gamepadStick <= 60)
                            || gamepadStick >= 300);
                        global.keyUp[i] += (gamepadStick >= 30
                            && gamepadStick <= 150);
                        global.keyDown[i] += (gamepadStick >= 210
                            && gamepadStick <= 330);
                    }
                }
            }
            global.keyJump[i] += gamepad_button_check(jp,
                global.joystick_jumpKey[i]);
            global.keyShoot[i] += gamepad_button_check(jp,
                global.joystick_shootKey[i]);
            global.keySlide[i] += gamepad_button_check(jp,
                global.joystick_slideKey[i]);
            global.keyPause[i] += gamepad_button_check(jp,
                global.joystick_pauseKey[i]);
            global.keyWeaponSwitchLeft[i] += gamepad_button_check(jp,
                global.joystick_weaponSwitchLeftKey[i]);
            global.keyWeaponSwitchRight[i] += gamepad_button_check(jp,
                global.joystick_weaponSwitchRightKey[i]);
        }
    }

    // Key pressed stuff
    global.keyLeftPressed[i] = global.keyLeft[i] && !keyLeftHold;
    global.keyRightPressed[i] = global.keyRight[i] && !keyRightHold;
    global.keyUpPressed[i] = global.keyUp[i] && !keyUpHold;
    global.keyDownPressed[i] = global.keyDown[i] && !keyDownHold;
    global.keyJumpPressed[i] = global.keyJump[i] && !keyJumpHold;
    global.keyShootPressed[i] = global.keyShoot[i] && !keyShootHold;
    global.keySlidePressed[i] = global.keySlide[i] && !keySlideHold;
    global.keyPausePressed[i] = global.keyPause[i] && !keyPauseHold;
    global.keyWeaponSwitchLeftPressed[i] = global.keyWeaponSwitchLeft[i]
        && !keyWeaponSwitchLeftHold;
    global.keyWeaponSwitchRightPressed[i] = global.keyWeaponSwitchRight[i]
        && !keyWeaponSwitchRightHold;
}

// recorded controls dubbing:
recordInputHandle();
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
/// freeze / unfreeze game objects
if (global.frozen)
{
    var len = array_length_1d(obj);
    for (i = 0; i < len; i += 1)
    {
        with (obj[i])
        {
            if (!frozen) // Start Freeze
            {
                pre_hsp = hspeed;
                pre_vsp = vspeed;
                pre_spe = speed;
                pre_isp = image_speed;
                hspeed = 0;
                vspeed = 0;
                speed = 0;
                image_speed = 0;
                frozen = 1;
            }

            for (_i = 0; _i <= 11; _i += 1)
            {
                if (alarm[_i] > 0)
                {
                    alarm[_i] += 1;
                }
            }
        }
    }
    setfrozen = 1;
}
else if (setfrozen) // Stop Freeze
{
    var len = array_length_1d(obj);
    for (i = 0; i < len; i += 1)
    {
        with (obj[i])
        {
            if (frozen)
            {
                hspeed = pre_hsp;
                vspeed = pre_vsp;
                speed = pre_spe;
                image_speed = pre_isp;
                frozen = 0;
            }
        }
    }
    setfrozen = 0;
}
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
/// Respawn players
if (global.frozen)
{
    exit;
}

global.respawnAllowed = false;

with (objMegaman)
{
    if (gravDir > 0)
    {
        global.respawnAllowed = true;
    }
}

with (objMegaman)
{
    if (global.playerHealth[playerID] > global.respawnDonateThreshold)
    {
        global.respawnAllowed = true;
    }
    if (playerIsLocked(PL_LOCK_PAUSE))
    {
        global.respawnAllowed = false;
    }
}

if (instance_exists(objAutoScroller))
{
    global.respawnAllowed = false;
}

for (i = 0; i < global.playerCount; i += 1)
{
    if (global.respawnTimer[i] >= 0)
    {
        if (global.respawnTimer[i])
        {
            global.respawnTimer[i] -= 1;
            if (!instance_exists(objMegaman))
            {
                global.respawnTimer[i] = -1;
            }
        }

        if (!instance_exists(prtBoss)
            && global.respawnTimer[i] > global.respawnTime)
        {
            global.respawnTimer[i] = global.respawnTime;
        }

        if (global.keyPausePressed[i] && global.respawnAllowed
            && !global.respawnTimer[i])
        {
            // Check no existing player already has this id
            var nogo = false;
            with (objMegaman)
            {
                if (playerID == i)
                {
                    nogo = true;
                }
            }
            if (nogo)
            {
                continue;
            }

            if (!global.respawnAllowed)
            {
                playSFX(sfxError);
                continue;
            }
            playSFX(sfxMenuSelect);

            // determine respawn health:
            var donators = 1;
            var respawn_health = 0;

            with (objMegaman)
            {
                if (global.playerHealth[playerID]
                    > global.respawnDonateThreshold)
                {
                    donators += 1;
                }
            }
            with (objMegaman)
            {
                donate = floor(global.playerHealth[playerID] / donators)
                    * (global.playerHealth[playerID]
                    > global.respawnDonateThreshold);
                respawn_health += donate;
                global.playerHealth[playerID] -= donate;
            }

            // respawn player at random other player's coords
            targetPlayer = instance_find(objMegaman,
                irandom(instance_number(objMegaman) - 1));
            prev_checkpoint = global.checkpoint;
            global.checkpoint = -1;

            p = instance_create(targetPlayer.x, targetPlayer.y, objMegaman);
            p.gravfactor = targetPlayer.gravfactor;
            p.inWater = targetPlayer.inWater;
            p.grav = targetPlayer.grav;
            p.gravWater = targetPlayer.gravWater;
            with (p)
            {
                // teleporting init
                teleportLock = lockPoolLock(
                    localPlayerLock[PL_LOCK_MOVE],
                    localPlayerLock[PL_LOCK_PHYSICS],
                    localPlayerLock[PL_LOCK_SHOOT],
                    localPlayerLock[PL_LOCK_CLIMB],
                    localPlayerLock[PL_LOCK_CHARGE],
                    localPlayerLock[PL_LOCK_PAUSE],
                    localPlayerLock[PL_LOCK_TURN],
                    localPlayerLock[PL_LOCK_GRAVITY]);
                canHit = false;
            }

            global.checkpoint = prev_checkpoint;
            p.playerID = i;
            global.playerHealth[i] = respawn_health;
            global.respawnTimer[i] = -1;
            objGlobalControl.alarm[0] = -1;
            global.decrementLivesOnRoomEnd = false;
        }
    }
}
#define Step_2
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
/// camera update, flicker, and fade

if (!instance_exists(objSectionSwitcher) && global.inGame)
{
    // Camera
    playerCamera(1);

    // screen shaking
    if (!global.frozen)
    {
        view_xview[0] += choose(-global.shakeFactorX, 0, global.shakeFactorX);
        view_yview[0] += choose(-global.shakeFactorY, 0, global.shakeFactorY);
    }

    with (prtCustomCamera)
    {
        event_user(0);
    }
}

// Flicker
depthAlter = !depthAlter;
if (depthAlter)
{
    depth = 10;
}

for (i = 0; i <= 1; i += 1)
{
    with (obj[i])
    {
        if (depth < 100000 && !noFlicker)
        {
            depth = floor(depth) + (irandom(99) * 0.01);
        }
    }
}

if (global.nextRoom != 0 || fadeAlpha > 0)
{
    fadetimer += (1 + instance_exists(objPauseMenu));

    if (fadetimer >= fadeinterval)
    {
        if (global.nextRoom && fadeAlpha == 1)
        {
            global.previousRoom = room;
            room_goto(global.nextRoom);
        }

        fadeAlpha += fadestep * (1 - (2 * (global.nextRoom == 0)));
        fadeAlpha = max(0, min(1, fadeAlpha));

        fadetimer = 0;
        if (fadeAlpha == 1)
        {
            fadetimer = -5;
        }
        else if (global.nextRoom == 0 && fadeAlpha == 0)
        {
            if (!instance_exists(objPauseMenu))
            {
                global.frozen = false;
            }
        }
    }
}
#define Other_3
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
// Save game
saveLoadOptions(true);
saveLoadGame(true);
#define Other_4
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
/// setup room, spawn players, etc.
joystick_connected = 0;
if (joystick_exists(1))
{
    joystick_connected = true;
}

// global.frozen = false;
global.aliveBosses = 0;

global.lockTransition = false;
global.switchingSections = false;

global.keyCoinTotal = 0;
global.keyCoinCollected = 0;
global.keyNumber = 0;

global.nextRoom = 0;

view_wview[0] = min(global.screenWidth, room_width);
view_hview[0] = min(global.screenHeight, room_height);

room_speed = global.gameSpeed;

showhealth = 0;
global.roomTimer = 0;

// begin level if flag set
if (global.beginStageOnRoomBegin && global.hasTeleported)
{
    // Delete this if you actually desire levels to begin by teleporter.
    // (Note that MaGMML-esque hub teleporters should not trigger this because they should not set hasTeleported to true.)
    printErr("Warning: A new stage began by teleporting in. This is probably not intended behaviour. See objGlobalControl:Room Start event for details.");
}

global.inGame = (instance_exists(objDefaultSpawn) || global.hasTeleported);

assert(!global.beginStageOnRoomBegin || global.inGame, "Began a stage but nowhere for player to spawn.");

if (global.inGame)
{
    if (DEBUG_SPAWN)
        show_debug_message("Level Start (objGlobalControl) " + roomExternalGetName(room));
    showhealth = 1;

    // set room settings
    view_enabled = true;
    view_visible[0] = true;
    room_speed = 60;

    // quadrant size
    for (i = 0; i <= 7; i += 1)
    {
        if (string_pos("bgQuad", background_get_name(background_index[i])) == 1)
        {
            global.quadWidth = background_get_width(background_index[i]);
            global.quadHeight = background_get_height(background_index[i]);
            global.quadMarginTop = (global.quadHeight - view_hview[0]) / 2;
            global.quadMarginBottom = global.quadMarginTop;
            background_index[i] = -1;
        }
    }

    view_wview[0] = global.quadWidth;

    // Destroy collected pickups
    var str, slash, totalPickups;

    totalPickups = ds_list_size(pickups);
    for (var i = 0; i <= totalPickups; i += 1)
    {
        str = ds_list_find_value(pickups, i);
        if (!is_string(str))
        {
            break;
        }
        slash = string_pos('/', str);
        if (room == real(string_copy(str, 1, slash - 1)))
        {
            with (real(string_delete(str, 1, slash)))
            {
                visible = 0;
                instance_destroy();
            }
        }
    }

    // Place section borders
    for (var v = 0; v < room_height; v += global.quadHeight)
        for (var i = 0; i < room_width; i += global.quadWidth)
        {
            with (instance_create(i, v, objStopScrollingVertical))
            {
                image_xscale = global.quadWidth / sprite_get_width(sprite_index);
            }
        }

    // Delete vertical border to make vertical scrolling possible
    with (objStopScrollingVertical)
    {
        if (place_meeting(x, y, objSectionFreeVerticalScrolling))
        {
            instance_destroy();
        }
    }

    // Connect Horizontal borders
    /*with (objStopScrollingHorizontal)
    {
        if (!place_meeting(x, y - 12, object_index))
        {
            while (place_meeting(x, y + 12, object_index))
            {
                with (instance_place(x, y + 12, object_index))
                {
                    other.image_yscale += image_yscale;
                    instance_destroy();
                }
            }
        }
    }*/

    ds_list_clear(global.borderlist);

    with (objStopScrollingHorizontal)
    {
        ds_list_add(global.borderlist, "h" + string(x) + "s" + string(y) + "e" + string(y + sprite_height));
        instance_destroy();
    }
    with (objStopScrollingVertical)
    {
        ds_list_add(global.borderlist, "v" + string(y) + "s" + string(x) + "e" + string(x + sprite_width));
        instance_destroy();
    }

    // determine starting location
    var spawn_x, spawn_y;

    // three ways to enter a room: teleporting, respawning, or level start
    if (global.hasTeleported)
    {
        // just teleported in
        if (global.teleportX || global.teleportY)
        {
            spawn_x = global.teleportX;
            spawn_y = global.teleportY;
        } // if coordinates were not specified, use the DefaultSpawn coordinates
        else
        {
            assert(instance_exists(objDefaultSpawn));
            spawn_x = objDefaultSpawn.x;
            spawn_y = objDefaultSpawn.y;
        }
    }
    else
    {
        if (global.checkpoint == room)
        {
            // respawn after death
            spawn_x = global.checkpointX;
            spawn_y = global.checkpointY;

            // reset health
            for (var i = 0; i < global.playerCount; i++)
            {
                global.playerHealth[i] = 28;
            }
        }
        else
        {
            // Level start. Use default spawn location.
            global.checkpoint = room;
            global.checkpointX = objDefaultSpawn.x;
            global.checkpointY = objDefaultSpawn.y;
            global.respawnAnimation = objDefaultSpawn.respawnAnimation;
            global.freeMovement = false;
            if (instance_exists(objMegaman))
            {
                objMegaman.showDuringReady = objDefaultSpawn.showDuringReady;
            }
            spawn_x = global.checkpointX;
            spawn_y = global.checkpointY;

            stageStart();
        }
    }

    // Create players
    for (var i = 0; i < global.playerCount; i += 1)
    {
        if (global.playerHealth[i] <= 0)
        {
            continue;
        }

        with (instance_create(spawn_x, spawn_y, objMegaman))
        {
            playerID = i;
            readyTimer -= playerID * 12;

            if (global.hasTeleported)
            {
                showReady = false;
                teleporting = true;
                landy = y;
            }
            else
            {
                // teleport in
                showReady = true;
                readyTimer = 0;
                canHit = false;
            }

            teleportLock = lockPoolLock(
                localPlayerLock[PL_LOCK_MOVE],
                localPlayerLock[PL_LOCK_PHYSICS],
                localPlayerLock[PL_LOCK_SHOOT],
                localPlayerLock[PL_LOCK_CLIMB],
                localPlayerLock[PL_LOCK_CHARGE],
                localPlayerLock[PL_LOCK_PAUSE],
                localPlayerLock[PL_LOCK_TURN],
                localPlayerLock[PL_LOCK_GRAVITY]
                );

            playerPalette();
        }
    }

    // combine objects to save on CPU
    combineObjects(objSolid);
    combineObjects(objSpike);
    combineObjects(objDamageSpike);
    combineObjects(objIce);
    combineObjects(objWater);
    combineObjects(objStandSolid);
    combineObjects(objTopSolid, true, false);
    combineObjects(objLadder, false, true);
    with (prtBossDoor)
        event_user(3);

    setSection(spawn_x, spawn_y, 1);
    playerCamera(1);

    // defer deactivating objects until after room start
    // this allows objects with room start events to run those
    var activate;
    activate[0] = 2;
    activate[1] = 1;
    defer(ev_step, ev_step_begin, depth, reAndDeactivateObjects, activate);
    with (prtEntity)
    {
        beenOutsideView = true;
        dead = true;
    }
    global.hasTeleported = false;
}

// if the new room's view size is different, adjust the screen size accordingly
if (surface_get_width(application_surface) != view_wview[0] * global.screensize
    || surface_get_height(application_surface) != view_hview[0] * global.screensize)
{
    setScreenSize(global.screensize, false);
}

// next room should not launch a new level
global.beginStageOnRoomBegin = false;
global.beginHubOnRoomBegin = false;
#define Other_5
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
setfrozen = 0;

if (global.endStageOnRoomEnd)
{
    stageEnd();
}
else if (global.decrementLivesOnRoomEnd)
{
    // lose a life
    if (global.inGame)
    {
        global.livesRemaining--;
    }
    global.decrementLivesOnRoomEnd = false;
    if (global.livesRemaining < 0)
    {
        global.inGame = false;
    }
}

// objMegaman clean-up
with (objMegaman)
    instance_destroy();

// weapon clean up
for (i = 0; i <= global.playerCount; i += 1)
{
    global.weapon[i] = 0;
}

global.lockBuster = false;

global.timeStopped = false;

application_surface_draw_enable(true);

// forcibly reset control locks
globalLockReset();
#define Draw_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if (showhealth)
{
    var dx = view_xview + 16;
    var dy = view_yview + 17;

    draw_enable_alphablend(false);

    /// Draw HUD
    for (z = 0; z < global.playerCount; z += 1)
    {
        draw_sprite_ext(sprHealthbarBackground, 0, dx, dy, 1, 1, image_angle,
            c_black, image_alpha);

        // Respawn indicators
        if (global.respawnTimer[z] >= 0)
        {
            draw_set_color(c_white);
            draw_set_halign(fa_left);
            draw_set_valign(fa_middle);

            if (global.respawnTimer[z] > 0)
            {
                draw_text(dx, dy + 28, ceil(global.respawnTimer[z] / 60));
            }
            else if (global.respawnAllowed)
            {
                draw_text(dx, dy + 28, "R#E#A#D#Y");
            }

            draw_set_valign(fa_top);
        }
        else
        {
            // normal healthbar
            var pcol = make_color_rgb(252, 228, 160);
            var scol = c_white;

            // low health -- red color
            if (global.playerHealth[z] <= global.respawnDonateThreshold && global.playerCount > 1)
            {
                scol = pcol;
                pcol = global.nesPalette[5];
            }

            for (i = 1; i <= ceil(global.playerHealth[z]); i += 1)
            {
                draw_sprite_ext(sprHealthbarPrimary, 0, dx + 1,
                    dy + (sprite_get_height(sprHealthbarBackground) - i * 2),
                    1, 1, 0, pcol, 1);
                draw_sprite_ext(sprHealthbarSecondary, 0, dx + 1,
                    dy + (sprite_get_height(sprHealthbarBackground) - i * 2),
                    1, 1, 0, scol, 1);
            }

            var display = true;

            // Weapons
            if (global.weapon[z] != 0) // Weapon energy
            {
                c = round(global.ammo[z, global.weapon[z]]);
            }
            else // Charge bar
            {
                c = 0;
                with (objMegaman)
                {
                    if (playerID == other.z)
                    {
                        other.c = min(28, floor(chargeTimer) / 2);
                    }
                }
                display = global.chargeBar;
            }

            if (display)
            {
                draw_sprite_ext(sprHealthbarBackground, 0, dx - 8, dy, 1, 1,
                    image_angle, global.outlineCol[z], image_alpha);
                for (i = 1; i <= c; i += 1)
                {
                    draw_sprite_ext(sprHealthbarPrimary, 0, dx - 8 + 1, dy
                        + (sprite_get_height(sprHealthbarBackground) - i * 2),
                        1, 1, 0, global.primaryCol[z], 1);
                    draw_sprite_ext(sprHealthbarSecondary, 0, dx - 8 + 1, dy
                        + (sprite_get_height(sprHealthbarBackground) - i * 2),
                        1, 1, 0, global.secondaryCol[z], 1);
                }
                if (global.infiniteEnergy[global.weapon[z]])
                {
                    draw_sprite_ext(sprInfinityMarkVertical, 0, dx - 8, dy + 28, 1,
                        1, 0, c_white, 1);
                    draw_sprite_ext(sprInfinityMarkVerticalPrimary, 0, dx - 8,
                        dy + 28, 1, 1, 0, global.primaryCol[z], 1);
                    draw_sprite_ext(sprInfinityMarkVerticalSecondary, 0, dx - 8,
                        dy + 28, 1, 1, 0, global.secondaryCol[z], 1);
                }
            }
        }

        dx += 24;
    }

    var bossFade = 0;
    var healthIndex = 0;
    with (prtBoss) // Boss healthbars
    {
        if (!quickSpawn&&drawHealthBar && healthParent == -1)
        {
            var dxx = dx + ((healthIndex - 1) * 8); // Multibosses

            // Initial black bg for healthbar
            draw_sprite_ext(sprHealthbarBackground, 0, dxx, dy, 1, 1, 0, c_black, 1);

            // Choose color to draw
            var currentExtraHealthBar = 0;
            var myPrimaryColor, mySecondaryColor;
            var _currentHealth = 0;

            if (fillingHealthBar) //Intro health bar
            {
                _currentHealth = ceil(healthBarHealth);
            }
            else
            {
                if (shareMode==1) //Combine health bars if needed
                {
                    with (prtBoss)
                    {
                        if (id == other.id || (healthParent==other.id && drawHealthBar))
                        {
                            _currentHealth += healthpoints;
                        }
                    }
                }
                else
                {
                    _currentHealth = healthpoints;
                }
            }
            // draw the health within the healthbar.
            for (i = 1; i <= ceil(_currentHealth); i += 1;)
            {
                // If the boss has more than 28 health, use this math to find out what 'layer' of
                // health the boss is currently on. It's i-1/28 because if it was i/28, it would start
                // a new health layer at the max health (28) rather than 1 over, when it should
                // overflow.

                if ((i mod 28) == 1) // Set new colors for the health bar
                {
                    currentExtraHealthBar = ((i - 1) / 28);
                    if (manualColors)
                    {
                        myPrimaryColor = healthBarPrimaryColor[currentExtraHealthBar + 1];
                        mySecondaryColor = healthBarSecondaryColor[currentExtraHealthBar + 1];
                    }
                    else
                    {
                        // if the colors chosen are higher numbered than valid colors on the NES palette, default to the last in the index (black)
                        myPrimaryColor = global.nesPalette[min(54, (healthBarPrimaryColor[1] + (healthBarColorSkip * (currentExtraHealthBar))))];
                        mySecondaryColor = global.nesPalette[min(54, (healthBarSecondaryColor[1] + (healthBarColorSkip * (currentExtraHealthBar))))];
                    }
                }

                // now actually draw the pellets themselves, using all the info we've gatehred.
                draw_sprite_ext(sprHealthbarPrimary, 0, dxx + 1,
                    dy + (sprite_get_height(sprHealthbarBackground)) - ((i - (currentExtraHealthBar * 28)) * 2),
                    1, 1, 0, myPrimaryColor, 1);
                draw_sprite_ext(sprHealthbarSecondary, 0, dxx + 1,
                    dy + (sprite_get_height(sprHealthbarBackground)) - ((i - (currentExtraHealthBar * 28)) * 2),
                    1, 1, 0, mySecondaryColor, 1);
            }
            healthIndex += 1;
        }

        if (isIntro && introType == 3) // MM6 intro fading
        {
            bossFade = max(bossFade, introFade);
        }
    }

    draw_enable_alphablend(true);

    if (bossFade > 0)
    {
        draw_sprite_ext(sprDot, 0, view_xview, view_yview, view_wview, view_hview, 0, c_black, bossFade);
    }

    // reset position
    var dx = view_xview + 16;
    var dy = view_yview + 17;

    // Keys
    for (i = 0; i < global.keyNumber; i += 1)
    {
        draw_sprite_ext(sprKeyHud, 0, dx + 8, dy + (8 * i), 1, 1, 0, c_white, 1);
    }

    // Key coins
    for (i = 0; i < global.keyCoinTotal; i += 1)
    {
        draw_sprite_ext(sprKeyCoinHUD, !(i < global.keyCoinCollected),
            view_xview + (8 * i), view_yview + view_hview - 8, 1, 1, 0, c_white, 1);
    }
}
#define Draw_73
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
draw_set_halign(fa_center);

if (global.showControllerOverlay)
{
    drawControllerOverlay(view_xview + view_wview - 28, view_yview + view_hview);
}

// Show FPS
if (global.showFPS)
{
    draw_set_halign(fa_right);
    draw_set_valign(fa_bottom);
    draw_text(view_xview + view_wview - (28 - ((global.showControllerOverlay == 0) * 28)) - ((global.showControllerOverlay == 1) * 4), view_yview + view_hview,
        string(fps));
}

draw_set_valign(fa_top);
draw_set_halign(fa_center);

// Save icon
if (saveTimer >= 0)
{
    saveTimer -= 0.5;
    draw_sprite(sprSavingIcon, saveFrame, view_xview + 2 + 7, view_yview + 224 - 16 + 5);
    draw_text(view_xview + 16 + 32 + 4 + 2, view_yview + 224 - 10 - 4, "SAVING...");

    if (saveTimer mod 4 == 0)
    {
        saveFrame = !saveFrame;
    }
}

// Screen iFrames
draw_set_color(c_white);
draw_set_alpha(1);
if (!global.frozen)
{
    if (global.flashTimer > 0)
    {
        global.flashTimer -= 1;
        draw_sprite_ext(sprDot, image_index, view_xview, view_yview, view_wview, view_hview, image_angle, image_blend, image_alpha);
    }
}

draw_set_color(c_white);
draw_set_halign(fa_left);
draw_set_valign(fa_top);

if (fadeAlpha > 0)
{
    draw_sprite_ext(sprDot, 0, view_xview, view_yview, view_wview, view_hview, 0, c_black, fadeAlpha);
}

depth = depthstart;
