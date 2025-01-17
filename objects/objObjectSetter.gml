#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
/// Autotiler for tilesets, place the whole tileset image somewhere in the level and place this
// object on the top left tile of the tileset, then place one of the supported objects of your choice over the tiles.
// If the object is flipped vertically the object setter will use the tile asociated to it as a chunk of tiles with the whole tileset
//preventing any weird behavior caused by using the object setter on an incomplete chunk of tiles

// only one autotiler runs this code:
if (id == object_index.id)
{
    var beginTime; beginTime = get_timer();
    print("Autotile begin (instance " + string(id) + ")", WL_VERBOSE);

    // learn list of layers
    print("Determining layer set...", WL_VERBOSE);
    var preplace_time; preplace_time = get_timer();
    global.tileLayersN = 0;
    var tid_all; tid_all = tile_get_ids();
    var tid_all_n; tid_all_n = array_length_1d(tid_all);
    if (tid_all_n <= 0)
        exit;
    var layers;
    layers[0] = 0;
    global.tileLayers = layers;
    var i; for ( i = 0; i < tid_all_n; i+=1)
    {
        var d; d = tile_get_depth(tid_all[i]);
        if (indexOf(global.tileLayers, d) == -1)
        {
            global.tileLayers[global.tileLayersN] = d; global.tileLayersN+=1
        }
    }

    print("Sorting layer set", WL_VERBOSE);

    // sort layer list
    quickSort(global.tileLayers, 0, global.tileLayersN);

    print("Layers found: " + string(global.tileLayers), WL_VERBOSE);

    // map from (layer, bg) -> (automapper id)
    var i; for ( i = 0; i < global.tileLayersN; i+=1)
        global.automapper[i] = ds_map_create();

    // set of instances which were placed during the autotiler process
    // maps (instance id) -> (true)
    var placed_instances; placed_instances = ds_map_create();

    // each object scans for a key and parses it
    with (object_index)
    {
        event_user(0);
    }

    preplace_time = get_timer() - preplace_time;
    print("Iterating through all tiles in all layers...", WL_VERBOSE);
    var place_time; place_time = get_timer();

    var layerIndex; for (layerIndex = 0; layerIndex < global.tileLayersN; layerIndex+=1)
    {
        // list each tile on each layer
        var layer; layer = global.tileLayers[layerIndex];
        var tid; tid = tile_get_ids_at_depth(layer);
        var tid_n; tid_n = array_length_1d(tid);

        print("Layer " + string(layer) + "...", WL_VERBOSE);
        print("  Splitting tiles...", WL_VERBOSE);
        var tile_split_time; tile_split_time = get_timer();

        // split tiles into 16x16
        var i; for ( i = 0; i < tid_n; i+=1)
        {
            splitTile(tid[i], grid, grid);
        }
        print("  (" + string((get_timer() - tile_split_time) / 1000) + " ms)");
        print("  Placing instances...", WL_VERBOSE);

        // look at every tile in room and place objects
        var tid; tid = tile_get_ids_at_depth(layer);
        var tid_n; tid_n = array_length_1d(tid);
        var instance_placed_n; instance_placed_n = 0; // this variable is purely to help debugging
        var instance_place_time; instance_place_time = get_timer();

        var i; for ( i = 0; i < tid_n; i+=1)
        {
            // determine which objObjectSetter has the associated tileset
            var bg; bg = tile_get_background(tid[i]);

            var automapperID; automapperID = ds_map_find_value(global.automapper[layerIndex], bg);

            if (is_undefined(automapperID))
            {
                continue;
            }

            with (automapperID)
            {
                // figure out which object to place according to tileset key (which is determined in user defined 0)
                var key_lookup_x; key_lookup_x = floor(tile_get_left(tid[i])/grid) - key_left;
                var key_lookup_y; key_lookup_y = floor(tile_get_top(tid[i])/grid) - key_top;
                if( (key_lookup_x<0) || (key_lookup_x > coordW-1) || (key_lookup_y<0) || (key_lookup_y>coordH-1) )
                {
                    break;
                }
                var obj_id; obj_id = ds_grid_get(coord,key_lookup_x, key_lookup_y);
                if (obj_id >= 0)
                {
                    with (instance_create(floor(tile_get_x(tid[i]) / grid) * grid, floor(tile_get_y(tid[i]) / grid) * grid, obj_id))
                    {
                        ds_map_set(placed_instances,id,true);
                        isTile = true;
                        visible = false;
                        instance_placed_n+=1;
                    }
                }
            }
        }

        print("  Placed " + string(instance_placed_n) + " instances.", WL_VERBOSE);
        print("  (" + string((get_timer() - instance_place_time) / 1000) + " ms)");
    }
    place_time = get_timer() - place_time;

    // clean up resources
    print("Cleaning up data structures...", WL_VERBOSE);
    var free_time; free_time = get_timer();
    print("  Freeing legend grids...", WL_VERBOSE);
    with (object_index)
    {
        ds_grid_destroy(coord);
    }

    print("  Destroying secondary autotilers...", WL_VERBOSE);
    with (object_index)
    {
        if (id != other.id)
        {
            instance_destroy();
        }
    }

    print("  Freeing layer -> autotiler map", WL_VERBOSE);
    var i; for ( i = 0; i < global.tileLayersN; i+=1)
        ds_map_destroy(global.automapper[i]);

    print("  Freeing placed instances map", WL_VERBOSE);
    ds_map_destroy(placed_instances);

    print("Finished object setting. Overall time taken: " + string((get_timer() - beginTime) / 1000) + " ms.", WL_VERBOSE);
    instance_destroy();

    free_time = get_timer() - free_time;
    print("  Pre-processing: " + string(preplace_time / 1000) + " ms");
    print("  tile placing: " + string(place_time / 1000) + " ms");
    print("  Freeing resources: " + string(free_time / 1000) + " ms");
}
#define Other_10
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
var useTileAsTileset; useTileAsTileset = (image_yscale<0);

if(useTileAsTileset)
{
    image_yscale=1;
    y-=16;
}

/// parse key
var key; key = -1;

print("Parsing legend (instance " + string(id) + ")", WL_VERBOSE);
print("  Searching for legend...", WL_VERBOSE);

// search for key until one is found
var i; for ( i = global.tileLayersN - 1; i >= 0; i-=1)
{
    layer = global.tileLayers[i];
    layerIndex = i;
    key = tile_layer_find(layer, x + 8, y + 8);
    if (key != -1)
    {
        break;
    }
}

ERR_HEAD = "Autotile Error: ";

if (key == -1)
{
    printErr(ERR_HEAD + "Cannot find background key on any layer (at x = " + string(x) + ", y = " + string(y) + ")");
    exit;
}

// found a key and layer

grid = 16;


key_bg = tile_get_background(key);

if(!useTileAsTileset)
{
    key_width = tile_get_width(key);
    key_height = tile_get_height(key);
    key_left = floor(tile_get_left(key) / grid);
    key_top = floor(tile_get_top(key) / grid);
    key_x = tile_get_x(key) + grid*0.5;
    key_y = tile_get_y(key) + grid*0.5;
}
else
{
    key_left = tile_get_left(key);
    key_top = tile_get_top(key);

    key_width = abs(background_get_width(key_bg)-key_left);
    key_height = abs(background_get_height(key_bg)-key_top);
    key_left = floor(key_left / grid);
    key_top = floor(key_top / grid);
    key_x = tile_get_x(key) + grid*0.5;
    key_y = tile_get_y(key) + grid*0.5;
}

tile_delete(key);

print("  Legend found! " + background_get_name(key_bg) + " on layer " + string(layer), WL_VERBOSE);
print("  Scanning legend...", WL_VERBOSE);

ds_map_replace(global.automapper[layerIndex], key_bg, id);

coordW = ceil(key_width/grid);
coordH = ceil(key_height/grid);
coord = ds_grid_create(coordW, coordH);

var i; for ( i = 0; i < coordW; i+=1)
{
    var j; for ( j = 0; j < coordH; j+=1)
    {
        ds_grid_set(coord,i,j,-1);
    }
}

// objects that can be autotiled
// make sure descendants are lower down in this list than their ancestors
obj[0] = objSolid;
obj[1] = objIce;
obj[2] = objTopSolid;
obj[3] = objLadder;
obj[4] = objSpike;
obj[5] = objWater;
obj[6] = objBossBarrier;
obj[7] = objBossDoor;
obj[8] = objBossDoorVertical;
obj[9] = objLineHorizontalDrop;
obj[10] = objStandSolid;
obj[11] = objSlopeR;
obj[12] = objSlopeL;
obj[13] = objSlopeRLong;
obj[14] = objSlopeLLong;
obj[15] = objDamageSpike;
obj[16] = objLiftRail;
obj[17] = objLiftHole;
obj[18] = objLiftEnd;
obj[19] = objLineVertical;
obj[20] = objLineHorizontal;
obj[21] = objLineTopLeft;
obj[22] = objLineTopRight;
obj[23] = objLineBottomLeft;
obj[24] = objLineBottomRight;
obj[25] = objLineVerticalDrop;
obj[26] = objCossackSnow;
obj_n = array_length_1d(obj);

// scan key for objects
var _x; for (_x = 0;_x < coordW; _x+=1) //_x < key_width; _x += grid)
{
    var _y; for (_y = 0; _y < coordH; _y+=1)// < key_height; _y += grid)
    {
        var obj_found; obj_found = noone;

        var i; for ( i = 0; i < obj_n; i+=1) // find object located at this point
        {
            if (position_meeting(key_x + _x*grid, key_y + _y*grid, obj[i]))
            {
                obj_found=obj[i];
            }
        }

        if (obj_found) // object found - add to list
        {
            ds_grid_set(coord,_x, _y,obj_found);
        }
    }
}

print("  Scan complete.", WL_VERBOSE);
