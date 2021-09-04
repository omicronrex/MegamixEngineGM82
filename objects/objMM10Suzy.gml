#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
// Also known as Octopus Battery. Will periodically move in the direction set in creation code (default is right).
// When it starts moving, it will move until it hits a wall, then rest for a bit, and move back in the opposite direction.
// Wash, rinse, repeat.

// Creation code (all optional):
// dir = "h"/"v" ("h" = horizontal (default); "v" = vertical)
// startDir = -1/1 (1 makes the suzy move right/down first (default); -1 makes the suzy move left/up first)

event_inherited();

healthpointsStart = 5;
healthpoints = healthpointsStart;
contactDamage = 4;
enemyDamageValue(objThunderBeam, 5);

grav = 0;

// Enemy specific code
init = 1;

dir = "h";
startDir = 1;

beginStartDir = startDir;

moveTimer = 0;
moving = false;
firsttime = 1;
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if (init)
{
    init = 0;
    beginStartDir = startDir;
}

event_inherited();

if (entityCanStep())
{
    if (!moving)
    {
        moveTimer += 1;
        if (moveTimer == 10)
        {
            image_index = 0; // After touching a wall, we want the eye to close slowly (half-open the first 10 frames)
        }
        if (moveTimer == 110)
        {
            image_index = 1; // eye half-open
        }
        else if (moveTimer >= 120)
        {
            image_index = 2;
            moving = true;
            if (firsttime)
            {
                if (dir == "h")
                {
                    if (checkSolid(-4, 0, 1, 1))
                    {
                        startDir = 1;
                    }
                    else if (checkSolid(4, 0, 1, 1))
                    {
                        startDir = -1;
                    }
                    else
                    {
                        if (instance_exists(target) && target.x < x)
                        {
                            startDir = -1;
                        }
                        else
                        {
                            startDir = 1;
                        }
                    }
                }
                else
                {
                    if (checkSolid(0, -4, 1, 1))
                    {
                        startDir = 1;
                    }
                    else if (checkSolid(0, 4, 1, 1))
                    {
                        startDir = -1;
                    }
                    else
                    {
                        if (instance_exists(target) && target.y < y)
                        {
                            startDir = -1;
                        }
                        else
                        {
                            startDir = 1;
                        }
                    }
                }
            }
            firsttime = 0;
        }
    }
    else
    {
        if ((xspeed == 0 && dir == "h") || (yspeed == 0 && dir == "v"))
        {
            moving = false;
            moveTimer = 0;
            image_index = 1;
            startDir = -startDir;
        }
    }

    if (moving)
    {
        if (dir == "h")
        {
            xspeed = startDir * 3;
        }
        else
        {
            yspeed = startDir * 3;
        }
    }
}
else if (dead)
{
    moveTimer = 0;
    startDir = beginStartDir;
    moving = false;
    image_index = 0;
    firsttime = 1;
}
