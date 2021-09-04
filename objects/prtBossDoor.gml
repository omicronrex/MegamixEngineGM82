#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
/// The classic boss door, place as many as you want togheter
event_inherited();
faction = 6;

canHit = false;

shiftVisible = 2;

respawnRange = -1;
despawnRange = -1;

inWater = -1;
grav = 0;
blockCollision = 0;

isSolid = 1;

// Entity specific variables
type = 'h';

//@cc -1 = opened from the left (default); 1 = opened from the right); 0 = opened both ways;
dir = 0;

height = 0;
doorHeight = 0;

opening = false;
closing = false;
canOpen = true;

imgSpeed = 0.125;
layer = 1000000;

//@cc true / false (default)
isTile = false;

destroyDelay = 1;
#define Destroy_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
var i, z, t;

if (isTile && type != '' && !destroyDelay)
{
    for (i = 0; i < image_xscale; i += 1)
    {
        for (z = 0; z < image_yscale; z += 1)
        {
            t = tile_layer_find(layer, x + i * 16, y + z * 16);
            if (t)
            {
                tile_delete(t);
            }
        }
    }
}
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();

if (canOpen)
{
    var player; player = collision_rectangle(bbox_left + 3, bbox_top + 3, bbox_right - 3, bbox_bottom - 3, objMegaman, false, false);

    if (player)
    {
        if (!player.teleporting)
        {
            if (type != "")
            {
                canOpen = false;
                opening = true;

                with (player)
                {
                    isShoot = 0;

                    if (other.type == "h")
                    {
                        var i; i = sign(bboxGetXCenterObject(other.id) - x);
                        setSection(x + (other.sprite_width + sprite_get_width(mask_index)) * i, y, 1);
                        var xy; xy = "x";
                        var b; b = abs((other.bbox_right - global.sectionLeft) * (i == 1) + (other.bbox_left - global.sectionRight) * (i == -1));
                    }
                    if (other.type == "v")
                    {
                        var i; i = sign(bboxGetYCenterObject(other.id) - y);
                        setSection(x, y + (other.sprite_height + sprite_get_height(mask_index)) * i, 1);
                        var xy; xy = "y";
                        var b; b = abs((other.bbox_bottom - global.sectionTop) * (i == 1) + (other.bbox_top - global.sectionBottom) * (i == -1)) + 8;
                    }
                }

                with (instance_create(x, y, objSectionSwitcher))
                {
                    dir = xy;
                    num = i;
                    door = true;
                    doorWait = other.height;
                    borderDistance = max(borderDistance, b + 8);
                    show_debug_message(string(borderDistance));
                }
            }
        }
    }
}

if (closing || opening)
{
    var lastHeightFrame; lastHeightFrame = doorHeight;

    doorHeight = clamp(doorHeight + imgSpeed * (1 - (!closing) * 2), 0, height);

    if (floor(doorHeight) != floor(lastHeightFrame))
    {
        playSFX(sfxDoor);
        if (isTile)
        {
            if (type == 'h')
            {
                for (i = 0; i < image_xscale; i += 1)
                {
                    t = tile_layer_find(layer,
                        x + i * 16,
                        y + (floor(doorHeight) - 1 + opening) * 16);
                    if (t)
                    {
                        tile_set_visible(t, closing);
                    }
                }
            }
            if (type == 'v')
            {
                for (i = 0; i < image_yscale; i += 1)
                {
                    t = tile_layer_find(layer,
                        x + (floor(doorHeight) - 1 + opening) * 16,
                        y + i * 16);
                    if (t)
                    {
                        tile_set_visible(t, closing);
                    }
                }
            }
        }
    }

    if (floor(doorHeight) == height && closing)
    {
        with (objSectionSwitcher)
        {
            event_user(1);
        }
        doorHeight = height;
        closing = false;
        canOpen = true;
        opening = false;
    }
}

if (global.lockTransition)
{
    fnsolid = 0;
}
else
{
    fnsolid = 2;

    if (type == 'h')
    {
        if ((dir == 1 && bbox_right < global.sectionRight - 8)
            || (dir == -1 && bbox_left > global.sectionLeft + 8))
        {
            fnsolid = 0;
        }
    }
    if (type == 'v')
    {
        if ((dir == 1 && bbox_bottom < global.sectionBottom - 8)
            || (dir == -1 && bbox_top > global.sectionTop + 8))
        {
            fnsolid = 0;
        }
    }
}
#define Step_2
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
///No
#define Other_13
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if (!instance_exists(id))
{
    exit;
}

// Check if not in upper-left corner
if (place_meeting(x, y - 4, object_index)
    || place_meeting(x - 4, y, object_index))
{
    exit;
}


if(type=='h')
{

    // Set vertical (horizontal door)
    var inst; inst = instance_place(x, y + 4, object_index);
    while (inst!=noone)
    {
        while(inst!=noone)
        {
            with(inst)
                instance_destroy();
            inst = instance_place(x, y + 4, object_index);
        }
        image_yscale += 1;
        inst = instance_place(x, y + 4, object_index);
    }

    // Set horizontal (vertical door)
    inst = instance_place(x + 4, y, object_index);
    while (inst!=noone)
    {
        while(inst!=noone)
        {
            with(inst)
                instance_destroy();
            inst =  instance_place(x + 4, y, object_index);
        }
        image_xscale += 1;
        inst = instance_place(x + 4, y, object_index);
    }



}
else if(type=='v')
{
    // Set horizontal (vertical door)
    inst = instance_place(x + 4, y, object_index);
    while (inst!=noone)
    {
        while(inst!=noone)
        {
            with(inst)
                instance_destroy();
            inst =  instance_place(x + 4, y, object_index);
        }
        image_xscale += 1;
        inst = instance_place(x + 4, y, object_index);
    }
    // Set vertical (horizontal door)
    var inst; inst = instance_place(x, y + 4, object_index);
    while (inst!=noone)
    {
        while(inst!=noone)
        {
            with(inst)
                instance_destroy();
            inst = instance_place(x, y + 4, object_index);
        }
        image_yscale += 1;
        inst = instance_place(x, y + 4, object_index);
    }

}



if ((type == 'v')) // If vertical
{
    type = 'v';
    height = image_xscale;
    doorHeight = height;

    sprite_index = sprBossDoorVertical;

    dir = place_meeting(x, y, objSectionArrowDown) - place_meeting(x, y, objSectionArrowUp);
}
if ((type == 'h')) // If horizontal
{
    type = 'h';
    height = image_yscale;
    doorHeight = height;

    sprite_index = sprBossDoor;

    dir = place_meeting(x, y, objSectionArrowRight) - place_meeting(x, y, objSectionArrowLeft);
}

var xs, ys, tx, ty, tile;
if (isTile)
{
    // tile split check
    for (xs = 0; xs < image_xscale; xs += 1)
    {
        for (ys = 0; ys < image_yscale; ys += 1)
        {
            tile = tile_layer_find(layer, x + xs * 16, y + ys * 16);
            if (tile)
            {
                if (tile_get_left(tile) > 16 || tile_get_top(tile) > 16)
                {
                    for (tx = 0; tx < tile_get_width(tile); tx += 16)
                    {
                        for (ty = 0; ty < tile_get_height(tile); ty += 16)
                        {
                            tile_add(tile_get_background(tile),
                                tile_get_left(tile) + tx,
                                tile_get_top(tile) + ty, 16, 16,
                                tile_get_x(tile) + tx,
                                tile_get_y(tile) + ty, layer);
                        }
                    }
                    tile_delete(tile);
                }
            }
        }
    }
}

destroyDelay = 0;
#define Draw_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if (!isTile)
{
    var xsc; xsc = image_xscale;
    var ysc; ysc = image_yscale;

    if (type == 'h')
    {
        ysc = doorHeight;
    }
    if (type == 'v')
    {
        xsc = doorHeight;
    }

    // Draw sprite-based door
    var i; for ( i = 0; i < xsc; i+=1)
    {
        var z; for (z = 0; z < ysc; z+=1)
        {
            draw_sprite_ext(sprite_index, image_index,
                x + i * sprite_get_width(sprite_index),
                y + z * sprite_get_height(sprite_index),
                1, 1, image_angle, image_blend, image_alpha);
        }
    }
}
