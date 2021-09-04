#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();

calibrateDirection();

respawn = false;

healthpointsStart = 1;
healthpoints = healthpointsStart;
contactDamage = 2;
contactStart = contactDamage;
grav = 0.15;
ground = false;

// Enemy specific code
xspeed = image_xscale * 4;
yspeed = -5;

image_speed = 0.3;
image_index = 0;

canHit = false;
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
        playSFX(sfxExplosion2);
        instance_create(x, y, objHarmfulExplosion);
        instance_destroy();
    }
}
