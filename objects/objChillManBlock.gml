#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
// You can set the itemDrop of these objects to create a "frozen" enemy inside of them. The Centering seems to be quite inconsistent so I added variables to help correct the X/Y of the frozen object
event_inherited();

killOverride = false;
canIce = false;

shiftVisible = 1;

isSolid = 1;

blockCollision = 0;
grav = 0;
bubbleTimer = -1;

healthpointsStart = 2;
healthpoints = healthpointsStart;

breakTimer = -1;
drawItem = false;

// You can execute scripts or limited GML using this upon the chill block being destroyed. Functions exactly as the custom spawner's does. Note that the graphic does not change for frozen enemies, only the one created on death.
script = scrNoEffect;
code = "";

// You can set some of these variables for additional control over the item's frozen graphics. spawnalpha only affects the spawned

sprite = 0;
subimage = 0; // Only used for drawing
xscale = 1;
yscale = 1;
color = image_blend;
alpha = 0.5;
spawnAlpha = 1;

// these only affect the position of the frozen enemy, change with caution
itemDrawOffsetX = 0;
itemDrawOffsetY = 0;
itemSpawnOffsetX = 0;
itemSpawnOffsetY = 0;
width = 27;
height = 27;

// super arm interaction
category = "superArmTarget";
superArmFlashTimer = 0;
superArmFlashOwner = noone;
superArmFlashInterval = 1;
superArmHoldOwner = noone;
superArmDeathOnDrop = true;
superArmThrown = false;
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();

if (!global.frozen && !dead)
{
    /* if (endit)
    {
        endit += 1;
        event_user(EV_HURT);
    }
    */
    if (breakTimer == -1)
    {
        if (true) // else
        {
            with (prtEntity)
            {
                if ((faction == 3 || faction == 1) && !dead && ground && ycoll != 0 && object_index != objBusterShotCharged)
                {
                    if (place_meeting(x, y + sign(grav), other.id))
                    {
                        with (other)
                        {
                            healthpoints = max(0, healthpoints - 1);
                            if (healthpoints == 0)
                            {
                                healthpoints = 1;
                                breakTimer = 13;
                            }
                            else
                                event_user(EV_HURT);

                            /*
                            if (image_index==1)
                            {
                                endit = 1;
                            }
                            else
                            {
                                event_user(EV_DEATH);
                            }
                            */
                            break;
                        }
                    }
                }
            }
        }
    }
    else
    {
        if (breakTimer > 0)
            breakTimer -= 1;
        if (breakTimer == 0)
        {
            healthpoints = 0;
            event_user(EV_HURT);
            event_user(EV_DEATH);
            dead = true;
        }
    }
    if (healthpoints > 1)
        image_index = 0;
    else
        image_index = 1;
}
else if (dead)
    image_index = 0;
#define Step_1
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();
if (!drawItem)
    drawItem = true;
#define Other_19
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
/// Crack and break
if (healthpoints == 1) // Get a crack
{
    image_index = 1;
    playSFX(sfxChillCrack);
}
else if (healthpoints < 1) // Break
{
    drawItem = false;
    playSFX(sfxChillBreak);

    for (b = 0; b < 4; b += 1)
    {
        if (b == 0)
        {
            xx = -12;
            yy = 0;
            xs = -0.5;
            ys = -2;
        }
        if (b == 1)
        {
            xx = 0;
            yy = 10;
            xs = -0.5;
            ys = -3;
        }
        if (b == 2)
        {
            xx = 5;
            yy = -7;
            xs = 0.5;
            ys = -3;
        }
        if (b == 3)
        {
            xx = 12;
            yy = 14;
            xs = 0.5;
            ys = -2;
        }
        i = instance_create(bboxGetXCenter() + xx, bboxGetYCenter() + yy, objEnemyBullet);
        i.sprite_index = sprChillBlockShards;
        i.image_index = b;
        i.grav = 0.2;
        i.xspeed = xs;
        i.yspeed = ys;
        i.contactDamage = 0;
        i.reflectable = 0;
    }

    dead = true;
    if (itemDrop)
    {
        var itemDrawLeft; itemDrawLeft = max(0, sprite_get_bbox_left(sprite) - (floor(width / 4)));
        var itemDrawRight; itemDrawRight = min(itemDrawLeft + width, min(sprite_get_bbox_right(sprite) + (floor(width / 4)), sprite_get_width(sprite)));
        var itemDrawTop; itemDrawTop = max(0, sprite_get_bbox_top(sprite) - floor((height / 4)));
        var itemDrawBottom; itemDrawBottom = min(itemDrawTop + height, min(sprite_get_bbox_bottom(sprite) + floor((height / 4)), sprite_get_height(sprite)));
        if (itemDrawLeft < 0 || ((itemDrawLeft < 0) != (itemDrawRight > width)))
        {
            itemDrawLeft = sprite_get_bbox_left(sprite);
            itemDrawRight = min(itemDrawLeft + width, sprite_get_bbox_right(sprite));
        }
        if (itemDrawTop < 0 || ((itemDrawTop < 0) != (itemDrawBottom > height)))
        {
            itemDrawTop = sprite_get_bbox_top(sprite);
            itemDrawBottom = min(itemDrawTop + height, sprite_get_bbox_bottom(sprite));
        }

        // Gettimg the dimensions of the region to be draw
        var itemDrawBoxWidth; itemDrawBoxWidth = abs(itemDrawLeft - itemDrawRight);
        var itemDrawBoxHeight; itemDrawBoxHeight = abs(itemDrawTop - itemDrawBottom);

        var bboxWidth; bboxWidth = abs(bbox_left - bbox_right);
        var bboxHeight; bboxHeight = abs(bbox_top - bbox_bottom);
        var boxLeft; boxLeft = bbox_left + 2;
        var boxTop; boxTop = bbox_top + 2;

        myEnemy = instance_create(boxLeft, boxTop, itemDrop);
        myEnemy.sprite_index = sprite;
        myEnemy.image_xscale = xscale;
        myEnemy.image_yscale = yscale;
        myEnemy.x = boxLeft + myEnemy.x - myEnemy.bbox_left;
        myEnemy.y = boxTop + myEnemy.y - myEnemy.bbox_top;

        myEnemy.x += max(0, floor(width / 2) - floor(itemDrawBoxWidth / 2)) + itemSpawnOffsetX;
        myEnemy.y += max(0, floor(height / 2) - floor(itemDrawBoxHeight / 2)) + itemSpawnOffsetY;

        myEnemy.image_blend = color;
        myEnemy.image_alpha = spawnAlpha;
        myEnemy.respawn = false;

        with (myEnemy)
        {
            /* if (other.subimage != 0)
                image_index = other.subimage ;*/ // This could break some animation based enemies
            script_execute(other.script);
            if (other.code != "")
                stringExecutePartial(other.code);
        }
    }
}
#define Other_20
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
drawItem = false;
#define Other_21
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if (other.penetrate < 2 && other.pierces < 2 && other.object_index != objBusterShotCharged)
{
    other.penetrate = 0;
    other.pierces = 0;
    global.damage = 1;
}
if (healthpoints - global.damage <= 0)
    drawItem = false;
#define Other_25
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();
breakTimer = -1;
image_index = 0;
#define Draw_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();

if (drawItem && itemDrop && !dead)
{
    if (sprite == 0)
        sprite = object_get_sprite(itemDrop);

    // getting the boundaries of the sprite
    var itemDrawLeft; itemDrawLeft = max(0, sprite_get_bbox_left(sprite) - (floor(width / 4)));
    var itemDrawRight; itemDrawRight = min(itemDrawLeft + width, min(sprite_get_bbox_right(sprite) + (floor(width / 4)), sprite_get_width(sprite)));
    var itemDrawTop; itemDrawTop = max(0, sprite_get_bbox_top(sprite) - floor((height / 4)));
    var itemDrawBottom; itemDrawBottom = min(itemDrawTop + height, min(sprite_get_bbox_bottom(sprite) + floor((height / 4)), sprite_get_height(sprite)));

    if (itemDrawLeft < 0 || ((itemDrawLeft < 0) != (itemDrawRight > width)))
    {
        itemDrawLeft = sprite_get_bbox_left(sprite);
        itemDrawRight = min(itemDrawLeft + width, sprite_get_bbox_right(sprite));
    }
    if (itemDrawTop < 0 || ((itemDrawTop < 0) != (itemDrawBottom > height)))
    {
        itemDrawTop = sprite_get_bbox_top(sprite);
        itemDrawBottom = min(itemDrawTop + height, sprite_get_bbox_bottom(sprite));
    }

    // Getting the dimensions of the region to be draw
    var itemDrawBoxWidth; itemDrawBoxWidth = abs(itemDrawLeft - itemDrawRight);
    var itemDrawBoxHeight; itemDrawBoxHeight = abs(itemDrawTop - itemDrawBottom);

    var bboxWidth; bboxWidth = abs(bbox_left - bbox_right);
    var bboxHeight; bboxHeight = abs(bbox_top - bbox_bottom);
    var boxLeft; boxLeft = bbox_left + 2;
    var boxTop; boxTop = bbox_top + 2;

    var drawX; drawX = max(boxLeft + (xscale < 0) * itemDrawBoxWidth, boxLeft + (xscale < 0) * itemDrawBoxWidth + floor(width / 2) - floor(itemDrawBoxWidth / 2)) + itemDrawOffsetX;
    var drawY; drawY = max(boxTop + (yscale < 0) * itemDrawBoxHeight, boxTop + (yscale < 0) * itemDrawBoxHeight + floor(height / 2) - floor(itemDrawBoxHeight / 2)) + itemDrawOffsetY;

    // the actual sprite drawing happens here
    d3d_set_fog(true, make_color_rgb(0, 120, 255), 0, 0);
    draw_sprite_part_ext(sprite, subimage, itemDrawLeft, itemDrawTop, itemDrawBoxWidth, itemDrawBoxHeight, drawX, drawY, xscale, yscale, color, alpha);
    d3d_set_fog(false, 0, 0, 0);
    draw_set_blend_mode(bm_add);
    draw_sprite_part_ext(sprite, subimage, itemDrawLeft, itemDrawTop, itemDrawBoxWidth, itemDrawBoxHeight, drawX, drawY, xscale, yscale, color, alpha);
    draw_set_blend_mode(bm_normal);
}

// super arm flash
if (superArmFlashTimer mod (2 * superArmFlashInterval) >= superArmFlashInterval || superArmThrown || superArmHoldOwner != noone)
{
    draw_set_blend_mode(bm_add);
    drawSelf();
    draw_set_blend_mode(bm_normal);
    draw_set_alpha(1);
}
