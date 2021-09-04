#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_perform_object(prtEntity, ev_create, 0);
timer = 0;
restore_tile_n = 0;
inst_restore_n = 0;
parent = noone;
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
// restore tiles if outside section
if (entityCanStep())
{
    if (timer == 0)
    {
        // split tiles
        var i; for ( i = -1; i < 2; i+=1)
            var j; for ( j = 0; j < 2; j+=1)
            {
                carveSolid(x + i * 16, y + j * 16, x + (i + 1) * 16, y + (j + 1) * 16);
                var tile; tile = tile_layer_find(tile_layer, x + i * 16 + 8, y + j * 16 + 8);
                if (tile != -1)
                {
                    splitTile(tile);
                }
            }
    }
    timer+=1;
    var progress; progress = timer div 3;

    // what tiles blow up
    pos_n = 0;
    if (progress == 0)
    {
        pos_x[0] = 0;
        pos_y[0] = 0;
        pos_n = 1;
    }
    if (progress == 1)
    {
        pos_x[0] = -16;
        pos_y[0] = 0;
        pos_x[1] = 16;
        pos_y[1] = 0;
        pos_x[2] = 0;
        pos_y[2] = 16;
        pos_n = 3;
    }
    if (progress == 2)
    {
        pos_x[0] = -16;
        pos_y[0] = 16;
        pos_x[1] = 16;
        pos_y[1] = 16;
        pos_n = 2;
    }
    if (timer == 3 * 3)
    {
        var i; for ( i = 0; i < inst_restore_n; i+=1)
        {
            instance_activate_object(inst_restore[i]);
            with (inst_restore[i])
            {
                dead = true;
                beenOutsideView = true;
                event_perform(ev_step, ev_step_normal);
                dead = false;
                visible = true;
            }
        }
    }
    var i; for ( i = 0; i < pos_n; i+=1)
    {
        with (instance_position(x + 8 + pos_x[i], y + 8 + pos_y[i], objSolid))
        {
            instance_deactivate_object(id);
        }
        var tile; tile = tile_layer_find(tile_layer, x + 8 + pos_x[i], y + 8 + pos_y[i]);
        if (tile != -1 && tile_get_visible(tile))
        {
            other.restore_tile[other.restore_tile_n] = tile; other.restore_tile_n+=1
            tile_set_visible(tile, false);
        }
    }
}
var restore; restore = !insideSection(x, y) && !instance_exists(objSectionSwitcher);
if (instance_exists(parent))
    if (parent.beenOutsideView)
        restore = true;
if (restore)
{
    var i; for ( i = 0; i < restore_tile_n; i+=1)
    {
        tile_set_visible(restore_tile[i], true);
    }
    instance_destroy();
}
