#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();

healthpointsStart = 3;
healthpoints = healthpointsStart;
contactDamage = 3;

canHit = true;

image_speed = 0;

yspeed = -4;
grav = 0.16;

calibrateDirection();
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
    if (xcoll != 0 || ground)
    {
        bwooooaaaaaaa = instance_create(x, y, objHarmfulExplosion);
        bwooooaaaaaaa.contactDamage = 3;
        playSFX(sfxExplosion2);
        instance_destroy();
    }
}
#define Draw_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
drawSelf();
