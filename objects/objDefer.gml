#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
/// struct for the defer() script
event = ev_step;
subEvent = ev_step_normal;
script = scrNoEffect;
argCount = 0;
timer = 0;
caller = noone;
triggered = false; // set to true as soon as timer begins to decrement
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
step = ev_step_normal;
event_user(1);
#define Step_1
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
step = ev_step_begin;
event_user(1);
#define Step_2
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
step = ev_step_end;
event_user(1);
#define Other_5
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
// trigger no matter what
timer = 0;
if (event == ev_destroy || event == ev_other || event == ev_room_end)
{
    if (event == ev_room_end || subEvent == ev_room_end)
    {
        event_user(0);
    }
}
#define Other_10
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
/// trigger / decrement timer
triggered = true;
timer--;
if (!timer)
{
    if (argCount > 0)
    {
        scriptExecuteNargs(script, args);
    }
    else
    {
        script_execute(script);
    }
    instance_destroy();
}
#define Other_11
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if (event == ev_destroy)
{
    if (!instance_exists(caller) && !triggered)
    {
        event_user(0);
    }
}
else if (event == ev_step)
{
    if (subEvent == step)
    {
        event_user(0);
    }
}
if (event == EV_DEATH || subEvent == EV_DEATH)
{
    if (instance_exists(caller))
    {
        if (caller.dead && !triggered)
        {
            event_user(0);
        }
    }
}
#define Draw_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if (event == ev_draw && subEvent == ev_draw)
{
    event_user(0);
}
