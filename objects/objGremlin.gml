#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
/// An angry looking robot that slowly moves towards the player.
event_inherited();

healthpointsStart = 1;
healthpoints = healthpointsStart;
contactDamage = 3;

category = "cluster";

blockCollision = 0;
grav = 0;

// Enemy specific code
alarmAnimation = -2;
alarmRise = -1;

generated = true;
alarmGenerate = -1;
alarmAnimation = 10;
gremlinDir = 1;
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();

if (entityCanStep())
{
    if (alarmGenerate > -1)
    {
        alarmGenerate -= 1;
        x += (0.33 * gremlinDir);
        if (alarmGenerate == 0)
        {
            yspeed = -3;
            alarmRise = 30;
        }
    }
    if (alarmRise > -1)
    {
        alarmRise -= 1;
        if (alarmRise == 0)
        {
            generated = true;
            alarmAnimation = 10;
            yspeed = 0;
            calibrateDirection();
            xspeed = 0.5 * image_xscale;
            image_xscale = 1;
        }
    }
    if (alarmAnimation > -1)
    {
        alarmAnimation -= 1;
        if (alarmAnimation == 0)
        {
            if (image_index == 2)
            {
                image_index = 1;
            }
            else
            {
                image_index = 2;
            }
            alarmAnimation = 10;
        }
    }

    if (instance_exists(target))
    {
        if (distance_to_object(target) <= 64 && generated)
        {
            mp_linear_step(target.x, target.y, 0.25, false);
        }
    }
}
