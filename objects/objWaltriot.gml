#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
/// Put this enemy on a wall or he will commit seppuku
// Note: don't change its image_xscale/image_yscale in the editor, rotate it instead
// Note: make sure its aligned with the solid you want it to move on

event_inherited();
healthpointsStart = 2;
healthpoints = 2;
contactDamage = 3;
blockCollision = false;
facePlayerOnSpawn = false;
grav = 0;
image_xscale = 1;
image_yscale = 1;

// Creation code:

//@cc movement speed
spd = 1.65; // Speed

//@cc how much it moves in each direction(from it's perspective) -1 ->unlimited
leftLimit = 32;

//@cc
rightLimit = 32;

//@cc How many pixels it moves before launching a missile
shootAfter = 128;

//@cc direction in which it will move when it spawns(from its perspective);
//@cc 1:right, -1:left;
startDir = 1;

//@cc Color
//@cc 0:blue, 1:pink
col = 0;

phase = 0;
timer = 0;
dir = 1;
pixelsMoved = 0;
myMissile = noone;
animFrame = 0;
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
xprevious = x;
yprevious = y;
event_inherited();

if (entityCanStep())
{
    var myRad; myRad = degtorad(image_angle + 90);
    if (!checkSolid(-cos(myRad) * 8, sin(myRad) * 8))
    {
        event_user(EV_DEATH);
        exit;
    }

    var xdir; xdir = cos(degtorad(image_angle));
    var ydir; ydir = -sin(degtorad(image_angle));
    var destRX; destRX = xstart + xdir * rightLimit;
    var destRY; destRY = ystart + ydir * rightLimit;
    var destLX; destLX = xstart - xdir * leftLimit;
    var destLY; destLY = ystart - ydir * leftLimit;

    var stop; stop = false;
    var reverse; reverse = false;
    if (xspeed != 0 || yspeed != 0)
    {
        if (rightLimit != -1 && dir == 1 && sign(destRX - x) == -sign(dir * xdir) && sign(destRY - y) == -sign(dir * ydir))
        {
            stop = true;
            reverse = true;
            x = destRX;
            y = destRY;
        }
        else if (leftLimit != -1 && dir == -1 && sign(destLX - x) == -sign(dir * xdir) && sign(destLY - y) == -sign(dir * ydir))
        {
            stop = true;
            reverse = true;
            x = destLX;
            y = destLY;
        }
    }
    timer += 1;
    if (!instance_exists(myMissile) && timer == 30 && pixelsMoved >= shootAfter)
    {
        myMissile = instance_create(x + cos(myRad) * 8, y - sin(myRad) * 8, objWaltriotMissile);
        myMissile.angle = round(wrapAngle(image_angle + 90) / 45) * 45;
        myMissile.newAngle = myMissile.angle;
        myMissile.col = col;
        animFrame = 1;
        pixelsMoved = 0;
    }
    if (timer > 60)
    {
        xspeed = spd * xdir * dir;
        yspeed = spd * ydir * dir;
        timer = 61;
    }
    else if (animFrame == 0 && timer > 30)
    {
        timer = 61;
    }

    if (xspeed != 0 || yspeed != 0)
    {
        if (checkSolid(xspeed, yspeed, 1) || !checkSolid(16 * dir * xdir - 8 * cos(myRad), 16 * dir * ydir + 8 * sin(myRad), 1))
        {
            stop = true;
            reverse = true;
        }
    }
    if (!instance_exists(myMissile) && (xspeed != 0 || yspeed != 0))
    {
        if (!stop)
            pixelsMoved += abs(x - xprevious) + abs(y - yprevious);
        if (pixelsMoved >= shootAfter)
        {
            stop = true;
        }
    }

    if (animFrame > 0)
    {
        if (floor(animFrame) != 2)
        {
            animFrame += 0.135;
        }
        else
            animFrame += 0.05;
        if (floor(animFrame) > 4)
        {
            animFrame = 0;
        }
    }
    if (stop)
    {
        xspeed = 0;
        yspeed = 0;
        timer = 0;
        if (reverse)
            dir *= -1;
    }
    image_index = col * 5 + floor(animFrame);
}
#define Other_25
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();
phase = 0;
timer = 0;
dir = sign(startDir);
image_xscale = 1;
image_yscale = 1;
pixelsMoved = shootAfter;
myMissile = noone;
