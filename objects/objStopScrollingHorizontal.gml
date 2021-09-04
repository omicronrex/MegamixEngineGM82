#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
image_speed = 0;

var height; height = image_yscale * sprite_get_height(sprite_index);

if (object_index == objRightScrolling || object_index == objRightScrollingNES || object_index == objHorizontalScrolling || object_index == objHorizontalScrollingNES)
{
    i = instance_create(x - 16, y, objSectionArrowRight);
    i.image_yscale = height / 16;
}

if (object_index == objLeftScrolling || object_index == objLeftScrollingNES || object_index == objHorizontalScrolling || object_index == objHorizontalScrollingNES)
{
    i = instance_create(x, y, objSectionArrowLeft);
    i.image_yscale = height / 16;
}
