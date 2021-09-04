#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();

calibrateDirection();

healthpointsStart = 1;
healthpoints = healthpointsStart;
contactDamage = 2;

canHit = true;

facePlayerOnSpawn = true;

// enemy specific
yspeed = -4;

setTargetStep(); // this one isnt prtEnemyProjectile so, gotta do this here lol
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

if (entityCanStep())
{
    if (ground)
    {
        instance_create(x, y, objExplosion);
        instance_destroy();
    }
}
