#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();

//! Illusian will place hologram tiles on this tile layer.
tile_layer = 800000;
healthpointsStart = 1;
healthpoints = healthpointsStart;
blockCollision = 0;
category = "flying";
grav = 0;

// not confirmed:
contactDamage = 3;

// these can be adjusted in creation code
move_speed = 2;
lay_time = 90;
image_speed = 2;
image_index = 0;
dir = 0;
lay_timer = 0;
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();
tile_layer_hide(tile_layer);
if (entityCanStep())
{
    if (dir == 0)
    {
        dir = -sign(x - view_xview[0] - view_wview[0] / 2);
        x = view_xview[0] + 4;
        if (dir == -1)
            x = view_xview[0] + view_wview[0] - 4;

        // split tiles to 16x16:
        var tile_list; tile_list = tile_get_ids_at_depth(tile_layer);
        var i; for ( i = 0; i < array_length_1d(tile_list); i+=1)
        {
            var tile; tile = tile_list[i];
            splitTile(tile);
        }

        // gather tiles on route:
        route_tile_n = 0;
        var tile_list; tile_list = tile_get_ids_at_depth(tile_layer);
        var i; for ( i = 0; i < array_length_1d(tile_list); i+=1)
        {
            var tile; tile = tile_list[i];
            if (tile_get_y(tile) == y)
            {
                route_tile[route_tile_n] = tile; route_tile_n+=1
            }
        }

        // bubble sort x values
        swapped = false;
        var i; for ( i = 0; i < route_tile_n - 1; i+=1)
        {
            if (tile_get_x(route_tile[i + 1]) * dir < tile_get_x(route_tile[i]) * dir)
            {
                var tmp; tmp = route_tile[i];
                route_tile[i] = route_tile[i + 1];
                route_tile[i + 1] = tmp;
                swapped = true;
            }
            if (i == route_tile_n - 2 && swapped)
            {
                swapped = false;
                i = -1;
            }
        }

        if (route_tile_n != 0)
        {
            // route_combined: place two tiles at once in route
            route_combined[route_tile_n - 1] = false;
            var i; for ( i = 0; i < route_tile_n - 1; i+=1)
            {
                if (tile_get_x(route_tile[i]) == tile_get_x(route_tile[i + 1]) - 16 * dir)
                {
                    route_combined[i] = true;
                    i+=1;
                }
            }
        }
        route_progress = 0;
        y_route = y;
    }

    // movement:
    if (lay_timer == 0)
    {
        x += move_speed * dir;
        image_index = 2;

        // stop if passed next block on route:
        if (route_progress < route_tile_n)
        {
            var dst_x; dst_x = tile_get_x(route_tile[route_progress]) + 8 + 8 * route_combined[route_progress] * dir;
            if (x * dir >= dst_x * dir && y == y_route)
            {
                x = dst_x;
                lay_timer = lay_time;
                var i; for ( i = 0; i <= route_combined[route_progress]; i+=1)
                {
                    var tile; tile = route_tile[route_progress + i];
                    with (instance_create(tile_get_x(tile), y_route, objIllusianBlock))
                    {
                        tile_bg = tile_get_background(tile);
                        tile_left = tile_get_left(tile);
                        tile_top = tile_get_top(tile);
                        tile_width = tile_get_width(tile);
                        tile_height = tile_get_height(tile);
                        depth = other.tile_layer;
                    }
                }
                route_progress += 1 + route_combined[route_progress];
            }
        }
    }
    else // laying tiles down
    {
        lay_timer -= 1;
        image_index = ((lay_timer div 4) mod 2);
    }
}
else if (dead)
{
    route = -1;
    image_index = 2;
    dir = 0;
    lay_timer = 0;
}
#define Other_4
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
/// hide tile layer
tile_layer_hide(tile_layer);
