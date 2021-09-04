#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();

respawn = true;

healthpointsStart = 3;
healthpoints = healthpointsStart;
contactDamage = 3;
category = "aquatic, nature";

// Enemy specific code
image_speed = 0;
phaseTimer = 0;
phase = 0; // 0: in shell, 1: popping out, 2: out, 3: retracting
shootTimer = -1;
waitTimer = -1;
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if (entityCanStep())
    image_index = 0;

event_inherited();

if (entityCanStep())
{
    phaseTimer += 1;
    switch (phase)
    {
        case 0: // retracted
            image_index = 0;
            if (waitTimer > 0)
                waitTimer--;
            if (waitTimer <= 0) // pop out if mega man comes near
                with (objMegaman)
                    if (point_distance(x, y, other.x, other.y) < 64)
                    {
                        other.target = id;
                        other.phase = 1;
                        other.phaseTimer = 0;
                        with (other)
                            calibrateDirection();
                    }
            break;
        case 1: // emerging
            image_index = floor(phaseTimer * 15 / 60);
            if (image_index >= 4)
            {
                phase = 2;
                phaseTimer = 0;
                shootTimer = -1;
            }
            else
                break;
        case 2: // emerged
            image_index = 4 + (phaseTimer div 10) mod 2;

            // shoot
            if (phaseTimer == 30)
            {
                shootTimer = 0;
                with (instance_create(x + 16 * image_xscale, y - 8, objOctoneInkball))
                {
                    yspeed = -2;
                    xspeed = 4 * other.image_xscale;
                    if (instance_exists(target))
                    {
                        if (abs(target.x - x) < 140)
                        {
                            xspeed = floor((target.x - x)) / 20;
                            if (abs(target.x - other.x) < 18)
                                xspeed = other.image_xscale / 2;
                        }
                        else
                            xspeed = other.image_xscale * 140 / 20;
                    }
                }
            }
            if (shootTimer >= 0 && shootTimer <= 10)
            {
                shootTimer += 1;
                image_index = 6;
            }
            if (phaseTimer >= 60)
            {
                phase = 3;
                phaseTimer = 0;
            }
            else
                break;
        case 3: // retract
            image_index = 4 - (floor(phaseTimer * 15 / 60));
            waitTimer = 40;
            if (image_index <= 0)
                phase = 0;
            break;
    }
}
else if (dead)
{
    phase = 0;
    waitTimer = -1;
}
#define Other_21
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if (other.penetrate >= 1 && image_index < 2)
    exit;

// reflect bullets
if (collision_rectangle(x - 16, y - 3,
    x + 16, y + 17, other.id, false, false))
{
    other.guardCancel = 1;
    if (phase == 0)
    {
        phase = 1;
        phaseTimer = 0;
        calibrateDirection();
    }
}
else if (collision_rectangle(x - 32, y - 3,
    x + 32, y + 17, other.id, false, false))
{
    // bullets pass through tentacles
    other.guardCancel = 2;
}
