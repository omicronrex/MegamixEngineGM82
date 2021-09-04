#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
/// A weird helicopter that goes up drops trying to stomp megaman
event_inherited();

healthpointsStart = 5;
healthpoints = healthpointsStart;
contactDamage = 4;

category = "flying, semi bulky";

facePlayerOnSpawn = true;

// Enemy specific code

//@cc 0 = red (default); 1 = green
col = 0;
init = 1;

moveTimer = 0;
animEndme = 0;

floating = false;
floatTimer = 0;
xs = 0;
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
            sprite_index = sprProptop;
            break;
        case 1:
            sprite_index = sprProptopGreen;
            break;
        default:
            sprite_index = sprProptop;
            break;
    }
}

xspeed = xs;

event_inherited();

if (entityCanStep())
{
    if (ground)
    {
        if (ycoll > 0)
        {
            xspeed = 0;
            xs = 0;
            playSFX(sfxHeavyLand);
        }
    }
    else
    {
        moveTimer = 0;
    }

    if (ground)
    {
        moveTimer += 1;
        if (moveTimer >= 70)
        {
            floating = true;
            grav = 0;
            yspeed = -1;
        }
    }
    else
    {
        moveTimer = 0;
    }

    if (floating)
    {
        floatTimer += 1;
        if (floatTimer >= 64)
        {
            calibrateDirection();
            floatTimer = 0;
            floating = false;
            grav = 0.25;
            yspeed = -3;

            if (instance_exists(target))
            {
                xspeed = xSpeedAim(x, y, target.x, target.y, yspeed, grav);
            }
            xs = xspeed;
        }
    }

    animEndme += 1;
    if (animEndme >= 8)
    {
        if (yspeed < 0)
        {
            if (image_index == 2)
            {
                image_index = 3;
            }
            else
            {
                image_index = 2;
            }
        }
        else
        {
            if (image_index == 0)
            {
                image_index = 1;
            }
            else
            {
                image_index = 0;
            }
        }
        animEndme = 0;
    }
}
else if (dead)
{
    moveTimer = 0;
    animEndme = 0;
    floating = false;
    floatTimer = 0;
    xs = 0;
    grav = 0.5;
    image_index = 0;
}
