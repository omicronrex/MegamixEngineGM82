#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();

sandWidth = sprite_get_width(sprite_index);
imgsp = 0.125;
stretchX = 1;
stretchY = 1;
stopXScale = false;
noRain = true;

// Autocombine quicksand stuff
if (!instance_place(x - sandWidth, y, objQuickSand)
    && instance_place(x + sandWidth, y, objQuickSand))
{
    do
    {
        if (place_meeting(x + sandWidth * stretchX, y - 16, objQuickSand))
        {
            stopXScale = true;
        }

        // ignore destroy fields
        if (place_meeting(x + sandWidth * stretchX, y, objDestroyField))
        {
            stopXScale = true;
        }

        if (!stopXScale)
        {
            sand = instance_place(x + sandWidth * stretchX, y, objQuickSand);
            with (sand)
            {
                instance_destroy();
            }
            stretchX += 1;
        }
    } until (!place_meeting(x + sandWidth * stretchX, y, objQuickSand)
        || stopXScale)
}

stopYScale = false;

if (!instance_place(x, y - 1, objQuickSand) && stretchX > 1)
{
    while (instance_place(x + 1, y + 16 * stretchY, objQuickSand)
        && !stopYScale)
    {
        for (i = 0; i < stretchX; i += 1)
        {
            if (!instance_place(x + sandWidth * i, y + 16 * stretchY,
                objQuickSand)
                && !instance_place(x + sandWidth * i, y - 16, objQuickSand))
            {
                stopYScale = false;
            }
        }
        if (!stopYScale)
        {
            for (i = 0; i < stretchX; i += 1)
            {
                sand = instance_place(x + sandWidth * i, y + 16 * stretchY,
                    objQuickSand);
                with (sand)
                {
                    instance_destroy();
                }
            }
            if (!stopYScale)
            {
                stretchY += 1;
            }
        }
    }
}

if (stretchX > 1)
{
    image_xscale = stretchX;
}
#define Step_1
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if (!global.frozen) && (noRain)
{
    image_speed = imgsp;

    with (objMegaman)
    {
        if (place_meeting(x, y + gravDir, other.id) || place_meeting(x, y, other.id))
        {
            shiftObject(0, 0.125, 1);
        }
    }

    with (objRainFlush)
    {
        if (timer >= 30)
        {
            other.noRain = false;
        }
    }
}
else
{
    image_speed = 0;
}
print(noRain);
#define Draw_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
for (i = 0; i < image_xscale; i += 1)
{
    for (j = stretchY - 1; j >= 0; j -= 1)
    {
        draw_sprite(sprite_index, -1,
            round(x) + sprite_get_width(sprite_index) * i,
            round(y) + j * 16);
    }
}
