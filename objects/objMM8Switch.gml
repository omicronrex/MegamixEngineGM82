#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();
canHit = false;

isSolid = 1;

blockCollision = 0;
grav = 0;
bubbleTimer = -1;

myFlag = 0;
inverse = false;
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();

if (!global.frozen && !dead && !global.timeStopped)
{
    if (global.flag[myFlag] == round(global.flag[myFlag])
        && !place_meeting(x, y - image_yscale, objMegaman))
        image_index = 0;
    if (place_meeting(x, y - image_yscale, objMegaman)
        && image_index == 0)
    {
        global.flagParent[myFlag].active = 1 - global.flagParent[myFlag].active;
        playSFX(sfxSidewayElevatorButton);
        image_index = 1;
    }
}
