#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();
stopOnFlash = false;
blockCollision = 0;
grav = 0;

contactDamage = 5;

reflectable = 0;

laserFormed = false;

image_speed = 1 / 6;

playSFX(sfxSharkLaser);
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();

if (!global.frozen)
{
    xspeed = 4 * image_xscale;
    if (image_index <= 0)
    {
        if (laserFormed)
        {
            image_index = 1;
        }
        else
        {
            laserFormed = true;
        }
    }
}
