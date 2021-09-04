#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
image_speed = 0;

var width; width = image_xscale * sprite_get_width(sprite_index);

if (object_is_ancestor(object_index, objDownScrolling) || object_is_ancestor(object_index, objVerticalScrolling)
    || object_index == objDownScrolling || object_index == objVerticalScrolling)
{
    i = instance_create(x, y - 16, objSectionArrowDown);
    i.image_xscale = width / 16;
}

if (object_is_ancestor(object_index, objUpScrolling) || object_is_ancestor(object_index, objVerticalScrolling)
    || object_index == objUpScrolling || object_index == objVerticalScrolling)
{
    i = instance_create(x, y, objSectionArrowUp);
    i.image_xscale = width / 16;
}
