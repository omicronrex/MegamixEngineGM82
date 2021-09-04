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
    if ((global.flagParent[myFlag].active && object_index == objPUSwitchBlockRed)
        || (!global.flagParent[myFlag].active && object_index == objPUSwitchBlockBlue))
    {
        if (!isSolid)
        {
            isSolid = 1;
            with (prtEntity)
            {
                if (!dead)
                {
                    if (blockCollision)
                    {
                        if (place_meeting(x, y, other.id))
                        {
                            other.isSolid = 0;
                            break;
                        }
                    }
                }
            }
        }
    }
    else
    {
        isSolid = 0;
    }

    image_index = !isSolid;
}
