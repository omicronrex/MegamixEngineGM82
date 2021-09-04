#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();

calibrateDirection();

respawn = false;

itemDrop = -1;
pierces = 0;

healthpointsStart = 1;
healthpoints = healthpointsStart;
contactDamage = 2;

blockCollision = false;
grav = 0;
dir = 90;
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();

if (entityCanStep())
{
    image_xscale = 1;
    if (instance_exists(target))
    {
        var diff; diff = angle_difference(dir, point_direction(x, y, target.x, target.y));
        if (abs(diff) > 12)
        {
            dir -= 90 / 8 / 4 * sign(diff);
        }
    }
    image_index = round(dir * 8 / 360);
    var spd; spd = 1.5;
    if (image_index mod 2 == 1)
        spd = 1.1;
    xspeed = spd * cos(degtorad(dir));
    yspeed = -spd * sin(degtorad(dir));
}
