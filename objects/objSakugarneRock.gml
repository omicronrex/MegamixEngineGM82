#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();
stopOnFlash = false;
contactDamage = 2;
xspeed = image_xscale;
yspeed = -2;
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();

if (global.frozen == false)
{
    if (ground)
    {
        instance_create(x, y, objExplosion);
        playSFX(sfxExplosion);
        instance_destroy();
    }
}
