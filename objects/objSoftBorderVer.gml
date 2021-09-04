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
if (collision_rectangle(bbox_left, y, bbox_right, y + (view_wview / 2) * sign(image_yscale), objMegaman, 0, 1)
    && !collision_rectangle(bbox_left, y, bbox_right, y + deactivationDistance * sign(image_yscale), objMegaman, 0, 1))
{
    if (image_yscale > 0)
        global.borderLockTop = min(y, max(view_yview + 4, global.borderLockTop));
    else
        global.borderLockBottom = max(y, min(view_yview + view_hview - 4, global.borderLockBottom));
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
    if (abs(viewPlayer.y - viewPlayer.yprevious) >= maxSpeed)
        maxSpeed++;
    if (image_yscale > 0)
    {
        if (global.borderLockTop > viewPlayer.y - view_hview / 2)
            global.borderLockTop -= maxSpeed;
        else
        {
            global.borderLockTop = 0;
            active = false;
            maxSpeed = defaultSpeed;
        }
    }
    else
    {
        if (global.borderLockBottom < viewPlayer.y + view_hview / 2)
            global.borderLockBottom += maxSpeed;
        else
        {
            global.borderLockBottom = room_height;
            active = false;
            maxSpeed = defaultSpeed;
        }
    }
}
