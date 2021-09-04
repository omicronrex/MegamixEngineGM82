#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();

bulletLimitCost = 1;

contactDamage = 0;

blockCollision = 1;
grav = 0.25;
bubbleTimer = 0;

canHit = -1;

timer = 4 * 60;
rider = -1;

active = false;

animTimer = 0;
animAdd = 0;
currentImg = 0;
shootTimer = 0;

turning = 0;

// vehicle vars
weaponsAllowed = true;
shootYOffset = 9;
riderPhysicsAllowed = false;
physicsLock = false;


dustTimer = 0;
trailTimer = 0;
#define Destroy_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();

if (instance_exists(rider))
{
    rider.vehicle = noone;
    rider.dieToSpikes = 1;
    lockPoolRelease(physicsLock);
}
#define Step_2
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();

if (!instance_exists(parent))
{
    instance_destroy();
    exit;
}

if (!global.frozen)
{
    // Mount Wario- I mean Mount Ru- I MEAN, GET ON THE RUSH CYCLE
    if (!active && instance_exists(parent))
    {
        if (!parent.isSlide && !parent.climbing)
        {
            if (position_meeting(x, y - 4 * image_yscale, parent) && !active)
            {
                rider = parent.id;
                active = true;

                shiftVisible = 2;
                timer = -1;

                grav = 0;

                playSFX(sfxLargeClamp);

                // lock controls + give spike immunity
                rider.dieToSpikes = 0;
                physicsLock = lockPoolLock(
                    rider.localPlayerLock[PL_LOCK_MOVE],
                    rider.localPlayerLock[PL_LOCK_TURN],
                    rider.localPlayerLock[PL_LOCK_JUMP],
                    rider.localPlayerLock[PL_LOCK_SLIDE],
                    rider.localPlayerLock[PL_LOCK_CLIMB]);
            }
        }
    }

    // Set this as a variable for ease of access
    var isGlobalLocked; isGlobalLocked = (isLocked(global.playerLock[PL_LOCK_MOVE]) &&
        isLocked(global.playerLock[PL_LOCK_JUMP]) &&
        isLocked(global.playerLock[PL_LOCK_TURN]) &&
        isLocked(global.playerLock[PL_LOCK_SHOOT]) &&
        isLocked(global.playerLock[PL_LOCK_SLIDE]) &&
        isLocked(global.playerLock[PL_LOCK_CLIMB])) || (isLocked(global.playerFrozen));

    // Make sure to set
    if (isGlobalLocked)
    {
        xspeed = 0;
        rider.xspeed = 0;
    }

    // Riding this bad boy
    if (active && !isGlobalLocked)
    {
        // Drain energy
        if (global.ammo[playerID, global.weapon[playerID]] > 0 && instance_exists(rider))
        {
            // Take away ammo
            global.ammo[playerID, global.weapon[playerID]] = max(0,
                global.ammo[playerID, global.weapon[playerID]]
                - ((1 / 60) / (global.energySaver + 1)));

            turning = 0;

            // Set up ice multiplier
            var iceMultiplier; iceMultiplier = 1;

            if (place_meeting(x, y + rider.gravDir, objIce)
                || place_meeting(x, y + rider.gravDir, objOil)
                || place_meeting(x, y + rider.gravDir, objPUOil)
                || (instance_exists(parent.statusObject) && parent.statusObject.statusOnIce))
            {
                iceMultiplier = .4;
            }

            // slow down if not holding any buttons (or turning)
            if (rider.xDir == 0)
            {
                xspeed -= min(abs(xspeed), 0.25) * sign(xspeed) * iceMultiplier;
            } // regular driving
            else
            {
                if (xspeed == 0 && xcoll == 0)
                {
                    if (rider.xDir == image_xscale && rider.ground)
                    {
                        var i; i = instance_create(x - 14 * image_xscale, y, objSlideDust);
                        i.image_xscale = image_xscale;
                        i.image_yscale = image_yscale;
                        playSFX(sfxRushCycle1);
                    }
                }

                // Check for boost inputs
                var boosting; boosting = (global.keySlide[rider.playerID] || global.keyDown[rider.playerID]);

                // set speed, including the boosts
                var spd; spd = 3.15 + (2 * boosting);

                xspeed = clamp(xspeed + (0.125 * iceMultiplier) * rider.xDir, -spd, spd);

                if (xspeed != 0)
                {
                    image_xscale = sign(xspeed);
                }

                // spawn trail effects if boosting
                if (boosting)
                {
                    trailTimer+=1;

                    if (trailTimer mod 3 == 0 && abs(xspeed) > 1.5)
                    {
                        a = instance_create(rider.x, rider.y, objTrailEffect);
                        a.drawingPlayer = true;
                        a.parent = rider;
                        a.spriteX = 10 + currentImg;
                        a.spriteY = 11;
                        a.image_xscale = image_xscale;
                        a.image_yscale = rider.image_yscale;
                    }
                }

                // detect turning
                if (rider.xDir == -image_xscale && rider.ground)
                {
                    if (!audio_is_playing(sfxRushCycle2))
                    {
                        playSFX(sfxRushCycle2);
                    }
                    turning = 1;
                }
            }

            // Rider updating
            with (rider)
            {
                xspeed = other.xspeed;
                image_xscale = other.image_xscale;

                if (!iFrames)
                {
                    if (ground)
                    {
                        if (place_meeting(x, y + image_yscale * 2, objSpike))
                        {
                            if global.infiniteEnergy[ds_map_get(global.weaponID,objRushCycle)]
                            {
                                global.playerHealth[playerID] = max(0, global.playerHealth[playerID] - 1);
                            }
                            else
                            {
                                global.ammo[playerID, global.weapon[playerID]] = max(0, global.ammo[playerID, global.weapon[playerID]] - 1);
                            }
                            playSFX(sfxHit);
                            iFrames = 8;
                        }
                    }
                }

                if (!other.turning) // jumping:
                {
                    if (global.keyJumpPressed[playerID] && ground /* checkSolid(0, gravDir * 2 )*/ )
                    {
                        playSFX(sfxRushCycle1);
                        yspeed = -4 * gravDir;
                    }
                }
            }

            shootTimer -= 1;
        }
        else
        {
            timer = 1;
        }
    }

    // Animation update
    animTimer += 1;
    if (animTimer >= 9 - (abs(xspeed) * 1.5))
    {
        animTimer = 0;
        animAdd = !animAdd;
    }

    currentImg = animAdd + (active * 2) + ((shootTimer > 0) * 2);

    dustTimer *= turning;

    // visual effects
    if (active && !isGlobalLocked)
    {
        if (!rider.ground)
        {
            currentImg = 6;
            animTimer = 0;
        }
        else
        {
            // effects if turning
            if (turning)
            {
                currentImg = 7;
                animTimer = 0;
                if (!(dustTimer mod 8))
                {
                    var i; i = instance_create(x + 16 * image_xscale, y - 1 * image_yscale, objSlideDust);
                    i.image_xscale = image_xscale;
                    i.image_yscale = image_yscale;
                    i.hspeed = xspeed * 1.5;
                    i.vspeed = image_yscale * -0.25;
                }
                dustTimer += 1;
            }
        }
    }

    // teleport away if its inactive
    if (timer)
    {
        timer -= 1;
        if (!timer)
        {
            // Teleport away
            i = instance_create(x, y - 12, objRushTeleport);
            i.upordown = 'up';
            i.parent = parent;
            i.image_yscale = image_yscale;

            instance_destroy();
        }
    }
}

// sprite setting
if (active)
{
    if (global.ammo[playerID, global.weapon[playerID]] > 0 && instance_exists(rider))
    {
        with (rider)
        {
            vehicle = other.id;
            playerHandleSprites("Cycle");
        }
        x = rider.x;
        y = rider.y + 15 * rider.image_yscale;
    }
}
#define Other_22
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
weaponSetup("RUSH BIKE", -2, -2, sprWeaponIconsRushCycle);
#define Other_24
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if (global.keyShootPressed[playerID] && !playerIsLocked(PL_LOCK_SHOOT))
{
    if (!instance_exists(objRushCycle) && !instance_exists(objRushTeleport)
    && global.ammo[playerID, global.weapon[playerID]] > 0)
    {
        i = fireWeapon(26, 0, objRushTeleport, 1, 0, 0, 0);
        with (i)
        {
            type = 'cycle';
            y = view_yview;
            if (image_yscale < 0)
            {
                y += view_hview;
            }
        }
    } // buster shot if cycle is on
    else if (instance_exists(vehicle))
    {
        if (!vehicle.turning)
        {
            with (vehicle)
            {
                shootTimer = 20;
                if (currentImg < 4 && ground)
                {
                    currentImg += 2;
                }
            }

            i = fireWeapon(13, 4, objBusterShot, 3, 0, 1, 0);
            if (instance_exists(i))
            {
                i.xspeed = objRushCycle.image_xscale * 6.5;
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
if (!active)
{
    drawPlayer(0, costumeID, 10 + currentImg, 11, x, y - 16 * image_yscale, image_xscale, image_yscale);
}
