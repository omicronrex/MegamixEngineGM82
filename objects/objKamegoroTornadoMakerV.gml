#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();
#define Draw_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
var i; for ( i = 0; i < abs(image_yscale); i += 1)
{
    if (image_yscale >= 1 && i == image_yscale - 1)
        draw_sprite_ext(sprite_index, 0, x, y + i * 16, image_xscale, 1, image_angle, image_blend, image_alpha);
    if (image_yscale >= 1 && i < image_yscale - 1)
        draw_sprite_ext(sprite_index, 1, x, y + i * 16, image_xscale, 1, image_angle, image_blend, image_alpha);
    if (image_yscale <= -1 && i > 0)
        draw_sprite_ext(sprite_index, 1, x, y + i * 16 - (abs(image_yscale) * 16) + 16, image_xscale, -1, image_angle, image_blend, image_alpha);
    if (image_yscale <= -1 && i == 0)
        draw_sprite_ext(sprite_index, 0, x, y + i * 16 - (abs(image_yscale) * 16) + 16, image_xscale, -1, image_angle, image_blend, image_alpha);
    if (active && image_yscale >= 1)
        draw_sprite(sprKamegoroTornadoSpawn, (attackTimer / 3) mod 2, x + 8, y + (image_yscale * 16) - 12);
    if (active && image_yscale <= -1)
        draw_sprite(sprKamegoroTornadoSpawn, (attackTimer / 3) mod 2, x + 8, (y + 12) - (abs(image_yscale) * 16));
}
