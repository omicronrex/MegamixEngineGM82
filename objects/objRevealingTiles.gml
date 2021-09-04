#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
// makes all tiles on a particular layer invisible.
// when mega man is near those tiles in the section
// this is placed in, they become visible.

//@cc tiles on this layer will be invisible
layer = 1000000;

//@cc number of revealing objects
revealersN = 1;

//@cc objects which reveal tiles
revealers[0] = objMegaman;

//@cc radius about these objects in which the light is revealed
radius[0] = 32;

sectionSurface = noone;
sectionSurfaceMask = noone;
scanned = false;
skipDraw=false;

prevWeather = global.telTelWeather;
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if(!insideSection(x,y))
{
    instance_deactivate_object(id);
}
skipDraw=false;
if(instance_exists(objTelTelWeatherControl))
{
    if(prevWeather!=global.telTelWeather&&global.telTelWeather==2)
    {
        tiles = tile_get_ids_at_depth(layer);
        tile_layer_show(layer);
        for(var i=array_length_1d(tiles)-1;i>=0;--i)
        {
            var tile = tiles[i];
            var tx = tile_get_x(tile);
            var ty = tile_get_y(tile);
            var st = instance_create(tx,ty,objTelTelSnowTile);
            st.tileTop = tile_get_top(tile);
            st.tileLeft = tile_get_left(tile);
            st.tileBG = tile_get_background(tile);
            st.tileWidth = tile_get_width(tile);
            st.tileHeight = tile_get_height(tile);
            st.depth = layer-1;
            st.tile = tile;

            if(!tile_exists(tile_layer_find(layer,tx,ty-8)))
            {
                st.isGround=true;
            }

        }
        skipDraw=true;
    }
    else if(prevWeather!=global.telTelWeather)
    {
        scanned=false;
    }

}
prevWeather = global.telTelWeather;
if(global.telTelWeather==2)
{
    skipDraw=true;
    exit;
}
if (!scanned)
{
    tiles = tile_get_ids_at_depth(layer);
    tile_layer_hide(layer);
    depth = layer;
    setSection(x + 8, y + 8, false);

    for (var i = 0; i < array_length_1d(tiles); i++)
    {
        var tile = tiles[i];
        if (tile_get_x(tile) > sectionRight)
        {
            tiles[i] = -1;
        }
        if (tile_get_x(tile) + tile_get_width(tile) < sectionLeft)
        {
            tiles[i] = -1;
        }
        if (tile_get_y(tile) > sectionBottom)
        {
            tiles[i] = -1;
        }
        if (tile_get_y(tile) + tile_get_height(tile) < sectionTop)
        {
            tiles[i] = -1;
        }
    }

    var oldTiles = tiles;
    tiles = makeArray();
    var j = 0;
    for (var i = 0; i < array_length_1d(oldTiles); i++)
    {
        if (oldTiles[i] != -1)
        {
            tiles[j++] = oldTiles[i];
        }
    }

    scanned = true;
}

// allocate surface
if (!surface_exists(sectionSurface) || !surface_exists(sectionSurfaceMask))
{
    sectionWidth = sectionRight - sectionLeft;
    sectionHeight = sectionBottom - sectionTop;
    surface_free(sectionSurface);
    surface_free(sectionSurfaceMask);

    sectionSurface = surface_create(sectionWidth, sectionHeight);
    sectionSurfaceMask = surface_create(sectionWidth, sectionHeight);
}
#define Other_5
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
surface_free(sectionSurface);
surface_free(sectionSurfaceMask);
#define Draw_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
// surface (tiles)
if(skipDraw)
    exit;
surface_set_target(sectionSurface);
draw_clear_alpha(c_white, 0);
for (var i = 0; i < array_length_1d(tiles); i++)
{
    var tile = tiles[i]
        ;
    draw_background_part(
        tile_get_background(tile),
        tile_get_left(tile),
        tile_get_top(tile),
        tile_get_width(tile),
        tile_get_height(tile),
        tile_get_x(tile) - sectionLeft,
        tile_get_y(tile) - sectionTop
        );
}
surface_reset_target();

// mask (reveals tiles)
surface_set_target(sectionSurfaceMask);
draw_clear_alpha(c_white, 0);
draw_set_color(c_white);
draw_set_alpha(1);
draw_set_circle_precision(64);
for (var i = 0; i < revealersN; i++)
{
    with (revealers[i])
    {
        draw_circle(
            (bbox_left + bbox_right) / 2 - other.sectionLeft,
            (bbox_top + bbox_bottom) / 2 - other.sectionTop,
            other.radius[i], false);
    }
}

// apply tiles to mask
draw_set_blend_mode_ext(bm_dest_alpha, bm_zero);
draw_surface(sectionSurface, 0, 0);
draw_set_blend_mode(bm_normal);
surface_reset_target();

// draw surface on screen
draw_surface(sectionSurfaceMask, sectionLeft, sectionTop);
