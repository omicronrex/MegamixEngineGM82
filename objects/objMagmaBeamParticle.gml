#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();

dir = -1;
grav = 0.05;
yspeed = -2;
startYspeed = yspeed;
init = 1;

image_speed = 0.3;
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if (!global.frozen)
{
    x += dir * 0.2;
    yspeed += grav;
    y += yspeed;
    image_xscale = dir;
}
#define Step_1
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if (init)
{
    startYspeed = yspeed;
    init = 0;
}
#define Other_7
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
instance_destroy();
