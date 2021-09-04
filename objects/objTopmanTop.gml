#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();

blockCollision = 0;
grav = 0;
stopOnFlash = false;
contactDamage = 4;
stopAtSolid = false;

grav = 0;

number = 0;

spd = 5.5;
phase = 0; // 0 = idling; 1 = getting into position and launching at player
timer = 0;

xspeed = 0;
yspeed = 0;

reflectable = 0;
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if (!instance_exists(objTopMan))
{
    instance_destroy();
    exit;
}
event_inherited();

if (global.frozen == false)
{
    image_speed = 22 / 60;

    switch (phase)
    {
        case 0: // Idling
            xspeed = 0;
            yspeed = 0;
            timer += 1;
            if (timer >= 4)
            {
                timer = 0;
                phase = 1;
            }
            break;
        case 1: // Getting into position
            timer += 1;
            if (timer >= 12 + (number * 9) && timer < 50)
            {
                xspeed = 0;
                yspeed = 0;
            }
            else if (timer < 50)
            {
                xspeed = image_xscale * (spd / sqrt(2));
                yspeed = -spd / sqrt(2);
            }
            if (timer == 50)
            {
                var useAngle;
                if (instance_exists(target))
                {
                    useAngle = point_direction(x, y,
                        spriteGetXCenterObject(target),
                        spriteGetYCenterObject(target));
                }
                else
                {
                    if (image_xscale == 1)
                        useAngle = 0;
                    else
                        useAngle = 180;
                }

                xspeed = cos(degtorad(useAngle)) * 5;
                yspeed = -sin(degtorad(useAngle)) * 5;
            }
            break;
    }
}
else
{
    image_speed = 0;
}
