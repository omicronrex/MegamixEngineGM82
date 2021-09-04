#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
global.gravityLiftBulletMap = -1;
global.gravityLiftXSpeedMap = -1;

// -1: up
// 1: down
liftSpeed = -.7;
liftAccel = 0.05;
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if (insideSection(x, y) && !global.frozen)
{
    // create map if it doesn't exit
    if (global.gravityLiftXSpeedMap == -1 || !ds_exists(global.gravityLiftXSpeedMap, ds_type_map))
    {
        global.gravityLiftXSpeedMap = ds_map_create();
        global.gravityLiftBulletMap = ds_map_create();
        global.gravityLiftLockMap = ds_map_create();
        global.gravityLiftLockJumpMap = ds_map_create();
        defer(ev_other, ev_room_end, 0, dsDestroy, makeArray(global.gravityLiftXSpeedMap, ds_type_map));
        defer(ev_other, ev_room_end, 0, dsDestroy, makeArray(global.gravityLiftBulletMap, ds_type_map));
        defer(ev_other, ev_room_end, 0, dsDestroy, makeArray(global.gravityLiftLockMap, ds_type_map));
        defer(ev_other, ev_room_end, 0, dsDestroy, makeArray(global.gravityLiftLockJumpMap, ds_type_map));
    }

    // ensure all mega man objects are on map
    with (objMegaman)
    {
        // first entering a grav lift room: add to the map and cut yspeed:
        if (is_undefined(global.gravityLiftXSpeedMap[? id]))
        {
            global.gravityLiftXSpeedMap[? id] = 0;
            global.gravityLiftLockMap[? id] = 0;
            global.gravityLiftLockJumpMap[? id] = 0;
            yspeed /= 4;
        }

        // remove ability to minjump in rising lifts lest the player stop rising suddenly
        canMinJump &= other.liftSpeed * gravDir > 0;

        // no jumping in rising lifts either (except while climbing)
        if (gravDir * other.liftSpeed < 0 && !climbing)
        {
            if (!global.gravityLiftLockJumpMap[? id])
                global.gravityLiftLockJumpMap[? id] = lockPoolLock(localPlayerLock[PL_LOCK_JUMP]);
        }
        else
            global.gravityLiftLockJumpMap[? id] = lockPoolRelease(localPlayerLock[PL_LOCK_JUMP], global.gravityLiftLockJumpMap[? id]);

        // lock movement except when on the ground:
        if (ground)
        {
            playLandSound = 0;
            if (global.gravityLiftLockMap[? id])
                lockPoolRelease(localPlayerLock[PL_LOCK_MOVE], localPlayerLock[PL_LOCK_GRAVITY], global.gravityLiftLockMap[? id]);
            global.gravityLiftLockMap[? id] = false;
        }
        else if (!global.gravityLiftLockMap[? id])
        {
            global.gravityLiftLockMap[? id] =
                lockPoolLock(localPlayerLock[PL_LOCK_MOVE],
                localPlayerLock[PL_LOCK_GRAVITY]);
        }
        if (climbing)
        {
            // mega man can climb unaffected by lift
            global.gravityLiftXSpeedMap[? id] = 0;
            xspeed = 0;
        }
        else
        {
            // bring yspeed to lift speed:
            var accel = other.liftAccel;

            // in downward lifts, gravity applies when moving upward
            if (other.liftSpeed * gravDir > 0 && yspeed < 0) // TODO: account for water gravity, etc.
                accel = max(abs(accel), 0.25);
            var deltaYSpeed = clamp(other.liftSpeed - yspeed, -abs(accel), abs(accel));
            yspeed += deltaYSpeed;

            // stop at top if lift does not continue (these physics should be double-checked for accuracy)
            if (other.liftSpeed * gravDir < 0 && ((gravDir == 1 && bbox_top <= global.sectionTop + 16) || (gravDir == -1 && bbox_bottom >= global.sectionBottom - 16)) && !climbing)
            {
                var continues = false;
                with (other.object_index)
                    if (y * other.gravDir < other.y * other.gravDir)
                    {
                        setSection(x, y, false);
                        if ((other.gravDir == 1 && sectionBottom == global.sectionTop) || (other.gravDir == -1 && sectionTop == global.sectionBottom))
                            if (other.x <= sectionRight && other.x >= sectionLeft)
                                continues = true;
                    }

                // hover at top 16 pixels:
                if (!continues)
                {
                    if (gravDir == 1)
                        yspeed = max(yspeed, min(2, global.sectionTop + 16 - bbox_top) / 3);
                    else
                        yspeed = min(yspeed, max(-2, global.sectionBottom - 16 + bbox_bottom) / 3);
                }
            }

            // bullet impulse
            with (prtPlayerProjectile)
            {
                if (playerID == other.playerID)
                {
                    if (is_undefined(global.gravityLiftBulletMap[? id]))
                    {
                        global.gravityLiftXSpeedMap[? other.id] -= sign(xspeed) * 0.5;
                    }
                    global.gravityLiftBulletMap[? id] = 0;
                }
            }

            if (ground && other.liftSpeed * gravDir > 0) // walking (downward lifts)
                global.gravityLiftXSpeedMap[? id] = xspeed / 2;
            else // horizontal momentum
            {
                shiftObject(global.gravityLiftXSpeedMap[? id], 0, true);
                xspeed = 0;
            }

            // stop if hit object or side of screen:
            var screenMargin = 8;
            if (((x < view_xview[0] + screenMargin || x > view_xview[0] + view_wview[0] - screenMargin)
                && !position_meeting(x, y, objSectionArrowLeft) && !position_meeting(x, y, objSectionArrowRight)) || xcoll != 0)
            {
                x = clamp(x, view_xview[0] + screenMargin, view_xview[0] + view_wview[0] - screenMargin);
                global.gravityLiftXSpeedMap[? id] = 0;
            }
        }
    }
}

// delete map if player not in a gravity lift room
if (global.gravityLiftXSpeedMap != -1)
{
    var deleteMap = true;
    with (object_index)
        if (insideSection(x, y))
            deleteMap = false;
    if (deleteMap)
    {
        with (objMegaman)
        {
            lockPoolRelease(global.gravityLiftLockMap[? id]);
            lockPoolRelease(global.gravityLiftLockJumpMap[? id]);
        }
        if (ds_exists(global.gravityLiftXSpeedMap, ds_type_map))
        {
            ds_map_destroy(global.gravityLiftXSpeedMap);
            ds_map_destroy(global.gravityLiftBulletMap);
            ds_map_destroy(global.gravityLiftLockMap);
            ds_map_destroy(global.gravityLiftLockJumpMap);
        }
        global.gravityLiftXSpeedMap = -1;
    }
}
