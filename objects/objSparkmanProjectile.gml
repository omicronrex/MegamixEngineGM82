#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();
blockCollision = 0;
grav = 0;
contactDamage = 4;
dir = 0;
stopOnFlash = false;
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();
if (!global.frozen)
{
    xspeed = cos(degtorad(dir)) * 2 * image_xscale;
    yspeed = -sin(degtorad(dir)) * 2;
    image_index += 0.25;
}
