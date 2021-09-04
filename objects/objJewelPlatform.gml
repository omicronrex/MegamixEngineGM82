#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();
canHit = false;

isSolid = true;

blockCollision = false;
doesTransition = false;
bubbleTimer = -1;

// this can be adjusted
radius = 83;
hingeX = x;
hingeY = y + 6;
tetherSpacing = 22.5;
fric = 0.993;
walkAccel = 0.06;
initStepBoost = 0.7; // a bit of boost from first step
grav = 0;
trueGrav = 0.25;
respawnRange = -1; // set to -1 to make infinite
despawnRange = -1; // set to -1 to make infinite

// don't edit these
initStepBoostDir = 0;
playedSFX = 0;
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();

if (sprite_index == sprJewelPlatformPlace)
{
    y += 83 + 6;
    ystart += 83 + 6;
    sprite_index = sprJewelPlatform;
}

if (!global.frozen)
{
    var sinY; sinY = abs((y - hingeY) / radius);
    var cosX; cosX = abs((x - hingeX) / radius);
    isSolid = true;
    if (dead)
        beenOutsideView = true;

    // mega man gives boost:
    var accel; accel = false
        ;
    with (objMegaman)
    {
        if (ground && place_meeting(x, y + 2*gravDir, other))
        {
            var xDir; xDir = global.keyRight[playerID] - global.keyLeft[playerID];
            if ((stepTimer >= stepFrames && !playerIsLocked(PL_LOCK_MOVE) && ground && (xDir == image_xscale)) || isSlide)
            {
                // walking
                other.xspeed += image_xscale * other.walkAccel * sinY * sinY;
                accel = true;
                if (sign(other.xspeed) != other.initStepBoostDir && image_xscale != sign(-other.xspeed))
                {
                    other.xspeed += image_xscale * other.initStepBoost * abs(sinY);
                    other.initStepBoostDir = image_xscale;
                }

                // play sfx
                if (!other.playedSFX)
                {
                    playSFX(sfxJewelPlatform);
                    other.playedSFX = 1;
                }
            }
        }
        else
        {
            other.playedSFX = 0;
        }
    }

    // friction
    xspeed *= fric;
    yspeed *= fric;

    // extra friction for end
    if (abs(x - hingeX) < 2 && abs(xspeed) < initStepBoost && !accel)
        xspeed *= 0.91;
    if (abs(x - hingeX) < 7 && abs(xspeed) < 1.5 && !accel)
        xspeed *= 0.99;
    if (!insideView())
        xspeed *= 0.90;

    // circular motion logic
    yspeed += trueGrav;

    var dotx; dotx = (x - hingeX);
    var doty; doty = (y - hingeY);
    var dotrad; dotrad = max(1, point_distance(0, 0, dotx, doty));
    dotx /= dotrad;
    doty /= dotrad;
    var tanspeed; tanspeed = dot_product(xspeed, yspeed, doty, -dotx);

    xspeed = doty * tanspeed;
    yspeed = -dotx * tanspeed;
    var nextX; nextX = x + xspeed;
    var nextY; nextY = y + yspeed;
    var _rad_actual; _rad_actual = point_distance(hingeX, hingeY, nextX, nextY);
    nextX = hingeX + (nextX - hingeX) * radius / _rad_actual;
    nextY = hingeY + (nextY - hingeY) * radius / _rad_actual;

    xspeed = (nextX - x);
    yspeed = (nextY - y);

    if (sign(xspeed) != initStepBoostDir)
        initStepBoostDir = 0;
}
#define Draw_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if (hingeX + 16 < view_xview[0] || hingeX - 16 > view_xview[0] + view_wview[0])
{
    exit;
}

// tether
var i; for ( i = 0; i < (radius - 9) / tetherSpacing; i+=1)
{
    var p; p = i * tetherSpacing / radius;
    var imgIndex; imgIndex = 0;

    // special frame for top hinge:
    if (positionCollision(hingeX - x, (hingeY - 2) - y) && i == 0)
        imgIndex = 1;
    draw_sprite(sprJewelPlatformTether, imgIndex,
        round(hingeX * (1 - p) + x * p), floor(hingeY * (1 - p) + y * p));
}

drawSelf();
