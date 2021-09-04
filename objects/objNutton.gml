#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();

healthpointsStart = 1;
healthpoints = healthpointsStart;
contactDamage = 0;

canHit = true;
blockCollision = 0;
grav = 0;

respawn = false;
inWater = -1;

contactDamage = 2;

// specific code
xspeed = 0;
yspeed = 0;
image_speed = 0.1;

reflectable = 1;

despawnRange = -1;
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();

if (!global.frozen && !global.timeStopped)
{
    xspeed = 3.3 * image_xscale;
}
#define Other_21
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
other.guardCancel = 3;
