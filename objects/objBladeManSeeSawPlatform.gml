#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();
canHit = false;

isSolid = 2;
respawn = false;
blockCollision = 0;
grav = 0;
facePlayerOnSpawn = false;

respawnRange = -1;
despawnRange = -1;

phase = 0;

// 0 - default
// 1, 2 - moving down
// 3, 4 - moving up

xPosition = 1; // platform position: -1 = left; 1 = right
yPosition = 1; // platform position: -1 = up; 1 = down

yMin = 0; // upper ordinate value
yMax = 0; // lower ordinate value
canStep = false;

parent = noone;

// see saw center
xMain = 0;
yMain = 0;

centerShift = 0.00;
radiusSquare = 0;

// speed of see-saw
xspeedMain = 0;
yspeedMain = 0;

// speed of platforms
xspeedPlatform = 0;
yspeedPlatform = 0;

accel = 0.2;
mySpeedMax = 4;
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if (!canStep)
    exit;
event_inherited();
if (canStep)
{
    if (phase == 0)
    {
        if (yPosition == -1)
        {
            with (objMegaman)
            {
                if (place_meeting(x, y + 1, other.id) && ground)
                {
                    if (!place_meeting(x, y, other.id))
                    {
                        other.phase = 0.75;
                    }
                }
            }
        }
    }
    if (phase >= 0.75 && phase < 2)
    {
        phase += 0.25;
    }
    if (phase == 2) // Moving down
    {
        yspeedPlatform += accel;
        if (yspeedPlatform > mySpeedMax)
            yspeedPlatform = mySpeedMax;

        if (xPosition == 1)
            xspeedPlatform = xMain + 1 + xPosition * sqrt(radiusSquare - power(yMain + centerShift - y - yspeedPlatform, 2)) - x;
        else
            xspeedPlatform = xMain + xPosition * sqrt(radiusSquare - power(yMain + centerShift - y - yspeedPlatform, 2)) - x;

        if (y >= yMain + yMax)
        {
            // y = yMain + yMax;
            shiftObject((xMain + xPosition * sqrt(radiusSquare - power(yMain + centerShift - y, 2))) - x, (yMain + yMax) - y, true);
            phase = 0;
            yPosition = -yPosition;
            xspeedPlatform = 0;
            yspeedPlatform = 0;
            if (xPosition == 1)
                x += 1;
        }
    }

    if (phase >= 3 && phase < 4)
        phase += 0.25;

    if (phase == 4) // Moving up
    {
        yspeedPlatform += -accel;
        if (yspeedPlatform < -mySpeedMax)
        {
            yspeedPlatform = -mySpeedMax;
        }

        if (xPosition == 1)
            xspeedPlatform = xMain + 1 + xPosition * sqrt(radiusSquare - power(yMain + centerShift - y - yspeedPlatform, 2)) - x;
        else
            xspeedPlatform = xMain + xPosition * sqrt(radiusSquare - power(yMain + centerShift - y - yspeedPlatform, 2)) - x;

        if (y <= yMain - yMin)
        {
            phase = 0;
            yPosition = -yPosition;
            shiftObject((xMain + xPosition * sqrt(radiusSquare - power(yMain + centerShift - y, 2))) - x, (yMain - yMin) - y, true);
            if (xPosition == 1)
                x += 1;
            xspeedPlatform = 0;
            yspeedPlatform = 0;
        }
    }

    xspeed = xspeedMain + xspeedPlatform;
    yspeed = yspeedMain + yspeedPlatform;
}
#define Other_25
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();
phase = 0;
#define Draw_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
var yShift; yShift = 0;
if (y - yMain < 0)
    yShift = 1;
if (y - yMain > 0)
    yShift = -1;

var xDiff; xDiff = 9 * xPosition;
var yDiff; yDiff = (y + 5 + yShift - yMain - 2 - 3 * (y - yMain - yMax) / (yMax + yMin)) / 3;

draw_sprite(sprBladeManSeeSawTether, 0, x, y + 5);
draw_sprite(sprBladeManSeeSawTether, 0, x - xDiff, y + 5 + yShift - yDiff);
draw_sprite(sprBladeManSeeSawTether, 0, x - 2 * xDiff, y + 5 + yShift - 2 * yDiff);

event_inherited();
