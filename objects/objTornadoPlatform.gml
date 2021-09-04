#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();
canHit = false;

image_speed = 0.1;

respawnRange = -1;
despawnRange = -1;

xOffset = 16;
noFlicker = true;

isSolid = 2;
blockCollision = 0;
grav = 0;

mySpeed = 1;

// Enemy-specific code
spinRate = (1 / 3);
spinMod = 10;
spinTimer = 0;

for (i = 0; i < global.playerCount; i += 1)
{
    attached[i] = false;
    attachX[i] = x;
    offset[i] = 0;
    animOffset[i] = 0;
    shootLock[i] = false;
}

currX = x;
currY = y;
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();

if (!global.frozen && !dead)
{
    // Check for drop rails
    if (instance_exists(lastRail))
    {
        if (lastRail.drop)
        {
            image_speed = 0;
        }
        else
        {
            image_speed = 0.1;
        }
    }
    else
    {
        image_speed = 0.1;
    }

    // Rotate this absolute madman if they're touching the platform
    with (objMegaman)
    {
        with (other)
        {
            // Check if the player is touching the platform or is already attached
            if ((place_meeting(x, y - other.gravDir * 2, other) && !place_meeting(x, y, other) && other.ground)
                || attached[other.playerID])
            {
                // If they're not attached, start ROTATING
                if (!attached[other.playerID])
                {
                    attached[other.playerID] = true;
                    with (other)
                        other.shootLock[playerID] = lockPoolLock(localPlayerLock[PL_LOCK_SHOOT]);
                    attachX[other.playerID] = other.x - x; // set x rotation origin

                    spinTimer = 0; // reset timer

                    // based on where they land on the platform, set the proper Stuff
                    if (other.y > y + 8)
                    {
                        offset[other.playerID] = 1;
                        animOffset[other.playerID] = 0;
                        playerDir[other.playerID] = -1;
                    }
                    else
                    {
                        offset[other.playerID] = 0;
                        animOffset[other.playerID] = 0;
                        playerDir[other.playerID] = 1;
                    }
                } // Actual rotating code
                else if (attached[other.playerID])
                {
                    // Update position + variables

                    // Rotate UNLESS the platform is over a drop rail
                    if (image_speed > 0)
                    {
                        spinTimer += 1;

                        if (spinTimer mod spinMod == 0)
                        {
                            offset[other.playerID] += spinRate * playerDir[other.playerID];
                            animOffset[other.playerID] += spinRate;
                        }
                    }

                    // handle playerDirection spinning when going under the platform etc
                    if (offset[other.playerID] >= 1)
                    {
                        offset[other.playerID] = 1;
                        animOffset[other.playerID] = 1;
                        playerDir[other.playerID] = -1;
                    }
                    if (offset[other.playerID] <= 0)
                    {
                        offset[other.playerID] = 0;
                        animOffset[other.playerID] = 0;
                        playerDir[other.playerID] = 1;
                    }

                    // handle depth of player
                    depth = other.depth - playerDir[other.playerID];

                    // Jumping off the platform
                    if (global.keyJumpPressed[other.playerID])
                    {
                        if (offset[other.playerID] > 0.5)
                        {
                            other.yspeed = other.jumpSpeed;
                            other.canMinJump = true;
                        }
                        else
                        {
                            other.yspeed = -other.jumpSpeed;
                            other.canMinJump = true;
                        }
                        attached[other.playerID] = false;

                        // It was easier to just flip the players sprites temporarily for this
                        other.image_yscale = other.gravDir;
                        shootLock[other.playerID] = lockPoolRelease(shootLock[other.playerID]);
                    }

                    // no land sound pls
                    if (instance_exists(target))
                        target.playLandSound = 0;
                }
            }
            else
            {
                // This replicates the flicker effect seen in MM9
                depth *= -1;
                if (depth == 0)
                    depth = 1;
            }
        }
    }
}
#define Step_2
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();

// Handle rotation animation
with (objMegaman)
{
    with (other)
    {
        if (attached[other.playerID])
        {
            other.x = x + attachX[other.playerID];
            other.y = y - 16 + (40 * offset[other.playerID]);
            other.image_yscale = 1;

            sprx = (animOffset[other.playerID] * 3);
            spry = 12;

            with (other)
            {
                playerHandleSprites("Magnet");
            }
        }
    }
}

// Stop movement if out of range
if (instance_exists(objMegaman))
{
    if (!insideSection(x, y))
    {
        x -= xspeed;
        y -= yspeed;
        x = currX;
        y = currY;
    }
    else
    {
        currX = x;
        currY = y;
    }
}
