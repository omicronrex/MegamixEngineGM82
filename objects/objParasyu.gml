#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
/// is an enemy that uses a parachute to fall down from the top of the screen
// then drift in a swaying motion attempting to crash into Mega Man
event_inherited();

healthpointsStart = 3;
healthpoints = healthpointsStart;
contactDamage = 3;

category = "flying";

blockCollision = 0;
grav = 0;

// Enemy specific code
active = false;
distance = 32;
offset = distance / 2;
rangeActive = 96;
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();

if (entityCanStep())
{
    if (active)
    {
        visible = true;
        if (y < ystart && image_index == 0)
        {
            yspeed = 3;
        }
        else
        {
            if (image_index == 0)
            {
                xspeed = -0.2;
                image_index = 1;
            }
            if (sign((x + offset) - xstart) == sign(xspeed))
            {
                yspeed = 1 - abs((x + offset) - xstart) / (offset / 2);
            }
            else
            {
                yspeed = 1;
            }
            if (image_index < 2)
            {
                image_index += (20 / 60);
            }
            xspeed += 0.05 * sign(xspeed);
            if (x <= xstart - distance)
            {
                xspeed = 0.2;
            }
            if (x >= xstart)
            {
                xspeed = -0.2;
            }
        }
    }
    else
    {
        y = view_yview;
        visible = false;
    }

    if (instance_exists(target))
    {
        if (abs(x - target.x) < rangeActive)
        {
            active = true;
        }
    }
}
else if (dead)
{
    image_index = 0;
    active = false;
}
