#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();

healthpointsStart = 1;
healthpoints = healthpointsStart;
contactDamage = 4;

category = "grounded";

facePlayerOnSpawn = true;

// Enemy specific code
ground = 1;
calibrated = 0;
sp = 1;
jump = 0;

action = 0;
actionTimer = 0;

calibrateTimer = 80;
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();
if(xcoll!=0)
{
    xspeed=xcoll;
}


if (entityCanStep())
{
    xSpeedTurnaround();

    // Set direction
    calibrateTimer += 1;

    if (calibrateTimer >= 80)
    {
        if (instance_exists(target))
        {
            if (sprite_index != sprDompanJump)
            {
                calibrateDirection();
                xspeed = abs(xspeed) * image_xscale;
                calibrateTimer = 0;
            }
        }
    }

    // Jump
    if (ground)
    {
        if (xspeed != 0)
        {
            if (checkSolid(3 * sign(xspeed), 0))
            {
                if (!checkSolid(3 * sign(xspeed), -32))
                {
                    jump = 1;
                    xspeed = 0;
                    action = 1;
                    actionTimer = 0;
                }
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
                action = 0;
                jump = 2;
                yspeed = -4.5;
                ground = 0;
            }
        }
        else if (action == 2)
        {
            if (actionTimer == 10)
            {
                action = 0;
                jump = 0;
                alarm[0] += 10;
            }
        }
    }

    if (ground && !jump)
    {
        if (sprite_index == sprDompanJump)
        {
            image_index = 0;
        }
        sprite_index = sprDompan;
        image_speed = 0.1;
        xspeed = sp * image_xscale;
    }
    else
    {
        sprite_index = sprDompanJump;
        image_speed = 0;
        xspeed = 0;

        if (jump == 0)
        {
            jump = 3;
        }
        if (jump == 1)
        {
            image_index = 0;
        }
        if (jump == 2 || jump == 3)
        {
            image_index = 1;
            if (ground && yspeed == 0)
            {
                action = 2;
                actionTimer = 0;
                jump = 1;
            }
            else if (jump == 2)
            {
                if (yspeed > -2)
                {
                    xspeed = sp * image_xscale;
                }
            }
        }
    }
}
else if (dead)
{
    calibrateTimer = 80;
    action = 0;
    actionTimer = 0;
    jump = 0;
    sprite_index = sprDompan;
    image_index = 0;
}
#define Other_20
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();

instance_create(x, bbox_top, objDompanFireworkSpark);
