#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();

blockCollision = 0;
grav = 0;

contactDamage = 3;
image_speed = 1 / 6;

dist = 0;
phase = 0;
timer = 45;

_speed = 4.5;
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();

if (!global.frozen && !global.timeStopped)
{
    switch (phase)
    {
        case 0:
            dist -= sqrt(xspeed * xspeed + yspeed * yspeed);
            if (dist < 0)
                phase = 1;
            break;
        case 1:
            x -= xspeed;
            y -= yspeed;
            timer -= 1;
            if (timer <= 0)
            {
                phase = 2;
                var dir;
                if (instance_exists(target))
                    dir = point_direction(x, y, target.x, target.y);
                else
                    dir = random(360);
                xspeed = cos(degtorad(dir)) * _speed;
                yspeed = -sin(degtorad(dir)) * _speed;
            }
            break;
    }
}
else if (global.timeStopped)
{
    instance_create(x, y, objExplosion);
    instance_destroy();
}
