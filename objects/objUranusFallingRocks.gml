#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();
while (place_meeting(x, y, objSolid))
{
    with (instance_place(x, y, objSolid))
        instance_destroy();
}
image_xscale = 7;
image_yscale = 1;
canHit = false;
destroyTimer = 0;
despawnRange = -1;
respawn = false;
stopOnFlash = false;
resetDepth = false;
if (depth == -2)
{
    depth = 1000000;
    resetDepth = true;
}
f = 0; // facade
solidBlock = noone;
isSolid = false;
killMega = true;
tileNumber = 0;
alarm[0] = 1;
blockCollision = 1;
grav = 0;
contactDamage = 4;
subGroup = false;
startingY = 0;
#define Destroy_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();
with (solidBlock)
    instance_destroy();
#define Alarm_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if (subGroup == false)
{
    for (getX = 0; getX * 16 < image_xscale * sprite_get_width(sprite_index); getX += 1)
    {
        for (getY = 0; getY * 16 < image_yscale * sprite_get_height(sprite_index); getY += 1)
        {
            myTile = tile_layer_find(depth, x + 8 + 16 * getX, y + 8 + 16 * getY);
            if (tile_exists(myTile))
            {
                tileBG[tileNumber] = tile_get_background(myTile);
                tileLeft[tileNumber] = tile_get_left(myTile);
                tileTop[tileNumber] = tile_get_top(myTile);
                tileWidth[tileNumber] = tile_get_width(myTile);
                tileHeight[tileNumber] = tile_get_height(myTile);
                tileX[tileNumber] = tile_get_x(myTile) - x;
                tileY[tileNumber] = tile_get_y(myTile) - y;
                tileNumber += 1;
            }
            else
            {
                instance_destroy();
            }
        }
    }
    startingY = y;
}
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();
if (isSolid)
{
    if (!instance_exists(solidBlock))
    {
        if (killMega)
        {
            // if mega man is inside block when spawned, KILL HIM!
            with (instance_place(x, y, objMegaman))
            {
                event_user(EV_DEATH);
            }
            killMega = false;
        }
        else
            solidBlock = instance_create(x, y, objSolidIndependent);
    }
    with (solidBlock)
    {
        image_xscale = other.image_xscale * sprite_get_width(other.sprite_index) / 16;
        image_yscale = other.image_yscale * sprite_get_height(other.sprite_index) / 16;

        // visible = true;
    }
}
else
{
    with (solidBlock)
        instance_destroy();
}
with (solidBlock)
{
    x = other.x;
    y = other.y;
}
if (entityCanStep())
{
    destroyTimer += 1;
    if (destroyTimer == 128)
        instance_destroy();
    if (destroyTimer == 4)
    {
        if (!checkSolid(0, 16, 1, 1))
        {
            var inst = instance_create(x, y + 16, object_index);
            inst.subGroup = true;
            with (inst)
            {
                startingY = other.startingY;
                for (getX = 0; getX * 16 < image_xscale * sprite_get_width(sprite_index); getX += 1)
                {
                    for (getY = 0; getY * 16 < image_yscale * sprite_get_height(sprite_index); getY += 1)
                    {
                        {
                            myTile = tile_layer_find(depth, x + 8 + 16 * getX, startingY + 8 + 16 * getY);
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
            }
        }
    }
}
if (resetDepth)
    depth = -2;
#define Draw_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if (subGroup)
{
    for (var i = 0; i < tileNumber; i += 1)
        draw_background_part(tileBG[i], tileLeft[i], tileTop[i], tileWidth[i], tileHeight[i], floor(x + tileX[i]), floor(y + tileY[i]));
}
else
{
    if (destroyTimer mod 2 == 0)
    {
        for (var i = 0; i < tileNumber; i += 1)
            draw_background_part(tileBG[i], tileLeft[i], tileTop[i], tileWidth[i], tileHeight[i], floor(x + tileX[i]), floor(y + 16 + tileY[i]));
    }
}

// drawSelf();
