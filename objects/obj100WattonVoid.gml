#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();

blockCollision = 0;
grav = 0;

contactDamage = 0;
canHit = false;

image_alpha = 0;
fadephase = 1;
autoDieTimer = 0;
autoDieTime = 60 * 10;
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
    autoDieTimer += 1;
    if (autoDieTimer >= autoDieTime)
        fadephase = 2;
    if (fadephase == 1)
    {
        if (image_alpha < 1)
        {
            image_alpha += 1 / 15;
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
