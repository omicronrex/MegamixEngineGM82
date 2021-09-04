#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
/// destroys objects and tiles in the area at room start time.

//@cc destroy instances of prtEntity?
destroyEntities = false;

//@cc destroy any object (including prtEntity?), except collision objects (objSolid, objSpike, etc.)
destroyObjects = false;

//@cc destroy solids
destroySolids = true;

//@cc delete tiles
destroyTiles = true;

//@cc what layer of tiles to delete
destroyTilesDepth = 1000000;
#define Other_4
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if (!instance_exists(id))
{
    exit;
}

var solids;
solids[0] = objSolid;
solids[1] = objLadder;
solids[2] = objTopSolid;

// destroy all objects
if (destroyObjects)
{
    with (all)
    {
        if (indexOf(solids, object_index) == -1)
            continue;
        if (id != other.id && place_meeting(x, y, other))
        {
            instance_destroy();
        }
    }
} // destroy just entities
else if (destroyEntities)
{
    with (prtEntity)
    {
        if (place_meeting(x, y, other))
        {
            instance_destroy();
        }
    }
}

// destroy solids & co.
if (destroySolids)
{
    var i; for (i = 0; i < array_length_1d(solids); i+=1)
    {
        with (solids[i])
        {
            if (place_meeting(x, y, other))
            {
                instance_destroy();
            }
        }
    }
}

// delete tiles
if (destroyTiles)
{
    var _x; for (_x = roundTo(bbox_left, 8) + 4; _x < roundTo(bbox_right, 8); _x += 8)
    {
        var _y; for (_y = roundTo(bbox_top, 8) + 4; _y < roundTo(bbox_bottom, 8); _y += 8)
        {
            tile_layer_delete_at(destroyTilesDepth, _x, _y);
        }
    }
}

// no need for this to stick around
instance_destroy();
