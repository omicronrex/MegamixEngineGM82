#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
/// If you place this object in a section, it'll cancel the effects of Tel Tel's weather
// as soon as it's in the same section as you are (even during a screen transition).

event_inherited();
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();

// Change even during a screen transition
if (insideSection(x, y))
{
    global.telTelWeather = 0;
}
#define Draw_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
// No
