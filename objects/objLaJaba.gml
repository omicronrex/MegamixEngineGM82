#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();

healthpointsStart = 5;
healthpoints = healthpointsStart;
contactDamage = 4;
category = "semi bulky";

facePlayerOnSpawn = true;
phase = 0;

// @cc - use this to change how fast La Jaba's horizontal movement is.
moveSpeed = 1;

// @cc - use this to set how high La Jaba jumps.
jumpSpeed = -3;

image_index = 2;
imgSpd = 0.1;
moveTimer = 0;
tauntCount = 0;
mask_index = sprLaJabaSmallMask;
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();

if (entityCanStep())
{
    if (image_index < 2)
    {
        mask_index = sprLaJabaSmallMask;
    }
    else
    {
        mask_index = sprLaJaba;
    }

    switch (phase)
    {
        // Do Small Jump
        case 0:
            moveTimer-=1;
            if ((moveTimer <= 0) && (ground))
            {
                image_index += imgSpd;
                if (image_index >= 4)
                {
                    image_index = 2;
                    phase = 1;
                    yspeed = jumpSpeed;
                    xspeed = moveSpeed * image_xscale;
                    moveTimer = 4;
                }
            }
            else
            {
                image_index += imgSpd;
                if (image_index >= 2)
                {
                    image_index = 0;
                }
            }
            break;
        // Small Jump - Air
        case 1:
            if (yspeed < 0)
            {
                image_index = 4;
            }
            else if (yspeed > 0)
            {
                image_index = 5;
            }
            else
            {
                image_index = 3;
            }
            if (ground)
            {
                // Do large jump
                if (instance_exists(target))
                {
                    if ((x < target.x + 32) && (image_xscale == -1)
                        || (x > target.x - 32) && (image_xscale == 1))
                    {
                        image_index = 1;
                        xspeed = 0;
                        yspeed = 0;
                        phase = 2;
                        moveTimer = 10;
                        calibrateDirection();
                    } // Do small jump
                    else
                    {
                        xspeed = 0;
                        yspeed = 0;
                        image_index = 2;
                        moveTimer-=1;
                        if (moveTimer == 0)
                        {
                            phase = 0;
                        }
                    }
                }
            }
            break;
        // Do Large Jump
        case 2:
            moveTimer-=1;
            if (moveTimer <= 0)
            {
                image_index += imgSpd;
                if (image_index >= 3)
                {
                    image_index = 1;
                    phase = 3;
                    yspeed = jumpSpeed - 1;
                    xspeed = moveSpeed * image_xscale;
                }
            }
            break;
        // Large Jump - Air
        case 3:
            if (yspeed < 0)
            {
                image_index = 4;
            }
            else if (yspeed > 0)
            {
                image_index = 2;
            }
            else
            {
                image_index = 3;
            }
            if (ground)
            {
                image_index = 0;
                xspeed = 0;
                yspeed = 0;
                phase = 4;
            }
            break;
        case 4:
            if (tauntCount < 2)
            {
                // image_index = 2;
                image_index += imgSpd;
                if (image_index == 1)
                {
                    image_index = 2;
                }
                if (image_index >= 3)
                {
                    image_index = 0;
                    tauntCount += 1;
                }
            }
            else
            {
                moveTimer = 60;
                tauntCount = 0;
                phase = 0;
                calibrateDirection();
            }
            break;
    }
}
else if (dead)
{
    healthpoints = healthpointsStart;
    moveTimer = 0;
    image_index = 2;
    phase = 0;
    xspeed = 0;
    yspeed = 0;
    facePlayer = false;
    tauntCount = 0;
}
