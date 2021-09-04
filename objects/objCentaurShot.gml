#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();

stopOnFlash = false;

grav = 0;

contactDamage = 4;

xspeed = 0;
yspeed = 0;


reflectable = 0;
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();

if (global.frozen == false)
{
    if (xcoll != 0)
    {
        playSFX(sfxEnemyShoot);
        var i;
        for (i = 0; i <= 8; i += 1)
        {
            cS = instance_create(x, y, objCentaurSecondaryBullet);
            cS.dir = 90 + (22.5 * i);
            cS.image_xscale = image_xscale;
            cS.xscale = cS.image_xscale;
            cS.contactDamage = 4;
            cS.reflectable = 0;
        }
        instance_destroy();
    }
}
