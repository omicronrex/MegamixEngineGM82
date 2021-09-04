#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();

respawn = true;

healthpointsStart = 3;
healthpoints = healthpointsStart;
contactDamage = 5;
contactStart = contactDamage;

isSolid = 2;

grav = 0;

// Enemy specific code
image_speed = 0.2;
alarmStop = 0;
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
ys = yspeed;

event_inherited();

if (entityCanStep())
{
    if (instance_exists(target))
    {
        if (abs(target.x - x) < 48)
        {
            if (y == ystart)
            {
                yspeed = 2.5;
            }
        }
    }

    if (alarmStop)
    {
        alarmStop += 1;
        if (alarmStop == 21)
        {
            yspeed = -0.5;
            alarmStop = 0;
        }
    }

    if (yspeed == 0)
    {
        if (ys > 0)
        {
            alarmStop = 1;
            repeat (2)
            {
                image_xscale *= -1;
                i = instance_create(x + 5 * image_xscale, bbox_bottom - 1, objSlideDust);
                i.image_xscale = -image_xscale;
            }
        }
    }

    if (yspeed < 0)
    {
        if (y < ystart)
        {
            shiftObject(0, ystart - y, 1);
            y=ystart;
        }
    }
}
else if (dead)
{
    alarmStop = 0;
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

if (iFrames == 1 || iFrames == 3)
{
    d3d_set_fog(true, c_white, 0, 0);
}

if (!ground)
{
    drawSelf();
}
else
{
    draw_sprite_part(sprite_index, image_index, 0, 0, sprite_width,
        sprite_height - 2, x - sprite_xoffset, y - sprite_yoffset);
}

if (iFrames == 1 || iFrames == 3)
{
    d3d_set_fog(false, 0, 0, 0);
}
