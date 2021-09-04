#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();

contactDamage = 3;

megaX = -1000;

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

if (!global.frozen && !global.timeStopped)
{
    if (ground)
    {
        explosion = instance_create(x, y, objExplosion);
        playSFX(sfxEnemyHit);

        instance_destroy();
    }

    if (megaX > -1000)
    {
        x = view_xview + megaX;
    }
}
