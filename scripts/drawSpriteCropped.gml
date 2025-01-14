/// drawSpriteCropped(sprite, image index, x, y, left, top, right, bottom, xscale, yscale, colour, alpha)
// draws the given sprite as usual, but constrained to the given rectangle.
// a more convenient interface to draw_sprite_ext

var spr; spr = argument0;
var img; img = argument1;
var _x; _x = argument2;
var _y; _y = argument3;
var left; left = argument4;
var top; top = argument5;
var width; width = argument6 - argument4 + 1;
var height; height = argument7 - argument5 + 1;
var xscale; xscale = argument8;
var yscale; yscale = argument9;
var colour; colour = argument10;
var alpha; alpha = argument11;
var sprWidth; sprWidth = sprite_get_width(spr) * xscale;
var sprHeight; sprHeight = sprite_get_height(spr) * yscale;

assert(xscale >= 0, "negative xscale hasn't been implemented yet... it's tricky... sorry...");
assert(yscale >= 0, "negative yscale hasn't been implemented yet... it's tricky... sorry...");

var trueX; trueX = max(_x, left);
var trueY; trueY = max(_y, top);
if (trueX < left - sprWidth)
{
    exit;
}
if (trueY < top - sprHeight)
{
    exit;
}
if (trueX >= left + width)
{
    exit;
}
if (trueY >= top + height)
{
    exit;
}
var trueRight; trueRight = left + width;
var trueBottom; trueBottom = top + height;
var trueWidth; trueWidth = trueRight - trueX;
var trueHeight; trueHeight = trueBottom - trueY;
var sprLeft, sprTop_, sprWidth, sprHeight;

// xscale
if (xscale != 0)
{
    sprLeft = (trueX - _x) / xscale;
    sprWidth = trueWidth / xscale;
}
else
{
    exit;
}

// yscale
if (yscale != 0)
{
    sprTop_ = (trueY - _y) / yscale;
    sprHeight = trueHeight / yscale;
}
else
{
    exit;
}
draw_sprite_part_ext(spr, img, sprLeft, sprTop_, sprWidth, sprHeight, trueX, trueY, xscale, yscale, colour, alpha);
