#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();

contactDamage = 0;
canHit = false;

blockCollision = 0;
grav = 0;

image_alpha = 0;
fadephase = 1;

starbg[0] = bgStarFieldBackground;
starshift[0] = 0;
starspeed[0] = 1;
starbg[1] = bgStarFieldMiddleground;
starshift[1] = 0;
starspeed[1] = 0.5;
starbg[2] = bgStarFieldForeground;
starshift[2] = 0;
starspeed[2] = 0.25;
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if (!global.frozen && !global.timeStopped)
{
    x = view_xview + view_wview * 0.5;
    x = view_yview + view_hview * 0.5;
    if (fadephase == 1)
    {
        if (image_alpha < 1)
        {
            image_alpha += 1 / 15;
        }
        else
        {
            for (i = 0; i <= 2; i += 1)
            {
                starshift[i] += starspeed[i];
                if (starshift[i] >= 256)
                {
                    starshift[i] -= 256;
                }
            }
        }
        endit = 1;
        with (objHologran)
        {
            if (!dead)
            {
                other.endit = 0;
            }
        }
        if (endit)
        {
            fadephase = 2;
        }
    }
    else if (fadephase == 2)
    {
        image_alpha -= 1 / 15;
        if (image_alpha <= 0)
        {
            instance_destroy();
        }
    }
}
#define Draw_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
draw_set_color(c_black);
storealpha = draw_get_alpha();
draw_set_alpha(image_alpha);

draw_rectangle(view_xview - 1, view_yview - 1, view_xview + view_wview + 1,
    view_yview + view_hview + 1, false);

draw_set_alpha(storealpha);

if (image_alpha == 1)
{
    for (i = 1; i <= 2; i += 1)
    {
        draw_background(starbg[i], view_xview - starshift[i], view_yview);
        draw_background(starbg[i], view_xview - starshift[i] + 256, view_yview);
    }
}
