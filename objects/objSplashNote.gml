#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
image_speed = 0;
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if (!instance_exists(objSplashWoman))
    instance_destroy();

if (instance_exists(objSplashWoman))
{
    if (objSplashWoman.sprite_index != sprSplashSing)
        instance_destroy();
}
