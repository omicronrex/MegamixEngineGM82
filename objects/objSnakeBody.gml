#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();
canHit = false;

grav = 0;
blockCollision = 0;

isSolid = 1;
shiftVisible = 1;

shakeSpeed = 1;

shakeDir = 1;
startDir = -99;
yOffset = 0;

snakeBoss = instance_nearest(x, y, objBigSnakey);
shake = true;

if (!instance_place(x - 16, y, objSnakeBody))
{
    getLength = 1;
    while (instance_place(x + 16 * getLength, y, objSnakeBody))
    {
        bod = instance_place(x + 16 * getLength, y, objSnakeBody);
        if (getLength mod 4 >= 1 && getLength mod 4 <= 4)
        {
            bod.shakeDir = -1;
            if (getLength mod 4 == 1)
            {
                bod.yOffset = 8;
            }
            if (getLength mod 4 == 3 || getLength mod 4 == 4)
            {
                bod.yOffset = -8;
            }
        }

        //        bod.startDir = bod.dir;
        getLength += 1;
    }
}
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();
if (startDir == -99)
    startDir = shakeDir;
if (!global.frozen && !dead && !global.timeStopped)
{
    if (shake)
    {
        yspeed = shakeSpeed * shakeDir;

        if (y >= ystart + 8)
        {
            shakeDir = -1;
        }
        if (y <= ystart - 8)
        {
            shakeDir = 1;
        }
        if (instance_exists(snakeBoss))
        {
            if (snakeBoss.dead && insideSection(snakeBoss.x, snakeBoss.y))
            {
                shake = false;
                yspeed = 0;
            }
        }
        else
        {
            shake = false;
            yspeed = 0;
        }
    }
    else
    {
        if (instance_exists(snakeBoss))
        {
            shake = 1;
        }
    }
}
else if (dead)
{
    shakeDir = startDir;
    y = ystart + yOffset;
    shake = 1;
}
