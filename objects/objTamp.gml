#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();

healthpointsStart = 6;
healthpoints = healthpointsStart;
contactDamage = 4;

grav = 0;
facePlayerOnSpawn = true;
category = "semi bulky";

imgSpd = 0.2;
moveTimer = 30;
warpDelay = 30;
phase = 0;
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
        case 0:
            moveTimer--;
            if (moveTimer <= 0)
            {
                yspeed = -1;

                image_index += imgSpd;
                if (image_index >= 2)
                {
                    image_index = 0;
                }

                warpDelay--;
                if (warpDelay == 0)
                {
                    yspeed = 0;
                    phase = 1;
                    warpDelay = 30;
                    moveTimer = 10;
                }
            }
            break;
        // warp out
        case 1:
            if (image_index == 0)
            {
                image_index = 2;
                canDamage = false;
                canHit = false;
                playSFX(sfxPortal);
            }
            else
            {
                image_index += imgSpd;
                if (image_index >= 5)
                {
                    image_alpha = 0;
                    phase = 2;
                }
            }
            break;

        // warp In
        case 2:
        warpDelay--;
        if (warpDelay == 0)
        {
            image_alpha = 1;
            if (instance_exists(target))
            {
                var newY = target.y - 64;
                if (!insideSection(target.x, newY))
                    newY = global.sectionTop + 8;
                shiftObject(0, newY - y, true);
                shiftObject(target.x - x, 0, true);
            }
            canDamage = true;
            canHit = true;
        }
        if (warpDelay < 0)
        {
            image_index -= imgSpd;
            calibrateDirection();

            if (image_index == 2)
            {
                image_index = 0;
                phase = 3;
                warpDelay = 4; // Reusing warpDelay as a timer for next phase
            }
        }
        break;
    case 3:
        moveTimer--;
        if (moveTimer <= 0)
        {
            yspeed = 3;
            if (ground)
            {
                warpDelay--;
                if (warpDelay > 0)
                {
                    image_index = 5;
                }
                else
                {
                    playSFX(sfxHeavyLand);
                    phase = 0;
                    image_index = 0;
                    moveTimer = 30;
                    warpDelay = 30;
                    canAnimate = true;
                }
            }
        }
        break;
    }
}
#define Other_25
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
healthpoints = healthpointsStart;
image_index = 0;
yspeed = 0;
canDamage = true;
canHit = true;
moveTimer = 30;
warpDelay = 30;
image_alpha = 1;
