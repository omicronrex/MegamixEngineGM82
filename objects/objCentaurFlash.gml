#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
flashScreen = 10;
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
x = view_xview + (view_wview / 2);
y = view_yview + (view_hview / 2);

if (global.frozen == false)
{
    if (flashScreen > 0)
        flashScreen -= 0.5;

    if (flashScreen mod 2 == 0)
        visible = true;
    else
        visible = false;

    if ((flashScreen == 0) || !instance_exists(objCentaurMan))
        instance_destroy();
}
