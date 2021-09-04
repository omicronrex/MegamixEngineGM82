#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
/*
    Causes the camera to shake up and down periodically,
    as in Charge Man's stage (mm5)
*/

//@cc vertical offset in each state
shakeVertical = makeArray(0, -1);

//@cc horizontal offset in each state
shakeHorizontal = makeArray(0, 0);

//@cc time to spend in each state
shakeTime = makeArray(72, 24);

//@cc should shift only tiles instead of everything?
onlyShiftTiles = true;


init = false;
timer = 0;
cachedShakeV = 0;
cachedShakeH = 0;
#define Step_2
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
var tmpTimer; tmpTimer = timer;
var i;
for (i = 0; i < array_length_1d(shakeTime); i+=1)
{
    tmpTimer -= shakeTime[i];
    if (tmpTimer <= 0)
    {
        cachedShakeV = -shakeVertical[i];
        cachedShakeH = -shakeHorizontal[i];
        if (!audio_is_playing(sfxTrainBump))
        {
            playSFX(sfxTrainBump);
        }
        break;
    }
}

if (!global.frozen && !global.timeStopped)
{
    timer+=1;
    if (i == array_length_1d(shakeTime))
    {
        timer = 0;
    }
}
#define Other_10
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
/// adjust camera
view_xview[0] += cachedShakeH;
view_yview[0] += cachedShakeV;
#define Draw_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
/// [re]set camera for shift layer mode

if (onlyShiftTiles)
{
    d3d_set_projection_ortho(view_xview[0] - cachedShakeH, view_yview[0] - cachedShakeV, view_wview[0], view_hview[0], 0);
    view_xview[0] -= cachedShakeH;
    view_yview[0] -= cachedShakeV;
}
