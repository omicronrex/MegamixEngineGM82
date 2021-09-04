#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();

respawn = false;

healthpointsStart = 1;
healthpoints = healthpointsStart;
contactDamage = 1;

grav = 0;

// Enemy specific code
xsp = 0;
ysp = 0;

actionTimer = 0;
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();

if (entityCanStep())
{
    if (image_index == 1)
    {
        actionTimer += 1;
        if (actionTimer == 10)
        {
            image_index = 0;
            actionTimer = 0;
        }
    }

    if (xcoll != 0)
    {
        xspeed = -xcoll;
        image_index = 1;
        xspeed += sign(xspeed) * 0.25;
        yspeed += sign(yspeed) * 0.25;
    }
    if (ycoll != 0)
    {
        yspeed = -ycoll;
        image_index = 1;
        xspeed += sign(xspeed) * 0.25;
        yspeed += sign(yspeed) * 0.25;
    }
    if (abs(yspeed) > 6)
        yspeed = sign(yspeed) * 6;
    if (abs(xspeed) > 6)
        xspeed = sign(xspeed) * 6;
}
