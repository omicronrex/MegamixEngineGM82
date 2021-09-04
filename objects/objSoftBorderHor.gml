#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
active = false;
viewPlayer = noone;
alarm[0] = 1;

//  changables
// deactivationDistance, amount of pixels away from the player before panning over
deactivationDistance = 32;

// maxSpeed, speed at which the camera scrolls
maxSpeed = 4;
#define Alarm_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
defaultSpeed = maxSpeed;
#define Step_2
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if (collision_rectangle(x, bbox_top, x + (view_wview / 2) * sign(image_xscale), bbox_bottom, objMegaman, 0, 1)
    && !collision_rectangle(x, bbox_top, x + deactivationDistance * sign(image_xscale), bbox_bottom, objMegaman, 0, 1))
{
    if (image_xscale > 0)
        global.borderLockLeft = min(x, max(view_xview + 4, global.borderLockLeft));
    else
        global.borderLockRight = max(x, min(view_xview + view_wview - 4, global.borderLockRight));
    if (!active
        && instance_exists(objMegaman))
    {
        active = true;
        with (objMegaman)
            if (viewPlayer)
                other.viewPlayer = id;
    }
}
else if (active
    && instance_exists(viewPlayer))
{
    if (abs(viewPlayer.x - viewPlayer.xprevious) >= maxSpeed)
        maxSpeed++;
    if (image_xscale > 0)
    {
        if (global.borderLockLeft > viewPlayer.x - view_wview / 2)
            global.borderLockLeft -= maxSpeed;
        else
        {
            global.borderLockLeft = 0;
            active = false;
            maxSpeed = defaultSpeed;
        }
    }
    else
    {
        if (global.borderLockRight < viewPlayer.x + view_wview / 2)
            global.borderLockRight += maxSpeed;
        else
        {
            global.borderLockRight = room_width;
            active = false;
            maxSpeed = defaultSpeed;
        }
    }
}
