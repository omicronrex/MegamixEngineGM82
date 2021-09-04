#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
/// Spawns [objTadpole](objTadpole.html) when is shot
event_inherited();

isSpawned = false;
blockCollision = false;
inWater = -1;
#define Other_20
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();

i = instance_create(x + 8, y + 8, objTadpole);
i.respawn = false;
#define Other_23
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
specialDamageValue(objBlackHoleBomb, 0);
specialDamageValue(objTornadoBlow, 0);
