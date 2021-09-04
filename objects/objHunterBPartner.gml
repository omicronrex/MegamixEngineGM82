#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();
isFight = true;
quickSpawn = true;
#define Draw_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if ((ceil(iFrames) mod 4) < 2 || !iFrames)
{
    drawSelf();
}
else // Hitspark
{
    draw_sprite_ext(sprHitspark, 0, spriteGetXCenter(), spriteGetYCenter(), 1, 1, 0, c_white, 1);
}
