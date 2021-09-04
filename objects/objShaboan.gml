#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
// A big soap bubble that hangs on ceilings until Mega Man gets close. It then drops down
// and jumps after him constantly.

event_inherited();

healthpointsStart = 4;
healthpoints = healthpointsStart;
contactDamage = 3;

grav = 0;
phase = 0;
category = "aquatic";

imgSpd = 0.1;
moveTimer = 10;
blinkCount = 0;
canBlink = true;
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();
if (entityCanStep())
{
    switch (phase)
    {
        // Hang on ceiling
        case 0:
        image_index += imgSpd;

            if (instance_exists(target))
            {
                // Mostly here for the sake of the "else" block.
                if ((target.x > x + 85) || (target.x < x - 85))
                {
                    if (image_index >= 2)
                    {
                        image_index = 0;
                    }
                }
                else
                {
                    if (image_index == 2)
                    {
                        calibrateDirection();
                        phase = 1;
                    }
                }
            }
            break;

        // Drop down
        case 1:
        moveTimer-=1;
        if (moveTimer <= 0)
        {
            image_index = 3;
            grav = 0.25;
            if (ground)
            {
                playSFX(sfxWaveManPipe);
                image_index = 4;
                phase = 2;
            }
        }
        break;

        // On ground
        case 2:
            image_index += imgSpd;
            if (image_index == 9)
            {
                image_index = 10;
            }
            if (image_index == 12)
            {
                xspeed = 2 * image_xscale;
                yspeed = -5;
                phase = 3;
                moveTimer = 30;
            }
            calibrateDirection();
            break;

        // Land from jump
        case 3:
            if (yspeed > 0)
            {
                image_index = 4;
            }
            if (ground)
            {
                xspeed = 0;
                if (sprite_index != sprShaboanLand)
                {
                    sprite_index = sprShaboanLand;
                    image_index = 0;
                    playSFX(sfxWaveManPipe);
                }
                if (image_index < 6)
                {
                    image_index += imgSpd;
                }
                else
                {
                    moveTimer-=1;
                    if (moveTimer <= 0)
                    {
                        sprite_index = sprShaboan;
                        image_index = 6;
                        phase = 4;
                        moveTimer = 120;
                    }
                }
            }
            break;
        // Remain idle
        case 4:
            image_index += imgSpd;
            if (instance_exists(target))
            {
                if ((target.x > x + 85) || (target.x < x - 85))
                {
                    moveTimer-=1;
                    if (moveTimer > 0)
                    {
                        if (image_index >= 8)
                        {
                            image_index = 6;
                        }
                    }
                    else
                    {
                        image_index = 9;
                        moveTimer = 30;
                        phase = 5;
                    }
                }
                else
                {
                    phase = 2;
                }
            }
            // Do idle animation if Mega Man is dead
            else
            {
                moveTimer-=1;
                if (moveTimer > 0)
                {
                    if (image_index >= 8)
                    {
                        image_index = 6;
                    }
                }
                else
                {
                    image_index = 9;
                    moveTimer = 30;
                    phase = 5;
                }
            }
            break;
        // Blink Once
        case 5:
            if (instance_exists(target))
            {
                if ((target.x > x + 100) || (target.x < x - 100))
                {
                    if (canBlink == true)
                    {
                        image_index += imgSpd;
                        if (image_index >= 10)
                        {
                            image_index = 8;
                        }
                    }
                    if (blinkCount < 2)
                    {
                        if (image_index == 8)
                        {
                            blinkCount+=1;
                        }
                    }
                    else
                    {
                        canBlink = false;
                        moveTimer-=1;
                        if (moveTimer == 0)
                        {
                            phase = 6;
                        }
                    }
                }
                else
                {
                    image_index = 10;
                    blinkCount = 0;
                    canBlink = true;
                    phase = 2;
                }
            }
            break;
        case 6:
            if (instance_exists(target))
            {
                if ((target.x > x + 100) || (target.x < x - 100))
                {
                    image_index += imgSpd;
                    if (image_index >= 10)
                    {
                        image_index = 8;
                        blinkCount+=1;
                    }

                    if (blinkCount == 3)
                    {
                        if (image_index >= 8)
                        {
                            image_index = 6;
                            phase = 4;
                            moveTimer = 120;
                            blinkCount = 0;
                            canBlink = true;
                        }
                    }
                }
                else
                {
                    image_index = 10;
                    blinkCount = 0;
                    canBlink = true;
                    phase = 2;
                }
            }
            break;
    }
}
else if (dead)
{
    healthpoints = healthpointsStart;
    grav = 0;
    phase = 0;
    xspeed = 0;
    yspeed = 0;
    moveTimer = 10;
    sprite_index = sprShaboan;
    image_index = 0;
    blinkCount = 0;
    canBlink = true;
}
