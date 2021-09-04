#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
/// A gimmick exclusive to Dark Man's Castle stage 4 in MM5. It will stay still unless there
// are no Dark Man blocks or Falling Tower stoppers blocking it, at which point it will
// shake and then fall upwards.

// You can flip this in editor to make upside down towers.

event_inherited();

blockCollision = 0;
grav = 0;
canHit = false;
bubbleTimer = -1;

isSolid = 1;

respawnRange = -1;
despawnRange = -1;

shiftVisible = 3;

// Customizable variables

// @cc the depth of the tile layer to attach to the tower
myTile = 10;

// @cc whatever this is set to will be added to myTile in the code to determine how
// many tile layers to iterate over in the code. For example, if this is set to 2,
// and myTile is 10, the tower will have control over tile depths 10, 11, and 12.
// to be used with animated tiles.
additionalTile = 0;

// @cc if set to true, the falling tower will change the section boundaries and attach
// itself to the camera
setCamera = true;

// @cc the speed of the tower's ascent
spd = 8;

// What stops the darkman tower from ascending
blockObject[0] = objDarkmanBlock;
blockObject[1] = objFallingTowerStop;

// other variables that you Probably shouldn't be setting
height = 1;
width = 1;

fall = false;

init = 1;
getY = y;
xOffset = 0;

timer = 0;
sectionTop = -1;
sectionBottom = -1;
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();

// Extending its reach to the stars above
if (init && insideSection(x + 8, y))
{
    // Extend horizontally
    while (insideSection(x - 16, y)
        && tile_layer_find(myTile, x - 16, y - (1 * (sign(image_yscale) == -1)))
        && x > 0)
    {
        x -= 16;
    }
    width = 1;

    while (insideSection(x + (width * 16), y)
        && tile_layer_find(myTile, x + (width * 16), y - (1 * (sign(image_yscale) == -1)))
        && x + (width * 16) < room_width)
    {
        width += 1;
    }
    image_xscale = width;

    // Extend vertically

    // sign(image_yscale) is used here so you can make reverse grav towers.
    while (insideSection(x, y - 16 * sign(image_yscale))
        && tile_layer_find(myTile, x, y - (16 * sign(image_yscale)) + (1 * (sign(image_yscale) == -1))) && y > 0)
    {
        y -= 16 * sign(image_yscale);
    }
    height = 1 * sign(image_yscale);

    while (insideSection(x, y + height * 16)
        && tile_layer_find(myTile, x, y - (1 * (sign(image_yscale) == -1)) + height * 16)
        && y + (height * 16 * sign(image_yscale)) < room_height)
    {
        height += 1 * sign(image_yscale);
    }

    image_yscale = height;

    init = 0;
}

// If Mega Man isn't active, don't do anything yet
with (objMegaman)
{
    if (showReady || teleporting)
    {
        exit;
    }
}

// Actual AI + checking for if you should fall
if (entityCanStep() && insideSection(x + 8, y))
{
    // Reset fall variable unless it's reached the top of the section
    if ((global.sectionTop > sectionTop && sign(image_yscale) == 1)
        || (global.sectionBottom < sectionBottom && sign(image_yscale) == -1))
    {
        fall = true;
    }

    // Check for any objects that should stop the darkman towers from falling
    for (var o = 0; o < array_length_1d(blockObject); o += 1)
    {
        for (i = 0; i <= image_xscale; i += 1)
        {
            towerBlock = collision_point(x + 8 + (i * 16), y - 1 * sign(image_yscale), blockObject[o], false, true);

            // if the tower block is found
            if (towerBlock)
            {
                if (!towerBlock.dead)
                {
                    fall = false;
                    yspeed = 0;
                    timer = 0;
                }
            }
        }
    }

    // Set camera properly + stop falling if it's hit the top of the section
    if (instance_exists(objMegaman))
    {
        // make the darkman tower the focus of the screen
        if (setCamera)
        {
            objMegaman.viewPlayer = 0;

            if (sectionTop == -1 && sign(image_yscale) == 1)
            {
                sectionTop = global.sectionTop;
                global.sectionTop = view_yview;
                global.sectionBottom = global.sectionTop + view_hview;
            }

            if (sectionBottom == -1 && sign(image_yscale) == -1)
            {
                sectionBottom = global.sectionBottom;
                global.sectionBottom = view_yview + view_hview;
                global.sectionTop = global.sectionBottom - view_hview;
            }
        }

        if ((global.sectionTop <= sectionTop && sign(image_yscale) == 1)
            || (global.sectionBottom >= sectionBottom && sign(image_yscale) == -1))
        {
            fall = false;
            yspeed = 0;
            timer = 0;
            objMegaman.viewPlayer = 1;
            if (sign(image_yscale) == 1)
            {
                global.sectionTop = sectionTop;
            }
            else
            {
                global.sectionBottom = sectionBottom;
            }
        }
    }

    // this code will need some serious cleanup eventually but rn i'm too tired
    // and celebrating over the fact that this even works again
    if (fall)
    {
        // Shaking effect
        if (timer > 0 && timer < 60)
        {
            if (timer == (floor(timer / 4) * 4))
            {
                for (i = myTile; i <= myTile + additionalTile; i += 1)
                {
                    tile_layer_shift(i, 1, 0);
                }

                xOffset += 1;
                if (place_meeting(x, y - 1 * sign(image_yscale), objMegaman))
                {
                    with (objMegaman)
                    {
                        shiftObject(1, 0, true);
                    }
                }
            }
            if (timer == (floor(timer / 4) * 4) + 1)
            {
                view_xview[0] = view_xview[0] + 1;
                for (i = myTile; i <= myTile + additionalTile; i += 1)
                {
                    tile_layer_shift(i, 1, 0);
                }

                xOffset += 1;
                if (place_meeting(x, y - 1 * sign(image_yscale), objMegaman))
                {
                    with (objMegaman)
                    {
                        shiftObject(1, 0, true);
                    }
                }
            }
            if (timer == (floor(timer / 4) * 4) + 2)
            {
                for (i = myTile; i <= myTile + additionalTile; i += 1)
                {
                    tile_layer_shift(i, -1, 0);
                }

                xOffset -= 1;
                if (place_meeting(x, y - 1 * sign(image_yscale), objMegaman))
                {
                    with (objMegaman)
                    {
                        shiftObject(-1, 0, true);
                    }
                }
            }
            if (timer == (floor(timer / 4) * 4) + 3)
            {
                view_xview[0] = view_xview[0] - 1;
                for (i = myTile; i <= myTile + additionalTile; i += 1)
                {
                    tile_layer_shift(i, -1, 0);
                }

                if (place_meeting(x, y - 1 * sign(image_yscale), objMegaman))
                {
                    with (objMegaman)
                    {
                        shiftObject(-1, 0, true);
                    }
                }
                xOffset -= 1;
            }
        }
        else if (xOffset != 0)
        {
            for (i = myTile; i <= myTile + additionalTile; i += 1)
            {
                tile_layer_shift(i, -xOffset, 0);
            }

            if (place_meeting(x, y - 1 * sign(image_yscale), objMegaman))
            {
                with (objMegaman)
                {
                    shiftObject(-other.xOffset, 0, true);
                }
            }
            xOffset -= xOffset;
        }
    }
}
else
{
    if (!insideSection(x, y))
    {
        timer = 0;
        fall = false;
        yspeed = 0;
    }
}
#define Step_1
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();

// For some reason, this wasn't working as intended if I moved this out of begin step,
// but the autoextending only worked in Step. Idk.

if (entityCanStep() && insideSection(x + 8, y))
{
    // Falling animation
    if (fall)
    {
        timer += 1;
        if (timer >= 60)
        {
            // set yspeed
            yspeed = -spd * sign(image_yscale);

            // move player and their projectiles
            if (!place_meeting(x, y - (1 + (abs(yspeed))) * sign(image_yscale), objMegaman)
                && collision_rectangle(x, view_yview - view_hview, x + image_xscale * 16, view_yview + view_hview * 2, objMegaman, false, true))
            {
                with (objMegaman)
                {
                    shiftObject(0, other.yspeed, true);
                }
            }

            if (instance_exists(prtPlayerProjectile) && setCamera)
            {
                with (prtPlayerProjectile)
                {
                    y += other.yspeed;
                }
            }

            // failsafe
            if ((global.sectionTop <= sectionTop && sign(image_yscale) == 1)
                || (global.sectionBottom >= sectionBottom && sign(image_yscale) == -1))
            {
                fall = false;
                yspeed = 0;
                timer = 0;

                if (sign(image_yscale) == 1)
                {
                    global.sectionTop = sectionTop;
                }
                else
                {
                    global.sectionBottom = sectionBottom;
                }
                exit;
            }

            // move section bounds and tiles
            if (setCamera)
            {
                global.sectionTop += yspeed;
                global.sectionBottom += yspeed;
            }

            for (i = myTile; i <= myTile + additionalTile; i += 1)
            {
                tile_layer_shift(i, 0, other.yspeed);
            }
        }
    }
    else
    {
        timer = 0;
        yspeed = 0;
    }
}