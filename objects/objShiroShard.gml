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
blockCollision = false;

// Enemy specific code
xspeed = 0;
yspeed = 0;

image_speed = 0;
image_index = 0;
grav = 0;

attackTimer = 0;

instance_create(x, y, objExplosion);
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();

if (entityCanStep())
{
    attackTimer++;

    if (attackTimer >= 8)
    {
        grav = 0.16;
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
instance_destroy();
#define Other_21
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
other.guardCancel = 3;
