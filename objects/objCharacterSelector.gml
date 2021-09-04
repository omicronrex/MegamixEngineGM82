#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
controlsLocked = false; // controls are locked when switching menu modes

/// variables

selection = 0;
player = 0;

character[0] = "NONE";
character[1] = "Mega Man";
character[2] = "Proto Man";
character[3] = "Bass";
character[4] = "Roll";
selectedCharacter = 0;

var i; for ( i = 0; i < global.playerCount; i+=1)
{
    if global.characterSelected[i] != "NONE"
    {
        global.characterSelected[i] = character[0];
    }
}
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
/// controls

if (!controlsLocked)
{
    var selectionCount; selectionCount = 3

    global.characterSelected[player] = character[selectedCharacter];
    // switch selection
    var yDir; yDir = 0;
    var xDir; xDir = 0;
    var i; for ( i = 0; i < global.playerCount; i+=1)
    {
        yDir += global.keyDownPressed[i] - global.keyUpPressed[i];
    }
    selection = (selection + yDir) mod selectionCount;
    selection = selection + selectionCount;
    selection = selection mod selectionCount;

    if (yDir != 0)
        playSFX(sfxMenuMove);
    var selected; selected = false;
    var i; for ( i = 0; i < global.playerCount; i+=1)
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
        }
        else if (selection == 1)
        {
            selectedCharacter += 1;
            if selectedCharacter > 4
            {
                selectedCharacter = 0;
            }
            global.characterSelected[player] = character[selectedCharacter];
        }
        else if (selection == 2)
        {
            player += 1;
            var i; for ( i = 0; i < 5; i+=1)
            {
                if global.characterSelected[player] == character[i]
                {
                    selectedCharacter = i;
                }
            }
            //selectedCharacter = global.characterSelected[player];
            if player > global.playerCount - 1
                player = 0;
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
var i; for ( i = 0; i < 3; i+=1)
{
    var draw_y; draw_y = 48 + i * 12;

    // draw cursor
    if (i == selection)
        draw_sprite(sprOptionsCursor, 0, 24, draw_y);

    // option text
    if (i == 0)
    {
        draw_text(48, draw_y, "Back...");
    }
    else if (i == 1)
    {
        draw_text(48, draw_y, string(global.characterSelected[player]));
    }
    else
    {
        draw_text(48, draw_y, "Player" + string(player + 1))
    }
}

draw_set_alpha(0.3);
draw_set_alpha(1);
