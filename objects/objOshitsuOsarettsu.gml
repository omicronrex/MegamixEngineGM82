#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();
healthpointsStart = 6;
healthpoints = 6;
contactDamage = 6; /// Holy $@#%
facePlayer = false;
facePlayerOnSpawn = false;
category = "grounded, shielded";

// Enemy specific code

// Creation Code
maxDist = 256 / 16; // How many 16x16 tiles it will advance before retrating

// Constants
retreatSpeed = 1;
chargeSpeed = 2.25;
deccel = 0.35;
stunTime = 20;
startTime = 30;

// Variables
timer = 0;
phase = 0;
stunTimer = 0;
isCharging = false;
canTurn = true;
animTimer = 0;
animSpeed = 0;
startXscale = 0;
image_speed = 0;
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
/// Enemy AI
event_inherited();
if (entityCanStep())
{
    if (!ground)
    {
        xspeed = 0;
        animSpeed = 0.25;
    }
    else
    {
        var leftLimit; leftLimit = xstart;
        var rightLimit; rightLimit = xstart + maxDist * 16 * startXscale;
        if (startXscale == -1)
        {
            leftLimit = xstart + maxDist * 16 * startXscale;
            rightLimit = xstart;
        }
        if (xcoll != 0 || checkFall(32 * sign(xspeed)) || (x > rightLimit) || ((x < leftLimit))) //! checkSolid(xspeed + sign(xspeed) * abs(bbox_left - bbox_right) + sign(xspeed), 3)
        {
            if (phase == 0)
            {
                isCharging = !isCharging;
                timer = 0;
            }
            xspeed = 0;
            if (x > rightLimit)
                x = rightLimit;
            else if (x < leftLimit)
                x = leftLimit;
        }
        if (stunTimer != 0)
        {
            animSpeed = 0.35;
            var psign; psign = sign(xspeed);
            xspeed += sign(xspeed) * -1 * deccel;
            if (psign != sign(xspeed))
                xspeed = 0;
            stunTimer -= 1;
            if (stunTimer < 0 && xspeed == 0)
            {
                stunTimer = 0;
                timer = 0;
            }
        }
        else
        {
            if (phase == 0 && (timer > startTime && isCharging && (place_meeting(x, y, objMegaman) || (instance_exists(target) && sign(target.x - x) == -image_xscale))))
            {
                xspeed = 0;
                isCharging = false;
                timer = 0;
                canTurn = false;
            }
            timer += 1;

            if (phase == 0)
            {
                if (timer > startTime)
                {
                    canTurn = true;
                    if (isCharging) // Charge
                    {
                        animSpeed = 0.4;
                        xspeed = chargeSpeed * image_xscale;
                    }
                    else // Retreat
                    {
                        animSpeed = 0.25;
                        xspeed = retreatSpeed * -1 * image_xscale;
                    }
                }
                else // Check if we should turn
                {
                    if (xspeed == 0 || !isCharging)
                        animSpeed = 0.25;
                    else if (isCharging)
                        animSpeed = 0.4;
                    if (canTurn && xspeed == 0 && instance_exists(target) && sign(target.x - x) == -image_xscale)
                    {
                        phase = 1;
                        animTimer = 0;
                        timer = 0;
                        animSpeed = 0.15;
                    }
                }
            }
        }
    }

    // Animations

    animTimer += animSpeed;
    if (phase == 0)
    {
        if (floor(animTimer) > 3)
            animTimer = 0;
        image_index = (stunTimer != 0) * 4 + floor(animTimer);
    }
    else if (phase == 1)
    {
        if (floor(animTimer) > 2)
        {
            image_xscale *= -1;
            phase = 0;
            isCharging = false;
            timer = 999;
            image_index = 0;
            animTimer = 0;
        }
        else
            image_index = 8 + floor(animTimer);
    }
}
#define Other_20
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();
instance_create(bbox_left + abs(bbox_left - bbox_right) / 2, bbox_top + abs(bbox_top - bbox_bottom) / 2, objBigExplosion);
playSFX(sfxMM9Explosion);
#define Other_21
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if (other.bbox_top >= bbox_top + 12 && sign(x - other.x) == image_xscale)
    exit;
if (other.bbox_top >= bbox_top + 12)
{
    other.guardCancel = 1;
    timer = 0;
    stunTimer = stunTime;
    if (phase != 1)
    {
        xspeed = -image_xscale * chargeSpeed;
        if (!checkSolid(xspeed + sign(xspeed) * abs(bbox_left - bbox_right) + sign(xspeed), 3))
            xspeed = 0;
    }
}
else if (other.bbox_top < bbox_top + 12 && !(other.bbox_right > bbox_left + 4 && other.bbox_left < bbox_right - 4))
{
    other.guardCancel = 2;
}
#define Other_25
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if (startXscale == 0)
    startXscale = image_xscale;
image_xscale = startXscale;
phase = 0;
timer = 0;
stunTimer = 0;
isCharging = true;
canTurn = true;
