#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();

healthpointsStart = 1;
healthpoints = healthpointsStart;
contactDamage = 3;

category = "grounded, cluster";

blockCollision = 0;
grav = 0;

facePlayerOnSpawn = true;

// Enemy specific code
yspeed = -3;

stopTimer = 20;
yMax = 0;
turnTimer = 60;
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();

if (entityCanStep())
{
    if (turnTimer > -1)
    {
        turnTimer -= 1;
    }
    if (turnTimer == 0)
    {
        calibrateDirection();
        xspeed = image_xscale * 1.5;
        turnTimer = 60;
    }

    if (stopTimer > -1)
    {
        stopTimer -= 1;
    }
    if (stopTimer == 0)
    {
        yspeed = 0;
        yMax = y;
        calibrateDirection();
        xspeed = image_xscale * 1.5;
    }

    if (instance_exists(target))
    {
        if (collision_rectangle(x - 32, y, x + 32, y + 512, target, false, true) && yspeed == 0)
        {
            yspeed = 4;
        }
    }
    if (y > view_yview + 224 - 16 && yspeed == 4)
    {
        yspeed = -4;
    }
    if (yspeed == -4 && y <= yMax)
    {
        yspeed = 0;
    }
}
