#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
/// To use just stretch the object

event_inherited();

blockCollision = 0;
image_speed = 0.45;
active = false;
startLen = image_xscale;
imgIndex = 0;

//@cc
mySpeed = 2;

//@cc
platformSprite = noone;

if (startLen > 0)
{
    platformSprite = sprRingManPlatformBridge;
}
else
{
    platformSprite = sprRingManPlatformRainbow;
}
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if (!global.frozen && !global.timeStopped)
{
    imgIndex += image_speed;

    // if a player lands on the platform, activate
    with (objMegaman)
    {
        if (place_meeting(x, y + gravDir, other)
            && !place_meeting(x, y, other))
        {
            other.active = true;
        }
    }

    // shrink and grow the platform when active
    if (active)
    {
        // decrease size
        if (image_xscale * sign(startLen) > -startLen * sign(startLen))
        {
            image_xscale -= (1 / 16) * mySpeed * sign(startLen);
        }

        // swich sides when heading into the negative
        if (sign(image_xscale) != sign(startLen))
        {
            x = xstart + (startLen * 16);
        }

        // reset
        if (image_xscale * sign(startLen) <= -startLen * sign(startLen))
        {
            x = xstart;
            active = false;
            image_xscale = startLen;
        }
    }
}
#define Draw_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if (image_xscale != 0)
{
    var posOffset; posOffset = max(sign(image_xscale), 0)
    var negOffset; negOffset = min(sign(image_xscale), 0);

    // body
    for (i = -negOffset; i < floor(abs(image_xscale)) - negOffset; i+=1)
    {
        draw_sprite(platformSprite, floor(imgIndex), floor(x + (i * 16) * sign(image_xscale)), floor(y));
    }

    // tail
    var tileOffset; tileOffset = abs(image_xscale mod 1);
    draw_sprite_part(platformSprite, floor(imgIndex), floor((16 * (1 - tileOffset)) * abs(negOffset)), 0, floor(16 * tileOffset), 16, floor(x + floor(image_xscale) * 16 - (16 - tileOffset * 16) * negOffset), floor(y));

    // sparkle tail for rainbow roa- bridge
    if (platformSprite == sprRingManPlatformRainbow && image_xscale != startLen)
    {
        draw_sprite_ext(sprRingManPlatformTrail, floor(imgIndex), floor(x + image_xscale * 16), floor(y), sign(image_xscale), image_yscale, image_angle, image_blend, image_alpha);
    }
}
