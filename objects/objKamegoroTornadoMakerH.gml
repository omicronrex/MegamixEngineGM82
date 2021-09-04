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
isSolid = 1;

attackTimer = 0;
active = false;
tornado = noone;
kamegoroDead = false;
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();
if (!global.frozen && !dead && !global.timeStopped)
{
    bubbleTimer = 0;
    if ((attackTimer < 8 && !instance_exists(tornado) || attackTimer >= 8) && !kamegoroDead)
        attackTimer += 1;
    if (attackTimer < 8)
        active = false;
    if (attackTimer >= 8 && attackTimer < 40)
        active = true;
    if (attackTimer == 40)
    {
        if (object_index != objKamegoroTornadoMakerV)
        {
            with (instance_create(x + (image_xscale * 16) + (16 * sign(image_xscale)), y + 8, objKamegoroTornado))
            {
                image_xscale = sign(other.image_xscale);
                sprite_index = sprKamegoroTornado2;
                other.tornado = id;
                parentID = other.id;
            }
        }
        else
        {
            with (instance_create(x + 8, y + (image_yscale * 16) + (16 * sign(image_yscale)), objKamegoroTornado))
            {
                image_yscale = sign(other.image_yscale);
                sprite_index = sprKamegoroTornado;
                other.tornado = id;
                parentID = other.id;
            }
        }
        attackTimer = 0;
    }
}
#define Draw_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
for (var i = 0; i < abs(image_xscale); i += 1)
{
    if (image_xscale >= 1 && i == image_xscale - 1)
        draw_sprite_ext(sprite_index, 0, x + i * 16, y, 1, image_yscale, image_angle, image_blend, image_alpha);
    if (image_xscale >= 1 && i < image_xscale - 1)
        draw_sprite_ext(sprite_index, 1, x + i * 16, y, 1, image_yscale, image_angle, image_blend, image_alpha);
    if (image_xscale <= -1 && i > 0)
        draw_sprite_ext(sprite_index, 1, x + i * 16 - (abs(image_xscale) * 16) + 16, y, -1, image_yscale, image_angle, image_blend, image_alpha);
    if (image_xscale <= -1 && i == 0)
        draw_sprite_ext(sprite_index, 0, x + i * 16 - (abs(image_xscale) * 16) + 16, y, -1, image_yscale, image_angle, image_blend, image_alpha);
    if (active && image_xscale >= 1)
        draw_sprite(sprKamegoroTornadoSpawn, (attackTimer / 3) mod 2, x + (image_xscale * 16) - 12, y + 8);
    if (active && image_xscale <= -1)
        draw_sprite(sprKamegoroTornadoSpawn, (attackTimer / 3) mod 2, (x + 12) - (abs(image_xscale) * 16), y + 8);
}
