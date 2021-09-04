#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();

yspeed = -irandom(20) * 0.1;
xspeed = irandom(20) * 0.05 * choose(1, -1);
grav = 0.2;

half = 'whole';
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if (!global.frozen)
{
    x += xspeed;
    y += yspeed;
    yspeed += grav;

    if (yspeed > 5)
    {
        yspeed = 5;
    }

    visible = !visible;
}
#define Draw_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if (half == 'whole')
{
    drawSelf();
}
else
{
    imgx = image_xscale;
    image_xscale = 1;
    imgy = image_yscale;
    image_yscale = 1;

    ys = sprite_height * 0.5;

    if (half == 'top')
    {
        top = 0;
        yh = 0;
    }
    if (half == 'bottom')
    {
        top = sprite_height - ys;
        yh = ys;
    }
    draw_sprite_part_ext(sprite_index, image_index, 0, top, sprite_width, ys,
        x - sprite_xoffset * imgx, y - sprite_yoffset * imgy + yh, imgx, imgy,
        image_blend, image_alpha);

    image_xscale = imgx;
    image_yscale = imgy;
}
