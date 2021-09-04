// setScreenSize(screenSize, [shift])
// argument0: screen size
// argument1: shift screen to centre? default: true

var ns; ns = argument[0];
var shift; shift = true;
if (argument_count > 1)
{
    shift = argument[1];
}
var xsize; xsize = global.screenWidth;
var ysize; ysize = global.screenHeight;
var full; full = 0;

var s; s = max(1, min(ns, display_get_height() / ysize, display_get_width() / xsize));

full = ns > s;

window_set_fullscreen(full);

if (!full)
{
    s = ceil(s);

    xsize *= s;
    ysize *= s;

    window_set_size(xsize, ysize);

    if (shift)
    {
        window_set_position(
            floor((display_get_width() - xsize) / 2),
            floor((display_get_height() - ysize) / 2));
    }
}

global.screensize = s;

window_resize_buffer(view_wview[0] * global.screensize, view_hview[0] * global.screensize + (global.screensize == 1));
