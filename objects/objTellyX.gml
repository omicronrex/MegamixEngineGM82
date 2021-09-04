#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();
col = 0; // 0 = red; 1 = blue
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();
switch (col)
{
    case 0:
        sprite_index = sprTellyXRed;
        break;
    case 1:
        sprite_index = sprTellyXBlue;
        break;
    default:
        sprite_index = sprTellyXRed;
        break;
}
