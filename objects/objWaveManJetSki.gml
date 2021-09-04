#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
image_speed = 0;
active = 0;

spd = 0;
maxSpeed = 2;
yOffset = 0;
waterPlat = -1;
init = 1;
scroll = true;

// vehicle vars
rider = -1;
weaponsAllowed = false;
riderPhysicsAllowed = true;
shootYOffset = 9;

physicsLock = -1;

inWater = -1;
#define Destroy_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if (instance_exists(rider))
{
    rider.vehicle = noone;
    physicsLock = lockPoolRelease(physicsLock);
}
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if (!global.frozen && (insideView() || active))
{
    if (init)
    {
        init = 0;
        waterPlat = instance_create(x, y + sprite_yoffset, objSolid);

        // spawn additional jetskis if more players
        if (!place_meeting(x, y, object_index))
        {
            var i; for ( i = 1; i < global.playerCount; i += 1)
            {
                with (instance_create(x + i * 4 * image_xscale, y, object_index))
                {
                    depth = i * 10;
                }
            }
        }
    }
    if (!active)
    {
        // Entering the wave bike
        with (objMegaman)
        {
            if (!instance_exists(vehicle))
            {
                with (other)
                {
                    if (place_meeting(x, y, other.id))
                    {
                        active = true;
                        rider = other.id;
                        playerID = rider.playerID;
                        depth = 0;

                        with (rider)
                        {
                            x = other.x;
                            y = other.y;

                            xspeed = 0;
                            yspeed = 0;

                            viewPlayer = 0;

                            image_xscale = other.image_xscale;

                            global.weapon[playerID] = 0;
                            playerPalette();
                            vehicle = other.id;

                            // fully reset the state when entering
                            if lockPoolExists(slideLock)
                            {
                                slideLock = lockPoolRelease(slideLock);
                            }
                            if lockPoolExists(climbLock)
                            {
                                slideLock = lockPoolRelease(climbLock);
                            }

                            if instance_exists(objBreakDash)
                            {
                                with objBreakDash
                                {
                                    instance_destroy();
                                }
                            }
                        }

                        physicsLock = lockPoolLock(
                            rider.localPlayerLock[PL_LOCK_MOVE],
                            rider.localPlayerLock[PL_LOCK_TURN],
                            rider.localPlayerLock[PL_LOCK_SLIDE],
                            rider.localPlayerLock[PL_LOCK_CHARGE],
                            rider.localPlayerLock[PL_LOCK_CLIMB]);


                        break;
                    }
                }
            }
        }
    }
    else if (instance_exists(rider))
    {
        if (abs(spd * image_xscale) < maxSpeed)
        {
            spd += 0.05 * image_xscale;
        }

        // Camera
        global.prevXView = round(clamp(global.prevXView + spd, global.sectionLeft, global.sectionRight - view_wview));
        global.cachedXView = round(clamp(global.cachedXView + spd, global.sectionLeft, global.sectionRight - view_wview));

        //
        // scroll = global.lockTransition;

        if (global.lockTransition) // Stop if miniboss
        {
            spd = 0;
        }

        with (rider)
        {
            // override animation
            visible = false;
            image_xscale = other.image_xscale;

            // Move player
            shiftObject(other.spd + (global.keyRight[playerID] - global.keyLeft[playerID]), 0, 1);
        }

        // Snap to player
        x = rider.x;
        y = rider.y;
        image_yscale = rider.image_yscale;

        // Destroy
        with (objWaveManJetSkiStopper)
        {
            if ((other.bbox_left > bbox_left && other.image_xscale == 1)
                || (other.bbox_right > bbox_right && other.image_xscale == -1))
            {
                with (other)
                {
                    with (rider)
                    {
                        visible = true;
                        viewPlayer = 1;
                        canTurn = 1;
                        yspeed = -5;
                    }
                    global.enableSlide = true;
                    playSFX(sfxExplosion);
                    instance_create(x, y, objBigExplosion);
                    instance_destroy();
                }
            }
        }

        // Landing on water
        if (place_meeting(x, y + 12 * rider.gravDir, objWater))
        {
            water = instance_place(x, y + 12, objWater);
            if (y < water.y - 12)
            {
                if (!instance_exists(waterPlat))
                {
                    waterPlat = instance_create(water.x, water.y + 1, objTopSolid);
                }
                else
                {
                    waterPlat.x = x;
                    waterPlat.y = water.y + 1;
                }
            }
        }
        else if (instance_exists(waterPlat))
        {
            with (waterPlat)
            {
                instance_destroy();
            }
        }
    }
}

// This is all down here because it should happen even when the game is frozen (i.e. during screen transitions)

// Animation
image_index += 0.2;
if (image_index > 3)
{
    image_index = 0;
}

// don't move if there's a section switching
if (instance_exists(objSectionSwitcher) && active)
{
    x = objSectionSwitcher.x;
    y = objSectionSwitcher.y;
}
#define Step_2
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if (!global.frozen)
{
    // Animation while active
    if (active && instance_exists(rider))
    {
        // Make sure the camera isn't following MM anymore - instead, the autoscroll
        with (objMegaman)
        {
            viewPlayer = 0;
        }


        with (rider)
        {
            global.weapon[playerID] = 0;
            playerPalette();

            if (!ground)
            {
                other.image_index = 0;
            }

            playerHandleSprites("Bike");
        }
    }

    // yOffset for shooting changes with animation index
    switch (floor(image_index))
    {
        case 0:
            yOffset = 0;
            break;
        case 1:
            yOffset = 1;
            break;
        case 2:
            yOffset = 2;
            break;
        case 3:
            yOffset = 1;
            break;
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
    draw_sprite_ext(sprite_index, image_index, round(x), round(y) + yOffset, image_xscale, image_yscale, image_angle, image_blend, image_alpha);
}
else if (instance_exists(rider))
{
    draw_sprite_ext(sprite_index, image_index, round(x), round(y) + yOffset, image_xscale, image_yscale, image_angle, image_blend, image_alpha);
    with (rider)
    {
        visible = 1;
        tx = x;
        ty = y;
        x = round(other.x) - 2 * other.image_xscale;
        y = round(other.y) + other.yOffset - 5 * gravDir;
        event_perform(ev_draw, 0);
        x = tx;
        y = ty;
        visible = 0;
        playerHandleSprites("Bike");
    }
}
