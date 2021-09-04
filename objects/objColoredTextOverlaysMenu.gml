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

phase = 0;
option = 0;
selected = 0;
buffer = 0;

dialogueBoxLightOffset = 0;

verticalQuickScrollTimer = 25;
horizontalQuickScrollTimer = 25;

// Control settings
newControls = 0;
current = 'NONE';
press = 1;

// Option text
optionText[0] = 'BACK';
optionText[1] = 'ENABLED';
optionText[2] = 'RED';
optionText[3] = 'GREEN';
optionText[4] = 'BLUE';
optionText[5] = 'OPACITY';
#define Alarm_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
buffer = 0;
#define Alarm_1
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
persistent = 0;
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
        global.nextRoom = -1;
        phase+=1;
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
if (phase == 2 && !selected)
{
    // left / right controlled selections
    dir = (global.keyRightPressed[0] || (global.keyRight[0] && horizontalQuickScrollTimer <= 0)) - (global.keyLeftPressed[0] || (global.keyLeft[0] && horizontalQuickScrollTimer <= 0));
    if (dir != 0)
    {
        switch (option)
        {
            // enable
            case 1:
                pre = global.showColoredTextOverlays;
                global.showColoredTextOverlays = min(max(0, global.showColoredTextOverlays + dir), 1);
                if (global.showColoredTextOverlays != pre)
                {
                    playSFX(sfxMenuMove);
                }
                break;

            // red
            case 2:
                pre = global.coloredTextOverlaysRed;
                global.coloredTextOverlaysRed = min(max(0, global.coloredTextOverlaysRed + dir), 255);
                if (global.coloredTextOverlaysRed != pre)
                {
                    if (dir > 0)
                    {
                        playSFX(sfxMenuScrollUp);
                    }
                    else
                    {
                        playSFX(sfxMenuScrollDown);
                    }
                }
                break;

            // green
            case 3:
                pre = global.coloredTextOverlaysRed;
                global.coloredTextOverlaysGreen = min(max(0, global.coloredTextOverlaysGreen + dir), 255);
                if (global.coloredTextOverlaysGreen != pre)
                {
                    if (dir > 0)
                    {
                        playSFX(sfxMenuScrollUp);
                    }
                    else
                    {
                        playSFX(sfxMenuScrollDown);
                    }
                }
                break;

            // blue
            case 4:
                pre = global.coloredTextOverlaysBlue;
                global.coloredTextOverlaysBlue = min(max(0, global.coloredTextOverlaysBlue + dir), 255);
                if (global.coloredTextOverlaysBlue != pre)
                {
                    if (dir > 0)
                    {
                        playSFX(sfxMenuScrollUp);
                    }
                    else
                    {
                        playSFX(sfxMenuScrollDown);
                    }
                }
                break;

            // opacity
            case 5:
                pre = global.coloredTextOverlaysOpacity;
                global.coloredTextOverlaysOpacity = min(max(40, global.coloredTextOverlaysOpacity + dir), 230);
                if (global.coloredTextOverlaysOpacity != pre)
                {
                    if (dir > 0)
                    {
                        playSFX(sfxMenuScrollUp);
                    }
                    else
                    {
                        playSFX(sfxMenuScrollDown);
                    }
                }
                break;
        }
    }

    // pause controlled selections
    if (global.keyPausePressed[0])
    {
        switch (option)
        {
            // back
            case 0:
                selected = true;
                phase+=1;
                playSFX(sfxMenuSelect);
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
    && ((global.keyLeft[0] && !global.keyRight[0]) || (global.keyRight[0] && !global.keyLeft[0])))
    {
        if (horizontalQuickScrollTimer <= 0)
        {
            // slight pause between scrolls
            horizontalQuickScrollTimer = 1;
        }

        horizontalQuickScrollTimer -= 1;
    }
    else
    {
        horizontalQuickScrollTimer = 25; // <-=1 time until quick scroll here
    }
}
#define Draw_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
// draw bg
draw_set_color(c_black);
draw_rectangle(view_xview[0], view_yview[0], view_xview[0] + view_wview[0], view_yview[0] + view_hview[0], false);

// draw cursor
draw_set_color(c_white);
draw_sprite(sprOptionsCursor, cursorImgIndex, view_xview[0] + 6, view_yview[0] + 8 + option * 12);

// animate cursor
cursorImgIndex += cursorImgSpd;
if (cursorImgIndex >= 5)
{
    cursorImgIndex -= 5;
}

// draw options
draw_set_halign(fa_left);
draw_set_valign(fa_top);
var j; for ( j = 0; j < array_length_1d(optionText); j+=1)
{
    draw_text_ext(view_xview[0] + 16, view_yview[0] + 8 + j * 12, optionText[j], 12, 256);
}

// draw current option status'
opt = '';
var j; for ( j = 0; j < array_length_1d(optionText); j+=1)
{
    switch (j)
    {
        // enabled
        case 1:
            if (!global.showColoredTextOverlays)
            {
                opt += "OFF";
            }
            else
            {
                opt += "ON";
            }

            break;
        case 2:
            opt += string(global.coloredTextOverlaysRed);

            break;
        case 3:
            opt += string(global.coloredTextOverlaysGreen);

            break;
        case 4:
            opt += string(global.coloredTextOverlaysBlue);

            break;
        case 5:
            opt += string(global.coloredTextOverlaysOpacity);

            break;
    }

    // next line
    opt += "#";
}

draw_set_halign(fa_right);
draw_text_ext(view_xview[0] + 230, view_yview[0] + 8, opt, 12, 256);

// demo text
draw_set_halign(fa_left);

draw_text_ext(view_xview[0] + 8, view_yview[0] + 84 + 8, "This is meant to aid people who suffer from Visual Stress, who have a hard time reading text. Adjust the color until the text is easier to read.", 8, 240);

draw_sprite_part_ext(sprDialogueBox, 0, 0, 0, 48, 64, view_xview[0], view_yview[0] + 148, 1, 1, image_blend, image_alpha); // mugshot section
draw_sprite_part_ext(sprDialogueBox, 0, 48, 0, 1, 64, view_xview[0] + 48, view_yview[0] + 148, view_wview[0] - 56, 1, image_blend, image_alpha); // content section
draw_sprite_part_ext(sprDialogueBox, 0, 48, 0, 8, 64, view_xview[0] + view_wview[0] - 8, view_yview[0] + 148, 1, 1, image_blend, image_alpha); // right border

draw_sprite_part(sprDialogueBox, 0, 1, 4, 2, 4, view_xview[0] + 4 + (floor(dialogueBoxLightOffset / 8) mod 10) * 2, view_yview[0] + 148 + 4); // moving light
dialogueBoxLightOffset+=1;

// draw_sprite(sprDialogueBox, 0, view_xview[0], view_yview[0] + 148);
draw_sprite(sprMugshots, 0, view_xview[0] + 5, view_yview[0] + 148 + 18);


draw_text_color(view_xview[0] + 43, view_yview[0] + 148 + 6, "Developer", global.nesPalette[31], global.nesPalette[31], global.nesPalette[31], global.nesPalette[31], 1);
draw_text_ext(view_xview[0] + 43, view_yview[0] + 148 + 19, "This is meant to aid people who suffer from Visual Stress, who have a hard time reading text.", 8, 208);

// colored text overlays
draw_set_color(make_color_rgb(global.coloredTextOverlaysRed, global.coloredTextOverlaysGreen, global.coloredTextOverlaysBlue));
draw_set_alpha(global.coloredTextOverlaysOpacity / 255);

draw_rectangle(view_xview[0], view_yview[0] + 84, view_xview[0] + view_wview[0], view_yview[0] + 140, false);
draw_rectangle(view_xview[0] + 38, view_yview[0] + 148, view_xview[0] + 256, view_yview[0] + 148 + 63, false);

draw_set_color(c_white);
draw_set_alpha(1);
