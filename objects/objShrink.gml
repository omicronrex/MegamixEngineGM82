#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
/// An aquatic enemie that follows the player
event_inherited();

healthpointsStart = 3;
healthpoints = healthpointsStart;
contactDamage = 2;

category = "aquatic, nature";

blockCollision = 0;
grav = 0;

facePlayerOnSpawn = true;

// Enemy specific code
yspeed = 0.75;

chaseTimer = 26;
animTimer = 0;

targetX = 0;
targetY = 0;
preSpeed = -1;
preDir = 0;

calibrated = 0;
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();

if (entityCanStep())
{
    if (preSpeed != -99)
    {
        motion_set(preSpeed, preSpeed);
        preSpeed = -99;
    }
    if (chaseTimer > 0)
    {
        chaseTimer -= 1;
    }

    if (speed == 0)
    {
        calibrateDirection();
        animTimer += 1;
        if (animTimer == 5)
        {
            animTimer = 0;
            if (image_index == 0)
            {
                image_index = 1;
            }
            else
            {
                image_index = 0;
            }
        }
    }

    if (chaseTimer < 70 && chaseTimer > 25)
    {
        yspeed = 0.75;
        if (instance_exists(target))
        {
            targetX = target.x;
            targetY = target.y;
        }
        else
        {
            targetX = x + image_xscale * 32;
            targetY = y - 48;
        }
    }
    else if (chaseTimer == 25)
    {
        yspeed = 0;
        preDir = point_direction(x, y, targetX, targetY);
        motion_set(preDir, 2);
        image_index = 2;
    }
    else if (chaseTimer == 0)
    {
        speed = 0;
        chaseTimer = 70;
    }
}
else
{
    if (preSpeed == -99)
        preSpeed = speed;
    speed = 0;
}
#define Other_25
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
/// On spawn
chaseTimer = 0;
targetX = 0;
targetY = 0;
preSpeed = -99;
speed = 0;
