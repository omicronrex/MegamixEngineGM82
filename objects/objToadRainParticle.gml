#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
timer = 0;
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if (global.frozen == false && global.timeStopped == false)
{
    timer += 1;
    if (timer mod 10 == 1)
    {
        playSFX(sfxRainFlush);
    }
    if (timer >= 60 * 2)
        instance_destroy();
    if (visible == true)
        visible = false;
    else
        visible = true;
}
if (!instance_exists(objToadMan))
    instance_destroy();
#define Draw_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
for (i = 1; i <= 16; i += 1)
    draw_sprite(sprite_index, -1,
        view_xview + view_wview - ((timer * 4 + i * 64) mod view_wview),
        view_yview + ((timer * 4 + i * 128) mod view_hview));
