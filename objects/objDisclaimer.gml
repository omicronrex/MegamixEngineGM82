#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
with (objGlobalControl)
{
    fadeAlpha = 1;
}

timer = 0;
timerMax = 420;

disclaimerText = "MEGA MAN AND ALL#
RELATED CONTENT (C) CAPCOM 2018###
THIS GAME IS A NON-PROFIT EFFORT#
BY FANS. IT IS NOT FOR SALE.##
MADE WITH THE MEGAMIX ENGINE,#
A FORK OF THE MEGA ENGINE.#
###
USING FMOD STUDIO#
BY FIRELIGHT TECHNOLOGIES,#
AND CHIPTUNE PLAYER#
BY MICK @ GAMEPHASE.";
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
// Proceed to the next screen
timer += 1;
if (global.keyPausePressed[0] || global.keyJumpPressed[0]
    || global.keyShootPressed[0] || timer >= timerMax)
{
    global.nextRoom = rmTitleScreen;
}
#define Draw_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
draw_set_halign(fa_center);
draw_set_valign(fa_middle);

draw_text(round(room_width / 2), round(room_height / 2), disclaimerText);

draw_set_halign(fa_left);
draw_set_valign(fa_top);
