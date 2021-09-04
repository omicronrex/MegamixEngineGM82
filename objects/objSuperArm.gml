#define Other_10
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
/// resets super arm carry state if necessary

var owner; owner = global.eventArgs;
with (owner)
{
    if (global.weaponObject[global.weapon[playerID]] != objSuperArm || !instance_exists(owner))
    {
        // reset
        with (prtEntity)
        {
            if (hasCategory(category, "superArmTarget"))
            {
                superArmFlashTimer = 0;
                if (superArmHoldOwner == other.id)
                {
                    superArmHoldOwner = noone;
                    if (superArmDeathOnDrop)
                    {
                        // destroyed by control flow a few lines down from here.
                        superArmThrown = true;
                    }
                    else
                    {
                        xspeed = 0;
                        yspeed = 0;
                        superArmThrown = true;
                        grav = 0.2;
                    }
                }

                if (superArmFlashOwner == other.id)
                {
                    superArmFlashOwner = noone;
                    superArmFlashTimer = 0;
                }

                // destroy thrown objects
                if (superArmThrown && superArmDeathOnDrop)
                {
                    dead = true;
                    spawned = false;
                    grav = superArmPreGrav;
                    blockCollision = superArmPreBlockCollision;
                    canHit = superArmPreCanHit;
                    isSolid = superArmPreIsSolid;
                    event_user(EV_SPAWN);
                    if (!respawn)
                    {
                        instance_destroy();
                    }
                }
            }
        }
    }
    else
    {
        // terminate early other defers
        with (objDefer)
        {
            if (script == eventExecute && argCount == 5)
            {
                if (args[2] == objSuperArm)
                {
                    instance_destroy();
                }
            }
        }
        defer(ev_step, ev_step_end, 0, eventExecute, makeArray(ev_other, ev_user0, objSuperArm, true, id));
    }
}
#define Other_11
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
/// kill super arm block

if (superArmDeathOnDrop)
{
    dead = true;
    superArmThrown = false;
    superArmHoldOwner = noone;
    spawned = false;
    grav = superArmPreGrav;
    blockCollision = superArmPreBlockCollision;
    canHit = superArmPreCanHit;
    isSolid = superArmPreIsSolid;
    event_user(EV_SPAWN);
    if (!respawn)
    {
        instance_destroy();
    }
}
else
{
    grav = superArmPreGrav;
    blockCollision = superArmPreBlockCollision;
    canHit = superArmPreCanHit;
    isSolid = superArmPreIsSolid;
}
#define Other_22
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
weaponSetup("SUPER ARM", global.nesPalette[20], global.nesPalette[40], sprWeaponIconsSuperArm);

// objects which have the 'superArmTarget' category
// must have the following instance variables:
// superArmFlashTimer = 0;
// superArmFlashOwner = noone;
// superArmFlashInterval = 1;
// superArmHoldOwner = noone;
// superArmDeathOnDrop = true;
// superArmThrown = false;
#define Other_24
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
defer(ev_step, ev_step_end, 0, eventExecute, makeArray(ev_other, ev_user0, objSuperArm, true, id));

var currentWeapon; currentWeapon = global.weapon[playerID];
var insufficientAmmo; insufficientAmmo = global.ammo[playerID, currentWeapon] <= 0;
var ammoCost; ammoCost = 2;

var interactionCache; interactionCache = makeArray();
var interactionCacheSort; interactionCacheSort = makeArray();
var interactionCacheCount; interactionCacheCount = 0;

var superArmHeldObject; superArmHeldObject = noone;
with (prtEntity)
{
    if (hasCategory(category, "superArmTarget"))
    {
        interactionCache[interactionCacheCount] = id;
        interactionCacheSort[interactionCacheCount] = floor(depth);
        interactionCacheCount+=1;
        if (superArmHoldOwner == other.id)
        {
            superArmHeldObject = id;
        }
    }
}

// prefer least-depth block
// remove this if frame rate drops (note that behaviour will change!)
quickSortBy(interactionCache, interactionCacheSort);

var doPickUpAction; doPickUpAction = false;

// not holding anything.. look for an object as a candidate!!
if (superArmHeldObject == noone)
{
    var checkPosYList; checkPosYList = makeArray(2, 8, -2, -6, 11);
    var selectFlash; selectFlash = noone;
    if (!playerIsLocked(PL_LOCK_SHOOT))
    {
        var j; for ( j = 4; j >= 0; j-=1)
        {
            var i; for ( i = 0; i < array_length_1d(checkPosYList); i+=1)
            {
                var k; for ( k = 0; k < interactionCacheCount; k+=1)
                {
                    with (interactionCache[k])
                    {
                        var checkPosX, checkPosY;
                        with (other)
                        {
                            var checkPosX; checkPosX = x + image_xscale * 4 * j;
                            var checkPosY; checkPosY = y + checkPosYList[i] * image_yscale;
                        }
                        if (position_meeting(checkPosX, checkPosY, id) && !superArmThrown && superArmHoldOwner == noone && !insufficientAmmo && !dead)
                        {
                            selectFlash = id;
                            break;
                        }
                    }

                    // continue break...
                    if (selectFlash != noone)
                    {
                        break;
                    }
                }

                // continue break...
                if (selectFlash != noone)
                {
                    break;
                }
            }

            // continue break...
            if (selectFlash != noone)
            {
                break;
            }
        }
    }
    doPickUpAction = global.keyShootPressed[playerID] && !playerIsLocked(PL_LOCK_SHOOT);

    var k; for (k = 0; k < interactionCacheCount; k+=1)
    {
        with (interactionCache[k])
        {
            if (selectFlash != id)
            {
                if (superArmFlashOwner == other.id)
                {
                    superArmFlashTimer = 0;
                    superArmFlashOwner = noone;
                }
            }
            else
            {
                if (superArmFlashOwner == noone || superArmFlashOwner == other.id)
                {
                    superArmFlashOwner = other.id;
                    superArmFlashInterval = 8;
                    superArmFlashTimer = max(superArmFlashTimer + 1, superArmFlashInterval);
                }

                if (doPickUpAction)
                {
                    superArmFlashTimer = -1;
                    superArmFlashOwner = other.id;
                    superArmHoldOwner = other.id;
                    superArmHeldObject = id;

                    // cache previous state
                    superArmPreIsSolid = isSolid;
                    superArmPreBlockCollision = blockCollision;
                    superArmPreGrav = grav;
                    superArmPreCanHit = canHit;

                    // this will overlap and look ugly, so set it to 0
                    other.drawWeaponIcon = 0;
                }
            }
        }
    }
}

// we're now holding something... move it above us, possibly throw
if (superArmHeldObject != noone)
{
    isShoot = 6;
    shootTimer = 0;

    assert(instance_exists(superArmHeldObject));
    assert(superArmHeldObject != id, "player somehow picked themself up with super arm.");

    // move above
    var originToBBoxBottom, originToBBoxTop, originToBBoxCenter;
    with (superArmHeldObject)
    {
        isSolid = false;
        blockCollision = false;
        grav = 0;
        despawnRange = -1;
        canHit = false;
        originToBBoxBottom = bbox_bottom - round(y);
        originToBBoxTop = round(y) - bbox_top;
        originToBBoxCenter = (bbox_left + bbox_right) / 2 - round(x);
    }

    var superArmDesiredX; superArmDesiredX = x - originToBBoxCenter;
    var superArmDesiredY; superArmDesiredY = y - originToBBoxBottom - 6;
    if (image_yscale == -1)
    {
        superArmDesiredY = y + originToBBoxTop + 6;
    }

    superArmHeldObject.x = superArmDesiredX;
    superArmHeldObject.y = superArmDesiredY;
    superArmHeldObject.xspeed = 0;
    superArmHeldObject.yspeed = 0;

    // throw
    var doThrowAction; doThrowAction = !doPickUpAction && global.keyShootPressed[playerID] && !playerIsLocked(PL_LOCK_SHOOT);
    if (doThrowAction)
    {
        global.ammo[playerID, currentWeapon] = max(global.ammo[playerID, currentWeapon] - ammoCost, 0);
        isShoot = 2;
        shootTimer = 0;
        with (superArmHeldObject)
        {
            superArmThrown = true;

            // adjust throw position
            y += 8 * other.image_yscale + yspeed;
            x += 16 * other.image_xscale + xspeed;

            // set throw velocity
            xspeed = 3.5 * other.image_xscale;
            yspeed = -2 * other.image_yscale;
            grav = 0.2;

            with (instance_create(x, y, objSuperArmBlockProjectile))
            {
                host = other.id;
                parent = other.superArmHoldOwner;
            }
            superArmHoldOwner = noone;
        }
    }
}
