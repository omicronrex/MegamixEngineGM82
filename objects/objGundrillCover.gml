#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
getX = 0;
getY = 0;
tileNumber = 0;
startingY = ystart;

ceilOrFloor = 0;

// debug
attackTimer = 0;
deathTimer = 4;

image_xscale = 2;
image_yscale = 2;
for (getX = 0; getX * 16 < image_xscale * sprite_get_width(sprite_index); getX += 1)
{
    for (getY = 0; getY * 16 < image_yscale * sprite_get_height(sprite_index); getY += 1)
    {
        {
            myTile = tile_layer_find(depth, x + 8 + 16 * getX, startingY + 8 + 16 * getY);
            if(!tile_exists(myTile))
            {
            	continue;
            }
            tileBG[tileNumber] = tile_get_background(myTile);
            tileLeft[tileNumber] = tile_get_left(myTile);
            tileTop[tileNumber] = tile_get_top(myTile);
            tileWidth[tileNumber] = tile_get_width(myTile);
            tileHeight[tileNumber] = tile_get_height(myTile);
            tileX[tileNumber] = tile_get_x(myTile) - x;
            tileY[tileNumber] = tile_get_y(myTile) - startingY;
            tileNumber += 1;
            isSolid = true;
        }
    }
}
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if (instance_exists(parent))
{
    depth = parent.depth - 2;

    // debug
    // attackTimer +=1;
    deathTimer-=1;
}
else
{
    instance_destroy();
}
#define Draw_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if (attackTimer mod 2 == 0)
{
    var i; for ( i = 0; i < tileNumber; i += 1)
        draw_background_part(tileBG[i], tileLeft[i], tileTop[i], tileWidth[i], tileHeight[i], floor(x + tileX[i]), floor(y + tileY[i]));
}

// debug
// drawSelf();
