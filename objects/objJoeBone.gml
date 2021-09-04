#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();

blockCollision = 0;

contactDamage = 2;
image_speed = 1 / 6;

yspeed = -6;

if (instance_exists(target))
{
    xspeed = xSpeedAim(x, y, target.x, target.y, yspeed, grav);
}
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();

if (global.timeStopped)
{
    instance_create(x, y, objExplosion);
    playSFX(sfxEnemyHit);
    instance_destroy();
}
