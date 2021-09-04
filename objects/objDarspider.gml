#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
/// Spider that crawls on ceilings and falls when megaman is close,
// if placed on the ground it will jump towards megaman inmediately.
// When its not on the ceiling it will jump once if megaman is close, otherwise it will jump twice
event_inherited();


healthpointsStart = 2;
healthpoints = 2;
contactDamage = 3;
facePlayer = false;
category = "nature";

// Enemy specific code

sprite_index = sprDarspider;
mask_index = sprDarspider;
x += abs(sprite_get_xoffset(sprDarspider) - sprite_get_xoffset(sprDarspiderPreview));
y -= image_yscale * (abs(sprite_get_yoffset(sprDarspider) - sprite_get_yoffset(sprDarspiderPreview)));
xstart = x;
ystart = y;
onCeiling = 1;
isJumping = 0;
timer = 0;
startYscale = image_yscale;
prevGravDir = 1;
image_speed = 0;
waitTime = 0;
imageIndex = 0;
prevWaitTime = 5;

// Optional Creation Code
leftLimit = 9999;
rightLimit = 9999;


// Setup
ceilingSpeed = 1.25;
ceilingAnimSpeed = 0.175;
landAnimSpeed = 0.25;
isDei = false; // Weather he should act like a deispider, this means it'll randomly choose between 1 or 2 jumps
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
var ixsc; ixsc = image_xscale;
image_xscale=1;
event_inherited();
image_xscale=ixsc;
if(!onCeiling)
{
    if(xcoll!=0)
    {
        xspeed=xcoll;
    }

}

if (entityCanStep())
{
    var hasTarget; hasTarget = instance_exists(target);
    var tx; tx = 0;
    var ty; ty = 0;
    var gravityDir; gravityDir = prevGravDir;
    if (hasTarget)
    {
        tx = target.x;
        ty = target.y;
        gravityDir = target.image_yscale;
    }
    prevGravDir = gravityDir;
    if (!isJumping && onCeiling && startYscale != gravityDir * -1)
    {
        isJumping = true;
        onCeiling = false;
    }


    if (onCeiling)
    {
        timer -= 1;
        image_yscale = -gravityDir;

        if (!isJumping)
        {
            grav = -0.25 * gravityDir;
            var onLimit; onLimit = false;
            if (image_xscale && x > xstart + rightLimit)
            {
                x = xstart + rightLimit;
                onLimit = true;
            }
            else if (image_xscale == -1 && x < xstart - leftLimit)
            {
                x = xstart - leftLimit;
                onLimit = true;
            }
            if (xcoll != 0 || checkFall(16 * image_xscale, 0) || onLimit) // !checkSolid(16 * image_xscale, 10 * sign(grav),1)
            {
                image_xscale *= -1;
                if (!isDei)
                    timer = 16;
                xspeed = 0;
            }
            if (timer < 0)
            {
                imageIndex += ceilingAnimSpeed;
                if (floor(imageIndex) > 1)
                    imageIndex = 0;
                xspeed = ceilingSpeed * image_xscale;
            }
            var _x; _x = bbox_right;
            var _tx; _tx = 0;
            if (hasTarget)
            {
                with (target)
                {
                    if (bbox_left > other.bbox_right)
                    {
                        _tx = bbox_left;
                        _x = other.bbox_right;
                    }
                    else
                    {
                        _tx = bbox_right;
                        _x = other.bbox_left;
                    }
                }
            }
            if (hasTarget && abs(_x - _tx) < 12)
            {
                imageIndex = 2;
                isJumping = 1;
                xspeed = 0;
                grav = 0.25 * gravityDir;
                ground = false;
                var top; top = bbox_top;
                if (sign(grav) == -1)
                    top = bbox_bottom;
                var i; i = instance_create(x, top + 1 * sign(grav), objDarspiderWeb);
                i.parent = id;
                i.grv = grav;
            }
        }
        else
        {
            grav = 0.25 * gravityDir;
            if (ground)
            {
                onCeiling = false;
                isJumping = false;
                timer = 24;
            }
        }
    }
    else
    {
        image_yscale = gravityDir;
        grav = 0.25 * gravityDir;
        var speedLimit; speedLimit = 1.65;
        if (!isJumping)
        {
            timer -= 1;

            if (floor(imageIndex) < 4)
            {
                imageIndex = min(4, imageIndex + landAnimSpeed);
            }
            if (isDei && floor(imageIndex > 4))
            {
                imageIndex += landAnimSpeed;
                if (floor(imageIndex) > 6)
                    imageIndex = 3;
            }
            if (timer <= 0)
            {
                yspeed = -5 * gravityDir;
                xspeed = xSpeedAim(x, y, tx, y, yspeed, grav, speedLimit);
                timer = 0;
                isJumping = true;
                imageIndex = 4;
                if (!isDei)
                {
                    if (abs(xspeed) >= speedLimit && abs(x - tx) >= 64)
                    {
                        waitTime = 7;
                    }
                    else
                    {
                        waitTime = 25;
                    }
                }
                else
                {
                    waitTime = choose(5, 30);
                    if (prevWaitTime == waitTime && waitTime == 5)
                    {
                        waitTime = 30;
                    }
                    prevWaitTime = waitTime;
                }
            }
        }
        else
        {
            var animLimit; animLimit = 5 + !isDei;
            if (floor(imageIndex) < animLimit)
            {
                imageIndex += 0.35;
                if (imageIndex > animLimit)
                    imageIndex = animLimit;
            }

            if (ground)
            {
                xspeed = 0;
                isJumping = false;
                imageIndex = 3;
                timer = waitTime;
                if (isDei)
                {
                    imageIndex = 6;
                    playSFX(sfxHeavyLand);
                }
            }
            if (xcoll != 0)
                xspeed = xcoll;
        }
    }
    image_index = floor(imageIndex);
}
#define Other_25
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();
if (spawned)
{
    onCeiling = 1;
    isJumping = 0;
    timer = 0;
    image_yscale = startYscale;
    prevGravDir = 1;
    image_index = 0;
    imageIndex = 0;
    yspeed = 0;
    prevWaitTime = 5;
    ground = true;
}
