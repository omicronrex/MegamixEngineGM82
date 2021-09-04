#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();

image_xscale = -1;

healthpointsStart = 3;
healthpoints = healthpointsStart;
contactDamage = 6;

category = "flying, joes";

facePlayer = true;

// Enemy specific code
aim = 1;
shooting = false;
animTimer = 0;
attackTimer = 0;
bulletID = -10;

getY = y;

blockCollision = 1;
grav = 0;
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();

if (entityCanStep())
{
    {
        if (instance_exists(target) && shooting == false)
        {
            facePlayer = true;
        }
        else
        {
            facePlayer = false;
        }

        animTimer += 1;

        if (animTimer == 3)
            image_index = (aim * 2) + 1;

        if (animTimer == 6)
        {
            image_index = (aim * 2);
            animTimer = 0;
        }

        if (y <= getY || shooting == true)
            attackTimer += 1;

        if (shooting == false)
        {
            if (y > getY)
                yspeed = -2;
            else if (yspeed < 0)
            {
                yspeed = 0;
                y = getY;
            }
        }

        if (attackTimer >= 30 && shooting == false)
        {
            shooting = true;
            aim = 0;
            if (instance_exists(target))
            {
                if (target.y > y + 12)
                    aim += 1;
                if (target.x > x - 16 && target.x < x + 16 && target.y >= y)
                    aim += 1;
            }
            bull = instance_create(x, y, objApacheJoeProjectile);
            bull.xspeed = (image_xscale - (floor(aim / 2) * image_xscale)) * 3;
            if (aim > 0)
                bull.yspeed = 3;
            bull.image_index = aim;
            bull.image_xscale = image_xscale;

            xspeed = (image_xscale - (floor(aim / 2) * image_xscale)) * 1.5;
            if (aim > 0)
                yspeed = 1.5;
            getY = y;
            attackTimer = 0;
        }

        if ((attackTimer > 60 || (yspeed == 0 && aim > 0)) && shooting == true)
        {
            shooting = false;
            xspeed = 0;
            attackTimer = 0;
        }
    }
}
else
{
    if (dead == true)
    {
        animTimer = 0;
        image_index = (aim * 2);
    }
}
