#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
/// Merserker
// Creation code: leftLimit and rightLimit, how many regular jumps it can move
// away from its original position in each direction

event_inherited();
facePlayerOnSpawn = true;
contactDamage = 3;
healthpointsStart = 3;
healthpoints = healthpointsStart;
canHit = true;
category = "flying";


// Enemy Specific Code
isFalling = false;
animTimer = 0;
timer = 0;

// Customizable values
leftLimit = 5;
rightLimit = 5;
fallSpeed = 4;
jumpSpeed = 4; // How fast he jumps
jumpDistance = 56; // How high he jumps
moveSpeed = 3; // How fast he moves horizontally
moveDistance = 32; // How much it travels in a full jump

// Adjust decceleration (using one of the uniform accelerated movement formulas)
event_user(0);
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
var prevXspeed; prevXspeed = xspeed;

event_inherited();

if (entityCanStep())
{
    if (prevXspeed != xspeed)
        xspeed = prevXspeed;

    // Deccelerate
    if (xspeed != 0)
    {
        var psign; psign = sign(xspeed);
        xspeed += moveDecceleration * -psign;
        if (sign(xspeed) != psign)
            xspeed = 0;
    }


    if (ground)
    {
        if (ycoll != 0)
        {
            timer = 0;
            if (isFalling)
                playSFX(sfxMerserker);
        }
        timer += 1;
        if (timer > 10)
        {
            yspeed = -jumpSpeed;
            isFalling = false;
            var canAdvance; canAdvance = true;
            if ((image_xscale < 0 && x < xstart - (leftLimit * moveDistance)) || (image_xscale > 0 && x > xstart + rightLimit * moveDistance))
            {
                image_xscale *= -1;
                canAdvance = false;
            }
            if (canAdvance)
                calibrateDirection();
            xspeed = moveSpeed * image_xscale;
        }
    }
    else if (yspeed > 0.35 && xspeed == 0)
    {
        isFalling = true;
        yspeed = fallSpeed;
    }
    if (yspeed > -jumpSpeed * 0.35 && !isFalling)
    {
        animTimer = 1;
    }


    // Animation
    animTimer += 0.4;
    if (floor(animTimer) > 1)
        animTimer = 0;

    image_index = isFalling * 2 + floor(animTimer);
}
#define Other_10
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
grav = (jumpSpeed * jumpSpeed) / (2 * jumpDistance);
moveDecceleration = (moveSpeed * moveSpeed) / (2 * moveDistance);
#define Other_25
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();

/// Spawnn
xspeed = 0;
yspeed = 1;
isFalling = false;
animTimer = 0;
timer = 0;
yspeed = 0;
if (spawned)
    event_user(0);
