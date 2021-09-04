#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
// An interesting enemy. On spawn, it will float in its faced direction, and occasionally stop, pop open and
// shoot an 8-way burst of shots before closing and moving again. It is invincible when moving.

event_inherited();

healthpointsStart = 1;
healthpoints = healthpointsStart;
contactDamage = 1;

grav = 0;
blockCollision = 0;

facePlayerOnSpawn = true;

// Enemy specific code
timer = 0;
phase = 0;

bullets = 8;
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();

if (entityCanStep())
{
    timer+=1;
    switch (phase)
    {
        case 0: // Move
            xspeed = 1.25 * image_xscale;
            if (timer >= 40)
            {
                xspeed = 0;
                image_index = 1; // pop out
                timer = 0;
                phase = 1;
            }
            break;
        case 1: // Shoot the 8-way shot.
            if (timer >= 15)
            {
                playSFX(sfxEnemyShootClassic);
                var t;
                for (i = 0; i < bullets; i+=1)
                {
                    t = instance_create(x, y, objEnemyBullet);
                    t.sprite_index = sprMM1MetBullet;
                    t.contactDamage = 2;
                    t.spd = 3.75;
                    t.dir = (180 * (image_xscale < 0)) + (i * (360 / bullets));
                }
                timer = 0;
                phase = 2;
            }
            break;
        case 2: // Reset to moving
            if (timer >= 20)
            {
                image_index = 0;
                timer = -20;
                phase = 0;
            }
            break;
    }
}
else if (dead)
{
    timer = 0;
    phase = 0;
    image_index = 0;
}
#define Other_21
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
// Reflect bullets if image_index == 0 (it closed up).
if (image_index == 0)
{
    other.guardCancel = 1;
}
