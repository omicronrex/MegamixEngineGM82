#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();

contactDamage = 0;

image_speed = 1 / 6;

despawnRange = -1;

hlth = 2;
canHit = false;
gotomega = 0;

is1Up = false;
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();

if (!global.frozen)
{
    if (!instance_exists(parent))
    {
        instance_destroy();
    }
    else
    {
        if (gotomega)
        {
            correctDirection(round(point_direction(spriteGetXCenterObject(id),
                spriteGetYCenterObject(id), maskGetXCenterObject(parent),
                maskGetYCenterObject(parent) - 4)), 24);
            speed += 0.1;
        }
        else
        {
            if (yspeed >= 0)
            {
                if (xspeed < 0)
                {
                    direction = 180;
                }
                speed = abs(xspeed);
                gotomega = 1;

                grav = 0;
                xspeed = 0;
                yspeed = 0;
            }
        }

        if (place_meeting(x, y, parent))
        {
            collectPlayer = parent;
            hlth = 2;
            event_perform_object(objLifeEnergyBig, ev_other, ev_user0);
            instance_destroy();
        }
    }
}
