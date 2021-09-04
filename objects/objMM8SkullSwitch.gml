#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
// creation code
// myFlag = ;
// inverse = ;

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
    if (place_meeting(x, y - image_yscale, objMegaman) && image_index == 0)
    {
        global.flagParent[myFlag].active = 1 - inverse;
        playSFX(sfxSidewayElevatorButton);
        image_index = 1;
        with (instance_place(x, y - image_yscale, objMegaman))
        {
            shiftObject(0, 8 * other.image_yscale, 1);
        }
    }
    if (global.flagParent[myFlag].active == inverse && !place_meeting(x, y, objMegaman))
    {
        image_index = 0;
    }
    else
    {
        image_index = 1;
    }

    isSolid = 1 - sign(image_index);
}
else if (dead)
{
    x = xstart;
    y = ystart;
}
