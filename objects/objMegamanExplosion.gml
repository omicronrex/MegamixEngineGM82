#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();

image_speed = 1 / 3;
alarm[0] = 1;
#define Alarm_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
direction = dir;
speed = spd;
#define Draw_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if (sprite_index != sprExplosionClassic)
{
    drawSelf();
}
else
{
    var imgs = floor(image_number / 4);

    image_index = image_index mod imgs;

    drawSelf();
    draw_sprite_ext(sprite_index, image_index + imgs, round(x), round(y), image_xscale, image_yscale, image_angle, global.primaryCol[0], image_alpha);
    draw_sprite_ext(sprite_index, image_index + imgs * 2, round(x), round(y), image_xscale, image_yscale, image_angle, global.secondaryCol[0], image_alpha);
}
