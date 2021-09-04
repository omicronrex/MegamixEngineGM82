#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();

// The exact same as regular moles, except they have a fancy spark when they drill floors

healthpointsStart = 3;
healthpoints = healthpointsStart;
contactDamage = 4;

category = "cluster";

grav = 0;
blockCollision = 0;

// Enemy specific code
image_speed = 0.2;

topblock = -1;
bottomBlock = -1;
touchblock = place_meeting(x, y, objSolid);
cantDraw = touchblock;

animTimer = 0;
sparkindex = 0;

x = round(x / 8) * 8;

ysc = 1;
if (y < view_yview + view_hview * 0.5)
{
    sprite_index = sprMolmoleDown;
    ysc = -1;
}
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();

if (entityCanStep())
{
    touchblock = place_meeting(x, y, objSolid);
    if (touchblock)
    {
        topblock = 0;
        while (!collision_line(bbox_left, bbox_top + topblock, bbox_right,
            bbox_top + topblock, objSolid, false, false))
        {
            topblock += 1;
        }
        bottomBlock = 0;
        while (!collision_line(bbox_left, bbox_bottom - bottomBlock,
            bbox_right, bbox_bottom - bottomBlock, objSolid, false, false))
        {
            bottomBlock += 1;
        }
        if (bottomBlock <= 0 && topblock <= 0)
        {
            yspeed = -8 * ysc;
            centerTopBlock = 0;
            while (!collision_line(bbox_left,
                bboxGetYCenter() - centerTopBlock, bbox_right,
                bboxGetYCenter() - centerTopBlock, objSolid, false,
                false))
            {
                centerTopBlock += 1;
            }
            centerBottomBlock = 0;
            while (!collision_line(bbox_left,
                bboxGetYCenter() + centerBottomBlock, bbox_right,
                bboxGetYCenter() + centerBottomBlock, objSolid, false,
                false))
            {
                centerBottomBlock += 1;
            }
        }
        else
        {
            yspeed = -1 * ysc;
        }
        yspeed = -0.25 * ysc;
    }
    else
    {
        topblock = -1;
        bottomBlock = -1;
        yspeed = -1 * ysc;
    }
    cantDraw = 0;
}
#define Draw_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if (dead || beenOutsideView || cantDraw)
{
    exit;
}

var drew;
drew = 0;

if (iFrames == 1 || iFrames == 3)
{
    d3d_set_fog(true, c_white, 0, 0);
}

var drew;
drew = 0;

if (topblock > 0)
{
    draw_sprite_part(sprite_index, image_index, 0, 0, sprite_width, topblock,
        x - sprite_xoffset, bbox_top);
    drew = 1;
    if (topblock > 1 && bottomBlock <= 0)
    {
        animTimer += 1;
        if (animTimer > 2)
        {
            animTimer = 0;
            sparkindex += 1;
            if (sparkindex == 3)
            {
                sparkindex = 0;
            }
        }

        sparkblock = (collision_point(x, y, objSolid, false, false));
        if (!sparkblock)
        {
            sparkblock = (collision_point(x, y + 12, objSolid, false, false));
        }
        draw_sprite(sprMoleSpark, sparkindex, x, (sparkblock.bbox_top));
    }
}
if (bottomBlock > 0)
{
    draw_sprite_part(sprite_index, image_index, 0, sprite_height - bottomBlock,
        sprite_width, bottomBlock, x - sprite_xoffset,
        bbox_bottom - bottomBlock + 1);
    drew = 1;
    if (topblock <= 1 && bottomBlock > 0)
    {
        animTimer += 1;
        if (animTimer > 2)
        {
            animTimer = 0;
            sparkindex += 1;
            if (sparkindex == 3)
            {
                sparkindex = 0;
            }
        }

        sparkblock = (collision_point(x, y, objSolid, false, false));
        if (!sparkblock)
        {
            sparkblock = (collision_point(x, y - 12, objSolid, false, false));
        }
        draw_sprite(sprMoleSpark, sparkindex, x, (sparkblock.bbox_bottom));
    }
}

if (!drew)
{
    if (!touchblock)
    {
        draw_sprite(sprite_index, image_index, x, y);
    }
    else if (centerTopBlock > 0 || centerBottomBlock > 0)
    {
        draw_sprite_part(sprite_index, image_index, 0,
            (bboxGetYCenter() - bbox_top) - centerTopBlock, sprite_width,
            centerBottomBlock + centerTopBlock - 1, x - sprite_xoffset,
            bboxGetYCenter() - centerTopBlock + 1);
    }
}

if (iFrames == 1 || iFrames == 3)
{
    d3d_set_fog(false, 0, 0, 0);
}
