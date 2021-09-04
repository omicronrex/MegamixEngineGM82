#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
// Creation Code (All optional)
// shotMax = <number> // how long L.E.C waits before firing.
event_inherited();

respawn = true;
healthpointsStart = 10;
healthpoints = healthpointsStart;
contactDamage = 4;
category = "aquatic, nature";

facePlayer = true;

// Enemy specific code
animTimer = 0;
animMax = 20;
shotTimer = 0;
shotMax = 8;
shooting = false;
img = 0;
bubble = noone;
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();
if (entityCanStep())
{
    animTimer += 1;
    shotTimer += 1;

    // if not currently shooting, alternate between animation frames 0 and 1.
    if (!shooting)
    {
        if (animTimer == animMax)
        {
            if (image_index == 0)
                image_index = 1;
            else
                image_index = 0;
            animTimer = 0;
        }
    }

    // if there isn't a bullet on screen, and there has been enough of a delay, create one.
    if (!instance_exists(bubble))
    {
        // checks whether the shot timer has reached its determined limit and enters shooting mode.
        if (shotTimer >= shotMax && image_index < 2)
        {
            image_index = 2;
            shooting = true;
        }

        // if in shooting mode, increases frame until final frame image.
        if (animTimer >= animMax && image_index >= 2 && image_index < 4)
        {
            image_index += 1;
            animTimer = 0;
        }

        // upon final frame image, create bubble.
        if (animTimer >= animMax && image_index >= 4)
        {
            image_index = 0;
            shooting = false;
            bubble = instance_create(x, y - 16, objLECBubble);
            animTimer = 0;
        }
    }
    else // if there is a bubble in existance, L.E.C cannot fire another one.
        shotTimer = 0;
}
else if (dead)
{
    image_index = 0;
    animTimer = 5;
    shooting = false;
    actionTimer = 0;
    shotTimer = 0;
}
#define Draw_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if (dead)
{
    exit;
}

draw_sprite_ext(sprite_index, image_index, round(x), floor(y), 1, image_yscale, image_angle, image_blend, image_alpha);
if ((iFrames == 1 || iFrames == 3) || (iceTimer > 0))
{
    var flashcol = c_white;
    if (iceTimer > 0)
        flashcol = make_color_rgb(0, 120, 255);
    d3d_set_fog(true, flashcol, 0, 0);
    draw_sprite_ext(sprite_index, image_index, round(x), floor(y), 1, image_yscale, image_angle, image_blend, image_alpha);
    d3d_set_fog(false, 0, 0, 0);
    if (iceTimer > 0)
    {
        draw_set_blend_mode(bm_add);
        draw_sprite_ext(sprite_index, image_index, round(x), floor(y), 1, image_yscale, image_angle, image_blend, image_alpha);
        draw_set_blend_mode(bm_normal);
    }
}
