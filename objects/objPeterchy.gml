#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
/// An enemy that continuously walks forward to attack, always facing the player.

event_inherited();

healthpointsStart = 3;
healthpoints = healthpointsStart;
contactDamage = 4;

category = "grounded";

facePlayerOnSpawn = true;

// Enemy specific code
turnTimer = 0;

image_speed = 12 / 60;
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();

if (entityCanStep())
{
    if (xcoll != 0)
    {
        image_xscale *= -1; // Turn around at walls
    }

    turnTimer += 1;
    if (turnTimer >= 20)
    {
        turnTimer = 0;
        if (instance_exists(target))
        {
            if (x > target.x + 48)
            {
                image_xscale = -1;
            }
            else if (x < target.x - 48)
            {
                image_xscale = 1;
            }
        }
    }

    xspeed = image_xscale * 0.5;
}
else if (dead)
{
    image_index = 0;
}
