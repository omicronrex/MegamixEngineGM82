#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
/// It can obscure the terrain by creating a hologram that causes the whole screen to go black
event_inherited();

healthpointsStart = 3;
healthpoints = healthpointsStart;
contactDamage = 3;

blockCollision = 0;
grav = 0;

// Enemy specific code
actionTimer = 0;
action = 0;

calibrateDirection();
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();

if (entityCanStep())
{
    if (instance_exists(target))
    {
        if (action == 0)
        {
            facePlayer = true;
            xspeed = image_xscale * 0.5;
            image_xscale = 1;
            if (abs(target.x - x) <= 96)
            {
                facePlayer = false;
                action = 1;
                dir = sign(xspeed);
                xspeed = 0;
            }
        }
    }
    if (action)
    {
        actionTimer += 1;
        if (action == 1)
        {
            if (actionTimer == 5)
            {
                action += 1;
                actionTimer = 0;
                image_index = 1;
                if (!instance_exists(objHologranVoid))
                {
                    instance_create(x, y, objHologranVoid);
                }
            }
        }
        else if (action == 2)
        {
            if (actionTimer == 5)
            {
                action += 1;
                actionTimer = 0;
                image_index = 2;
            }
        }
        else if (action == 3)
        {
            if (actionTimer == 5)
            {
                action += 1;
                actionTimer = 0;
                image_index = 0;
            }
        }
        else if (action == 4)
        {
            if (actionTimer == 50)
            {
                action = -1;
                actionTimer = 0;
            }
        }
    }
    if (action == -1)
    {
        xspeed = dir * 0.25;
    }
}
else if (dead)
{
    action = 0;
    actionTimer = 0;
    image_index = 0;
}
