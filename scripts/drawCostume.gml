/// drawCostume(costume, sheetX, sheetY, x, y, xscale, yscale, colBase, colPrimary, colSecondary, colOutline, [alphaBase = 1, alphaPrimary = 1, alphaSecondary = 1, alphaOutline = 1])
// draws the given costume (player skin) at the given coordinates with the given palette.
// costume: sprite index of costume (e.g. objMegaman)
// sheetX, sheetY: coord (in 48x48 units) of the animation frame in the skin sheet.
// colBase: blend mode to use for the base colour (leave as c_white)
// colPrimary, colSecondary, colOutline: palette colours
// [alphaBase, alphaPrimary, alphaSecondary, alphaOutline] (optional): alpha values for palette (0-1)

var costume; costume = argument[0]
var sheetX;sheetX = argument[1]
var sheetY;sheetY = argument[2]
var _x;_x = argument[3]
var _y;_y = argument[4]
var _xscale;_xscale = argument[5]
var _yscale;_yscale = argument[6]
var col;
var alpha;
var i;

// palette
for (i = 0; i < 4; i+=1)
{
    col[i] = argument[7 + i];
    if (argument_count > 11 + i)
        alpha[i] = argument[11 + i];
    else
        alpha[i] = 1;
}

var SquareSize; SquareSize = 48;

for (i = 0; i < 4; i += 1)
{
    draw_sprite_part_ext(costume, i,
        1 + (floor(sheetX) * (SquareSize + 3)),
        1 + (floor(sheetY) * (SquareSize + 3)), SquareSize,
        SquareSize, round(_x) - (24 * _xscale),
        round(_y) - (20 * _yscale), _xscale, _yscale,
        col[i], alpha[i]);
}
