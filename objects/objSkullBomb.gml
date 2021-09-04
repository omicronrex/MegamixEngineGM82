#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();

contactDamage = 6;
image_speed = 0;

xspeed = 0;
yspeed = 0;
ground = false;
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();

if (global.frozen == false && global.timeStopped == false)
{
    if (ground == true)
    {
        instance_create(x, y, objExplosion);
        playSFX(sfxExplosion);
        instance_destroy();
    }
}
else
{
    image_speed = 0;
}
