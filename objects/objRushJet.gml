#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();

contactDamage = 0;

image_speed = 0.25;

canHit = false;
doesTransition = false;
blockCollision = 1;
isSolid = 2;
bubbleTimer = 0;

decreaseAmmoTimer = 0;
decreaseAmmoTimerMax = 60;

maxSpd = 1.2;
spd = maxSpd;
canJet = true;

timer = 4 * 60;

rushJetLock = false;

climbSlope = 0.5; // slope of ascent/descent when holding up
#define Destroy_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();

if (instance_exists(parent))
{
    if (rushJetLock)
    {
        rushJetLock = lockPoolRelease(rushJetLock);
    }
}
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();

if (!global.frozen)
{
    if (instance_exists(parent))
    {
        if (canJet) // Waiting for Megaman
        {
            if (place_meeting(x, y - 1 * image_yscale, parent))
            {
                if (parent.ground && !place_meeting(x, y, parent))
                {
                    canJet = false;
                    timer = -1;
                }
            }
        }
        else // Flying
        {
            xspeed = spd * image_xscale;

            // Take away ammo
            decreaseAmmoTimer += 1;
            if (decreaseAmmoTimer >= decreaseAmmoTimerMax)
            {
                decreaseAmmoTimer = 0;
                global.ammo[playerID, global.weapon[playerID]] -= 1;
                if (global.ammo[playerID, global.weapon[playerID]] <= 0)
                {
                    global.ammo[playerID, global.weapon[playerID]] = 0;
                    timer = 1;
                }
            }

            if (place_meeting(x, y - parent.gravDir, parent) && parent.ground)
            {
                // lock player movement
                if (!rushJetLock)
                {
                    rushJetLock = lockPoolLock(
                        parent.localPlayerLock[PL_LOCK_MOVE],
                        parent.localPlayerLock[PL_LOCK_TURN],
                        parent.localPlayerLock[PL_LOCK_CLIMB],
                        parent.localPlayerLock[PL_LOCK_SLIDE]);
                }

                parent.xspeed = 0;

                // Horizontal slowdown
                if ((global.keyRight[parent.playerID] - global.keyLeft[parent.playerID]) == -image_xscale)
                {
                    if (spd != 0.6)
                    {
                        spd = 0.6;
                    }
                }
                else if (spd != maxSpd)
                {
                    spd = maxSpd;
                }

                // Move vertically
                yspeed = (-global.keyUp[parent.playerID] + global.keyDown[parent.playerID]) * sign(parent.image_yscale) * climbSlope * spd;

                isSolid *= -1;

                with (parent)
                {
                    if (checkSolid(0, other.yspeed*2))
                    {
                        other.yspeed = 0;
                    }
                }

                isSolid *= -1;
            }
            else
            {
                // not on player
                event_perform(ev_destroy, 0);
                yspeed = 0;
                spd = maxSpd;
            }
        }
    }

    if (xcoll != 0)
    {
        timer = 1;
    }

    if (timer)
    {
        timer -= 1;
        if (!timer)
        {
            // Teleport away
            i = instance_create(x, y + 8 * image_yscale, objRushTeleport);
            i.upordown = 'up';
            i.parent = parent;
            i.image_yscale = image_yscale;

            instance_destroy();
        }
    }
}
#define Other_22
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
weaponSetup("RUSH JET", -2, -2, sprWeaponIconsRushJet);
#define Other_24
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if (global.keyShootPressed[playerID] && !playerIsLocked(PL_LOCK_SHOOT))
{
    if (!instance_exists(objRushJet) && !instance_exists(objRushTeleport)
    && global.ammo[playerID, global.weapon[playerID]] > 0)
    {
        i = fireWeapon(26, 0, objRushTeleport, 4, 0, 0, 0);
        with (i)
        {
            type = 'jet';
            y = view_yview;
            if (image_yscale < 0)
            {
                y += view_hview;
            }
        }
    }
    else
    {
        with (fireWeapon(16, 0, objBusterShot, 4, 0, 1, 0))
        {
            xspeed = other.image_xscale * 5;
        }
    }
}
#define Draw_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
drawPlayer(0, costumeID, floor(15 + image_index), 9, x, y - 4 * image_yscale, image_xscale, image_yscale);
