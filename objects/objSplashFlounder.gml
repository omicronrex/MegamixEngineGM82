#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();
calibrateDirection();
respawn = true;
stopOnFlash = false;
healthpointsStart = 1;
healthpoints = healthpointsStart;
contactDamage = 3;

despawnRange = -1;

blockCollision = 0;
grav = 0;

// Enemy specific code
xspeed = 0;
yspeed = 0;
image_speed = 0;
image_index = 0;
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();

if (entityCanStep())
{
    if (xspeed == 0)
        xspeed = 4 * image_xscale;


    image_index += 0.25;

    if (image_xscale == -1 && x < view_xview)
        despawnRange = 32;
    if (image_xscale == 1 && x > view_xview + view_wview)
        despawnRange = 32;

    if (!instance_exists(objSplashWoman))
    {
        instance_create(spriteGetXCenter(), spriteGetYCenter(),
            objExplosion);
        instance_destroy();
    }
}
else if (dead == true)
{
    calibrateDirection();
    xspeed = 0;
    yspeed = 0;
    image_index = 0;
}
if ((global.timeStopped == true && !insideView())
    || (!instance_exists(objSplashWoman)))
    instance_destroy();
#define Other_20
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=605
invert=0
arg0=create debry upon death
*/
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
dead = 1;

var ID;
ID = instance_create(spriteGetXCenter(), spriteGetYCenter(), objExplosion);
{
    ID.xscale = image_xscale;
}
