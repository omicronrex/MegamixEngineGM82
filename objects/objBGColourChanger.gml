#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
/// changes colour when on-screen

//@cc the colour to change to
colour = global.nesPalette[7];
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if (insideView())
{
    background_colour = colour;
}
