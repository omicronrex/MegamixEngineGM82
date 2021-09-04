#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
// Debug keys
global.isInvincible = false;
global.alwaysHealth = false;
global.freeMovement = false;

// recording input
global.recordInputMode = 0; // 0: naught, 1: record, 2: playback
global.recordInputFidelityMessageBuffer = "";

// console lines
global.consoleN = 0;

// debug objectviewer
viewobjects = 0;

// screenshots
screenshotNum = 0;
screenshotTimer = 0.0;
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
// Debug keys

// Reset game
if (keyboard_check_pressed(vk_f2))
{
    sound_stop_all();
    stopMusic();
    game_restart();
}

// Change screen size
if (keyboard_check_pressed(vk_f3))
{
    var pre; pre = global.screensize;

    setScreenSize(global.screensize + 1);

    if (global.screensize == pre)
    {
        setScreenSize(1);
    }
}

// Toggle fullscreen
if (keyboard_check_pressed(vk_f4))
{
    window_set_fullscreen(!window_get_fullscreen());
}

// Screenshot
if (keyboard_check_pressed(vk_f9))
{
    while (file_exists(working_directory + "\screenshots\screenshot" + string(screenshotNum) + ".png"))
        screenshotNum += 1;
    screen_save(working_directory + "\screenshots\screenshot" + string(screenshotNum) + ".png");
    print("SCREENSHOT SAVED", WL_SHOW, c_orange);
    playSFX(sfxKeyGet);
}

// Quit
if (keyboard_check_pressed(vk_escape) && global.escapeBehavior == 0)
{
    game_end();
}

if (!global.debugEnabled)
{
    exit;
}

// free movement
if (keyboard_check_pressed(ord('1')))
{
    global.levelRunValid = false;
    global.levelRunInvalidReason = "free movement debug";
    playSFX(sfxSkullAmulet);

    global.freeMovement = !global.freeMovement;

    if (instance_exists(objMegaman))
    {
        with (objMegaman)
        {
            if (global.freeMovement == false)
            {
                iFrames = 0;
                blockCollision = true;
                visible = true;
            }

            spriteX = 0;
            spriteY = 0;
        }
    }
}

// Debug Menu
if (keyboard_check_pressed(ord('2')) && !global.frozen
    && !instance_exists(objDebugMenu) && instance_exists(objMegaman))
{
    instance_create(view_xview[0], view_yview[0], objDebugMenu);
}

// debug objectviewer
if (viewobjects)
{
    scroll += global.keyDownPressed[0] - global.keyUpPressed[0];
    scroll = min(max(0, scroll), ds_list_size(ids) - limit);

    if (keyboard_check_pressed(vk_backspace) || keyboard_check_pressed(ord('3'))) // Disable
    {
        ds_list_destroy(ids);
        ds_map_destroy(names);
        ds_map_destroy(amounts);

        viewobjects = 0;
    }
}
else if (keyboard_check_pressed(ord('3'))) // Set lists
{
    if (!viewobjects)
    {
        viewobjects = 1;

        ids = ds_list_create();
        names = ds_map_create();
        amounts = ds_map_create();
    }

    ds_list_clear(ids);
    ds_map_clear(names);
    ds_map_clear(amounts);

    var index;

    with (all)
    {
        index = string(object_index);

        with (other)
        {
            if (!ds_map_exists(names, index)) // Check if object_index is not in the list
            {
                ds_list_add(ids, index); // Add the id
                ds_map_add(names, index, string_delete(object_get_name(real(index)), 1, 3)); // Add the name
                ds_map_add(amounts, index, 1); // Add to amount list
            }
            else
            {
                ds_map_replace(amounts, index, ds_map_find_value(amounts, index) + 1);
            }
        }
    }

    limit = min(25, ds_list_size(ids));
    scroll = 0;
}

///////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////

// Effects
if (global.alwaysHealth)
{
    with (objMegaman)
    {
        global.playerHealth[playerID] = 28;
    }
}
#define Step_2
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
// console update
var CONSOLE_MAX; CONSOLE_MAX = 16;
draw_set_halign(fa_left);
draw_set_valign(fa_bottom);
var i; for ( i = 0; i < CONSOLE_MAX && i < global.consoleN; i+=1)
{
    var messageN; messageN = global.consoleN - i - 1;
    global.consoleTimer[messageN] += 1;
}
#define Draw_73
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
// Console
var CONSOLE_MAX; CONSOLE_MAX = 16;
draw_set_halign(fa_left);
draw_set_valign(fa_bottom);
var i; for ( i = 0; i < CONSOLE_MAX && i < global.consoleN; i+=1)
{
    var messageN; messageN = global.consoleN - i - 1;
    draw_set_color(global.consoleColour[messageN]);
    draw_set_alpha(roundTo(clamp(lerp(5, 0, global.consoleTimer[messageN] / 120), 0, 1), 0.2));
    draw_text(view_xview[0], view_yview[0] + view_hview[0] - 12 * i, global.consoleMessage[messageN]);
    draw_set_alpha(1);
}

// Debug - objectviewer
if (viewobjects)
{
    draw_set_valign(fa_top);
    draw_set_color(c_white);

    var cID; cID = 0;
    var yy; yy = view_yview + 16;

    if (limit)
    {
        draw_sprite_ext(sprDot, 0, view_xview + 8, yy, view_wview - 16, limit * 8, 0, c_gray, 0.5);
        for (_i = 0; limit > _i; _i+=1)
        {
            cID = ds_list_find_value(ids, _i + scroll);

            draw_set_halign(fa_right);
            draw_text(view_xview + view_wview - 8, yy, string(ds_map_find_value(amounts, cID)) + 'x');

            draw_set_halign(fa_left);
            draw_text(view_xview + 8, yy, string_copy(ds_map_find_value(names, cID), 0, 25));

            yy += 8;
        }
    }

    draw_set_halign(fa_left);
    draw_text(view_xview, view_yview, "Total instances: " + string(instance_number(all)));
}

// recording / playback sign
if (global.recordInputMode > 0)
{
    if ((global.recordInputFrame mod 30) >= 15)
    {
        draw_set_halign(fa_right);
        if (global.recordInputFidelity >= 0)
        {
            if (global.recordInputMessage == 0)
            {
                draw_sprite(sprRecPlay, global.recordInputMode - 1,
                    view_xview[0] + view_wview[0] - 32,
                    view_yview[0] + view_hview[0] - 48);
                draw_text(view_xview[0] + view_wview[0] - 64,
                    view_yview[0] + view_hview[0] - 16,
                    global.recordInputFrame);
            }
            else
            {
                draw_text(
                    view_xview[0] + view_wview[0] - 32,
                    view_yview[0] + view_hview[0] - 48,
                    global.recordInputMessage);
            }
        }
        else
        {
            draw_set_color(c_yellow);
            draw_text(
                view_xview[0] + view_wview[0] - 32,
                view_yview[0] + view_hview[0] - 48,
                "LO-FI");
        }
    }
}

draw_set_color(c_white);
