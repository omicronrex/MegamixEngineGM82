#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
/// A crab

event_inherited();

healthpointsStart = 1;
healthpoints = healthpointsStart;
contactDamage = 4;

category = "aquatic";

grav = 0;

facePlayerOnSpawn = true;

// Enemy specific code
yspeed = 1.5;
bounce = 0;

if (x > view_xview[0] + view_wview[0] * 0.5)
{
    dir = -1;
}
else
{
    dir = 1;
}


image_speed = 0.15;
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
    event_inherited();

if (entityCanStep())
{
    image_speed = 0.15;
    if (xcoll != 0)
    {
        image_xscale *= -1;
    }

    if (ycoll != 0)
    {
        if (bounce == 0)
        {
            yspeed = -3.5;
            grav = 0.25;
            ground = 0;
            bounce += 1;
            calibrateDirection();
        }
        else if (bounce == 1)
        {
            yspeed = -1.75;
            ground = 0;
            bounce += 1;
        }
    }

    xspeed = image_xscale * 0.75 * ground;
}
else
{
    image_speed = 0;
}
#define Other_25
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
/// On spawn
event_inherited();
if(spawned){
    while (checkSolid(0, 0, 1, 1))
    {
        x += dir * 4;
    }
}
bounce = 0;
yspeed = 1.5;
