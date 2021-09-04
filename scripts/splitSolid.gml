/// split_solid([instance], [width], [height])
// splits a given solid into width by height solids
// instance: the solid to split (default: self)
// width: the grid width (default: 16)
// height: the grid height (default: 16)

var instance; instance = self;
var width; width = 16;
var height; height = 16;
if (argument_count > 0)
    instance = argument[0];
if (argument_count > 2)
{
    width = argument[1];
    height = argument[2];
}

with (instance)
{
    var imwidth; imwidth = sprite_get_width(sprite_index);
    var imheight; imheight = sprite_get_height(sprite_index);

    var _x; for (_x = 0; _x < image_xscale * imwidth / width; _x+=1)
    {
        var _y; for (_y = 0; _y < image_yscale * imheight / height; _y+=1)
        {
            with (instance_create(x + _x * width, y + _y * height, object_index))
            {
                sprite_index = other.sprite_index;
                image_xscale = width / imwidth;
                image_yscale = height / imheight;
            }
        }
    }

    instance_destroy();
}
