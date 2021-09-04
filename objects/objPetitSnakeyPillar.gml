#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
//// Use with Snakey, when Snakey dies it will destroy causing a chain reaction
event_inherited();

healthpoints = 1;
healthpointsStart = healthpoints;

grav = 0;

canHit = false;

isSolid = 1;
blockCollision = 0;
bubbleTimer = -1;

contactDamage = 0;

alarmTime = -1;
inWater = -1;

stopOnFlash = false;

respawnRange = 90000; // set to -1 to make infinite
despawnRange = -1; // set to -1 to make infinite

dir = 1;
#define Other_20
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
instance_create(bboxGetXCenter(), bboxGetYCenter(), objExplosion);

dead = 1;
alarmTime = 0;
