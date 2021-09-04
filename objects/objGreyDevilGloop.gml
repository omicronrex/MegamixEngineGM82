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
blockCollision = 1;
grav = 0.25;
stopOnFlash = false;
yspeed = -4;
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
if (entityCanStep())
{
    if (!ground)
        image_index = 0;
    else
    {
        image_index += 0.25;
        xspeed = 0;
    }
    if (ground & image_index == 0)
        image_index = 1;
}
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
with (other)
{
    if (!instance_exists(objGloop))
    {
        with (instance_create(x, y, objGloop))
        {
            sprite_index = sprGreyDevilGloop;
            healthpointsStart = 5;
            healthpoints = healthpointsStart;
            dmg = 4;
        }
    }
}
instance_destroy();
