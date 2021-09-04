#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
/// A rotating platform that gradually sends Mega Man downwards. If he stands on it for too long, he'll eventually fall off.
// Stretch it horizontally in the editor to make multiple contiguous platforms
// Note: compatible with gravity flipping
event_inherited();
grav = 0;
canHit = false;
isSolid = 0;
animFrame = 0;
faction = 0;
grav = 0;
blockCollision = 0;
bubbleTimer = -1;
_gravDir = 1;
shiftVisible = 1;
combineObjects(object_index, true, false);

//@cc How fast it moves players
animSpeed = 0.2;

//@cc 0 = Uranus (default); 1 = Wily Star)
style = 0;
init = 1;

if (image_yscale < 0)
{
    image_yscale *= -1;
    y -= image_yscale * 16;
    image_yscale = 1;
    ystart = y;
}
image_yscale = 1;
if (image_xscale < 0)
{
    image_xscale *= -1;
    x -= image_xscale * 16;
    xstart = x;
}
image_xscale = round(image_xscale);
if (image_xscale < 1)
    image_xscale = 1;
despawnRange = (image_xscale - 1) * 16;
respawnRange = despawnRange;
segmentLimit = 4;
segmentRange = 8;
segmentCount = 0;
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if (init)
{
    init = 0;

    // Set the correct color
    switch (style)
    {
        case 0:
            sprite_index = sprUranusPlatform;
            break;
        /*
        case 1:
            sprite_index = sprUranusPlatform2;
            break;
        */
    }
}

grav = 0;
yspeed = 0;
event_inherited();

if (entityCanStep())
{
    if (instance_exists(objMegaman))
        _gravDir = objMegaman.gravDir;
    if (segmentCount < segmentLimit)
    {
        while (segmentCount < segmentLimit)
        {
            var i = instance_create(x, y, objUranusPlatformSegment);
            var origin = y;
            if (_gravDir == -1)
                origin = y + 16;
            i.image_xscale = image_xscale - (2 * (image_xscale / (16 * image_xscale))); // Prevent early slope effect
            i.x = x + 1;
            i.y = origin;
            i.gravDir = _gravDir;
            i.moveSpeed = animSpeed;
            i.moveAmount = 1;
            i.parent = id;
            i.range = segmentRange;
            i.y += segmentCount * 2 * _gravDir;
            segmentCount += 1;
        }
    }
    animFrame += animSpeed;
    if (floor(animFrame) > image_number - 1)
        animFrame = 0;
    image_index = floor(animFrame);
}
#define Step_2
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
/// Weird collision
if (!dead)
{
    // Collide with megaboy but only block him if he collides from the bottom, left or right side of
    // the pilar hitbox

    // This code is likely glitchy

    with (objMegaman)
    {
        if (xspeed == 0 && yspeed == 0)
            exit;
        var _prevX = x;
        var _prevY = y;
        var xsp = xspeed;
        var ysp = yspeed;
        x = xprevious;
        y = yprevious;
        var verticalCollision = bbox_top >= other.bbox_bottom;
        if (gravDir == -1)
        {
            verticalCollision = bbox_bottom <= other.bbox_top;
        }
        var horizontalCollision1 = bbox_right <= other.bbox_left;
        var horizontalCollision2 = bbox_left >= other.bbox_right;

        if ((
            verticalCollision
            || horizontalCollision1
            || horizontalCollision2
            )
            && !place_meeting(x - xspeed, y - yspeed, other.id) && place_meeting(x + xspeed, y + yspeed, other.id))
        {
            x += xspeed;
            if (horizontalCollision1 || horizontalCollision2)
            {
                if (place_meeting(x, y, other))
                {
                    if (horizontalCollision1)
                    {
                        shiftObject((other.bbox_left - 1) - bbox_right, 0, 0);
                        xspeed = 0;
                    }
                    else if (horizontalCollision2)
                    {
                        shiftObject((other.bbox_right + 1) - bbox_left, 0, 0);
                        xspeed = 0;
                    }
                }
                x += xspeed;
            }
            else
            {
                x = _prevX;
            }
            if (verticalCollision)
                y += yspeed;
            else
                y = _prevY;

            verticalCollision = verticalCollision && place_meeting(x, y, other.id);
            if (verticalCollision && !isSlide)
            {
                if (gravDir == 1)
                    shiftObject(0, (other.bbox_bottom + 1) - bbox_top, 0);
                else
                    shiftObject(0, (other.bbox_top - 1) - bbox_bottom, 0);

                yspeed = 0;
            }
        }
        else
        {
            x = _prevX;
            y = _prevY;
        }
    }
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
    segmentCount = 0;
    animFrame = 0;
    image_index = 0;
}
#define Draw_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
var i = 0;
while (i < image_xscale)
{
    draw_sprite_ext(sprite_index, image_index, x + (i * 16), y + 16 * (_gravDir == -1), 1, _gravDir, 0, c_white, 1);
    i += 1;
}
