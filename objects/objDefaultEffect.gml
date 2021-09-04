#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
/// Default animated background effect
event_inherited();

sq[(view_wview + view_hview) / 8] = 0;

timer = 0;
sp = 8;
#define Draw_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if (!global.frozen || instance_exists(objSectionSwitcher))
{
    timer += 1;

    open = ds_list_create();

    for (i = 0; i < array_length_1d(sq); i += 1)
    {
        if (sq[i] > 0)
        {
            sq[i] += sp;
            if (sq[i] >= view_wview + 32)
            {
                sq[i] = 0;
            }
        }
        else
        {
            ds_list_add(open, i);
        }
    }

    if (timer == 8)
    {
        timer = 0;
        if (!ds_list_empty(open))
        {
            sq[ds_list_find_value(open, irandom(ds_list_size(open)))] = sp;
        }
    }

    ds_list_destroy(open);
}

dir = 1;
sw = view_wview / 8;
for (i = 0; i < array_length_1d(sq); i += 1)
{
    if (sq[i])
    {
        if (i < sw)
        {
            xs = i * 16 mod view_wview;
            if (xs == 0)
            {
                dir *= -1;
            }
            ys = sq[i] * dir;
            if (dir == 1)
            {
                ys -= 16;
            }
            else
            {
                ys += view_hview;
            }
            xa = 0;
            ya = 1;
        }
        else
        {
            ys = (i - sw) * 16 mod view_hview;
            if (ys == 0)
            {
                dir *= -1;
            }
            xs = sq[i] * dir;
            if (dir == 1)
            {
                xs -= 16;
            }
            else
            {
                xs += view_wview;
            }
            xa = 1;
            ya = 0;
        }
        draw_sprite_ext(sprDot, 0, view_xview + xs, view_yview + ys, 16, 16,
            image_angle, global.nesPalette[12], image_alpha);
        draw_sprite_ext(sprDot, 0, view_xview + xs + 1, view_yview + ys + 1,
            14, 14, image_angle, background_colour, image_alpha);

        // draw_sprite_ext(sprDot,0,view_xview+xs+(-2+(dir=-1)*19)*xa,view_yview+ys+(-2+(dir=-1)*19)*ya,max(ya*16,1),max(xa*16,1),image_angle,global.nesPalette[12],image_alpha);
        // draw_sprite_ext(sprDot,0,view_xview+xs+(-5+(dir=-1)*25)*xa,view_yview+ys+(-5+(dir=-1)*25)*ya,max(ya*16,1),max(xa*16,1),image_angle,global.nesPalette[12],image_alpha);
    }

    dir *= -1;
}
