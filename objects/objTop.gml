#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();

respawn = false;

healthpointsStart = 1;
healthpoints = healthpointsStart;
contactDamage = 2;

// Enemy specific code
xspeed = -1.5 * image_xscale;
image_speed = 0.15;

alarmDie = 360;
xs = xspeed;
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();

if (xspeed != 0)
{
    xs = xspeed;
}


if (entityCanStep())
{
    image_speed = 0.15;
    xSpeedTurnaround();

    if (ground)
    {
        xspeed = abs(xs) * image_xscale;
    }
    else
    {
        xspeed = 0;
    }

    if (alarmDie)
    {
        alarmDie -= 1;
        if (!alarmDie)
        {
            instance_create(x, y, objExplosion);
            instance_destroy();
        }
    }
}
else
{
    image_speed = 0;
}
#define Other_20
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
dead = 1;

instance_create(bboxGetXCenter(), bboxGetYCenter() - 4, objExplosion);
#define Other_25
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
/// On spawn/Despawn
event_inherited();
if (spawned)
{
    calibrateDirection();
    image_index = 0;
}
