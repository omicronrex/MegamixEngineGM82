#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();

respawn = true;

healthpointsStart = 15;
healthpoints = healthpointsStart;
contactDamage = 6;
canIce = false;

category = "bulky, nature";

doesIntro = false;

dir = image_xscale;

// Enemy specific code
shootTimer = 0;
frogAnimTimer = 0;
frogFrame = 0;
rideFrame = 0;
attack = choose(0, 1);
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();

if (entityCanStep())
{
    shootTimer += 1;

    if (attack == 0)
    {
        if (shootTimer == 100)
        {
            rideFrame = 1;
        }

        if (shootTimer == 120)
        {
            rideFrame = 2;
            for (i = 1; i <= 2; i += 1)
            {
                bomb = instance_create(round(x - 4 * image_xscale), round(y - 48), objGamadayuBomb);
                if (instance_exists(target))
                {
                    with (bomb)
                    {
                        xspeed = xSpeedAim(x, y, other.target.x, other.target.y, yspeed, grav);
                        xspeed = xspeed / other.i;
                    }
                }
            }
        }
        if (shootTimer == 122)
        {
            rideFrame = 3;
        }

        if (shootTimer == 150)
        {
            shootTimer = 0;
            rideFrame = 0;
            attack = choose(0, 1);
        }
    }

    if (attack == 1)
    {
        if (shootTimer == 100)
        {
            frogFrame += 2;
            laser = instance_create(round(x + 32 * image_xscale), round(y + 10), objGamarnLaser);
            laser.image_xscale = image_xscale;
        }

        if (shootTimer == 150)
        {
            shootTimer = 0;
            frogFrame -= 2;
            attack = choose(0, 1);
        }
    }


    if (frogAnimTimer < 5)
    {
        frogAnimTimer += 1;
    }
    else
    {
        if (frogFrame == 1)
        {
            frogFrame = 0;
        }
        else if (frogFrame == 0)
        {
            frogFrame = 1;
        }

        if (frogFrame == 2)
        {
            frogFrame = 3;
        }
        else if (frogFrame == 3)
        {
            frogFrame = 2;
        }

        frogAnimTimer = 0;
    }
}
else if (!insideView())
{
    image_index = 0;
    shootTimer = 0;
}
#define Other_21
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
xb = bboxGetXCenterObject(other.id);
yb = bboxGetYCenterObject(other.id);

if (!(yb < y - 8 && yb > y - 28) || !(image_xscale < 0 && xb < x || image_xscale > 0 && xb > x))
{
    other.guardCancel = 1;
}
#define Draw_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if (iFrames == 1 || iFrames == 3)
{
    d3d_set_fog(true, c_white, 0, 0);
}

draw_sprite_ext(sprGamarn, frogFrame, round(x), round(y), image_xscale,
    image_yscale, image_angle, image_blend, image_alpha);
draw_sprite_ext(sprGamadayu, rideFrame, round(x - 6 * image_xscale),
    round(y - 48), image_xscale, image_yscale, image_angle, image_blend,
    image_alpha);

if (iFrames == 1 || iFrames == 3)
{
    d3d_set_fog(false, 0, 0, 0);
}
