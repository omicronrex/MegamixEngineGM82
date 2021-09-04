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
    if (xspeed == 0 && yspeed == 0)
    {
        xspeed = cos(degtorad(dir)) * 1 * xscale;
        yspeed = -sin(degtorad(dir))
            * 1.5; // The vertical speed was, for some reason, inverted, which is why I used a minus. Don't ask me what actually caused this behaviour
    }
}
