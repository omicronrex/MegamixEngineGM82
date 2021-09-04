#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();
healthpointsStart = 1;
contactDamage = 3;
grav = 0;
blockCollision = 0;
despawnRange = 4;
facePlayerOnSpawn = false;
category = "flying, nature";

//@cc Explosion lenght
explosionLenght = 3;

//@cc if false the explision will damage other enemies
onlyDamageMines=true;

//@cc Change colours: 0 (default) = green, 1 = blue
col = 0;

phase = 0;
timer = 0;
deccel = 0;
newX = -9999;

animFrame = 0;
animOffset = 0;

init = 1;
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();

if (init)
{
    switch (col)
    {
        case 1:
            sprite_index = sprBombPottonBlue;
            break;
        default:
            sprite_index = sprBombPotton;
            break;
    }
    init = 0;
}

if (entityCanStep())
{
    animFrame += 0.2;
    if (floor(animFrame) > 1)
        animFrame = 0;
    if (phase == 0)
    {
        animOffset = 0;
        if (yspeed <= 0 || y >= ystart)
        {
            grav = 0;
            yspeed = 0;
            phase = 1;
            timer = 0;
            newX = -9999;
        }
    }
    else if (phase == 1)
    {
        if (newX == -9999)
        {
            var last; last = noone;
            var dir; dir = image_xscale;
            with (objBombPottonStopper)
            {
                if (!(other.bbox_top <= bbox_bottom && other.bbox_bottom >= bbox_top) || place_meeting(x, y, other))
                    continue;
                if (dir == 1)
                {
                    if (x <= other.x)
                        continue;
                    if (last == noone || (last != noone && x < last.x))
                    {
                        last = self;
                    }
                }
                else
                {
                    if (x >= other.x)
                        continue;
                    if (last == noone || (last != noone && x > last.x))
                    {
                        last = self;
                    }
                }
            }
            if (last != noone)
            {
                newX = last.x;
            }
            else
            {
                newX = -666;
            }
            deccel = -999;
        }
        else
        {
            if (deccel == -999 && abs(x - newX) < 32)
            {
                if (abs(xspeed) < 3)
                    xspeed = 3 * image_xscale;
                deccel = (xspeed * xspeed) / (2 * abs(x - newX));
                deccel *= image_xscale * -1;
            }
            if (newX != -666 && /*( sign(newX-x) == -image_xscale ||*/ (abs(x - newX) < 16) && (xspeed == 0 || sign(xspeed) != image_xscale)) //))
            {
                phase = 2;
                timer = 0;
                xspeed = 0;
            }
            if (deccel == -999 && (newX == -666 || phase == 1) && abs(xspeed) < 3)
            {
                xspeed += image_xscale * 0.25;
                if (abs(xspeed) > 3)
                    xspeed = 3 * sign(xspeed);
            }
            if (deccel != -999 && phase == 1)
            {
                xspeed += deccel;
            }
        }
    }
    else if (phase == 2)
    {
        if (timer == 0)
        {
            var i; i = instance_create(x - 2 * image_xscale, y + 6, objBombPottonBomb);
            animOffset = 1.99999;
            i.onlyDamageMines=onlyDamageMines;
            i.remaining = explosionLenght - 1;
            if (col == 1)
            {
                i.image_index = 1;
            }
        }
        timer += 1;
        if (timer > 30)
        {
            timer = 0;
            phase = 1;
            newX = -9999;
        }
    }
    if (floor(animOffset) > 0)
    {
        animOffset -= 0.1;
        if (floor(animOffset) <= 0)
            animOffset = 0;
    }
    image_index = floor(animOffset) * 2 + floor(animFrame);
}
#define Other_25
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();
if (spawned)
{
    if (instance_exists(target) && ((image_xscale == 1 && target.x > x) || (image_xscale == -1 && target.x < x)))
    {
        y = view_yview;
        yspeed = 5.678;
        grav = -(yspeed * yspeed) / (2 * abs(y - ystart));
    }
    else
    {
        dead = true;
        beenOutsideView = true;
    }
    animFrame = 0;
    animOffset = 0;
    phase = 0;
}
