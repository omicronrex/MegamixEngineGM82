#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();

xspeed = 0;
yspeed = 0;
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if (!global.frozen)
{
    yspeed += gravAccel;
    if (yspeed >= 7)
    {
        yspeed = 7;
    }

    x += xspeed;
    y += yspeed;
}
