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
isTargetable = false;

despawnRange = 64;

phase = 0;
phaseTimer = 0;
animTimer = 0;
image_speed = 0;
image_index = 0;
grav = 0;
blockCollision = 0;

// distance from starting point cutter orbits
radius = 38;

// number of frames per revolution
period = 90;

dir = -1;
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();

if (entityCanStep())
{
    phaseTimer+=1;
    calibrateDirection();
    switch (phase)
    {
        case 0: // wait
            xspeed = 0;
            yspeed = 0;
            image_index = 1;
            if (instance_exists(target))
                if (point_distance(x, y, target.x, target.y) < 64)
                {
                    phase = 1;
                    phaseTimer = 0;
                    dir = image_xscale;
                }
            break;
        case 1: // lunge
            var p; p = (phaseTimer / 28) * 0.7 + 0.15;
            var desDst; desDst = radius * (-0.5 * cos(p * pi) + 0.5)
                ;
            var desX; desX = xstart + dir * desDst
                ;
            xspeed = desX - x;
            if (abs(p - 0.5) < 0.2)
                image_index = 2;
            else
                image_index = 0;

            // begin circling:
            if (p >= 0.85)
            {
                phase = 2;
                animTimer = 0;
                phaseTimer = 0;
            }
            break;
        case 2: // circle
        // motion is discontinuous and defies all sense.
            xspeed = 0;
            yspeed = 0;
            phaseTimer -= floorTo(phaseTimer, period);
            var theta; theta = pi * 2 * roundTo(phaseTimer / period, 1 / 16);
            x = xstart + radius * cos(theta) * dir;
            y = ystart - radius * sin(theta);
            animTimer = (animTimer + 1) mod 24;
            var animTable; animTable = makeArray(1, 0, 2, 0)
                ;
            image_index = animTable[animTimer div 6];
    }
}
#define Other_21
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
other.guardCancel = true;
#define Other_25
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();

phase = 0;
phaseTimer = 0;
