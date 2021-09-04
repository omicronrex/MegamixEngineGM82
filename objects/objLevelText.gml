#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
/// This object will print whatever you put as 'text' at the x and y origin of this object.

//@cc text to print
text = "";

//@cc text alignment
align = fa_left;
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
x = xstart;
y = ystart;
#define Draw_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
draw_set_color(c_white);
draw_set_halign(align);
draw_set_valign(fa_top);
draw_text(x, y, text);

// will do colored text overlays for this later, really not in the mood to figure out the code for the box dimensions right now  ~Entity
