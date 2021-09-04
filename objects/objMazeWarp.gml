#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
/// Note: don't place tiles of the same layer on top of eachother otherwise this may not be picked up by the maze

// creation code variables

//@cc set positions (top left corner of the new view)
camX = x;

//@cc set positions (top left corner of the new view)
camY = y;

//@cc tile layer chack ranges
// Note: don't make the gap between these too large or your room may take longer to load
tileCheckStart = 1000000;

//@cc tile layer chack ranges
// Note: don't make the gap between these too large or your room may take longer to load
tileCheckEnd = 1000000;

// distance to check between
tileDistanceCheck = 16;

// don't touch
init = true;
tileSurface = noone;
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if (init)
{
    depth = min(tileCheckStart, tileCheckEnd);
    init = false;
}

// 8-pixel leeway here to prevent some jankiness
if (collision_rectangle(x + 8, y + 8, x + view_xview - 8, y + view_hview - 8, objMegaman, 0, 0)
    && !instance_exists(objSectionSwitcher) && insideView() && !global.frozen)
{
    with (objMegaman)
    {
        x += other.camX - view_xview;
        y += other.camY - view_yview;
        setSection(x, y, 1);
        playerCamera(1);
        reAndDeactivateObjects(1, 1);

        if instance_exists(vehicle)
        {
            with vehicle
            {
                x += other.camX - view_xview;
                y += other.camY - view_yview;
            }
        }
    }

    if instance_exists(objWaterShield)
    {
        with objWaterShield
        {
            x += other.camX - view_xview;
            y += other.camY - view_yview;
        }
    }
}
#define Draw_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
// Grab all tiles on the screen you're teleporting to
if (!surface_exists(tileSurface))
{
    tileSurface = surface_create(view_wview, view_hview);
    surface_set_target(tileSurface);
    draw_clear_alpha(c_black, 0);

    for (layer = min(tileCheckStart, tileCheckEnd); layer <= max(tileCheckStart, tileCheckEnd); layer++)
    {
        for (i = 0; i <= round(view_wview); i += tileDistanceCheck)
            for (j = 0; j <= round(view_hview); j += tileDistanceCheck)
            {
                var tile = tile_layer_find(layer, camX + i, camY + j);
                if (tile_exists(tile))
                {
                    draw_background_part(tile_get_background(tile),
                        tile_get_left(tile), tile_get_top(tile), tile_get_width(tile), tile_get_height(tile),
                        tile_get_x(tile) - camX, tile_get_y(tile) - camY);
                }
            }
    }

    surface_reset_target();
} // now once everything is grabbed, draw it
else
{
    draw_surface(tileSurface, x, y);
}
