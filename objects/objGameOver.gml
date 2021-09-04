#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
/// variables

controlsLocked = false; // controls are locked when switching menu modes
selection = 0;

playMusic("Mega_Man_2.nsf", "VGM", 13, 0, 0, true, 1);

optionText[0] = "Return to Hub";
optionText[1] = "Try Again";

global.livesRemaining = 2;
global.checkpoint = false;
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if (!controlsLocked)
{
    var selectionCount = 2;

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
        stopMusic();
        if (selection == 0)
        {
            // quit:
            returnFromLevel();
            lockControls = true;
        }
        else
        {
            // try stage again
            goToLevel(global.stageStartRoom, false);
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
for (var i = 0; i < 2; i++)
{
    var draw_y = 48 + i * 12;

    // draw cursor
    if (i == selection)
        draw_sprite(sprOptionsCursor, 0, 24, draw_y);

    // option text
    draw_text(48, draw_y, optionText[i]);
}

draw_set_alpha(0.3);
draw_text(0, 0, "Game Over#Make a better screen!#objGameOver :)");
draw_set_alpha(1);
