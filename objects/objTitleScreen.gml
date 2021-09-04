#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
playMusic('Mega_Man_1GB.GBS', "VGM", 0, 0, 0, 0, 1);

canProceed = true;
drawtext = 0;

option = 0;
options = 2;

wait = 16;

demoTimer = 0;

// reset all game state
engineConfig();
freshSaveFile();
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if (canProceed)
{
    drawtext = 1;

    if (wait)
    {
        wait -= 1;
        exit;
    }

    demoTimer+=1
    if ((demoTimer) mod 500 == 495)
    {
        if (!recordInputPlayback(
            choose("Recordings/demoPharaohMan.mrc",
            "Recordings/demoHoneyWoman.mrc")))
            canProceed = false;
        exit;
    }
    dir = global.keyDownPressed[0] - global.keyUpPressed[0];
    if (dir != 0)
    {
        demoTimer = 0;
        option += dir;
        if (option == -1)
        {
            option = options - 1;
        }
        if (option == options)
        {
            option = 0;
        }
        playSFX(sfxMenuMove);
    }

    if (global.keyPausePressed[0])
    {
        demoTimer = 0;
        switch (option)
        {
            case 0: // Start
                canProceed = false;
                playSFX(sfxMenuSelect);
                global.nextRoom = rmRoomSelect;
                break;
            case 1: // Options
                canProceed = false;
                playSFX(sfxMenuSelect);
                global.nextRoom = rmOptions;
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
var oldCol; oldCol = draw_get_color();
draw_set_color(c_white);

draw_set_valign(fa_top);
draw_set_halign(fa_left);

if (drawtext)
{
    draw_text(96, 160, "GAME START##OPTIONS");
}
if (canProceed)
{
    draw_sprite(sprOptionsCursor, 0, 96 - 12, 160 + option * 16);
}

draw_set_color(oldCol);

// colored text overlay
if (global.showColoredTextOverlays)
{
    draw_set_color(make_color_rgb(global.coloredTextOverlaysRed, global.coloredTextOverlaysGreen, global.coloredTextOverlaysBlue));
    draw_set_alpha(global.coloredTextOverlaysOpacity / 255);

    draw_rectangle(96 - 12 - 4, 160 - 4, 176 + 2, 160 + 23 + 3, false);

    draw_set_color(c_white);
    draw_set_alpha(1);
}
