#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();

healthpointsStart = 1;
healthpoints = healthpointsStart;
contactDamage = 4;
stopOnFlash = false;
blockCollision = 1;
grav = 0.25;

// Enemy specific code
yspeed = -6;
collectMe = false;
shotsFired = 0;
attackTimer = 0;

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
    if (place_meeting(x, y, objBombMan) && yspeed > 0 && collectMe)
        instance_destroy();
    if (ground)
    {
        playSFX(sfxClassicExplosion);
        for (var i = 0; i < 8; i += 1)
        {
            with (instance_create(x, y, objBombManBlast))
            {
                dir = 45 * i;
                spd = 1.75;
            }
            if (i mod 2 == 0)
            {
                with (instance_create(x, y, objBombManBlast))
                {
                    dir = 45 * i;
                    spd = 1;
                }
            }
        }
        instance_destroy();
    }
}
