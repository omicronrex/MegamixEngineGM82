#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();

canHit = false;

grav = 0;
bubbleTimer = -1;

shiftVisible = 1;

if (image_angle == 90)
{
    dir = "left";
    image_angle = 0;
    y -= 16;
    ystart -= 16;
}
else if (image_angle == 180)
{
    dir = "down";
    image_angle = 0;
    y -= 16;
    x -= 16;
    xstart -= 16;
    ystart -= 16;
}
else if (image_angle == 270)
{
    dir = "right";
    image_angle = 0;
    x -= 16;
    xstart -= 16;
}
else
{
    dir = "up";
}

//@cc
startTimer = 60;

//@cc
activeTimer = 120;

length = 0;
timer = 0;

// variables
plat = noone;

isSolid = 1;
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();

if (!global.frozen && !dead && !global.timeStopped)
{
    timer += 1;
    if (timer > startTimer && length < 64)
    {
        length += 2;
    }

    if (timer > startTimer && dir == "up")
    {
        if (!instance_exists(plat))
        {
            plat = instance_create(x, y + 4, objStandSolid);
        }
        else
        {
            plat.y = y + 4 - length;
            plat.image_yscale = (length / 64) * 4;
        }
    }
    else
    {
        if (instance_exists(plat))
        {
            with (plat)
            {
                instance_destroy();
            }
        }
    }

    if (timer >= startTimer + activeTimer)
    {
        timer = 0;
        length = 0;
    }

    that = 0;
    with (objMegaman)
    {
        with (other)
        {
            that = other.id;
            if (dir == "left" && collision_rectangle(x + 4, y, x - length + 4,
                y + 16 - 3, that, 0, 0))
            {
                xs = -2;
                ys = 0;
                event_user(0);
            }
            if (dir == "right" && collision_rectangle(x + 16 - 4, y,
                x + 16 + length - 4, y + 16 - 3, that, 0, 0))
            {
                xs = 2;
                ys = 0;
                event_user(0);
            }
            if (dir == "down" && collision_rectangle(x, y + 16 - 4, x + 16 - 3,
                y + 16 + length - 4, that, 0, 0))
            {
                xs = 0;
                ys = 2;
                event_user(0);
                if (!that.ground)
                {
                    that.yspeed += 0.1;
                }
            }
            if (dir == "up" && collision_rectangle(x, y + 4, x + 16 - 3,
                y - length + 4, that, 0, 0))
            {
                xs = 0;
                ys = -2;
                event_user(0);
            }
        }
    }
}
else if (dead || instance_exists(objSectionSwitcher))
{
    length = 0;
    timer = 0;
}
#define Other_10
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
with (that)
{
    shiftObject(other.xs, other.ys, 1);
}
#define Draw_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
X = 0;
Y = 0;
xDir = 1;
yDir = 1;
angle = 0;

if (dir == "up")
{
    draw_sprite_part_ext(sprWaterPillar, timer / 4, 0, 0, 16, length,
        round(x) + 8 - sprite_get_xoffset(sprWaterPillar),
        round(y) - length - sprite_get_yoffset(sprWaterPillar),
        image_xscale, image_yscale, image_blend, image_alpha);
}
if (dir == "down")
{
    X = 0;
    Y = 16;
    xDir = -1;
    angle = 180;
    draw_sprite_part_ext(sprWaterPillar, timer / 4, 0, 0, 16, length,
        round(x) + 8 - sprite_get_xoffset(sprWaterPillar),
        round(y) + 16 + length, image_xscale, -image_yscale, image_blend,
        image_alpha);
}
if (dir == "left")
{
    X = 0;
    Y = 0;
    xDir = -1;
    angle = 90;
    draw_sprite_part_ext(sprWaterPillarH, timer / 4, 0, 0, length, 16,
        round(x) + 8 - length - sprite_get_xoffset(sprWaterPillar),
        round(y), image_xscale, image_yscale, image_blend, image_alpha);
}
if (dir == "right")
{
    X = 16;
    Y = 0;
    angle = 270;
    draw_sprite_part_ext(sprWaterPillarH, timer / 4, 0, 0, length, 16,
        round(x) + 16 + length, round(y), -image_xscale, image_yscale,
        image_blend, image_alpha);
}

draw_sprite_ext(sprWaterPump, timer / 4, round(x) + X, round(y) + Y,
    image_xscale * xDir, image_yscale * yDir, angle, image_blend,
    image_alpha);
