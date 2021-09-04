#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();
grav = 0.135;
yspeed = 0.65;
contactDamage = 5;
blockCollision = 0;
ground = 0;
maxYspeed = 6.5;
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();
if (entityCanStep())
{
    if (abs(yspeed) > maxYspeed)
        yspeed = maxYspeed * sign(yspeed);
}
