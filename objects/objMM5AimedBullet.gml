#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();

blockCollision = 0;
grav = 0;
spd = 1.5;

//@cc
dir = 0;
contactDamage = 3;
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();

if (!global.frozen && !global.timeStopped)
{
    xspeed = cos(degtorad(dir)) * spd;
    yspeed = -sin(degtorad(dir))
        * spd; // The vertical speed was, for some reason, inverted, which is why I used a minus. Don't ask me what actually caused this behaviour
}
