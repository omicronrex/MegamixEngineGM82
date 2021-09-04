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
contactDamage = 2;

blockCollision = 0;

// enemy specific
lands = 0;

yspeed = -4; // <-- initial throwing arc

calibrateDirection();
