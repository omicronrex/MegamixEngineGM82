#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();

healthpointsStart = 10;
contactDamage = 6;

category = "semi bulky";

waitTimer = 0;
phase = 0;
image_speed = 0;

airDrag = 0.963;
saveXSpeed = 0;
targetX = 0;
targetY = 0;
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
        case 0: // sitting
            image_index = 0;
            if (waitTimer > 45)
                image_index = 1;
            waitTimer--;
            grav = 0.25;
            if (instance_exists(target) && waitTimer < 0)
            {
                phase = 1;
                waitTimer = 100;
            }
            break;
        case 1: // rising
            yspeed = -2;
            grav = 0;
            if (y < view_yview[0] + 4)
                phase = 2;
        case 2: // hovering
            waitTimer--;
            image_index = 2 + (waitTimer div 4) mod 2;
            if (phase == 2)
                yspeed = 0;

            // aim at target
            if (waitTimer == 8)
            {
                targetX = x;
                targetY = y;
                if (instance_exists(target))
                {
                    targetX = target.x;
                    targetY = target.y;
                }
            }
            if (waitTimer < 0)
            {
                phase = 3;

                // fling self at target
                grav = 0.25;
                var airTime = sqrt(2 * max(1 + abs(x - targetX) / 1.8, targetY - y) / grav)
                // trust calculus
                ;
                xspeed = (targetX - x) * ln(airDrag) / (power(airDrag, airTime) - 1);
                saveXSpeed = xspeed;

                // cap xspeed
            }
            break;
        case 3: // dropping
            image_index = 4 + (y div 3) mod 2;
            grav = 0.25;
            xspeed *= airDrag;
            saveXSpeed *= airDrag;
            xspeed = 0.95 * xspeed + 0.05 * saveXSpeed;
            if (ycoll)
            {
                screenShake(20, 2, 2);
                playSFX(sfxLargeClamp);
                phase = 0;
                waitTimer = 60;
                xspeed = 0;
            }
    }
}
#define Other_25
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();

waitTimer = 0;
phase = 0;
