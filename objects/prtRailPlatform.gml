#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();
canHit = false;

isSolid = 2;

startingDirection = -1;

grav = 0;
blockCollision = 0;
bubbleTimer = -1;

respawnRange = -1;
despawnRange = -1;

mySpeed = 1;

init = 1;
dir = "none"; // left, up, down, right
startDir = "none";

// distance from the x and y position to check by
xOffset = 8;
yOffset = 8;

// Helpful variable to use in childs
lastRail = noone;
prevRail = noone;
bumped = false;

fallMomentum = 0.25;
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
var xsp = xspeed;
var ysp = yspeed;
xspeed = 0;
yspeed = 0;
event_inherited();
xspeed = xsp;
yspeed = ysp;
if (init)
{
    lastRail = collision_point(x + xOffset, y + yOffset, prtRail, true, true);
    if (dir == "none"
        && instance_exists(lastRail))
    {
        // by default, the platform goes vertically on corner tiles
        switch (lastRail.dir)
        {
            case 0:
                dir = "right";
                break;
            case 1:
            case 3:
            case 5:
                dir = "up";
                break;
            case 2:
            case 4:
                dir = "down";
                break;
        }
        if(startDir == "none")
            startDir = dir;
        init = false;
    }
}

if (entityCanStep())
{
    bumped = false;
    event_user(0);

    if (dir == "none")
    {
        dir = "fall";
    }

    if (dir != "fall")
    {
        xspeed = 0;
        yspeed = 0;
    }
    if (instance_exists(lastRail))
    {
        switch (lastRail.dir)
        {
            case 0: // horizontal
                if (dir == "fall")
                {
                    if (xspeed >= 0)
                        dir = "right";
                    else
                        dir = "left";
                    yspeed = (lastRail.y + 8 - yOffset) - (y);
                }
                break;
            case 1: // vertical
                if (dir == "fall")
                {
                    if (yspeed >= 0)
                        dir = "down";
                    else
                        dir = "up";
                    xspeed = (lastRail.x + 8 - xOffset) - (x);
                }
                break;
            case 2: // top left
                if (x + xOffset <= lastRail.x + 8
                    && dir == "left")
                {
                    dir = "down";
                    xspeed = (lastRail.x + 8 - xOffset) - (x);
                }
                if (y + yOffset <= lastRail.y + 8
                    && dir == "up")
                {
                    dir = "right";
                    yspeed = (lastRail.y + 8 - yOffset) - (y);
                }
                if (dir == "fall"
                    && y + yOffset >= lastRail.y + 8)
                {
                    yspeed = (lastRail.y + 8 - yOffset) - (y);
                    if (xspeed >= 0)
                        dir = "right";
                    else
                        dir = "left";
                }
                break;
            case 3: // bottom left
                if (x + xOffset <= lastRail.x + 8
                    && dir == "left")
                {
                    dir = "up";
                    xspeed = (lastRail.x + 8 - xOffset) - (x);
                }
                if (y + yOffset >= lastRail.y + 8
                    && dir == "down")
                {
                    dir = "right";
                    yspeed = (lastRail.y + 8 - yOffset) - (y);
                }
                if (dir == "fall"
                    && y + yOffset >= lastRail.y + 8)
                {
                    yspeed = (lastRail.y + 8 - yOffset) - (y);
                    if (xspeed >= 0)
                        dir = "right";
                    else
                        dir = "left";
                }
                break;
            case 4: // top right
                if (x + xOffset >= lastRail.x + 8
                    && dir == "right")
                {
                    dir = "down";
                    xspeed = (lastRail.x + 8) - (x + xOffset);
                }
                else if (y + yOffset <= lastRail.y + 8
                    && dir == "up")
                {
                    dir = "left";
                    yspeed = (lastRail.y + 8 - yOffset) - (y);
                }
                else if (dir == "fall"
                    && y + yOffset >= lastRail.y + 8)
                {
                    yspeed = (lastRail.y + 8 - yOffset) - (y);
                    if (xspeed > 0)
                        dir = "right";
                    else
                        dir = "left";
                }
                break;
            case 5: // bottom right
                if (x + xOffset >= lastRail.x + 8
                    && dir == "right")
                {
                    dir = "up";
                    xspeed = (lastRail.x + 8 - xOffset) - (x);
                }
                if (y + yOffset >= lastRail.y + 8
                    && dir == "down")
                {
                    dir = "left";
                    yspeed = (lastRail.y + 8 - yOffset) - (y);
                }
                if (dir == "fall"
                    && y + yOffset >= lastRail.y + 8)
                {
                    yspeed = (lastRail.y + 8 - yOffset) - (y);
                    if (xspeed > 0)
                        dir = "right";
                    else
                        dir = "left";
                }
                break;
            case 6: // bumper
                if (lastRail != prevRail)
                    bumped = true;
                else
                    break;
                if (dir == "fall")
                {
                    x -= xspeed;
                    y -= yspeed;
                    xspeed = -xspeed;
                    yspeed = -yspeed;
                }
                else
                {
                    var _X = x;
                    var _Y = y;

                    if (dir == "left"
                        || dir == "right")
                    {
                        if (x + xOffset >= lastRail.x + 8)
                        {
                            dir = "right";
                        }
                        else
                        {
                            dir = "left";
                        }
                    }
                    else
                    {
                        if (y + yOffset >= lastRail.y + 8)
                        {
                            dir = "down";
                        }
                        else
                        {
                            dir = "up";
                        }
                    }
                }
                break;
        }
    }
    else
        dir = "fall";


    // direction to move
    switch (dir)
    {
        case "right":
            xspeed += mySpeed;

            // yspeed = 0;
            break;
        case "left":
            xspeed += -mySpeed;

            // yspeed = 0;
            break;
        case "down": // xspeed = 0;
            yspeed += mySpeed;
            break;
        case "up": // xspeed = 0;
            yspeed += -mySpeed;
            break;
        case "fall":
            yspeed += fallMomentum;
            break;
    }
    prevRail = lastRail;
    xprevious = x;
    yprevious = y;

    if (blockCollision)
    {
        generalCollision(1);
    }
    else
    {
        x += xspeed;
        y += yspeed;
    }

    entityPlatform();
}
#define Other_10
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
lastRail = noone;

var msk = mask_index;
var rexsc = image_xscale;
var reysc = image_yscale;
mask_index = sprDot;

image_xscale = 1;
image_yscale = 1;

/*
image_yscale=1.0/sprite_get_height(sprite_index);
image_xscale=1.0/sprite_get_width(sprite_index);
*/

with (prtRail)
{
    var quit = false;
    with (other)
    {
        if (place_meeting(round(x + xOffset), round(y + yOffset), other) || place_meeting(round(xprevious + xOffset), round(yprevious + yOffset), other))
        {
            lastRail = other.id;
            quit = true;
        }
    }
    if (quit)
        break;
}

mask_index = msk;
image_xscale = rexsc;
image_yscale = reysc;

if (lastRail == noone)
{
    left = min(x + xOffset, xprevious + xOffset);
    right = max(x + xOffset, xprevious + xOffset);
    top = min(y + yOffset, yprevious + yOffset);
    bottom = max(y + yOffset, yprevious + yOffset);
    lastRail = collision_rectangle(left, top, right, bottom, prtRail, true, true);
    if (lastRail == noone)
        lastRail = collision_line(x + xOffset, y + yOffset, xprevious + xOffset, yprevious + yOffset, prtRail, true, true);
}
#define Other_25
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();
grav = 0;
dir = startDir;
prevRail = noone;
lastRail = noone;
