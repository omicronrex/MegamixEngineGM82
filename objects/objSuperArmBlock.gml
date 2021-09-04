#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();

//@cc set the depth in creation code to change what layer this applies to.
layer = 1000000;

if (place_meeting(x, y, objSolid))
{
    carveSolid(bbox_left, bbox_top, bbox_right, bbox_bottom);
    with (objSolid)
    {
        if (place_meeting(x, y, other))
        {
            instance_destroy();
        }
    }

    isSolid = 1;
}
tileN = 0;

// Super Arm interaction setup
category = "superArmTarget";
superArmFlashTimer = 0;
superArmFlashOwner = noone;
superArmFlashInterval = 1;
superArmHoldOwner = noone;
superArmDeathOnDrop = true;
superArmThrown = false;

canHit = false;
contactDamage = 0;

grav = 0;
blockCollision = 0;
shiftVisible = 1;
bubbleTimer = -1;
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();

// change depth
if (superArmHoldOwner != noone)
{
    depth = 1;
}
#define Other_4
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
// remove solids under self
depth = layer;

carveSolid(bbox_left, bbox_top, bbox_bottom, bbox_right, true);
with (objSolid)
{
    if (place_meeting(x, y, other))
    {
        other.isSolid = true;
        instance_destroy();
    }
}

// place pickups under the super arm block so they become Hidden Boys
if (place_meeting(x, y, prtPickup))
{
    with instance_place(x, y, prtPickup)
    {
        depth = other.layer + 1;
        blockCollision = 0;
        grav = 0;
    }
}

// find underlying tiles
var ix; for (ix = bbox_left + 8; ix < bbox_right; ix += 16)
{
    var iy; for (iy = bbox_top + 8; iy < bbox_bottom; iy += 16)
    {
        var tile; tile = tile_layer_find(depth, ix, iy);
        if (tile != -1)
        {
            tileOffsetX[tileN] = tile_get_x(tile) - x;
            tileOffsetY[tileN] = tile_get_y(tile) - y;
            tileLeft[tileN] = tile_get_left(tile);
            tileTop[tileN] = tile_get_top(tile);
            tileWidth[tileN] = tile_get_width(tile);
            tileHeight[tileN] = tile_get_height(tile);
            tiles[tileN] = tile_get_background(tile);
            tileN+=1
            tile_delete(tile);
        }
    }
}

if (tileN <= 0)
{
    printErr("Warning: a super arm block at " + string(x) + "," + string(y) + " had no underlying tiles. (Did you remember to set its layer to the tile layer?)");
}
#define Draw_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if (!dead)
{
    var i; for ( i = 0; i < tileN; i+=1)
    {
        draw_background_part(tiles[i], tileLeft[i], tileTop[i], tileWidth[i], tileHeight[i], floor(x) + tileOffsetX[i], floor(y) + tileOffsetY[i]);
    }

    if (superArmFlashTimer mod (2 * superArmFlashInterval) >= superArmFlashInterval || superArmHoldOwner != noone || superArmThrown)
    {
        // flash
        draw_set_blend_mode(bm_add);
        var i; for ( i = 0; i < tileN; i+=1)
        {
            draw_background_part(tiles[i], tileLeft[i], tileTop[i], tileWidth[i], tileHeight[i], floor(x) + tileOffsetX[i], floor(y) + tileOffsetY[i]);
        }
        draw_set_blend_mode(bm_normal);
        draw_set_alpha(1);
    }
}
