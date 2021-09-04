#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();
goToMercury = false;
grav = 0;
blockCollision = 0;
stopOnFlash = false;

image_speed = 0.10;
despawnRange = -1;
canHit = 0;
parent = noone;
hlth = 0; // How much Mercury is healed by item
if (sprite_index != sprGrabBusterPickup)
{
    usePlayerColor = 0;
}
else
{
    usePlayerColor = 1;
}
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();

if (!global.frozen)
{
    if (!instance_exists(parent))
    {
        instance_destroy();
    }
    else
    {
        if (goToMercury)
        {
            correctDirection(round(point_direction(spriteGetXCenterObject(id),
                spriteGetYCenterObject(id), maskGetXCenterObject(parent),
                maskGetYCenterObject(parent) - 4)), 24);
            speed += 0.1;
        }
        else
        {
            if (yspeed >= 0)
            {
                if (xspeed < 0)
                {
                    direction = 180;
                }
                speed = abs(xspeed);
                goToMercury = 1;

                grav = 0;
                xspeed = 0;
                yspeed = 0;
            }
        }

        if (place_meeting(x, y, parent))
        {
            // hlth = 2;
            parent.healthpoints += hp;
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
if (!dead)
{
    if (sprite_index != sprGrabBusterPickup)
    {
        if (usePlayerColor)
        {
            var imgs = floor(image_number / 4);

            image_index = image_index mod imgs;

            drawSelf();
            draw_sprite_ext(sprite_index, image_index + imgs, round(x), round(y), image_xscale, image_yscale, image_angle, global.primaryCol[0], image_alpha);
            draw_sprite_ext(sprite_index, image_index + imgs * 2, round(x), round(y), image_xscale, image_yscale, image_angle, global.secondaryCol[0], image_alpha);
            draw_sprite_ext(sprite_index, image_index + imgs * 3, round(x), round(y), image_xscale, image_yscale, image_angle, global.outlineCol[0], image_alpha);
        }
        else
        {
            drawSelf();
        }
    }
    else
    {
        drawSelf();
    }
}
