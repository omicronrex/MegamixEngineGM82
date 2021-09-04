#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
// An enemy infamous for being pretty annoying. It'll erratically try to home in on Mega
// Man, and it moves very quickly. Luckily, it has only 1 HP.

event_inherited();

healthpointsStart = 1;
healthpoints = healthpointsStart;
contactDamage = 3;

category = "cluster, flying";

blockCollision = 0;
grav = 0;

facePlayerOnSpawn = true;

// Enemy specific code
image_speed = 0.25;

timer = 0;
phase = 1;

//@cc 0 = green (default); 1 = blue
col = 0;
init = 1;
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
// Set color on spawn
if (init)
{
    init = 0;
    switch (col)
    {
        case 0:
            sprite_index = sprBlader;
            break;
        case 1:
            sprite_index = sprBladerBlue;
            break;
    }
}

event_inherited();

if (entityCanStep())
{
    image_speed = 0.25;
    timer++;
    switch (phase)
    {
        case 1: // Look for target
            xspeed = 1.5 * image_xscale;
            if (target && timer >= 30)
            {
                if (abs(target.x - x) < 48 && yspeed == 0 && round(target.y) != round(y))
                {
                    xspeed = (target.x - x) / 24;
                    yspeed = (target.y - y) / 24;
                    targetY = target.y;
                    phase = 2;
                    calibrateDirection();
                }
            }
            break;
        case 2: // Swoop at target
            yspeed += 0.025 * sign(yspeed);
            xspeed += 0.025 * sign(xspeed);
            if (sign(y - targetY) == sign(yspeed))
            {
                phase = 3;
                yspeed = -yspeed;
            }
            break;
        case 3: // Move back to original height
            yspeed -= 0.025 * sign(yspeed);
            xspeed -= 0.025 * sign(xspeed);
            if (sign(y - ystart) == sign(yspeed))
            {
                timer = 0;
                phase = 1;
                xspeed = 0;
                yspeed = 0;
                shiftObject(0, ystart - y, blockCollision);
                cooldown = 30;
                calibrateDirection();
            }
            break;
    }
}
else
{
    image_speed = 0;
}
#define Other_25
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
/// On spawn
event_inherited();

timer = 0;
phase = 1;
