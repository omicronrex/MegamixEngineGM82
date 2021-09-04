#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();

cAngle = 0;
cDistance = 8;
addAngle = 22.5;

blockCollision = false;
contactDamage = 4;
iFrames = 0;

hasFired = false;

curX = x;
curY = y;

parent = noone;

xspeed = 0;
yspeed = 0;
spd = 2;
grav = 0;

attackTimer = 0;
attackTimerMax = 8;

image_speed = 0;
image_index = 0;
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();

if (!global.frozen)
{
    if (instance_exists(parent))
    {
        attackTimer+=1;

        if (xspeed == 0 && yspeed == 0)
        {
            x = round(curX + cos(degtorad(cAngle)) * cDistance);
            y = round(curY + sin(degtorad(cAngle)) * cDistance);
            image_index = -cAngle / 22.5;
        }
        else
        {
            image_index = cAngle / 22.5;
        }
        if (!hasFired)
        {
            if (attackTimer == attackTimerMax)
            {
                cAngle += addAngle;

                if (cAngle >= 360)
                {
                    cAngle -= 360;
                }
                attackTimer = 0;
            }
            curX = parent.x + parent.headX[parent.image_index - 5];
            curY = parent.y;
        }
        else if (xspeed == 0 && yspeed == 0)
        {
            if (instance_exists(target))
            {
                cAngle = point_direction(spriteGetXCenter(), spriteGetYCenter(),
                    spriteGetXCenterObject(target),
                    spriteGetYCenterObject(target));
            }
            else
            {
                cAngle = 0;
            }
            aimAtTarget(spd);
        }

        if (!insideView || parent.dead)
            instance_destroy();
    }
    else
    {
        instance_destroy();
    }
}
#define Draw_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if (!hasFired)
{
    with (parent)
    {
        if ((ceil(iFrames / 2) mod 4) || !iFrames)
        {
            if ((ceil(iFrames / 2) mod 2) || (iceTimer > 0))
            {
                var flashcol; flashcol = c_white;
                if (iceTimer > 0)
                {
                    flashcol = make_color_rgb(0, 120, 255);
                }

                d3d_set_fog(true, flashcol, 0, 0);
                with (other)
                {
                    drawSelf();
                }
                draw_sprite_ext(sprHanabiranOverlay, image_index - 5, round(x), round(y), image_xscale, image_yscale, image_angle, image_blend, image_alpha);
                d3d_set_fog(false, 0, 0, 0);

                if (iceTimer > 0)
                {
                    draw_set_blend_mode(bm_add);
                    with (other)
                    {
                        drawSelf();
                    }
                    draw_sprite_ext(sprHanabiranOverlay, image_index - 5, round(x), round(y), image_xscale, image_yscale, image_angle, image_blend, image_alpha);
                    draw_set_blend_mode(bm_normal);
                }
            }
            else
            {
                with (other)
                {
                    drawSelf();
                }
                draw_sprite_ext(sprHanabiranOverlay, image_index - 5, round(x), round(y), image_xscale, image_yscale, image_angle, image_blend, image_alpha);
            }
        }
    }
}
else
{
    drawSelf();
}
