/// positionCollision(x, y, [noSlopeConditions], [alwaysCheckSolids])
// Check for solid at the given x, y coordinates

var remask; remask = mask_index;
var rexsc; rexsc = image_xscale;
var reysc; reysc = image_yscale;
var reimg; reimg = image_index;
var alwaysCheckSolids; alwaysCheckSolids = 0;
var noSlopeConditions; noSlopeConditions = 0;
if (argument_count > 3)
    noSlopeConditions = argument[3];
if (argument_count > 4)
    alwaysCheckSolids = argument[4];

mask_index = sprDot;
image_xscale = 1;
image_yscale = 1;
image_index = 0;

var _re; _re = checkSolid(argument[0] - x, argument[1] - y, noSlopeConditions, alwaysCheckSolids);

mask_index = remask;
image_xscale = rexsc;
image_yscale = reysc;
image_index = reimg;

return (_re);
