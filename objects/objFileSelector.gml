#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
controlsLocked = false; // controls are locked when switching menu modes

/// variables

selection = 0;


global.debugEnabled = false; // debug keys not allowed for now
global.livesEnabled = true;
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
/// load list of files
for (var i = 0; true; i++)
{
    // load file:
    fileName[i] = "save" + string(i + 1) + ".sav";
    global.saveFile = fileName[i];
    var error = saveLoadGame(false);

    // if file doesn't exist, halt.
    if (error)
    {
        fileCount = i;
        break;
    }

    // read relevant variables from save file
    energyElements[i] = global.energyElements;
    gameTimer[i] = global.gameTimer;
    fileDifficulty[i] = global.difficulty;
}

freshSaveFile();
objGlobalControl.saveTimer = -1;
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
/// controls

if (!controlsLocked)
{
    var selectionCount = fileCount + 2;

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
            global.nextRoom = rmTitleScreen;
            lockControls = true;
            global.debugEnabled = true;
            global.livesEnabled = false;
        }
        else if (selection == selectionCount - 1)
        {
            // new file:
            global.nextRoom = rmNewFile;
            global.saveFile = fileName[fileCount];
            lockControls = true;
            playSFX(sfxMenuSelect);
        }
        else
        {
            // load file:
            global.saveFile = fileName[selection - 1];
            var error = saveLoadGame(false);
            if (error)
            {
                freshSaveFile();
                playSFX(sfxError);
            }
            else
            {
                global.nextRoom = rmStageSelect;
                lockControls = true;
                playSFX(sfxMenuSelect);
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
draw_set_alpha(1);
draw_set_halign(fa_left);
draw_set_valign(fa_top);
for (var i = 0; i < fileCount + 2; i++)
{
    var draw_y = 48 + i * 12;

    // draw cursor
    if (i == selection)
        draw_sprite(sprOptionsCursor, 0, 24, draw_y);

    // option text
    if (i == 0)
    {
        draw_text(48, draw_y, "Back...");
    }
    else if (i == fileCount + 1)
    {
        draw_text(48, draw_y, "New File...");
    }
    else
    {
        // files
        var file = i - 1;
        draw_text(48, draw_y, fileName[file] + ": " + string(gameTimer[file] div (60 * 60)) + " minutes");
    }
}

draw_set_alpha(0.3);
draw_text(0, 0, "New File#Make a better menu!#objFileSelector :)");
draw_set_alpha(1);
