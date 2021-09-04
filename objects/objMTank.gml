#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();

usePlayerColor = 1;
image_speed = 0.1;

grabable = 0;
heavy = 1;
#define Other_10
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
instance_destroy();

if (global.mTanks < global.maxMTanks)
{
    global.mTanks += 1;
}
playSFX(sfxImportantItem);
