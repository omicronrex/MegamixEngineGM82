#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
animationTimer = 0;
timeStopLock = playerTimeStopped();

with (objBreakDash)
{
    instance_destroy();
}
#define Destroy_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
timeStopLock = playerTimeRestored(timeStopLock);
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
animationTimer++;

if (global.frozen)
    exit;

if (animationTimer mod 8 == 0)
{
    for (var i = 0; i < 4; i++)
    {
        with (instance_create(
            view_xview[0] + irandom_range(0, view_wview[0]),
            view_yview[0] + irandom_range(0, view_hview[0]),
            objSingleLoopEffect))
        {
            sprite_index = sprFlashTwinkle;
            image_speed = 1 / 8;
        }
    }
}
