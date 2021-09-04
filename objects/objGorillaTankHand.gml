#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
// Creation code (all optional):

event_inherited();

image_xscale = -1;

respawn = true;

healthpointsStart = 16;
healthpoints = healthpointsStart;
contactDamage = 4;

grav = 0;
blockCollision = false;
isTargetable = false;

// Enemy specific code
attack = false;
shootTimer = 0;
image_speed = 0;
parent = noone;
dir = 1;
getX = x;
getY = y;
spd = 0;
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();

if (instance_exists(parent))
{
    if (healthpoints > parent.healthpoints)
    {
        healthpoints = parent.healthpoints;
    }
    else
    {
        parent.healthpoints = healthpoints;
    }
}

if (entityCanStep())
{
    if (attack == true)
    {
        shootTimer += 1;
        if (shootTimer == 1)
        {
            getX = x;
            getY = y;
            spd = 4;
            image_speed = 0.5;
            if (instance_exists(target))
            {
                var angle;
                angle = round(point_direction(spriteGetXCenter(),
                    spriteGetYCenter(),
                    spriteGetXCenterObject(target),
                    spriteGetYCenterObject(target) + 16) / 22.5) * 22.5;

                xspeed = cos(degtorad(angle)) * spd;
                yspeed = -sin(degtorad(angle)) * spd;
            }
            else
            {
                xspeed = spd * image_xscale;
                yspeed = 0;
            }
        }


        if (x < view_xview + 16 || x > view_xview + view_wview - 16
            || y < view_yview + 16 || y > view_yview + view_hview - 16)
        {
            dir = -1;
        }

        if (dir == -1)
        {
            spd = 2;
            var angle;
            angle = round(point_direction(spriteGetXCenter(), spriteGetYCenter(), getX, getY));

            xspeed = cos(degtorad(angle)) * spd;
            yspeed = -sin(degtorad(angle)) * spd;
        }
    }

    // dir
    if (dir == -1 && point_distance(spriteGetXCenter(), spriteGetYCenter(), getX, getY) <= spd)
    {
        xspeed = 0;
        yspeed = 0;
        x = getX;
        y = getY;
        dir = 1;
        image_single = 0;
        attack = false;
        shootTimer = 0;
    }
}
else if (!insideView())
{
    if (instance_exists(target))
    {
        if (target.x < x)
        {
            image_xscale = -1;
        }
        else
        {
            image_xscale = 1;
        }
    }

    image_index = 0;
    shootTimer = 0;
}
#define Other_21
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
global.damage = 0;
other.guardCancel = 3;
