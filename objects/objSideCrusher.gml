#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_perform_object(objCrusher, ev_create, 0);

despawnRange = -1;
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();

if (entityCanStep())
{
    if (((xcoll > 0 && image_xscale >= 1) || (xcoll < 0 && image_xscale <= -1)) && !goup) // If hit the wall
    {
        // only play sfx if you can actually see it
        if (insideView())
        {
            playSFX(sfxTimeStopper);
        }
        xspeed = 0;
        goup = 64;
    }

    if (goup) // wait for a bit then go up
    {
        goup -= 1;
        if (!goup)
        {
            xspeed = -image_xscale;
        }
    }

    if (!fallen)
    {
        if (xspeed == 0)
        {
            with (target)
            {
                with (other)
                {
                    if (abs(other.y - y) < 40)
                    {
                        fallen = true;
                        xspeed = 1.5 * image_xscale;
                    }
                }
            }
        }
    }
    else
    {
        if (((x < xstart) && image_xscale > 0) || (x > xstart && image_xscale < 0) || (sign(xspeed) != image_xscale && xcoll != 0))
        {
            xspeed = 0;
            fallen = false;
        }
        else
        {
            xspeed += 0.1 * image_xscale;
            xspeed = min(7, max(xspeed, -7));
        }
    }
}
else if (dead)
{
    fallen = false;
    goup = 0;
}
#define Other_10
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
i = x + (-4 * (image_xscale == -1)) + (16 * (image_xscale == 1)) + (-16 * image_xscale);
endit = 0;

while (i > view_xview - 16 + 16)
{
    s = 0;
    if (collision_point(i, y, objSolid, false, false))
    {
        while (collision_point(i + s, y, objSolid, false, false))
        {
            s += image_xscale;
            if ((s == 16) || (s == -16))
            {
                exit;
            }
            endit = 1;
        }
    }

    if (image_xscale == -1)
    {
        draw_sprite_part(sprSideCrusherChain, image_index, 0, 0, 16, 32,
            i + s - 15, y - 16);
    }
    else
    {
        draw_sprite_part(sprSideCrusherChain, image_index, 0, 0,
            16 - abs(s), 32, i + s, y - 16);
    }
    i -= 16 * image_xscale;

    if (endit)
    {
        exit;
    }
}
#define Other_21
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_perform_object(objCrusher, ev_other, ev_user11);
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

// chain drawing
// a somewhat yucky solution, but i don't want to have to suffer through infinite while loop
// crashes constantly to get this to work ;_;
event_user(0);

drawSelf();
