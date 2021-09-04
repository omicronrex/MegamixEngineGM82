#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();

grav = 0;

stopOnFlash = false;

contactDamage = 4;
delayContact = 24;
xspeed = 0;
yspeed = 0;

image_speed = 0;
image_index = 0;

parent = noone;

reflectable = 0;
timer = 360;
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();

if (global.frozen == false)
{
    timer -= 1;
    if (timer < 0)
    {
        instance_destroy();
        exit;
    }
    delayContact-=1;
    if (xcoll != 0 || place_meeting(x - 4 * image_xscale, y, objMegaman) && delayContact <= 0)
    {
        xspeed = 0;
        with (parent)
        {
            phase = 3;
        }
        grav = 0.25;
        image_index = 2;
    }
}
#define Draw_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if (timer > 60 || (timer < 60 && (timer mod 4 == 0)))
    event_inherited();
