#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();

healthpointsStart = 1;
healthpoints = healthpointsStart;
contactDamage = 2;
contactStart = contactDamage;

// Enemy specific code
xspeed = image_xscale * 4;
yspeed = -3;

if (instance_exists(target))
{
    xspeed = xSpeedAim(x, y, target.x, target.y, yspeed, grav);
}

image_speed = 0.3;

calibrateDirection();
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();

if (entityCanStep())
{
    if (ground)
    {
        instance_create(x, y, objHarmfulExplosion);
        playSFX(sfxExplosion2);
        instance_destroy();
    }
}
