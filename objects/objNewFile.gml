#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
/// variables

controlsLocked = false; // controls are locked when switching menu modes

selection = 0;

optionText[0] = "Back...";
optionText[1] = "Easy";
optionText[2] = "Normal";
optionText[3] = "Hard";
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
/// controls

if (!controlsLocked)
{
    var selectionCount = 4;

    // switch selection
    var yDir = 0;
    for (var i = 0; i < global.playerCount; i++)
    {
        yDir += global.keyDownPressed[i] - global.keyUpPressed[i];
    }
    selection = (selection + yDir) mod selectionCount;
    selection = selection + selectionCount;
    selection = selection mod selectionCount;

    if (yDir != 0)
        playSFX(sfxMenuMove);

    var selected = false;
    for (var i = 0; i < global.playerCount; i++)
    {
        selected = selected || global.keyPausePressed[i];
    }

    // select an option
    if (selected)
    {
        if (selection == 0)
        {
            // quit:
            global.nextRoom = rmFileSelect;
            lockControls = true;
        }
        else
        {
            // set difficulty
            switch (selection)
            {
                case 1:
                    global.difficulty = DIFF_EASY;
                    break;
                case 2:
                    global.difficulty = DIFF_NORMAL;
                    break;
                case 3:
                    global.difficulty = DIFF_HARD;
                    break;
                case 4:
                    global.difficulty = DIFF_HARD;
                    global.debugSkipStageMode = true;
                    break;
            }

            // set weapons
            for (var j = 1; j <= global.totalWeapons; j++)
            {
                global.weaponLocked[j] = 2;
            }

            // initial weapons:
            setWeaponLocked(objRushCoil, false);

            // go to stage select
            global.nextRoom = rmStageSelect;
            lockControls = true;
        }
        playSFX(sfxMenuSelect);
    }
}
#define Draw_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
draw_set_color(c_white);
draw_set_alpha(1);
draw_set_halign(fa_left);
draw_set_valign(fa_top);
for (var i = 0; i < 4; i++)
{
    var draw_y = 48 + i * 12;

    // draw cursor
    if (i == selection)
        draw_sprite(sprOptionsCursor, 0, 24, draw_y);

    // option text
    draw_text(48, draw_y, optionText[i]);
}

draw_set_alpha(0.3);
draw_text(0, 0, "New File#Make a better menu!#objNewFile :)");
draw_set_alpha(1);
