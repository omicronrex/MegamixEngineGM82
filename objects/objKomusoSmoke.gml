#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if (!global.frozen)
{
    image_speed = 0;
    image_index += 0.25;

    if ((image_index >= image_number - 1) || (!instance_exists(objKomusoMan)))
        instance_destroy();
}
