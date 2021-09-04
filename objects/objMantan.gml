#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();

healthpointsStart = 2;
healthpoints = healthpointsStart;
contactDamage = 4;

category = "aquatic, nature";

grav = 0;
blockCollision = 0;

facePlayerOnSpawn = true;

// Enemy specific code
actionTimer = 0;

xspeed = image_xscale;
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();

if (entityCanStep())
{
    xspeed = image_xscale;

    actionTimer += 1;
    if (actionTimer == 80 && instance_exists(target))
    {
        if (y < target.y)
        {
            image_index = 2;
            yspeed = 0.75;
        }
        else
        {
            image_index = 1;
            yspeed = -0.75;
        }
    }
    else if (actionTimer == 112)
    {
        yspeed = 0;
        image_index = 0;
    }
}
else if (dead)
{
    actionTimer = 0;
    xspeed = image_xscale;
    yspeed = 0;
}
