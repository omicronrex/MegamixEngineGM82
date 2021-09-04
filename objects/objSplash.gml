#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();

image_speed = 0.15;

timer = floor((1 / image_speed) * 3);

sfc = 0;

// both of these were added just for the skull doors lol
blockCollision = 1;
active = false;
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if (!global.frozen || active)
{
    image_speed = 0.15;
    if (sfc)
    {
        if (instance_exists(sfc))
        {
            x = sfc.x + sfcx;
            y = sfc.y + sfcy;
        }
    }

    timer--;
    if (place_meeting(x, y, objSolid) && blockCollision || !timer)
    {
        instance_destroy();
    }
}
else
{
    image_speed = 0;
}
#define Other_10
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if (place_meeting(x, y, object_index))
{
    instance_destroy();
    visible = 0;
}
else
{
    with (objSolid)
    {
        solid = 1;
    }
    with (objWater)
    {
        solid = 1;
    }

    var xs = 0;
    var ys = 0;

    if (image_angle == 0 || image_angle == 180)
    {
        xs = 1;
    }
    else if (image_angle == 90 || image_angle == 270)
    {
        ys = 1;
    }

    repeat (4)
    {
        if (!place_free(x, y))
        {
            if (place_free(x - xs * 12, y - ys * 12))
            {
                x -= xs * 4;
                y -= ys * 4;
            }
            else if (place_free(x + xs * 12, y + ys * 12))
            {
                x += xs * 4;
                y += ys * 4;
            }
            else
            {
                break;
            }
        }
    }

    if (!place_free(x, y))
    {
        instance_destroy();
        visible = 0;
    }
    else
    {
        playSFX(sfxSplash);
        sfc = other.id;
        sfcx = x - sfc.x;
        sfcy = y - sfc.y;
    }

    with (all)
    {
        solid = 0;
    }
}
