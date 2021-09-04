#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();
canHit = false;

respawnRange = -1;
despawnRange = -1;
shiftVisible = 1;

isSolid = 1;

blockCollision = 0;
grav = 0;
bubbleTimer = -1;

// Enemy specific code
origin = 0;
action = 1;
actionTimer = 0;

imgdelay = 6;
spawndelay = 10;
trainlength = 10;

xx = 16;
yy = 0;
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();

if (!global.frozen && !dead && !global.timeStopped)
{
    actionTimer += 1;
    iaction = action;
    switch (action)
    {
        case 0: // Appear - Only for the origin
            visible = 0;
            with (object_index)
            {
                if (origin == other.id)
                {
                    exit;
                }
            }
            if (actionTimer == imgdelay)
            {
                visible = 1;
                isSolid = 1;
                action += 1;
            }
            break;
        case 1: // Build up
            if (actionTimer == imgdelay)
            {
                image_index += 1;
                action += 1;
            }
            break;
        case 2:
            if (actionTimer == imgdelay)
            {
                image_index += 1;
                action += 1;
            }
            break;
        case 3: // Create successor
            if (actionTimer == spawndelay)
            {
                action += 1;
                if (place_meeting(x, y, objBlockTrainRight))
                {
                    xx = 16;
                    yy = 0;
                }
                if (place_meeting(x, y, objBlockTrainLeft))
                {
                    xx = -16;
                    yy = 0;
                }
                if (place_meeting(x, y, objBlockTrainDown))
                {
                    xx = 0;
                    yy = 16;
                }
                if (place_meeting(x, y, objBlockTrainUp))
                {
                    xx = 0;
                    yy = -16;
                }

                i = instance_create(x + xx, y + yy, object_index);
                i.origin = origin;
                if (!origin)
                {
                    i.origin = id;
                }
                i.xx = xx;
                i.yy = yy;
                i.imgdelay = imgdelay;
                i.spawndelay = spawndelay;
                i.trainlength = trainlength;
                i.sprite_index = sprite_index;

                with (i)
                {
                    if (!insideSection(bboxGetXCenter(), bboxGetYCenter()))
                    {
                        instance_destroy();
                        visible = 0;
                    }
                    else if (place_meeting(x, y, objMegaman)) // Push Mega out
                    {
                        ys = sign(yy);
                        if (ys == 0)
                        {
                            ys = -instance_place(x, y, objMegaman).gravDir;
                        }
                        with (objMegaman)
                        {
                            while (place_meeting(x, y, other.id))
                            {
                                y += other.ys;
                            }
                        }
                    }
                }
            }
            break;
        case 4: // Build off
            if (actionTimer == (spawndelay + imgdelay * 2)
                * (trainlength - 1) + imgdelay)
            {
                image_index -= 1;
                action += 1;
            }
            break;
        case 5:
            if (actionTimer == imgdelay)
            {
                image_index -= 1;
                action += 1;
            }
            break;
        case 6: // Reset / Destroy
            if (actionTimer == imgdelay)
            {
                if (!origin)
                {
                    x = xstart;
                    y = ystart;
                    action = 0;
                    actionTimer = 0;
                    image_index = 0;
                    visible = 0;
                    isSolid = 0;
                }
                else
                {
                    instance_destroy();
                }
            }
            break;
    }
    if (action != iaction)
    {
        actionTimer = 0;
    }
}
else if (dead && !global.switchingSections)
{
    action = 1;
    actionTimer = 0;
    image_index = 0;
    isSolid = 0;
    if (origin != 0)
    {
        instance_destroy();
    }
}
