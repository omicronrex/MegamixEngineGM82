#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();

contactDamage = 6;
grav = 0;
blockCollision = false;
reflectable = false;
stopOnFlash = false;

calibrateDirection();

var spd;
spd = 5;

aimAtTarget(5);
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();
if (!global.frozen)
    image_index += 0.15;
