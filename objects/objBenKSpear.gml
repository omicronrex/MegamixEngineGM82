#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();

blockCollision = false;
contactDamage = 2;

grav = 0;
iFrames = 0;
reflectable = 0;

isTargetable = false;

// specific code
shootTimer = 0;
shotCharge = 0;

image_speed = 0.4;

xSpd = 2;
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();

if (!global.frozen && !global.timeStopped)
{
    xspeed = xSpd * image_xscale;
}
#define Other_21
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
other.guardCancel = 3;
