#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();
canHit = false;

grav = 0;
blockCollision = 0;
bubbleTimer = -1;

respawnRange = -1;
despawnRange = -1;

moving = 0;
blowSpeed = -0.5;
shiftVisible = 3;

imgalarm = 0;
img = 1;

// mylayer = 1000000-1000;
mylayer = -100;

alarm[0] = 1;

bg = bgToadRain;
#define Alarm_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
setSection(x + 8, y + 8, 0);

xscale = -sign(blowSpeed);
if (xscale == 0)
{
    xscale = 1;
}

for (x = sectionLeft; x < sectionRight; x += 16)
{
    for (y = sectionTop; y < sectionBottom; y += 16)
    {
        if (!tile_layer_find(1000000, x, y))
        {
            t = instance_create(x, y, objToadRain);
            t.blowSpeed = blowSpeed;
            t.parent=id;

            if (place_meeting(x, y + 8, objSolid)
                || place_meeting(x, y + 16, objTopSolid))
            {
                top = 16;
            }
            else
            {
                top = 0;
            }

            for (i = 0; i <= 2; i += 1)
            {
                t = tile_add(bg, 0 + 16 * i, top, 16, 16, x + (xscale == -1) * 16, y, mylayer + i);
                tile_set_scale(t, xscale, 1);
            }
        }
    }
}

tile_layer_hide(mylayer + 1);
tile_layer_hide(mylayer + 2);

x = xstart;
y = ystart;
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();

if ((!global.frozen && !dead || instance_exists(objSectionSwitcher))
&& insideSection(x, y))
{
    with (objMegaman)
    {
        if (instance_exists(objSectionSwitcher))
        {
            exit;
        }

        if (place_meeting(x, y, objToadRain) && !instance_exists(objWireAdapter))
        {
            if (ground)
            {
                if (xspeed != 0)
                {
                    other.moving += 1;
                    if (other.moving == 20)
                    {
                        other.moving = 0;
                        if (image_xscale == -1)
                        {
                            with (instance_create(bbox_right - 2, bbox_bottom, objSlideDust))
                            {
                                sprite_index = sprRainSplash;
                                image_xscale = -1;
                            }
                        }
                        else
                        {
                            with (instance_create(bbox_left + 2, bbox_bottom, objSlideDust))
                            {
                                sprite_index = sprRainSplash;
                            }
                        }
                    }
                }
            }
            else
            {
                shiftObject(other.blowSpeed, 0, 1);
            }
        }
    }

    imgalarm += 1;
    if (imgalarm >= 8)
    {
        imgalarm = 0;
        if (img == 1)
        {
            tile_layer_show(mylayer);
            tile_layer_hide(mylayer + 1);
            tile_layer_hide(mylayer + 2);
        }
        else if (img == 2)
        {
            tile_layer_hide(mylayer);
            tile_layer_show(mylayer + 1);
            tile_layer_hide(mylayer + 2);
        }
        else if (img == 3)
        {
            tile_layer_hide(mylayer);
            tile_layer_hide(mylayer + 1);
            tile_layer_show(mylayer + 2);
        }
        img += 1;
        if (img == 4)
        {
            img -= 3;
        }
    }
}
#define Draw_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
// No
