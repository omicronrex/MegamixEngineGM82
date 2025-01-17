#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();

image_speed = 0;

textLength = 0;
showtext = 0;

phase = 1;
timer = 14;

name = '...';
nameCol = c_white;
itext = "Sorry Nothing";

sprite_index = sprMugshots;
mugshotIndex = 0;
mugshotIndexStart = 0;
mugshotIndexEnd = 0;
mugshotSpeed = 0;

optionPos = 0;
optionCount = 0;
for (i = 0; i <= 4; i += 1)
{
    optionText[i] = "";
}

pos = 0;
boxOffset = 8;
origin = 0;
o_event = 0;

text = ds_list_create();

_im = 0; // variable for animationLoop

// MegaMan specific
with (objMegaman)
{
    xspeed = 0;
    yspeed = 0;
}

dialogueLock = playerLockMovement();

offset = 0; // This is a constantly growing variable you can reference in text events, e.g. a constantly waving text.

parent = 0; //need to prevent interaction with npcs besides the one being talked to.
#define Destroy_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
dialogueLock = playerFreeMovement(dialogueLock);

with (origin)
{
    if (other.o_event != -1)
    {
        event_user(other.o_event);
    }
}

ds_list_destroy(text);
with (objNPC)
{
    if (npcID == other.parent)
    {
        event_user(2);
    }
}
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
switch (phase)
{
    case 1: // Move in box
        boxOffset-=1;
        if (boxOffset <= 0)
        {
            boxOffset = 0;
            showtext = 1;
            phase = 2;
            itext = ds_list_find_value(text, 0);
        }
        break;
    case 2: // Increase visible text
        timer-=1;
        if (!timer)
        {
            textLength += 0.5 + (1.5 * (global.keyJump[0] || global.keyPause[0]));
        }
        if (timer < 4 && global.keyPausePressed[0])
        {
            textLength = string_length(itext);
        }

        if (textLength >= string_length(itext))
        {
            textLength = string_length(itext);
            timer = 12;
            phase = 3;
        }
        break;
    case 3: // Go to next block of text
        timer-=1;
        if (!timer)
        {
            if (optionCount > 0 && ds_list_size(text) == 1) // Move between options
            {
                var mv; mv = global.keyDownPressed[0] - global.keyUpPressed[0];
                if (mv != 0)
                {
                    playSFX(sfxTextBox);

                    optionPos += mv;
                    if (optionPos < 0)
                    {
                        optionPos = optionCount - 1;
                    }
                    if (optionPos >= optionCount)
                    {
                        optionPos = 0;
                    }
                }
            }

            if (global.keyJumpPressed[0] || global.keyPausePressed[0])
            {
                ds_list_delete(text, 0);

                if (!ds_list_empty(text)) // Get next block of code
                {
                    itext = ds_list_find_value(text, 0);
                    timer = 2;
                    phase = 1;
                    playSFX(sfxTextBox);
                }
                else // No more text left
                {
                    if (optionCount > 0)
                    {
                        playSFX(sfxMenuSelect);
                        if (optionText[optionPos] != "")
                        {
                            with (objNPC)
                            {
                                if (active && npcID == other.parent)
                                {
                                    option_chosen = objDialogueBox.optionPos;
                                    if (option_text[option_chosen] != "")
                                    {
                                        var d; d = instance_nearest(x, y, objDialogueBox);
                                        d.dialogueLock = playerFreeMovement(d.dialogueLock);
                                        prev_index = d.image_index;
                                        with (d)
                                            instance_destroy();
                                        event_user(0);
                                        active = false;
                                    }
                                }
                            }
                        }
                    }
                    phase = 4;
                    showtext = 0;
                }
                textLength = 0;
            }
        }
        break;
    case 4: // Move away box
        boxOffset+=1;
        if (boxOffset == 8)
        {
            visible = 0;
            instance_destroy();
        }
        break;
}

animationLoop(mugshotIndexStart, mugshotIndexEnd, mugshotSpeed);

offset += 1;
#define Draw_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
// No
#define Draw_73
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
// Box
var ypos; ypos = view_yview - 8 * boxOffset;
if (pos == 1)
{
    ypos = view_yview + view_hview + 8 * boxOffset;
}
draw_sprite_part_ext(sprDialogueBox, 0, 0, 0, 48, 64, view_xview[0], ypos, 1, 1, image_blend, image_alpha); // mugshot section
draw_sprite_part_ext(sprDialogueBox, 0, 48, 0, 1, 64, view_xview[0] + 48, ypos, view_wview[0] - 56, 1, image_blend, image_alpha); // content section
draw_sprite_part_ext(sprDialogueBox, 0, 48, 0, 8, 64, view_xview[0] + view_wview[0] - 8, ypos, 1, 1, image_blend, image_alpha); // right border

draw_sprite_part(sprDialogueBox, 0, 1, 4, 2, 4, view_xview + 4 + (floor(offset / 8) mod 10) * 2, ypos + 4); // moving light

// text
if (showtext)
{
    draw_sprite_part(sprite_index, -1, 0, 0, 32, 32, view_xview[0] + 5, ypos + 18);

    draw_set_halign(fa_left);
    draw_set_valign(fa_left);
    draw_set_color(c_white);

    if (string_length(name)) // Draw name
    {
        draw_text_colour(view_xview[0] + 43, ypos + 6, name, nameCol, nameCol, nameCol, nameCol, 1);
    }

    // These variables checks if the current line reaches over the boundry.
    var line; line = 0;
    var length; length = floor((view_wview[0] - 56) / 8);
    var count; count = 0;

    var effect; effect = 0; // /0 = normal text, /1 = shakey /2 = wavey
    var colour; colour = c_white; // /C0 = white, /C1 = red, /C2 = yellow, /C3 = green, /C3 = blue

    for (i = 1; i <= textLength; i += 1) // we're going to draw the text individually, that way we can apply all sorts of effects to it.
    {
        drawChar = string_char_at(itext, i);

        if (drawChar == "/") // Get effects
        {
            if (string_char_at(itext, i + 1) == "C") // Color
            {
                var col1; col1 = string_char_at(itext, i + 2);
                var col2; col2 = string_char_at(itext, i + 3);
                var col3; col3 = col1 + col2;
                colour = global.nesPalette[real(col3)];
                i += 3;
                continue;
            }
            else if (string_digits(string_char_at(itext, i + 1)) != "") // Movement
            {
                if (global.showMovingText)
                {
                    effect = real(string_char_at(itext, i + 1));
                }

                i += 1;
                continue;
            }
        }
        else if (drawChar == "#") // Line break
        {
            line += 1;
            count = 0;
            continue;
        }

        // New line handling
        e = 1;
        while (i + e <= string_length(itext)) // Check for something that seperates words
        {
            check = string_char_at(itext, i + e);
            if (check == " " || check == "/" || check == "#")
            {
                break;
            }
            e+=1;
        }

        if (count + e > length + 1)
        {
            line += 1;
            count = 0;
        }

        // Process effect
        switch (effect)
        {
            case 1: // Shakey
                xd = choose(1, 0, -1);
                yd = choose(1, 0, -1);
                break;
            case 2: // Wavey
                xd = 0;
                yd = cos((offset + i * 8) / 8);
                break;
            default: // also 0 - Normal
                xd = 0;
                yd = 0;
                break;
        }

        // Finally draw a single letter *clap*
        draw_text_colour(view_xview[0] + 43 + (count * 8) + xd, ypos + 19 + (line * 8) + yd, drawChar, colour, colour, colour, colour, 1);

        count += 1;
    }

    // Extra Options
    if (phase == 3 && !timer)
    {
        if (optionCount > 0 && ds_list_size(text) == 1)
        {
            for (i = 1; i <= optionCount; i += 1)
            {
                draw_sprite_part_ext(sprDialogueOptionBox, 0, 0, 0, 8, 18, view_xview[0], ypos + 45 + 18 * i, 1, 1, image_blend, image_alpha);
                draw_sprite_part_ext(sprDialogueOptionBox, 0, 8, 0, 8, 18, view_xview[0] + 8, ypos + 45 + 18 * i, (view_wview[0] / 8) - 2, 1, image_blend, image_alpha);
                draw_sprite_part_ext(sprDialogueOptionBox, 0, 16, 0, 8, 18, view_xview[0] + view_wview - 8, ypos + 45 + 18 * i, 1, 1, image_blend, image_alpha);
                draw_text(view_xview[0] + 19, ypos + 51 + 18 * i, optionText[i - 1]);
            }

            draw_sprite(sprOptionsCursor, offset * 0.2, view_xview[0] + 9, ypos + 51 + 18 * (optionPos + 1));
        }
    }

    // colored text overlays
    if (global.showColoredTextOverlays)
    {
        draw_set_color(make_color_rgb(global.coloredTextOverlaysRed, global.coloredTextOverlaysGreen, global.coloredTextOverlaysBlue));
        draw_set_alpha(global.coloredTextOverlaysOpacity / 255);

        draw_rectangle(view_xview[0] + 38, ypos, view_xview[0] + view_wview[0], ypos + 62, false); // main text

        if (phase == 3 && !timer && optionCount > 0 && ds_list_size(text) == 1)
        {
            draw_rectangle(view_xview[0], ypos + 45 + 18, view_xview[0] + view_wview[0], ypos + 45 + 17 + 18 * optionCount, false); // dialogue options
        }

        draw_set_color(c_white);
        draw_set_alpha(1);
    }
}
