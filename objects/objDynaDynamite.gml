#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();

grav = 0;
contactDamage = 4;
reflectable = 0;
image_speed = 1 / 6;

stopOnFlash = false;

collectMe = false;
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();

if (!global.frozen)
{
    if (collectMe)
    {
        if (image_index < 2)
        {
            image_index = 2;
        }
        if (place_meeting(x, y, objDynaMan) && yspeed > 0)
        {
            instance_destroy();
        }
    }
    else
    {
        if (image_index > 1)
        {
            image_index = 0;
        }
        if (xcoll != 0 || ycoll != 0)
        {
            expl = instance_create(x, y, objHarmfulExplosion);
            expl.contactDamage = 4;
            expl.stopOnFlash = false;
            playSFX(sfxExplosion);
            instance_destroy();
        }
    }
}
