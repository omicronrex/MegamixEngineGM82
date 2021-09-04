#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();
canHit = false;

blockCollision = 0;
grav = 0;
bubbleTimer = -1;

isSolid = 0;

myFlag = 0;

playedSFX = false;
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();

if (!global.frozen && !dead && !global.timeStopped)
{
    isSolid = 2 * (image_index >= 2);

    image_index = global.flag[myFlag] * (image_number - 1);

    // sfx handler
    playedSFX *= isSolid;

    if (!playedSFX && isSolid == 2)
    {
        playSFX(sfxSheepPlatform);
        playedSFX = true;
    }
}
