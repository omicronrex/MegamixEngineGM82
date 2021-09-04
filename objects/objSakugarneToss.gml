#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();

contactDamage = 4;

ground = false;

stopOnFlash = false;

grav = gravAccel;
blockCollision = 1;
dieToSpikes = 1;

sinkin = 1;
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
        playSFX(sfxLargeClamp);
        yspeed = -abs(5);
        image_index = 1;
    }

    if (place_meeting(x, y, objQuint) && yspeed <= 0)
    {
        instance_destroy();
    }
}
if (instance_exists(objQuint))
{
    if (objQuint.dead)
    {
        instance_create(x, y, objExplosion);
        instance_destroy();
    }
}
else
{
    instance_create(x, y, objExplosion);
    instance_destroy();
}
#define Other_21
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
other.guardCancel = 3;
