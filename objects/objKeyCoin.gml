#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
/// A collectable item that makes a key once 5 are collected
event_inherited();

image_speed = 0.2;
grabable = 0;

respawnupondeath = true;

grav = 0;
blockCollision = 0;

alarm[8] = 1;
#define Alarm_8
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
global.keyCoinTotal += 1;
#define Other_10
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
global.keyCoinCollected += 1;

if (global.keyCoinCollected == global.keyCoinTotal)
{
    i = instance_create(spriteGetXCenter() - 8, spriteGetYCenter() - 8,
        objKey);
    i.yspeed = -4;
    i.homingTimer = 90;
    playSFX(sfxKeySpawn);
}

instance_destroy();
instance_create(bboxGetXCenter(), bboxGetYCenter(), objExplosion);
playSFX(sfxBolt);
