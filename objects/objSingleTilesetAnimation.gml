#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=other
*/
///Used to animate tilesets in one background file, it animates horizontal and vertical strips
///from left to right and from top to bottom.

///This object can have more than one animation but the tiles must be in the same layer

///An object setter is required for animating chunks of tiles(you don't have to set any object if you
///don't want to, just put one in the tileset so its tiles are splited).

/// How to use

/// Set animLayer to the layer where the animated tiles are, then set the region of the first frame in the animation
/// (relative to the background), and animLengths to the number of frames of each animation
/// Set animType to 0 if the frames are aligned vertically(with the first frame on the top)
/// or set it to 1 if the frames are aligned horizontally(with the first frame on the left)

/// The following arrays must have the same size and be set in creation code
animBackgrounds[0] = 0; //@cc **Mandatory** for each animation a background must be provided
animLengths[0] = 0; //@cc **Mandatory** sets the lenght of each animation
animSpeeds[0] = -1; //@cc **Mandatory** sets the speed of each animation
animLayer = 1000000; //@cc sets the layer of the animations, this object will only replace the tiles in this layer
animLayerOffset = 0; //@cc increase this number if two objSingleTilesetAnimation are conflicting
animDelays[0] = -1; //@cc sets the delay between loops
regionTop[0] = 0; //@cc *Mandatory**
regionLeft[0] = 0; //@cc *Mandatory**
regionWidth[0] = 0; //@cc *Mandatory** the width of the tileset(without repeating)
regionHeight[0] = 0; //@cc the height of the tileset(without repeating)
animType[0] = -1; //@cc if the background repeats horizontally set to 1
reverse[0] = -1;


//@cc
animateOnTransition = true;

//@cc
stopOnFlash = false;

//@cc this object makes the tiles for the animation over the originals
// if for whatever reason you don't want the original non animated tiles set this to true
deleteOriginals = false;

// Internal use only
init = 0;
animTimers[0] = 0;
delayTimer[0] = 0;
animFrames[0, 0] = 0;

alarm[0] = 1;
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if ((!global.frozen || global.switchingSections) && (!global.switchingSections || animateOnTransition) && (!global.timeStopped || !stopOnFlash))
{
    var layerOffset; layerOffset = 1;
    var i; for ( i = 0; i < animTotal; i+=1)
    {
        if (delayTimer[i] <= 0)
        {
            var prev; prev = animTimers[i];
            animTimers[i] += animSpeeds[i];
            if (floor(animTimers[i]) > animLengths[i] - 1)
            {
                animTimers[i] = 0;
                delayTimer[i] = animDelays[i];
            }
            if (floor(prev) != floor(animTimers[i]))
            {
                var animFrame; animFrame = (floor(prev) + 1) mod animLengths[i];
                animTimers[i] = animFrame;
                var prevFrame; prevFrame = (floor(prev));

                if(reverse[i])
                {
                    animFrame = animLengths[i] - animFrame -1;
                    prevFrame = (animLengths[i]-floor(prev)-1);
                }

                tile_layer_hide(animLayer - layerOffset - animLayerOffset - ((animLengths[i] - 1) - prevFrame));
                tile_layer_show(animLayer - layerOffset - animLayerOffset - ((animLengths[i] - 1) - animFrame));
            }
        }
        else
            delayTimer[i] -= 1;

        layerOffset += animLengths[i];
    }
}
#define Step_1
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
/// Make animations

if (init)
    exit;
init = 1;

animTotal = array_length_1d(animBackgrounds);

if (animDelays[0] == -1)
{
    for (i = 0; i < animTotal; i+=1)
        animDelays[i] = 0;
}
if (reverse[0] == -1)
{
    for (i = 0; i < animTotal; i+=1)
        reverse[i] = 0;
}
if (animSpeeds[0] == -1)
{
    for (i = 0; i < animTotal; i+=1)
        animSpeeds[i] = 0.1;
}
if (animType[0] == -1)
{
    for (i = 0; i < animTotal; i+=1)
        animType[i] = 0;
}

var widths;

var i; for ( i = 0; i < animTotal; i+=1)
{
    widths[i] = background_get_width(animBackgrounds[i]);
}

var offset; offset = 0;
animFrames[0, 0] = 0;
var i; for ( i = 0; i < animTotal; i+=1)
{
    var gridWidth; gridWidth = widths[i] div 16;
    var htiles; htiles = regionWidth[i] div 16;
    var vtiles; vtiles = regionHeight[i] div 16
        ;
    var left; left = regionLeft[i] div 16;
    var top; top = regionTop[i] div 16;
    var _x; for (_x = 0; _x < htiles; _x += 1)
    {
        var _y; for (_y = 0; _y < vtiles; _y += 1)
        {
            var indx; indx = offset + (_x + _y * htiles);
            var f; for (f = 0; f < animLengths[i]; f+=1)
            {
                animFrames[indx, f] = ((_x + left) + f * htiles * (animType[i] == 1)) + ((_y + top) + f * vtiles * (animType[i] == 0)) * gridWidth;
            }
        }
    }
    offset += htiles * vtiles;
    animTimers[i] = 0;
    delayTimer[i] = 0;
}
print("Finished the animation frame list###Placing tiles...");
var tiles; tiles = tile_get_ids_at_depth(animLayer);
var tileTotal; tileTotal = array_length_1d(tiles);

var i; for ( i = 0; i < tileTotal; i+=1)
{
    var tileY; tileY = tile_get_top(tiles[i]) div 16;
    var tileX; tileX = tile_get_left(tiles[i]) div 16;
    var tileBackground; tileBackground = tile_get_background(tiles[i]);
    var animTilesTotal; animTilesTotal = 0;
    offset = 0;
    var layerOffset; layerOffset = 1;
    var j; for ( j = 0; j < animTotal; j+=1)
    {
        var htiles; htiles = regionWidth[j] div 16;
        var vtiles; vtiles = regionHeight[j] div 16;

        var t; for (t = 0; t < htiles * vtiles; t+=1)
        {
            if (tileBackground == animBackgrounds[j])
            {
                var gridWidth; gridWidth = widths[j] div 16;
                var frame; for (frame = 0; frame < animLengths[j]; frame+=1)
                {
                    var frameX; frameX = animFrames[offset + t, frame] mod gridWidth;
                    var frameY; frameY = animFrames[offset + t, frame] div gridWidth;

                    if (frameX == tileX && tileY == frameY)
                    {
                        var tx; tx = tile_get_x(tiles[i]);
                        var ty; ty = tile_get_y(tiles[i]);
                        tile_add(animBackgrounds[j], frameX * 16, frameY * 16, 16, 16, tx, ty, animLayer - animLayerOffset - layerOffset - (animLengths[j] - 1));
                        var f; f = frame + 1;
                        if (f > animLengths[j] - 1)
                            f = 0;
                        var l; l = animLengths[j] - 2;

                        while (l >= 0 && f != frame)
                        {
                            tile_layer_hide(animLayer - layerOffset - animLayerOffset - l);
                            var fX; fX = animFrames[offset + t, f] mod gridWidth;
                            var fY; fY = animFrames[offset + t, f] div gridWidth;
                            tile_add(animBackgrounds[j], fX * 16, fY * 16, 16, 16, tx, ty, animLayer - layerOffset - animLayerOffset - l);
                            l-=1;
                            f+=1;
                            if (f > animLengths[j] - 1)
                                f = 0;
                        }

                        if(!reverse[j])
                        {

                            tile_layer_show(animLayer - layerOffset - animLayerOffset - (animLengths[j] - 1));
                        }
                        else
                        {
                            tile_layer_show(animLayer - layerOffset - animLayerOffset - (animLengths[j] - 1) - animLengths[j]-1);
                        }


                        if (deleteOriginals)
                            tile_delete(tiles[i]);
                    }
                }
            }
        }
        layerOffset += animLengths[j];
        offset += htiles * vtiles;
    }
}
animBackgrounds = 0;
animFrames = 0;
#define Draw_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
/// Draw cancel
