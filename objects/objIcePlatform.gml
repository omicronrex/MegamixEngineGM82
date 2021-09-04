#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();
canHit = false;
bubbleTimer = -1;

grav = 0;

blk = -1;
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();

if (!global.frozen && !dead && !global.timeStopped)
{
    ontop = 0;

    with (target)
    {
        if (ground && !other.ontop)
        {
            if (place_meeting(x, y + 1, other.id))
            {
                with (other)
                {
                    if (image_index < image_number)
                    {
                        image_index += 1 / 32;
                    }

                    ontop = 1;
                }
            }
        }
    }

    if (!ontop)
    {
        image_index = round(image_index);
    }

    switch (round(image_index))
    {
        case 0:
            ys = 0;
            break;
        case 1:
            ys = 4;
            break;
        case 2:
            ys = 8;
            break;
        case 3:
            ys = 11;
            break;
        case 4:
            ys = 16;
            break;
    }

    if (ys == 16)
    {
        if (blk != -1)
        {
            with (blk)
            {
                instance_destroy();
            }
            blk = -1;
        }
        dead = true;
    }
    else
    {
        if (blk == -1)
        {
            blk = instance_create(x, y, objSolidIndependent);
            blk.sprite_index = sprDot;
            blk.image_xscale = bbox_right - bbox_left;
            blk.image_yscale = bbox_bottom - bbox_top;
            blk.visible = 0;
        }
        blk.y = y + ys;
        blk.image_yscale = 16 - ys;
    }
}
else if (dead)
{
    image_index = 0;
}
