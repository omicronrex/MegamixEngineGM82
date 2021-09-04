#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();
contactDamage = 4;
despawnRange = 99999; // so you can have really long ones in vertical sections that don't despawn

blockCollision = 0;
grav = 0;

xspeed = 0;
yspeed = 0;

image_speed = 0.25;
image_index = 0;

reflectable = 0;
#define Draw_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
for (i = 0; i < image_xscale; i += 1)
{
    draw_sprite(sprite_index, image_index, x, y + i * 16);
}
