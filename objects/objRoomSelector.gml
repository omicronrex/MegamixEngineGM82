#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
image_speed = 0;

option = 1; // cursor position in the room list
endx = 8; // how many rooms fit on the screen at once
selected = 0;
shift = 0; // position in the list to start drawing to the screen from
timer = 0;
quickScrollTimer = 25;

lr = room_last;
roomlist = ds_list_create();
roomnames = ds_list_create();

nonLevels = makeArray();

ds_list_add(roomnames, "Main Menu...");
ds_list_add(roomlist, rmTitleScreen);
arrayAppend(nonLevels, rmTitleScreen);

ds_list_add(roomlist, -3);
ds_list_add(roomnames, "@#Difficulty: ");

ds_list_add(roomlist, rmFileSelect);
ds_list_add(roomnames, "@Example Game");
arrayAppend(nonLevels, rmFileSelect);

ds_list_add(roomnames, "@Character Select...");
ds_list_add(roomlist, rmCharacterSelect);
arrayAppend(nonLevels, rmCharacterSelect);

ds_list_add(roomlist, rmUnitTest);
arrayAppend(nonLevels, rmUnitTest);
ds_list_add(roomnames, "@Unit Tests");

ds_list_add(roomlist, -1);
ds_list_add(roomnames, "@Load External...");

ds_list_add(roomlist, -2);
ds_list_add(roomnames, "@Play Recording...");

// Get lvl-rooms
for (i = 0; i <= lr; i += 1)
{
    if (room_exists(i))
    {
        n = room_get_name(i);
        if (string_pos('lvl', n) == 1)
        {
            n = string_replace(n, 'lvl', '');
            if (string_pos('rm', n) == 1)
            {
                n = string_replace(n, 'rm', '');
            }
            if (string_length(n) > 18)
            {
                n = string_copy(n, 0, 18);
            }
            ds_list_add(roomlist, i);
            ds_list_add(roomnames, n);
        }
    }
}

// Fill in the blanks
while (ds_list_size(roomlist) < 8)
{
    ds_list_add(roomlist, 0);
    ds_list_add(roomnames, '-Slot Empty-');
}

//playMusic('Mega_Man_1GB.GBS', "VGM", 1, 0, 0, 0, 1);
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
timer += 1;

if (!selected)
{
    // do quick scroll timer
    if ((global.keyDown[0] ^^ global.keyUp[0]) // only do quick scroll if one direction is being held
    && !(option <= 1 && global.keyUp[0]) && !(option >= ds_list_size(roomlist) && global.keyDown[0]))
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

    // controls
    if (global.keyUpPressed[0] || (global.keyUp[0] && quickScrollTimer <= 0))
    {
        // up
        option -= 1;
        if (shift >= option)
        {
            // scroll Up
            shift -= 1;
        }

        if (option < 1)
        {
            // scroll to the bottom
            option = ds_list_size(roomlist);
            shift = option - endx;
        }

        playSFX(sfxMenuMove);
    }
    else if (global.keyDownPressed[0] || (global.keyDown[0] && quickScrollTimer <= 0))
    {
        // down
        option += 1;
        if (option > ds_list_size(roomlist))
        {
            // scroll to the top
            option = 1;
            shift = 0;
        }
        else if (option > endx + shift)
        {
            shift += 1;
        }

        playSFX(sfxMenuMove);
    }
    else if (global.keyWeaponSwitchLeftPressed[0])
    {
        // page up
        if (shift == 0)
        {
            if (option > 1)
            {
                // stop at the last option like with quick scrolling
                option = 1;
            }
            else
            {
                // scroll to the bottom if on the end of the list
                option = ds_list_size(roomlist);
                shift = option - endx;
            }
        }
        else if (shift - endx >= 0)
        {
            // move view up normally
            shift -= endx;
            option -= endx;
        }
        else
        {
            // stop at the top, but don't force the cursor to the top of the screen
            option -= shift;
            shift = 0;
        }

        playSFX(sfxMenuMove);
    }
    else if (global.keyWeaponSwitchRightPressed[0])
    {
        // page down
        if (shift == ds_list_size(roomlist) - endx)
        {
            if (option < ds_list_size(roomlist))
            {
                // stop at the last option like with quick scrolling
                option = ds_list_size(roomlist);
            }
            else
            {
                // scroll to the bottom if on the end of the list
                option = 1;
                shift = 0;
            }
        }
        else if (shift + endx <= ds_list_size(roomlist) - endx)
        {
            // move view down normally
            shift += endx;
            option += endx;
        }
        else
        {
            // stop at the bottom, but don't force the cursor to the top of the screen
            option += (ds_list_size(roomlist) - endx) - shift;
            shift = ds_list_size(roomlist) - endx;
        }

        playSFX(sfxMenuMove);
    }
    if (global.keyPausePressed[0])
    {
        var ID;
        myRoom = ds_list_find_value(roomlist, option - 1);
        if (myRoom == -1)
        {

            playSFX(sfxError);
        }
        else if (myRoom == -2)
        {
            show_message("recording was removed")
        }
        else if (myRoom == -3)
        {
            // temporary difficulty config
            if (global.difficulty == DIFF_HARD)
            {
                global.difficulty = DIFF_EASY;
            }
            else
            {
                global.difficulty += 1;
            }

            playSFX(sfxMenuMove);
        }
        else if (myRoom == -4)
        {
            // temporary lives config
            global.defaultLives = (global.defaultLives + 1) mod 7;
            global.livesEnabled = global.defaultLives != 6;
            global.livesRemaining = global.defaultLives;

            playSFX(sfxMenuMove);
        }
        else if (myRoom == 0)
        {
            playSFX(sfxError);

            exit;
        }
        else
        {
            if (indexOf(nonLevels, myRoom) != -1)
            {
                // non-level
                global.nextRoom = myRoom;
            }
            else
            {
                // stage level
                goToLevel(myRoom);
            }
            selected = 1;
            playSFX(sfxMenuSelect);
        }
    }

    if (global.keyLeftPressed[0] || global.keyRightPressed[0])
    {
        myRoom = ds_list_find_value(roomlist, option - 1);
        if (myRoom == -3)
        {
            var dir;
            if (global.keyRightPressed[0])
            {
                dir = 1;
            }
            else
            {
                dir = -1;
            }

            var pre; pre = global.difficulty;
            global.difficulty = max(0, min(2, global.difficulty + dir));

            if (global.difficulty != pre)
            {
                playSFX(sfxMenuMove);
            }
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
draw_set_halign(fa_center);
draw_set_valign(fa_top);

draw_text(128, round(8 + (sin(timer / 12) * 1)), "STAGE SELECT");

var col; col = c_white;
if (timer mod 44 < 40)
{
    col = make_color_rgb(128, 128, 128);
}

draw_sprite_ext(sprStageSelectLight, image_index, 128,
    44 + (option - 1 - shift) * 16, 1, 1, image_angle, col, image_alpha);

if (shift > 0)
{
    draw_sprite_ext(sprStageSelectArrow, image_index, 128, 48 - 13, 1, 1,
        image_angle, image_blend, image_alpha);
}
if (endx + shift < ds_list_size(roomlist))
{
    draw_sprite_ext(sprStageSelectArrow, image_index, 128, 48 + 5 + endx * 16,
        1, -1, image_angle, image_blend, image_alpha);
}

for (i = 0; i < endx; i += 1)
{
    var text; text = ds_list_find_value(roomnames, i + shift);

    // special colours
    if (is_undefined(text))
        text = "<out of bounds>";
    if (stringStartsWith(text, "@"))
    {
        text = stringSubstring(text, 2);
        draw_set_color(c_yellow);
    }
    else
        draw_set_color(c_white);
    if (stringStartsWith(text, "#"))
    {
        // difficulty
        text = stringSubstring(text, 2);
        switch (global.difficulty)
        {
            case 0:
                text += 'Easy';
                break;
            case 1:
                text += 'Normal';
                break;
            case 2:
                text += 'Hard';
                break;
        }
    }
    if (stringStartsWith(text, "$"))
    {
        // lives
        text = stringSubstring(text, 2);
        if (global.livesEnabled)
        {
            text += string(global.defaultLives);
        }
        else
        {
            text += "Disabled";
        }
    }
    draw_text(128, 48 + i * 16, text);
}

// colored text overlays
if (global.showColoredTextOverlays)
{
    draw_set_color(make_color_rgb(global.coloredTextOverlaysRed, global.coloredTextOverlaysGreen, global.coloredTextOverlaysBlue));
    draw_set_alpha(global.coloredTextOverlaysOpacity / 255);

    draw_rectangle(view_xview[0] + 73, view_yview[0] + 1, view_xview[0] + 182, view_yview[0] + 22, false); // title
    draw_rectangle(view_xview[0] + 44, view_yview[0] + 28, view_xview[0] + view_wview[0] - 45, view_yview[0] + view_hview[0] - 29, false); // content

    draw_set_color(c_white);
    draw_set_alpha(1);
}
