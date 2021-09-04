#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();

blockCollision = 0;
grav = 0;

contactDamage = 3;

despawnRange = view_hview + 16;
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();

if (entityCanStep())
{
    // "dissipate" if the tail is below the screen
    if (bbox_bottom > view_yview + view_hview)
    {
        y += 16;
    } // else, just extend
    else
    {
        image_yscale += 1;
    }
}
#define Draw_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if (!dead)
{
    for (i = 1; i <= image_yscale; i += 1)
    {
        var imgIndex;

        if (i == image_yscale)
        {
            imgIndex = 2;
        }
        else
        {
            imgIndex = (i mod 2 == 0);
        }

        draw_sprite_ext(sprite_index, imgIndex, x, y + (i * 16), 1, 1, 0, c_white, 1);
    }
}
