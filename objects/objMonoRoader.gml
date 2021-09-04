#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
// Creation code (all optional):
// col 0 = Blue, Red, Pink, Green

event_inherited();

healthpointsStart = 3;
healthpoints = healthpointsStart;
contactDamage = 4;

category = "grounded, shielded, semi bulky";

// Enemy specific code
inShell = false;
shellTimer = 0;
animTimer = 0;

col = 0;
init = 1;
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if (init)
{
    init = 0;
    switch (col)
    {
        case 0:
            sprite_index = sprMonoRoader;
            break;
        case 1:
            sprite_index = sprMonoRoaderRed;
            break;
        case 2:
            sprite_index = sprMonoRoaderPink;
            break;
        case 3:
            sprite_index = sprMonoRoaderGreen;
            break;
    }
}

event_inherited();

if (entityCanStep())
{
    if (xcoll != 0)
    {
        image_xscale = -sign(xcoll);
    }

    if (animTimer != -1)
    {
        animTimer += 1;
    }
    if (inShell)
    {
        if (animTimer >= 4)
        {
            animTimer = 0;
            image_index += 1;
            if (image_index > 11)
            {
                image_index = 6;
            }
        }
    }
    else
    {
        if (animTimer >= 8)
        {
            animTimer = 0;
            image_index += 1;
            if (image_index > 5)
            {
                image_index = 0;
            }
        }
    }

    if (xspeed == 0 && !inShell)
    {
        calibrateDirection();
        xs = 1;
    }

    if (instance_exists(target))
    {
        if (abs(target.x - x) < 48 && !inShell && ground)
        {
            inShell = true;
            animTimer = -1;
            xspeed = 0;
        }
    }

    if (inShell)
    {
        if (ground)
        {
            shellTimer += 1;
        }
        switch (shellTimer)
        {
            case 16:
                calibrateDirection();
                xs = 2;
                image_index = 6;
                animTimer = 0;
                break;
            case 48:
                xs = 0;
                break;
            case 80:
                xs = -2;
                break;
            case 112:
                xs = 0;
                inShell = false;
                shellTimer = 0;
                image_index = 0;
                break;
        }
    }

    if (!ground)
    {
        xspeed = 0;
    }
    else
    {
        xspeed = xs * image_xscale;
    }
}
else
{
    image_speed = 0;
    animTimer = 0;
    inShell = false;
    shellTimer = 0;
    if (dead)
    {
        image_index = 0;
    }
}
#define Other_21
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if (inShell)
{
    other.guardCancel = 1;
}
