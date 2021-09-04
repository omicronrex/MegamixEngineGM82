#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
/*
  Place many of these over a large area to be disabled when
  the lever is pulled. Only set creation code variables on one
  of the field objects in the area -- the information will automatically
  propagate to its neighbours.

  To have adjacent fields with different properties, declare the
  information on all the field objects at the boundary between
  the two fields.
*/

event_inherited();

contactDamage = 0;
canHit = false;
bubbleTimer = -1;

shiftVisible = 1;

active = false;
myinstance = noone;
myindex = noone;

image_alpha = 0;

sprite_index = sprLeverField;

TILE_DEPTH_UNSET = 4.035234; // special value for unset tiles

//@cc this value must match that of the associated objLever
tag = "";

//@cc if this is set, will cause an object to spawn when activated
// (will disable tile interaction)
object = noone;

//@cc set this to be the depth of the tile layer to make disappear
tile_depth = TILE_DEPTH_UNSET;

otheruptag = noone;
otherstate = noone;

// time since created:
createTime = 0;

// has propagated tag and depth to other fields?
propagated = false;

myTile = -1;
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if (!global.frozen && !global.timeStopped && createTime > 1)
{
    if (active)
    {
        image_alpha = min(image_alpha + 0.1, 1);
        if (((image_alpha >= 0.5 || object != noone)
            || createTime < 3) && myinstance == noone && myindex != noone)
        {
            // activate object:
            myinstance = instance_create(x, y, myindex);

            // ladders need special treatment
            if (myindex == objLadder)
            {
                combineObjects(objLadder, false, true);
            }

            // custom creation code
            if (otheruptag != noone)
            {
                myinstance.uptag = otheruptag;
            }
            if (otherstate != noone)
            {
                myinstance.state = otherstate;
            }

        }
    }
    else
    {
        image_alpha = max(image_alpha - 0.1, 0);
        if ((image_alpha < 0.5 && object == noone)
            || (image_alpha == 0 && object != noone)
            && instance_exists(myinstance))
        {
            with (myinstance)
            {
                instance_destroy();
            }
            myinstance = noone;
        }
    }

    // custom objects set alpha:
    if (object != noone && instance_exists(myinstance))
    {
        myinstance.image_alpha = image_alpha;
    }
}

if (instance_exists(objSectionSwitcher))
{
    image_alpha = active;
    if (object != noone && instance_exists(myinstance))
    {
        myinstance.image_alpha = image_alpha;
    }
}

createTime += 1;
depth = tile_depth;

if (myTile >= 0)
{
    tile_set_alpha(myTile, image_alpha);
}
#define Other_4
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
// propagate tags
print("leverfield");
if (id == object_index.id)
{
    while (true)
    {
        global.leverPropagated = false;
        with (object_index)
        {
            event_user(1);
        }
        if (!global.leverPropagated)
        {
            break;
        }
    }

    with (object_index)
    {
        // find objects underneath
        // highly negative depth of this object means it will
        // run before solids combine
        event_user(2);
    }

    with (object_index)
    {
        // find tiles underneath
        event_user(3);
    }
}
#define Other_11
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
/// propagate tag

if (tag == "")
{
    exit;
}
if (propagated)
{
    exit;
}

propagated = true;

for (x_offset = -1; x_offset <= 1; x_offset += 1)
{
    for (y_offset = -1; y_offset <= 1; y_offset += 1)
    {
        // skip diagonals and center:
        if (abs(x_offset) + abs(y_offset) != 1)
        {
            continue;
        }

        ix = x + 8 + 16 * x_offset;
        iy = y + 8 + 16 * y_offset;

        o = instance_position(ix, iy, object_index);
        if (instance_exists(o) && o != id)
        {
            // propagate tag if other's tag is blank
            if (o.tag == "")
            {
                with (o)
                {
                    tag = other.tag;
                    global.leverPropagated = true;
                }
            }

            // propagate tile depth to fields with same tag
            if (o.tag == tag)
            {
                if (o.tile_depth == TILE_DEPTH_UNSET)
                {
                    o.tile_depth = tile_depth;
                    global.leverPropagated = true;
                }
            }
        }
    }
}

// find object underneath field
event_user(2);
#define Other_12
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
/// find object underneath field

// set depth to proper value
if (tile_depth == TILE_DEPTH_UNSET)
{
    tile_depth = 1000000; // replacement tile depth
}
depth = tile_depth;

if (object != noone) // Set custom object
{
    myindex = object;
}

if (myindex == noone) // Set tile object
{
    myobj = 0;
    for (i = 1; i <= 7; i += 1)
    {
        switch (i)
        {
            case 1:
                obj = objSolid;
                break;
            case 2:
                obj = objIce;
                break;
            case 3:
                obj = objSpike;
                break;
            case 4:
                obj = objLadder;
                break;
            case 5:
                obj = objTopSolid;
                break;
            case 6:
                obj = objWater;
                break;
            case 7:
                obj = objStandSolid;
                break;
        }
        in_pos = instance_position(x + 8, y + 8, obj);
        if (instance_exists(in_pos))
        {
            myobj = in_pos;
        }
    }

    if (myobj)
    {
        myindex = myobj.object_index;

        with (myobj)
        {
            instance_destroy();
        }
    }
}
#define Other_13
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
/// find tile underneath
t = tile_layer_find(tile_depth, x + 8, y + 8);
splitTile(t);

t = tile_layer_find(tile_depth, x + 8, y + 8);
myTile = t;
