#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=other
*/
// Creation code (all optional):
// hideWhileHanging = <true/false>. If set to false, the enemy will not hide itself when it's hanging on the ceiling.

event_inherited();

healthpointsStart = 2;
healthpoints = healthpointsStart;
contactDamage = 4;
category = "grounded";

facePlayerOnSpawn = false;

//
sprite_index = sprImorm;
mask_index = sprImorm;
x = xstart + image_xscale * (sprite_get_xoffset(sprImorm) - sprite_get_xoffset(sprImormPreview));
y = ystart + image_yscale * (sprite_get_yoffset(sprImorm) - sprite_get_yoffset(sprImormPreview));
xstart = x;
ystart = y;

// Enemy specific code
grav = 0;
gravDir = 0;
phase = 0;
yscaleStart = image_yscale;
timer = 0;
animFrame = 0;
animOffset = 0;
animSpeed = 0.185; // Crawling speed
blinkSpeed = 0.200; // .265


hideWhileHanging = true;
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if (entityCanStep())
{
    checkGround();

    if (instance_exists(target))
    {
        gravDir = target.image_yscale;
    }

    if (gravDir == 0)
    {
        gravDir = 1;
    }

    if (phase == 0 && gravDir != image_yscale)
    {
        grav = 0.25 * gravDir;
        phase = 2;
        canHit = true;
        canDamage = true;
        image_index = 1;
        animFrame = 0;
        timer = 0;
    }

    image_yscale = gravDir;

    xspeed = 0;
    if (xcoll != 0 && phase >= 2)
    {
        xspeed = xcoll;
    }

    if (phase >= 1)
    {
        grav = 0.25 * gravDir;
    }

    switch (phase)
    {
        case 0: // detect if the player is getting close
            if (instance_exists(target))
            {
                if (abs(target.x - x) < 64) // Checking the horizontal distance between imorm and nearest player.
                {
                    phase = 1;
                    canHit = true;
                    canDamage = true;
                    image_index = 0;
                    timer = 0;
                    grav = 0.25 * gravDir;
                }
            }
            break;
        case 1: // switch to ground frames and begin waiting if it hits the floor
            if (ground && image_index == 0)
            {
                image_index = 5;
            }
            else if (image_index == 5)
            {
                timer += 1;
            }
            if (timer == 10) // now start crawling
            {
                timer = 0;
                phase = 2;
                animFrame = 0;
                calibrateDirection();
            }
            break;
        case 2: // Extend and advance
            var prevFrame = floor(animFrame);
            animFrame += animSpeed;
            if (prevFrame != floor(animFrame))
            {
                if (prevFrame == -1)
                {
                    animFrame = animSpeed;
                }
                if (floor(animFrame) <= 2)
                    xspeed = 8 * image_xscale;
            }
            if (floor(animFrame) > 3)
            {
                phase = 3;
                animFrame = 3;
            }
            break;
        case 3:
            var prevFrame = floor(animFrame);
            animFrame -= animSpeed;
            if (prevFrame != floor(animFrame) && prevFrame == 3)
            {
                xspeed = -image_xscale;
            }
            if (floor(animFrame) < 0)
            {
                phase = 2;
                animFrame = 0;
            }
            break;
    }



    if (phase >= 2)
    {
        timer += blinkSpeed;
        image_index = 1 + (floor(timer) mod 2) * 4 + floor(animFrame);
    }
}
event_inherited();

if (entityCanStep())
{
    if (phase >= 2 && ground)
    {
        if (checkSolid(image_xscale * 2, 0) || xcoll != 0 || checkFall(16 * image_xscale, false)) //! checkSolid(16 * image_xscale, 16 * image_yscale)) // Turn around
        {
            image_xscale *= -1;
            xspeed = abs(xcoll) * image_xscale;
            xcoll = xspeed;
            if (xspeed == 0)
                xcoll = image_xscale;
        }
    }
}
#define Other_25
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
/// spawn Event
event_inherited();
canHit = false;
canDamage = false;
grav = 0;
image_index = 0;
animFrame = 0;
timer = 0;
phase = 0;
xcoll = 0;
xspeed = 0;
gravDir = 0;
image_yscale = yscaleStart;
#define Draw_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if (hideWhileHanging && phase == 0)
{
    exit;
}

event_inherited();
