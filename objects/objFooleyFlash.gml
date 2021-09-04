#define Draw_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
draw_set_blend_mode(bm_add);
draw_set_alpha(0.5);
draw_rectangle_colour(view_xview, view_yview, view_xview + view_wview, view_yview + view_hview, c_white, c_white, c_white, c_white, false);
draw_set_blend_mode(bm_normal);
draw_set_alpha(1);
