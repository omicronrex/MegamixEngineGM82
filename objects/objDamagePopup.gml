#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();

yspeed = (-6 + (irandom_range(-150, 150) * -0.01)) * 0.5;
xspeed = (irandom_range(-100, 100) * 0.02) * 0.5;

grav = 0.1;

timer = 0;
damage = global.damage;
str = "0";
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

    timer+=1;
    if (timer >= 40)
    {
        instance_destroy();
    }
}
#define Other_40
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
instance_destroy();
#define Draw_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
draw_set_halign(fa_center);
draw_set_valign(fa_top);
draw_set_color(image_blend);

if (damage != 0)
{
    str = string_format(damage, string_length(string(floor(damage))), (damage - floor(damage) > 0));
    damage = 0;
}

draw_text(round(x), round(y), str);

draw_set_color(c_white);
