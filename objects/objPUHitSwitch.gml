#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();

isSolid = 1;

blockCollision = 0;
grav = 0;
bubbleTimer = -1;

myFlag = 999;
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();

if (!global.frozen && !dead && !global.timeStopped)
{
    if (hitTimer > 8)
    {
        image_index = global.flagParent[myFlag].active;
    }
}
#define Other_21
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
other.guardCancel = 3;

if (image_index != 2)
{
    hitTimer = 0;
    global.flagParent[myFlag].active = 1 - global.flagParent[myFlag].active;
    playSFX(sfxSidewayElevatorButton);
    image_index = 2;
}
