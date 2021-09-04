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

contactDamage = 2;
spd = 1.5;
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();

if (!global.frozen)
{
    xspeed = cos(degtorad(dir)) * spd * xscale;
    yspeed = -sin(degtorad(dir)) * spd;
}
