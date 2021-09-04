#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();

image_index = irandom(image_number - 1);

xspeed = 0;
yspeed = -3;
grav = 0.2;
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if (!global.frozen && !global.timeStopped)
{
    x += xspeed;
    y += yspeed;
    yspeed += grav;
}
