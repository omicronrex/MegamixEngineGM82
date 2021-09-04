#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
image_speed = 0;
parent=noone;
alarm[0] = 1;
#define Alarm_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
var inst;
inst = instance_place(x - 4, y, object_index);
if (inst!=noone&&inst.object_index==object_index&&inst.parent==parent)
{
    exit
}
inst = instance_place(x + 4, y, object_index);
while (inst!=noone && inst.parent==parent)
{
    if (inst.object_index != object_index)
    {
        exit;
    }
    with (inst)
    {
        instance_destroy();
    }
    image_xscale += 1;
    inst  = instance_place(x,y,object_index);
    while (inst!=noone)
    {
        if (inst.parent==parent&&inst.object_index == object_index)
        {
            with (inst)
            {
                instance_destroy();
            }
        }
        else
        {
            break;
        }
        inst  = instance_place(x,y,object_index);
    }
}

inst = instance_place(x, y-4, object_index);
if (inst!=noone&&inst.object_index==object_index&&inst.parent==parent)
{
    exit
}
inst = instance_place(x, y+4, object_index);
while (inst!=noone && inst.parent==parent)
{
    if (inst.object_index != object_index)
    {
        exit;
    }
    with (inst)
    {
        instance_destroy();
    }
    image_yscale += 1;
    inst  = instance_place(x,y,object_index);
    while (inst!=noone)
    {
        if (inst.parent==parent&&inst.object_index == object_index)
        {
            with (inst)
            {
                instance_destroy();
            }
        }
        else
        {
            break;
        }
        inst  = instance_place(x,y,object_index);
    }
}


if (place_meeting(x, y - 4, object_index))
{
    if (instance_place(x, y - 4,
        object_index).object_index == object_index && instance_place(x,
        y - 4, object_index).image_xscale == image_xscale)
    {
        exit;
    }
}

/*
while (place_meeting(x, y + 4, object_index))
{
    var nextobjSolid;
    nextobjSolid = instance_place(x, y + 4, object_index);
    if (nextobjSolid.object_index != object_index)
    {
        exit;
    }
    if (nextobjSolid.x == x && nextobjSolid.image_xscale == image_xscale)
    {
        with (nextobjSolid)
        {
            instance_destroy();
        }
    }
    else
    {
        exit;
    }
    image_yscale += 1;
}
*/
