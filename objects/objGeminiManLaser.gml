#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();

grav = 0;
stopOnFlash = false;
contactDamage = 6;
blockCollision = true;

xspeed = 0;
yspeed = 0;

savedXspeed = 0;
savedYspeed = 0;

reflectable = 0;
bounces = 0;
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();

if (entityCanStep())
{
    if (yspeed != 0)
    {
        savedYspeed = yspeed;
    }
    if (xspeed != 0)
    {
        savedXspeed = xspeed;
    }

    if (bounces <= 3)
    {
        if (xcoll != 0)
        {
            xspeed = -savedXspeed;
            bounces += 1;
            if (yspeed == 0 && sprite_index != sprGeminiLaserReflect)
            {
                yspeed = -2;
                sprite_index = sprGeminiLaserReflect;
            }
        }
        else if (ycoll != 0)
        {
            yspeed = -savedYspeed;
            bounces += 1;
        }
    }
    else
    {
        blockCollision = false;
    }

    image_xscale = sign(xspeed);
    if (sprite_index == sprGeminiLaserReflect)
    {
        image_yscale = sign(yspeed);
    }
}
if (!insideView())
    instance_destroy();
