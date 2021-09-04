#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();

usePlayerColor = 1;

hlth = 10;
#define Other_10
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
instance_destroy();

global.bolts = min(9999, global.bolts + hlth);

playSFX(sfxBolt);
