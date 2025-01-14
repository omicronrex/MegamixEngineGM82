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
image_xscale = 1;
image_yscale = 1;
canHit = false;
despawnRange = -1;
respawn = false;
stopOnFlash = false;
resetDepth = false;
if (depth == -2)
{
    depth = 1000000;
    resetDepth = true;
}
solidBlock = noone;
isSolid = false;
tileNumber = 0;
thrownSign = 0;
thrown = false;

// code stolen from NaOH. grabs the tile underneath it and makes it the graphic for the block.
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
            tile_delete(myTile);
        }
    }
}
blockCollision = 1;
grav = 0;
contactDamage = 4;
#define Destroy_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();
with (solidBlock)
    instance_destroy();
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
        solidBlock = instance_create(x, y, objSolidIndependent);
    with (solidBlock)
    {
        // if mega man is in solid, shunt him out!
        with (instance_place(x, y, objMegaman))
        {
            while (place_meeting(x, y, other))
                y -= 1;
        }
        image_xscale = other.image_xscale * sprite_get_width(other.sprite_index) / 16;
        image_yscale = other.image_yscale * sprite_get_height(other.sprite_index) / 16;
        visible = true;
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
    if (xspeed != 0)
    {
        thrownSign = sign(xspeed);
    }
    if (thrown) // if hit wall, create bullet spread.
    {
        if (xspeed == 0 && x >= view_xview)
        {
            var inst;
            inst = instance_create(x + 8, y + 8, objEnemyBullet);
            inst.sprite_index = sprUranusProjectile;
            inst.xspeed = 2.75 * (thrownSign * -1);
            inst.yspeed = -2;
            inst.depth = depth - 1;
            inst = instance_create(x + 8, y + 8, objEnemyBullet);
            inst.sprite_index = sprUranusProjectile;
            inst.xspeed = 3.75 * (thrownSign * -1);
            inst.yspeed = -1;
            inst.depth = depth - 1;
            inst = instance_create(x + 8, y + 8, objEnemyBullet);
            inst.sprite_index = sprUranusProjectile;
            inst.xspeed = 2.75 * (thrownSign * -1);
            inst.yspeed = 2;
            inst.depth = depth - 1;
            inst = instance_create(x + 8, y + 8, objEnemyBullet);
            inst.sprite_index = sprUranusProjectile;
            inst.xspeed = 3.75 * (thrownSign * -1);
            inst.yspeed = 1;
            inst.depth = depth - 1;
            instance_create(x + 8, y + 8, objExplosion);
            isSolid = true;
            x = -16;
            y = -16;
            xspeed = 0;
            yspeed = 0;
            thrown = false;
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
var i; for ( i = 0; i < tileNumber; i += 1)
    draw_background_part(tileBG[i], tileLeft[i], tileTop[i], tileWidth[i], tileHeight[i], round(x + tileX[i]), round(y + tileY[i]));

// drawSelf();
