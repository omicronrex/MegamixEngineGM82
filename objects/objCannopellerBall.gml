#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();

// calibrateDirection();

respawn = false;

healthpointsStart = 1;
healthpoints = healthpointsStart;
contactDamage = 2;
grav = 0;

// enemy specific
phase = 0;
xspeed = 0;
dropTimer = 16;

image_speed = 0;
image_index = 0;
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();

if (entityCanStep())
{
    if (dropTimer > 0)
    {
        dropTimer -= 1;
    }
    else
    {
        grav = 0.085;
    }

    if (ground || xspeed == 0)
    {
        playSFX(sfxExplosion2);
        explosion = instance_create(x, y, objHarmfulExplosion);
        explosion.contactDamage = contactDamage;
        instance_destroy();
    }
}
