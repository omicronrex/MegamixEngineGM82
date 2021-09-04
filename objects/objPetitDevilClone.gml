#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
// Creation code (all optional):
// angle = 0/90/180/270

event_inherited();

respawn = false;

healthpointsStart = 1;
healthpoints = healthpointsStart;

itemDrop = 0;

blockCollision = 0;
grav = 0;

floatTimer = 0;
init = 0;
canStep = false;
moveDir = 1;
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();

// initialization
if (init == 0)
{
    // Set the correct color
    absSpeed = 3;
    canStep = true;

    init = 1;
}

if (entityCanStep())
{
    calibrateDirection();

    // Blinking
    blinkTimer += 1;
    switch (blinkTimer)
    {
        case 110:
            image_index = 1;
            break;
        case 113:
            image_index = 2;
            break;
        case 116:
            image_index = 1;
            break;
        case 119:
            image_index = 0;
            break;
        case 140:
            image_index = 1;
            break;
        case 143:
            image_index = 2;
            break;
        case 146:
            image_index = 1;
            break;
        case 149:
            image_index = 0;
            blinkTimer = 0;
            break;
    }

    // Movement
    if (absSpeed > 0)
    {
        absSpeed -= 0.1;
        xspeed = cos(degtorad(angle)) * absSpeed * moveDir;
        yspeed = -sin(degtorad(angle)) * absSpeed;
    }
    else
        absSpeed = 0;

    // Floating
    floatTimer += 1;
    if (floatTimer >= 70)
    {
        if (floatTimer == 70)
        {
            refY = y;
            yspeed = -0.11;
        }

        if (y < refY)
            yspeed += 0.005;
        else if (y > refY)
            yspeed -= 0.005;
    }
}
