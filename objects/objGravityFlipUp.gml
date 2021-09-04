#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
with (objMegaman)
{
    if (gravDir > 0)
    {
        if (place_meeting(x, y, other.id))
        {
            if (!place_meeting(x - 8, y, objGravityFlipDown))
            {
                yspeed /= 2;
                image_yscale *= -1;
                y += sprite_get_yoffset(mask_index);

                playSFX(sfxGravityFlip);
                gravDir *= -1;
            }
        }
    }
}

depth = 1000000000;
#define Draw_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
// no
