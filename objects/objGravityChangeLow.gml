#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();
canHit = false;

gravMultiplier = 0.4;
image_speed = 0.25;

blink = 0;

blockCollision = 0;
grav = 0;
bubbleTimer = -1;

shiftVisible = 1;
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_perform_object(objGravityChangeNormal, ev_step, ev_step_normal);
