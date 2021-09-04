#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();

healthpointsStart = 1;
healthpoints = healthpointsStart;
contactDamage = 6;

isTargetable = false;

grav = 0;
blockCollision = 1;
bubbleTimer = -1;

fallen = false;
goup = 0;
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();

if (entityCanStep())
{
    if (ground)
    {
        if (goup) // wait for a bit then go up
        {
            goup -= 1;
            if (!goup)
            {
                yspeed = -image_yscale;
                grav = 0;
            }
        }

        if (ycoll * image_yscale > 0) // If hit the ground
        {
            // only play sfx if you can actually see it
            if (insideView())
            {
                playSFX(sfxTimeStopper);
            }
            yspeed = 0;
            goup = 64;
        }
    }

    if (!fallen)
    {
        if (yspeed == 0)
        {
            with (target)
            {
                with (other)
                {
                    if (abs(other.x - x) < 40)
                    {
                        fallen = true;
                        grav = 0.5 * image_yscale;
                        yspeed = grav * 3;
                    }
                }
            }
        }
    }
    else
    {
        if (((y - ystart) * image_yscale <= 0) || (ycoll * image_yscale < 0))
        {
            yspeed = 0;
            fallen = false;
        }
    }
}
else if (dead)
{
    grav = 0;
    fallen = false;
    goup = 0;
}
#define Other_21
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
other.guardCancel = 3;
#define Draw_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if (!ground)
{
    drawSelf();
}
else
{
    draw_sprite_part(sprite_index, image_index, 0, 0, sprite_width,
        sprite_height - 2, x - sprite_xoffset, y - sprite_yoffset);
}

if (dead)
{
    exit;
}

i = y - 6 - 16;
endit = 0;

while (i > view_yview - 16)
{
    s = 0;
    if (collision_point(x, i, objSolid, false, false))
    {
        while (collision_point(x, i + s, objSolid, false, false))
        {
            s += 1;
            if (s == 16)
            {
                exit;
            }
            endit = 1;
        }
    }
    draw_sprite_part(sprCrusherChain, image_index, 0, s, 32, 16 - s, x - 16,
        i + s);
    i -= 16;
    if (endit)
    {
        exit;
    }
}
