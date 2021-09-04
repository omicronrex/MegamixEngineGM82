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

contactDamage = 0;
canHit = false;
blockCollision = 0;

col = 0;
grav = 0;
yspeed = 0;
xspeed = 0;

explod = false;
playSFX(sfxGlooperFire);
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();
image_index = col;
if (entityCanStep())
{ }
else if (dead == true)
{
    calibrateDirection();
    xspeed = 0;
    yspeed = 0;
    image_index = 0;
}
#define Collision_objMegaman
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if (!dead)
{
    with (other)
    {
    if (!instance_exists(objGloop))
        instance_create(x, y, objGloop);
    }
    instance_destroy();
}
