#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();
canHit = false;

isSolid = 1;

blockCollision = 0;
grav = 0;
bubbleTimer = -1;

respawnRange = -1;
despawnRange = -1;

button = 0;
rightbutton = 0;
leftbutton = 0;

imgalarm = 0;
img = -1;

maxSpeed = 1;
accel = 0.01;

drawrail = 1;
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if (!global.frozen && !dead && !global.timeStopped)
{
    if (xspeed != 0)
    {
        if (bbox_left + xspeed < view_xview)
        {
            x = round(x);
            while (bbox_left < view_xview)
            {
                x += 1;
            }
            xspeed = 0;
        }
        if (bbox_right + xspeed > view_xview + view_wview)
        {
            x = round(x);
            while (bbox_right > view_xview + view_wview)
            {
                x -= 1;
            }
            xspeed = 0;
        }
    }

    if (instance_exists(objAutoScroller))
    {
        with (objAutoScroller)
        {
            if (dir == 'v')
            {
                if (phase == 3)
                {
                    other.yspeed = mySpeed;
                }
                if (phase == 4)
                {
                    other.yspeed = 0;
                }
            }
        }
    }
}

event_inherited();

if (!global.frozen && !dead && !global.timeStopped)
{
    // Left button
    mm = collision_rectangle(bbox_left + 1, bbox_top - 1, bbox_left + 1 + 30 - 2, bbox_top - 1, target, false, false);
    if (mm)
    {
        if (mm.ground)
        {
            if (leftbutton == 0)
            {
                playSFX(sfxSidewayElevatorButton);
            }
            leftbutton = -1;
        }
    }
    else
    {
        leftbutton = 0;
    }

    // Right button
    mm = collision_rectangle(bbox_right + 1, bbox_top - 1, bbox_right - 1 - 30 + 2, bbox_top - 1, target, false, false);
    if (mm)
    {
        if (mm.ground)
        {
            if (rightbutton == 0)
            {
                playSFX(sfxSidewayElevatorButton);
            }
            rightbutton = 1;
        }
    }
    else
    {
        rightbutton = 0;
    }

    // Shift speed from butto speed
    button = leftbutton + rightbutton;
    if (button != 0)
    {
        if (xspeed * button < maxSpeed)
        {
            xspeed += accel * button;
        }
        imgalarm += 1;
        if (imgalarm == 10)
        {
            img += 1;
            if (img == 4)
            {
                img = -1;
            }
            imgalarm = 0;
        }
    }
    else
    {
        if (xspeed != 0)
        {
            xspeed -= accel * sign(xspeed);
        }
        img = -1;
        imgalarm = 0;
    }
}
else if (dead)
{
    button = 0;
    imgalarm = 0;
    img = -1;
    xspeed = 0;
}
#define Draw_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if (instance_exists(objMegaman))
{
    if (!insideSection(x, y))
    {
        exit;
    }
}

xs = x;
ys = y;

x = round(x);
y = round(y);

if (drawrail)
{
    draw_sprite_ext(sprSidewayElevatortrack, 0, view_xview, y, view_wview / 16,
        image_yscale, image_angle, image_blend, image_alpha);
}

draw_sprite(sprite_index, image_index, x, y);

if (rightbutton == 0)
{
    draw_sprite(sprSidewayElevatorButton, 0, x + 32, y);
}
else if (img != -1)
{
    draw_sprite_ext(sprSidewayElevatorArrow, img, x + 32, y + 14, image_xscale,
        image_yscale, image_angle, image_blend, image_alpha);
}

if (leftbutton == 0)
{
    draw_sprite(sprSidewayElevatorButton, 0, x - 32, y);
}
else if (img != -1)
{
    draw_sprite_ext(sprSidewayElevatorArrow, img, x - 32 - 1, y + 14,
        -image_xscale, image_yscale, image_angle, image_blend, image_alpha);
}

x = xs;
y = ys;
