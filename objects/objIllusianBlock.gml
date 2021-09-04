#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
tile_bg = -1;
tile_left = 0;
tile_top = 0;
tile_w = 16;
tile_h = 16;
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if (!insideView())
    instance_destroy();
#define Draw_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
draw_background_part(tile_bg, tile_left, tile_top, tile_width, tile_height, x, y);
