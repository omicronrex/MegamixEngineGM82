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
contactDamage = 3;

isTargetable = false;

facePlayerOnSpawn = true;

// Enemy specific code
xspeed = 0;
yspeed = 0;

image_speed = 0;
image_index = 0;
grav = 0;

hitByBear = false;
parent = noone;
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();

if (entityCanStep())
{
    if (image_index < 2) // form
    {
        image_index += 0.125;
    }
    else
    {
        grav = 0.15;
    }

    if (xspeed == 0 && yspeed == 0 && ground && hitByBear)
    {
        xspeed = 1.5 * image_xscale;
    }

    if (xcoll != 0 || !instance_exists(parent) && !hitByBear)
    {
        event_user(EV_DEATH);
    }
}
else if (dead)
{
    xspeed = 0;
    yspeed = 0;
    image_index = 0;
}
#define Other_20
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
instance_create(x, y, objExplosion);
if (hitByBear)
{
    playSFX(sfxEnemyHit);
}
instance_destroy();
#define Other_21
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
other.guardCancel = 3;
