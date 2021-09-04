#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();

contactDamage = 4;
stopOnFlash = false;

// enemy specific
xspeed = 0;
yspeed = 0;

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
    if (ground)
    {
        instance_create(x, y, objExplosion);
        instance_create(x, y + 5, objHoneyPuddle);
        playSFX(sfxEnemyHit);

        instance_destroy();
    }
}
