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

contactDamage = 4;
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();

if (!global.frozen && !global.timeStopped)
{
    xspeed = cos(degtorad(dir)) * spd * image_xscale;
    yspeed = -sin(degtorad(dir))
        * spd; // The vertical speed was, for some reason, inverted, which is why I used a minus. Don't ask me what actually caused this behaviour
}
