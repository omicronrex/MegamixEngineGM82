#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
/* This object allows a part of the stage to move arbitrarily within a section. This
   allows emulating moving solid tiles such as in Knight Man's stage, Dust Man's stage,
   Blizzard Man's stage, and others.

   The object should be placed and stretched over a section of tiles. Any collision
   objects under these (i.e. objSolid) will be converted to moving platform objects.
   Entities will also be incorporated into the shift, but they will only actually shift
   if they have blockCollision = 0, otherwise they will only have their spawn coordinates
   adjusted.

   posX[], posY[], posT[] gives an array of space-time coordinates defining
   the shift object's path relative to its top-left corner. If the arrays are not
   all the same length, then the length of the longest is used and the shorter arrays
   are extended cyclically. posX and posY are as one would expect; posT defines an additional
   time coordinate.

   The first value of the arrays would typically be set to:

     posX[0] = x;
     posY[0] = y;
     posT[0] = 0;

   If a different value for posX[0], posY[0] is specified then the object will
   begin at that location, allowing you to define the shifting area in the room
   editor at a different location than where it appears.

   posT defines the relative time coordinate for each location. posT must
   be strictly increasing (no duplicates), and must start with a 0. An assertion will
   fail if either of these conditions fail.

   As an example, to make a shifting area which starts at the coordinates (256, 408)
   and moves up and down with a 2-second period:

     posX[0] = 256; // this value will be repeated since the array is shorter than the others.

     posY[0] = 408;
     posY[1] = 448;

     posT[0] = 0; // (required!)
     posT[1] = 60;
     posT[2] = 120; // an additional value is needed to define the length of the period.

     If you forget to provide an additional T value at the end, a value of 1
     greater than the previous value will be appended automatically, which
     may cause a rapid jump.

   Note: cannot currently handle some collision types, including ladders and spikes.
   Note: it's probable that many entities will not work correctly in a shift area.
*/

//@cc x-coordinates of path. See object decscription.
posX = makeArray(x);

//@cc y-coordinates of path. See object description.
posY = makeArray(y);

//@cc t-coordinates (time) of the path. See object description.
posT = makeArray(0);

//@cc if this is false, instead of cycling, the object will reach its destination and
// permanently stop.
isCyclic = true;

//@cc if this is set, the object is forced to exist in only this section. Otherwise, posX[0],posY[0] will be used.
secX = -1;
secY = -1; //@cc see secX

//@cc tiles on these layers should be moved (if they are under the object when the room begins).
// If this is an array, tiles on all provided layers will be moved
// (if they are under the object when the room begins).
tileLayer = 1000000;

// current time value
timer = -1;

// auto-generated statistics:
period = 0;
posCount = 0;
childCount = 0;
tileCount = 0;

MVT_SPEED = 0;
MVT_SPAWNSHIFT = 1;
MVT_SPAWNONLY = 1;
MVT_DIRECT = 3;
#define Step_1
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
var desX, desY; // desired coordinates
var preX = x, preY = y; // previous coordinates

if (!global.frozen && !global.timeStopped && insideSection(secX, secY))
{
    // current time step:
    _regT = ++timer;
    event_user(0); // calculate x,y
    var desX = _regPosX;
    var desY = _regPosY;

    // we now have desired X,Y location. Update tiles.
    for (var i = 0; i < tileCount; i++)
    {
        if (tile_exists(tileChild[i]))
        {
            tile_set_position(tileChild[i], desX + tileOffsetX[i], desY + tileOffsetY[i]);
        }
    }

    timer++;
    if (timer > 2 * period)
    {
        timer -= period;
    }

    x = desX;
    y = desY;

    // we now have desired X,Y location. Update objects.
    for (var i = 0; i < childCount; i++)
    {
        var moveType = childMovementType[i];

        // make sure activated
        // won't help this frame but should help next at least.
        instance_activate_object(child[i]);

        // update child
        with (child[i])
        {
            switch (moveType)
            {
                case 0: // MVT_SPEED
                    xspeed = other.x + other.childOffsetX[i] - x;
                    yspeed = other.y + other.childOffsetY[i] - y;
                    break;
                case 1: // MVT_SPAWNSHIFT
                    if (!dead)
                    {
                        xspeed = other.x + other.childOffsetX[i] - x;
                        yspeed = other.y + other.childOffsetY[i] - y;
                    }
                case 2: // MVT_SPAWNONLY
                // update spawn coordinates
                    xstart = other.x + other.childOffsetX[i];
                    ystart = other.y + other.childOffsetY[i];
                    if (dead)
                    {
                        x = xstart;
                        y = ystart;
                    }
                    spawnEnabled = insideSection(xstart, ystart);
                    break;
                case 3: // MVT_DIRECT
                    x = other.x + other.childOffsetX[i];
                    y = other.y + other.childOffsetY[i];
                    break;
            }
        }
    }
}
#define Other_4
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
/// set internal stats
posCount = max(
    array_length_1d(posX),
    array_length_1d(posY),
    array_length_1d(posT) - isCyclic
    );

var xProvLength = array_length_1d(posX);
var yProvLength = array_length_1d(posY);

// loop values: x
for (var i = array_length_1d(posX); i < posCount; i++)
{
    posX[i] = posX[i - xProvLength];
}

// loop values: y
for (var i = array_length_1d(posY); i < posCount; i++)
{
    posY[i] = posY[i - yProvLength];
}

// buffer values: t
for (var i = array_length_1d(posT) - 1; i < posCount - 1 + isCyclic; i++)
{
    posT[i + 1] = posT[i];
}

// make loop
if (isCyclic)
{
    posX[posCount] = posX[0];
    posY[posCount] = posY[0];
    posCount += 1;
}

// time period of shift
period = posT[posCount - 1];

assert(posT[0] == 0, "posT[0] was non-zero on objShift at " + string(x) + "," + string(y));
for (var i = 1; i < array_length_1d(posT); i++)
{
    assert(posT[i] > posT[i - 1], "posT non-increasing on objShift at " + string(x) + "," + string(y));
}

if (secX == -1)
{
    secX = posX[0];
}
if (secY == -1)
{
    secY = posY[0];
}
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
/// grab underlying

var convertObject, convertIsSolid, directObject;

// these objects should be converted into objSolidEntity
convertObject[0] = objSolid;
convertIsSolid[0] = 1;

convertObject[1] = objTopSolid;
convertIsSolid[1] = 2;

convertObject[2] = objStandSolid;
convertIsSolid[2] = 3;

// because objSolidEntity cannot be a ladder or a spike, it cannot be handled here.

// these objects should be left as-is and moved manually
directObject[0] = objWater;

carveSolid(bbox_left, bbox_top, bbox_right, bbox_bottom);

// leave these as they are; move directly
for (var k = 0; k < array_length_1d(directObject); k++)
{
    var obj = directObject[k];
    with (obj)
    {
        if (object_index == obj)
        {
            if (place_meeting(x, y, other))
            {
                other.child[other.childCount] = id;
                other.childMovementType[other.childCount] = other.MVT_DIRECT; // direct move
                other.childCount++;
            }
        }
    }
}

// these spawn, which we have to think about
with (prtEntity)
{
    var moveType = other.MVT_SPAWNONLY;
    if (blockCollision == 0)
    {
        moveType = other.MVT_SPAWNSHIFT;
    }
    if (place_meeting(x, y, other))
    {
        other.child[other.childCount] = id;
        other.childMovementType[other.childCount] = moveType; // direct move
        other.childCount++;
    }
}

// convert these to objSolidEntity
for (var k = 0; k < array_length_1d(convertObject); k++)
{
    var obj = convertObject[k];
    with (obj)
    {
        if (object_index == obj)
        {
            if (place_meeting(x, y, other))
            {
                var converted = instance_create(x, y, objSolidEntity);
                converted.image_xscale = image_xscale;
                converted.image_yscale = image_yscale;
                converted.image_angle = image_angle;
                converted.visible = false;
                converted.blockCollision = false;
                converted.grav = 0;
                converted.stopOnFlash = true;
                converted.respawnRange = -1;
                converted.despawnRange = -1;
                converted.isSolid = convertIsSolid[k];
                other.child[other.childCount] = converted;
                other.childMovementType[other.childCount] = other.MVT_SPEED; // xspeed/yspeed
                other.childCount++;
                instance_destroy();
            }
        }
    }
}

// get tiles
if (!is_array(tileLayer))
{
    tileLayer = makeArray(tileLayer);
}
for (var i = 0; i < array_length_1d(tileLayer); i++)
{
    var l = tileLayer[i];
    var tileIn = tile_get_ids_at_depth(l);
    for (var k = 0; k < array_length_1d(tileIn); k++)
    {
        var tile = tileIn[k];
        var tileX = tile_get_x(tile);
        var tileY = tile_get_y(tile);
        if (point_in_rectangle(tileX + tile_get_width(tile) / 2, tileY + tile_get_height(tile) / 2, bbox_left, bbox_top, bbox_right, bbox_bottom))
        {
            tileChild[tileCount] = tile;
            tileOffsetX[tileCount] = tileX - x;
            tileOffsetY[tileCount] = tileY - y;
            tileCount++;
        }
    }
}

var deltaX = posX[0] - x;
var deltaY = posY[0] - y;

// move objects to starting coordinates
for (var i = 0; i < childCount; i++)
{
    var moveType = childMovementType[i];
    with (child[i])
    {
        other.childOffsetX[i] = xstart - other.x;
        other.childOffsetY[i] = ystart - other.y;
        x += deltaX;
        xstart += deltaX;
        y += deltaY;
        ystart += deltaY;
    }
}

x = posX[0];
y = posY[0];
#define Other_10
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
/// calculate _regPosX, _regPosY from _regT
var indL;
_regT = max(0, _regT);
if (!isCyclic && timer >= period)
{
    _regT = period;
}
else
{
    _regT = _regT mod period;
}
var p = 1;
for (indL = 0; indL < posCount - 1; indL++)
{
    if (_regT <= posT[indL + 1])
    {
        break;
    }
}
assert(indL < posCount);
p = (_regT - posT[indL]) / (posT[indL + 1] - posT[indL]);
assert(inClosedRange(p, 0, 1));
_regPosX = round(posX[indL] * (1 - p) + posX[indL + 1] * p);
_regPosY = round(posY[indL] * (1 - p) + posY[indL + 1] * p);