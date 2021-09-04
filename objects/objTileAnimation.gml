#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();
///Used to animate a tileset with its animation frames in different backgrounds
///An object setter is required for animating chunks of tiles(you don't have to set any object if you
///don't want to, just put one in the tileset so its tiles are splited).
///To use you have to set the animID array to the animation frames of the tileset
///and set animationLayer to the layer where the animated tiles are
/*
animLength = how many frames
animTime = interval before change
animID[#] = background frame (Note # goes up from 0 to animLength)
animateOnTransition = will stop animations during the transition

animationLayer = Layer animated tiles start at (your animated tiles should start on this layer)

Note: This only works for tiles on a 16x16 grid


see the example level for how to set this up.
*/

animLength = 1;
animTime = 1;
animateOnTransition = false;
animID[10] = tstAnimated;
animID[0] = noone;
animationLayer=100000;

timer = 0;
tileID = 0;
init=1;
#define Step_1
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
/// This generates tiles all across the levet
/// Note this causes lag at the start of the stage in larger levels
if(init)
{
    print("Animating");
    var tiles = tile_get_ids_at_depth(animationLayer);
    var total = array_length_1d(tiles);
    if(total<=0)
    {
        init=0;
        instance_destroy();
        exit;
    }

    for (var i = 0; i < total; i+=1)
    {
        var tile = tiles[i];
        var bg=tile_get_background(tile);
        var skip=true;
        var k=0;
        for(var j=0; j<animLength;j+=1;)
        {
            if(bg==animID[j])
            {
                skip=false;
                k=j+1;
                break;
            }
        }
        if(skip)
            continue;
        if(k>=animLength)
        {
            k=0;
        }
        for(var j=1;j<animLength;j++)
        {
            tile_add(animID[k], tile_get_left(tile),
                tile_get_top(tile), 16,
                16, tile_get_x(tile), tile_get_y(tile),
                animationLayer + j);
            ++k;
            if(k>=animLength)
            {
                k=0;
            }
        }
    }
    for(var i =1;i<animLength;i++)
        tile_layer_hide(animationLayer+i);
    init=false;
    exit;
}

if (global.frozen)
{
    if (!global.switchingSections)
    {
        exit;
    }
    else if (!animateOnTransition)
    {
        exit;
    }
}

if (timer < animTime)
{
    timer += 1;
}
else
{
    timer = 0;
    if (tileID < animLength)
    {
        tile_layer_hide(animationLayer + tileID);
        tileID += 1;
        if(tileID==animLength)
            tileID = 0;
        tile_layer_show(animationLayer + tileID);
    }
}
