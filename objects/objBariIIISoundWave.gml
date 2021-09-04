#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();
blockCollision = false;
canCollide = true;
grav = false;
angle = 25;
spd = 2;
contactDamage = 3;
deathTimer = -1;
i = 0;
image_speed = 0.16;
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
var _xsp = xspeed;
var _ysp = yspeed;
event_inherited();

if (entityCanStep())
{
    var collided = false;
    if (canCollide)
    {
        if (!collided)
        {
            var ts = instance_place(x, y + yspeed, objTopSolid);
            if (place_meeting(x, y + yspeed, objSolid) || (yspeed > 0 && ts != noone && bbox_bottom - 1 > ts.bbox_top))
            {
                yspeed *= -1;
                collided = true;
            }
        }
        if (!collided)
        {
            if (place_meeting(x + xspeed, y, objSolid))
            {
                xspeed *= -1;
                collided = true;
            }
        }
    }
    else
    {
        if (place_meeting(x, y, objSolid))
        {
            deathTimer = 0;
        }
    }
    if (collided)
    {
        canCollide = false;
    }

    image_xscale = sign(xspeed);
    image_yscale = -sign(yspeed);

    if (deathTimer != -1)
    {
        deathTimer += 1;
        if (deathTimer mod 2)
        {
            visible = true;
        }
        else
        {
            visible = false;
        }

        if (deathTimer > 60)
        {
            instance_destroy();
            exit;
        }
    }
}
#define Other_10
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
image_xscale = other.image_xscale;
image_yscale = i;
xspeed = image_xscale * abs(cos(degtorad(angle)) * spd);
yspeed = image_yscale * abs(sin(degtorad(angle)) * spd);
