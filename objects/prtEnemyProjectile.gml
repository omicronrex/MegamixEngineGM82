#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
// This is kept because it'd be pretty heckin annoying to have to copy in everything below
// for every new prtEntity object that you want to be a projectile...
event_inherited();
respawn = false;
despawnRange = 64;
inWater = -1;
canHit = false;

// how the projectile interacts with shields.
// 0: cannot be stopped.
// 1: can be reflected.
// -1: instead of reflecting, is destroyed.
reflectable = 1;

// for legacy support reasons, projectiles need to access target in the create
// event. Most entities are barred from doing this at room create time.
// However, projectiles are not made at room create time, so it's acceptable
// to do this.
// In general: do not access target in the create event!
setTargetStep();
#define Other_20
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
dead = 1;
visible = false;
