#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();
respawn = false;
healthpointsStart = 1;
healthpoints = healthpointsStart;
contactDamage = 0;
canHit = false;
blockCollision = 0;
grav = 0.25;

// Enemy specific code
yspeed = -5 - random(3);
xspeed = -4 + random(8);
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();
image_index += 0.35;
