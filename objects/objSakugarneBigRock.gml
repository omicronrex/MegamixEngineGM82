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
yspeed = -4;
contactDamage = 6;
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
        for (i = -1; i <= 1; i += 1)
            if (i != 0)
            {
                rock = instance_create(x, y - 8, objSakugarneRock);
                rock.yspeed = -abs(i) * 4;
                rock.xspeed = i;
            }
    }
}
