#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();
canHit = false;
grav = 0;
isSolid = 2;
test = 0;
resetDelay = 32;
delayTimer = resetDelay;
distanceTimer = 0;
storeDir = image_xscale;

knuckleDusterPlatform = true;
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();
#define Other_20
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
dead = true;
#define Draw_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
var xs; xs = image_xscale;
image_xscale = 1;
event_inherited();
image_xscale = xs;
