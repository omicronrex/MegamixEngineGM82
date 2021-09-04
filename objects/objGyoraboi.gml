#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
/// Once aligned with megaman it will shoot a missile upwards
event_inherited();

healthpointsStart = 2;
healthpoints = healthpointsStart;
contactDamage = 6;

category = "aquatic";

blockCollision = 0;
grav = 0;

facePlayerOnSpawn = true;

// Enemy specific code
animTimer = 0;
actionTimer = 0;
action = 0;
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();

if (entityCanStep())
{
    if (action <= 0)
    {
        if (xcoll != 0)
        {
            yspeed = 0.5;
        }
    }

    if (instance_exists(target))
    {
        if (action == 0)
        {
            if (abs(target.x - x) <= 2)
            {
                actionTimer = 0;
                action = 1;
                dir = sign(xspeed);
                xspeed = 0;
                image_index += 1;
            }
        }
    }

    if (action)
    {
        actionTimer += 1;
        if (action == 1)
        {
            if (actionTimer == 10)
            {
                action += 1;
                actionTimer = 0;
                image_index += 1;
                instance_create(x, y - 5, objGyoraboiMissile);
            }
        }
        else if (action == 2)
        {
            if (actionTimer == 10)
            {
                action = -1;
                actionTimer = 0;
                image_index -= 2;
            }
        }
    }
    animTimer += 1;
    if (animTimer == 10)
    {
        animTimer = 0;
        if (image_index < 3)
        {
            image_index += 3;
        }
        else
        {
            image_index -= 3;
        }
    }
    if (action == -1)
    {
        xspeed = dir * 4;
    }
}
else if (dead)
{
    actionTimer = 0;
    action = 0;
    image_index = 0;
}
#define Other_25
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();

if (spawned)
{
    xspeed = image_xscale * 2;
}
