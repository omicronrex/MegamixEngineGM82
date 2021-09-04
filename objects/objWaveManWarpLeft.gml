#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
spd = 4;

dir = "Left";
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if (place_meeting(x, y, objMegaman) && !instance_exists(objWaveManWarp))
{
    ID = instance_create(x + 8, y, objWaveManWarp);
    ID.dir = dir;
    ID.spd = spd;
}
