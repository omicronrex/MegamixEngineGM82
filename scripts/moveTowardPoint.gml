/// moveTowardPoint(targetX, targetY, speed)
// sets xspeed, yspeed to bring this entity to the given target coordinates.
// returns true if already at those coordinates.

var targetX; targetX = argument0;
var targetY; targetY = argument1;
var moveSpeed; moveSpeed = argument2;

// cap speed if near target
moveSpeed = min(moveSpeed, point_distance(x, y, targetX, targetY));

var deltaX; deltaX = targetX - x;
var deltaY; deltaY = targetY - y;
if (deltaX == 0 && deltaY == 0)
{
    xspeed = 0;
    yspeed = 0;
    return true;
}

//var norm; norm = sqrt(deltaX * deltaX + deltaY * deltaY);
var dir; dir = point_direction(x,y,targetX,targetY);
xspeed = moveSpeed*cos(degtorad(dir));//deltaX * moveSpeed / norm;
yspeed = -moveSpeed*sin(degtorad(dir));//deltaY * moveSpeed / norm;

return false;
