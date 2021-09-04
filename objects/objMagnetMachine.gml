#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
/// Pulls megaman towards it when megaman is in front of it
event_inherited();
canHit = false;

grav = 0;
bubbleTimer = -1;

isSolid = 1;

shiftVisible = 1;

image_speed = 0.4;
succframe = 0;

blowSpeed = 0.5;
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();

if (!global.frozen && !dead && !global.timeStopped)
{
    succframe += 0.25;

    with (objMegaman) // prtEntity)
    {
        // if (id == other.id)
        // continue;
        if (!dead)
        {
            // if (object_index == objMegaman)
            //{
            if (climbing)
            {
                continue;
            }

            //}

            with (other)
            {
                if (collision_rectangle(x, bbox_top, x - image_xscale * 96, bbox_bottom, other.id, false, false))
                {
                    with (other)
                    {
                        shiftObject(other.blowSpeed * other.image_xscale, 0, 1);
                    }
                }
            }
        }
    }
}
#define Draw_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();

if (!instance_exists(objSectionSwitcher))
{
    draw_sprite_ext(sprMagnetSucc, succframe, x - image_xscale * 16, y,
        image_xscale, image_yscale, image_angle, image_blend, image_alpha);
}
