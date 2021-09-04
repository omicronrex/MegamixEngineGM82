#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();

/// The OG Bat enemy, will stay covered for a randomized amount of time and will slowly follow the player,
// once he's able to deal damage, he will fly up to the ceiling and cove himself again

healthpointsStart = 2;
healthpoints = healthpointsStart;
contactDamage = 4;

category = "cluster, flying, nature";

// Enemy specific code
alarmChange = 0;
animTimer = 0;
started = 0;

grav = 0;
blockCollision = 0;
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();

if (entityCanStep())
{
    if (instance_exists(target))
    {
        started = 1;
    }

    if (started)
    {
        if (alarmChange > 0)
        {
            alarmChange -= 1;
        }
    }

    if (alarmChange == 60 || alarmChange == 56 || alarmChange == 52
        || alarmChange == 48)
    {
        image_index += 1;
    }
    if (alarmChange == 44)
    {
        yspeed = 0.5;
    }

    if (alarmChange == 0)
    {
        yspeed = 0;
        if (instance_exists(target))
        {
            mp_linear_step(target.x, target.y + 18, 0.5, false);
        }
        else
        {
            mp_linear_step(x, y - 10, 0.5, false);
        }
    }

    if (alarmChange < 44)
    {
        animTimer += 1;
        if (animTimer == 4)
        {
            animTimer = 0;
            if (image_index == 3)
            {
                image_index = 4;
            }
            else if (image_index == 4)
            {
                image_index = 5;
            }
            else
            {
                image_index = 3;
            }
        }
    }
}
#define Other_21
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if (image_index == 0)
{
    other.guardCancel = 1;
}
#define Other_25
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
/// On spawn
event_inherited();
alarmChange = irandom_range(120, 220);
image_index = 0;
animTimer = 0;
started = 0;
