#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
// creation code
// moveDistX = <number>;   - The distance the enemy moves horizontally before turning back on itself. Default is 32.;
// moveDistY = <number>;   - The distance the enemy moves vertically before turning back on itself. Default is 32.;

event_inherited();

healthpointsStart = 5;
healthpoints = healthpointsStart;
contactDamage = 6;

category = "floating";

blockCollision = 0;
grav = 0;

// Enemy specific code
moveDelay = 0;
moveTimer = 0;
direct = 1;
homeX = xstart;
homeY = ystart;
delayTurn = 0;
init = false;
moveDir = 0;


// creation code variables
moveDistX = 32;
moveDistY = 32;
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();

if (entityCanStep())
{
    if (!init)
    {
        init = true;
        startDir = moveDir;
    }

    image_index += 0.20;
    facePlayer = false;

    moveDelay+=1;

    if (delayTurn > 0)
    {
        delayTurn-=1;
    }

    if (moveDelay == 0)
    {
        xspeed = 0;
        yspeed = 0;
    }

    if (moveDir == 0 && moveDelay >= 1)
    {
        xspeed = (1 * image_xscale) * direct;
    }
    else if (moveDir == 1 && moveDelay >= 1)
    {
        yspeed = 1 * direct;
    }
    else if (moveDir == 2 && moveDelay >= 1)
    {
        xspeed = (-1 * image_xscale) * direct;
    }
    else if (moveDir == 3 && moveDelay >= 1)
    {
        yspeed = -1 * direct;
    }
    if (moveDelay == 3)
    {
        moveDelay = -1;
    }

    moveTimer += 1;
    if ((((abs(x - homeX) >= moveDistX || abs(y - homeY) >= moveDistY) && direct == 1)
        || ((abs(x - homeX) <= 0 && abs(y - homeY) <= 0) && direct == -1)) && delayTurn == 0)
    {
        direct *= -1;
        if (direct == 1)
        {
            moveDir += 1;
        }
        if (moveDir == 4)
        {
            moveDir = 0;
        }
        delayTurn = 8;
        moveTimer = 0;
        moveDelay = -1;
    }
}
else
{
    if (dead == true)
    {
        facePlayer = true;
        moveDelay = -1;
        if (init)
        {
            moveDir = startDir;
        }
        image_index = 0;
    }
}
