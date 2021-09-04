#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();

// default values (change these in creation code)

//@cc  my background, if not set the object will be destroyed
myBG = -1;

//@cc if all of these are 0, infer the values to be the size of the background
bgL = 0; // left

//@cc
bgT = 0; // top

//@cc
bgH = 0; // height

//@cc
bgW = 0; // width

//@cc 1: background. 2: sprite. 3: surface. 0: infer.
resourceType = 0;

//@cc Horizontal speed
xspeed = 0;

//@cc Vertical speed
yspeed = 0;

//@cc distance offset (from alignment with room's 0 coordinate)
// positive number shifts to the right/down.
offsetX = 0;

//@cc
offsetY = 0;

//@cc parallax coefficients.
// negative: scrolls in opposite direction as camera
// 0: fixed in place (infinite distance)
// (0, 1): scrolls partly with camera
// 1: scrolls with camera (same parallax depth as game world)
// greater than 1: scrolls faster than camera (parallax foreground)
parallaxX = 1;

//@cc
parallaxY = 1;

//@cc
imgInterval = 4; // Delay between images (sprite only). -1: fixed.

//@cc
snaptogrid = 0; // align to 16x16 grid

//@cc define a custom area; for each value unused, the retrospective border
// of the current section where the object is placed is used as the default
areaLeft = -1;

//@cc
areaRight = -1;

//@cc
areaTop = -1;

//@cc
areaBottom = -1;

// don't edit these:
img = 0;
alarmImg = 0;
timer = 0;
xoff = 0;
yoff = 0;
init = false;
xshift = 0;
yshift = 0;
#define Step_2
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if (!init)
{
    if (myBG < 0)
    {
        instance_destroy();
        exit;
    }

    if (!resourceType) // figure out resource type:
    {
        if (background_exists(myBG))
        {
            resourceType = 1;
        }
        else if (sprite_exists(myBG))
        {
            resourceType = 2;
        }
        else if (surface_exists(myBG))
        {
            resourceType = 3;
        }
        else
        {
            instance_destroy();
            exit;
        }
    }

    if (bgL == 0 && bgT == 0 && bgW == 0 && bgH == 0)
    {
        switch (resourceType)
        {
            case 1: // background:
                bgW = background_get_width(myBG);
                bgH = background_get_height(myBG);
                break;
            case 2: // sprite:
                bgW = sprite_get_width(myBG);
                bgH = sprite_get_height(myBG);
                break;
            case 3: // surface
                bgW = surface_get_width(myBG);
                bgH = surface_get_height(myBG);
                break;
        }
    }

    setSection(x, y, false);

    if (areaLeft > -1)
    {
        sectionLeft = areaLeft;
    }
    if (areaRight > -1)
    {
        sectionRight = areaRight;
    }
    if (areaTop > -1)
    {
        sectionTop = areaTop;
    }
    if (areaBottom > -1)
    {
        sectionBottom = areaBottom;
    }

    init = true;
}

// time-based adjustments:
if (!global.frozen || instance_exists(objSectionSwitcher))
{
    // Image cycling (sprites only)
    if (imgInterval > 0 && resourceType == 2)
    {
        alarmImg += 1;
        if (alarmImg >= imgInterval)
        {
            alarmImg = 0;
            img = (img + 1) mod sprite_get_number(myBG);
        }
    }

    // add speed
    xoff += xspeed;
    yoff += yspeed;
}
#define Draw_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if (!init)
{
    exit;
}

clearDrawState();

// set position
xshift = xoff - view_xview[0] * (parallaxX - 1);
yshift = yoff - view_yview[0] * (parallaxY - 1);

xshift = modf(xshift, bgW);
yshift = modf(yshift, bgH);

if (snaptogrid)
{
    xshift = roundTo(xshift, 16);
    yshift = roundTo(yshift, 16);
}

var xDrawBase; xDrawBase = view_xview[0] + modf(xshift - view_xview[0] + offsetX, bgW);
var yDrawBase; yDrawBase = view_yview[0] + modf(yshift - view_yview[0] + offsetY, bgH);

xDrawBase = floor(xDrawBase);
yDrawBase = floor(yDrawBase);

for (i = -1; i < ceil(view_wview[0] / bgW) + 1; i += 1)
{
    for (j = -1; j < ceil(view_hview[0] / bgH) + 1; j += 1)
    {
        // determine offset of this backgroud chunk
        var xDraw; xDraw = i * bgW + xDrawBase;
        var yDraw; yDraw = j * bgH + yDrawBase;

        // restrict-to-section logic
        var addX; addX = 0;
        var addY; addY = 0;
        var partX; partX = bgL;
        var partY; partY = bgT;
        var partW; partW = bgW;
        var partH; partH = bgH;

        if (xDraw + bgW <= sectionLeft)
        {
            continue;
        }
        if (xDraw >= sectionRight)
        {
            continue;
        }
        if (yDraw + bgH <= sectionTop)
        {
            continue;
        }
        if (yDraw >= sectionBottom)
        {
            continue;
        }

        if (xDraw <= sectionLeft)
        {
            partX = max(bgL, sectionLeft - xDraw + bgL);
            partW -= partX - bgL;
            addX += partX - bgL;
        }
        if (yDraw <= sectionTop)
        {
            partY = max(bgT, sectionTop - yDraw + bgT);
            partH -= partY - bgT;
            addY += partY - bgT;
        }
        if (xDraw + bgW >= sectionRight)
        {
            partW = min(partW, sectionRight - xDraw);
        }
        if (yDraw + bgH >= sectionBottom)
        {
            partH = min(partH, sectionBottom - yDraw);
        }

        if (partW < 0 || partH < 0)
        {
            continue;
        }

        xDraw += addX;
        yDraw += addY;

        // draw background
        switch (resourceType)
        {
            case 1:
                draw_background_part(myBG, partX, partY, partW, partH, xDraw, yDraw);
                break;
            case 2:
                draw_sprite_part(myBG, img, partX, partY, partW, partH, xDraw, yDraw);
                break;
            case 3:
                draw_surface_part(myBG, partX, partY, partW, partH, xDraw, yDraw);
                break;
        }
    }
}
