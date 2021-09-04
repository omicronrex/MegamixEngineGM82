#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();
respawn = false;
healthpointsStart = 1;
healthpoints = healthpointsStart;
contactDamage = 4;
stopOnFlash = false;

// Enemy specific code
xspeed = 0;
yspeed = 0;
storeY = -1;
attackTimer = 0;
grav = 0;
image_speed = 0;
image_index = 0;
canflash = true;
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();
if (entityCanStep())
{
    attackTimer += 1;
    image_index = 0 + ((attackTimer / 4) mod 3);
    if (xcoll != 0)
    {
        xspeed = -xcoll;
        xcoll = 0;
        image_xscale *= -1;
    }
    if (place_meeting(x, y + yspeed, objSolid))
    {
        y -= yspeed;
        yspeed *= -1;
        ycoll = 0;
        storeY *= -1;
    }
    with (instance_place(x, y + yspeed, prtEntity))
    {
        if (isSolid == 1)
        {
            with (other)
            {
                y -= yspeed;
                yspeed *= -1;
                ycoll = 0;
                storeY *= -1;
            }
        }
    }
    if (xspeed == 0)
        xspeed = image_xscale * 2;
    if (yspeed == 0)
        yspeed = storeY * 1;
}
#define Other_20
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
instance_create(x, y - 8, objExplosion);
dead = true;
#define Draw_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
// Hunter Baby, regardless of what Image_Yscale and Image_xscale says. Image_yscale is used to determine which direction it moves in.
draw_sprite_ext(sprite_index, image_index, round(x), floor(y), 1, 1, image_angle, image_blend, image_alpha);
if (((iFrames == 1 || iFrames == 3) && canflash) || (iceTimer > 0))
{
    var flashcol; flashcol = c_white;
    if (iceTimer > 0)
        flashcol = make_color_rgb(0, 120, 255);
    d3d_set_fog(true, flashcol, 0, 0);
    draw_sprite_ext(sprite_index, image_index, round(x), floor(y), 1, 1, image_angle, image_blend, image_alpha);
    d3d_set_fog(false, 0, 0, 0);
    if (iceTimer > 0)
    {
        draw_set_blend_mode(bm_add);
        draw_sprite_ext(sprite_index, image_index, round(x), floor(y), 1, 1, image_angle, image_blend, image_alpha);
        draw_set_blend_mode(bm_normal);
    }
}
