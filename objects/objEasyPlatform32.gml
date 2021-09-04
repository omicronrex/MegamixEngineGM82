#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();

image_speed = 8 / 60;

isSolid = 2;
grav = 0;
blockCollision = 0;
bubbleTimer = -1;

iFrames = -1;
canHit = false;
image_index = (x div 32) mod 2;
respawnRange = -1;
despawnRange = -1;

if (global.difficulty > DIFF_EASY)
    instance_destroy();
