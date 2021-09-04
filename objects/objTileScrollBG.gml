#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
// Place this down over a tile on the set layer (tile) and it will shift left or right
// depending on the xscale of the object in the editor.

// Creation code (all optional):
// tile = <number>. Depth of the layer of tiles that needs to be shifted.
// spd = <number>. Speed of the tile shifting. Will be multiplied by image_xscale.

// it took me literally almost three full days to fix this and it was extremely painful
// please don't have me do this again :(
// -snoruntpyro

event_inherited();

canHit = false;
grav = 0;
blockCollision = 0;
bubbleTimer = -1;

respawnRange = -1;
despawnRange = -1;

stepInit = 1;
drawInit = 1;

// section boundaries
_sl = x;
sr = x;

tileID = 0;
xshift = 0;

// customizeable variables
tile = 30;
spd = 1;
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();

// initialize section + direction
if (stepInit)
{
    // direction setting
    if (image_xscale < 0)
    {
        image_xscale = 1;
        x -= 16;
        xstart = x;
        xshift = -1;
    }
    else
    {
        xshift = 1;
    }

    stepInit = 0;
}

// actual shifting
if (!global.frozen && !global.timeStopped && tileID > 0)
{
    // grab section boundaries, even if the game is frozen
    if (instance_exists(objMegaman))
    {
        _sl = global.sectionLeft;
        sr = global.sectionRight;
    }

    // loop around the screen
    if (x > (sr - 16) && xshift > 0 && xspeed != 0)
    {
        x -= sr - _sl;
    }
    if (x < (_sl) && xshift < 0 && xspeed != 0)
    {
        x += sr - _sl;
    }

    // ughhh failsafe
    if ((x < (_sl - 8) && xshift < 0) || (x >= (sr - 8) && xshift > 0))
    {
        x = xstart;
        y = ystart;
        xspeed = 0;
    }

    // move depending on xshift variable
    if (xspeed == 0 && _sl != sr && insideSection(x, y) && insideSection(x + 1, y))
    {
        xspeed = spd * xshift;
    }

    // this double inside section check probably looks really weird but that's
    // actually part of how i fixed this damn object from clipping into the wrong section.
    // don't question anything

    // this is a really hacky solution to a bug where mega man's speed would get messed up
    // if he was standing on multiple tile slides at a time. usually, objects will
    // instead combine with others next to them and increase their size to fix this
    // (e.g. conveyors) as well as improve performance, but doing this here would break
    // the looping effect. sorry ;-;

    with (prtEntity)
    {
        if (blockCollision && grav != 0)
        {
            var gravDir = sign(grav);

            with (other)
            {
                if (isSolid)
                {
                    if (place_meeting(x + 16, y, objTileScrollSolid))
                    {
                        var myID = id;
                        var otherID = instance_place(x + 16, y, objTileScrollSolid)

                        .id;
                        if (place_meeting(x, y - 1 + (17 * (gravDir == -1)), other) && place_meeting(otherID.x, otherID.y - 1 + (17 * (gravDir == -1)), other))
                        {
                            with (other)
                            {
                                shiftObject(-myID.xspeed, 0, 1);

                                // Why does it have to be negative?
                                // Don't ask questions you aren't prepared to know the answers to.
                                // : )
                            }
                        }
                    }
                }
            }
        }
    }
}
#define Draw_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
// don't draw + reset position if section switching is happening
if (instance_exists(objSectionSwitcher))
{
    x = xstart;
    y = ystart;
    despawnRange = 0; // despawn on screen transition
    respawnRange = 0;
    xspeed = 0;
    exit;
}

// reset to defaults
respawnRange = -1;
despawnRange = -1;

// set depth to be the same as the tile layer
depth = tile;

// finding the tile + setting direction
if ((drawInit || tileID <= 0) && !stepInit)
{
    tileID = tile_layer_find(tile, x + 8, y + 8);
    if (tileID)
    {
        if (x == tile_get_x(tileID) && y == tile_get_y(tileID))
        {
            tb = tile_get_background(tileID);
            tl = tile_get_left(tileID);
            tT = tile_get_top(tileID);
            tw = tile_get_width(tileID);
            th = tile_get_height(tileID);
            tile_delete(tileID);
        }
        else
        {
            tileID = 0;
        }
    }

    drawInit = 0;
}

// draw found tile
if (tileID && xspeed != 0)
{
    var drawx, drawy;

    // determine rounding method
    if (sign(image_xscale) < 0)
    {
        drawx = floor(x);
        drawy = floor(y);
    }
    else
    {
        drawx = ceil(x);
        drawy = ceil(y);
    }

    draw_background_part(tb, tl, tT, tw, th, drawx, drawy);
    if (_sl != sr)
    {
        draw_background_part(tb, tl, tT, tw, th, drawx - (sr - _sl), drawy);
        draw_background_part(tb, tl, tT, tw, th, drawx + (sr - _sl), drawy);
    }
}
