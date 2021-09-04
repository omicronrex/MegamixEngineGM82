#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();

blockCollision = 0;
grav = 0;

contactDamage = 2;
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();

if (!global.frozen && !global.timeStopped)
{
    if (dir == 0)
    {
        xspeed = cos(degtorad(dir)) * 1.5 * xscale;
        yspeed = 0;
    }

    if (dir == -45 || dir == 45)
    {
        xspeed = cos(degtorad(dir)) * 1.5 * xscale;
        yspeed = -sin(degtorad(dir)) * 1.5;
    }
}
