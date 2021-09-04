#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
/// An aquatic enemy that follows the player

// Notes:
// tail flickers every once in a while
// charge frame for like 10 frames
// buster shots make it go backwards horizontally for some reason
event_inherited();

healthpointsStart = 3;
healthpoints = healthpointsStart;
contactDamage = 2;

category = "aquatic, nature";

blockCollision = 0;
grav = 0;

facePlayerOnSpawn = true;

// Enemy specific code
chaseTimer = 1;
animTimer = 0;
tailTimer = 0;

aimSpeed = 3;
targetX = 0;
targetY = 0;

extraChoice = 0;

//@cc color of the enemy. 0 = blue, 1 = red, 2 = orange
col = 0;

imgOffset = 0;
image_speed = 0;
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();

if (entityCanStep())
{
    // chase + swim at the player
    chaseTimer -= 1;

    // Decrease speed
    if (chaseTimer > (30 + extraChoice))
    {
        if (instance_exists(target))
        {
            if (aimSpeed > 0)
            {
                aimSpeed -= 0.065;

                targetX += sign(xspeed);
                targetY += sign(yspeed);

                aimAtPoint(aimSpeed, targetX, targetY);
            } // prevent underflow
            else if (aimSpeed < 0)
            {
                aimSpeed = 0;
            }
        }
    }
    else
    {
        if (instance_exists(target))
        {
            xspeed = 0;
            yspeed += (gravAccel / 8);
        }
    }

    // stay in the water
    if (!inWater)
    {
        xspeed = 0;
        if (yspeed < 0)
        {
            yspeed = 0;
        }
    }

    // actually chase
    if (chaseTimer == 0)
    {
        if (instance_exists(target))
        {
            calibrateDirection();
            targetX = target.x;
            targetY = target.y;

            aimSpeed = 3;
            aimAtPoint(aimSpeed, targetX, targetY);

            animTimer = 15;
            imgOffset += 2;
        }

        chaseTimer = 90 + choose(0, 20, 40);
        extraChoice = (chaseTimer - 90);
    }

    // push forwards graphic handelling
    if (animTimer >= 0)
    {
        animTimer-=1;

        if (animTimer == 0)
        {
            imgOffset -= 2;
        }
    }

    // this one increments because i love consistency
    tailTimer+=1;

    if (tailTimer == 8)
    {
        if (imgOffset == 1 || imgOffset == 3)
        {
            imgOffset -= 1;
        }
        else
        {
            imgOffset += 1;
        }

        tailTimer = 0;
    }

    // Keep it inside water
    mask_index = sprDot;
    if (place_meeting(xprevious, yprevious, objWater) && !place_meeting(x, y, objWater))
    {
        var i; i = instance_place(xprevious, yprevious, objWater);
        if (i != noone)
        {
            if (y <= i.bbox_top)
            {
                y = i.bbox_top + 1;
                yspeed = 0;
                targetY += 64;
                aimAtPoint(aimSpeed, targetX, targetY);
            }
            else if (y >= i.bbox_bottom)
            {
                y = i.bbox_bottom - 1;
                yspeed = 0;
                targetY -= 64;
                aimAtPoint(aimSpeed, targetX, targetY);
            }

            if (x <= i.bbox_left)
            {
                x = i.bbox_left + 1;
                xspeed = 0;
            }
            else if (x >= i.bbox_right)
            {
                x = i.bbox_right - 1;
                xspeed = 0;
            }
        }
    }
    mask_index = sprShrimparge91;
}

image_index = imgOffset + (col * 4);
#define Other_21
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();

// why does this behavior exist? lol idk
if (other.pierces <= 1 && chaseTimer >= 30)
{
    image_xscale = -image_xscale;
    targetX += 64 * image_xscale;
    xspeed = -xspeed;
    aimAtPoint(aimSpeed, targetX, targetY);
}
#define Other_25
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
/// On spawn
chaseTimer = 1;
imgOffset = 0;
targetX = 0;
targetY = 0;
extraChoice = 0;
