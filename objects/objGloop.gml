#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();

respawn = false;

healthpointsStart = 10;
healthpoints = healthpointsStart;
contactDamage = 0;
shiftVisible = 3;

image_xscale = 1;

// Enemy specific code
capture = noone;
walkStore = 0;
animTimer = 5;
fire = 0;
dmgTimer = 0;
dmgMax = 48;
dmg = 2;
hurtMega = false;
playSFX(sfxHit);
pop = false;
setMega = false;
gloopLock = false;
movementLock = false;

category = "gloop";
#define Destroy_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
lockPoolRelease(gloopLock);
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();
if (!global.frozen && !pop)
{
    with (target)
    {
        // if there is no status effect object for current player, create one.
        if (!instance_exists(statusObject))
        {
            statusObject = instance_create(x, y, objStatusEffect);
        }
        if (place_meeting(x, y, other) && other.capture == noone)
        {
            other.capture = id;
        }
        if (other.capture == id)
        {
            with (other) // whilst glooped, gradually damage mega man.
            {
                dmgTimer += 1;
                if (dmgTimer == dmgMax)
                {
                    hurtMega = true;
                    dmgTimer = 0;
                }
            }
            if (other.hurtMega) // if the hurt mega is triggered, do damage once.
            {
                if (canHit && other.dmg > 0)
                {
                    if (global.skullAmulet)
                    {
                        if (!(global.playerHealth[playerID] - other.dmg)
                            && global.playerHealth[playerID] > 1)
                        {
                            other.dmg = global.playerHealth[playerID] - 1;
                            playSFX(sfxMenuSelect);
                        }
                    }
                    global.playerHealth[playerID] -= other.dmg;
                    playSFX(sfxHit);
                }
                other.hurtMega = false;
            }

            // set status of mega man
            if (instance_exists(statusObject))
            {
                statusObject.statusWalkSpeed = 1.3 / 2;
                statusObject.statusChangedWalk = true;

                // disable mega man's abilities whilst glooped
                statusObject.statusCanJump = false;
                statusObject.statusCanClimb = false;
                statusObject.statusCanSlide = false;

                statusObject.statusCanShoot = false;
                // reset charge
                if isCharge
                {
                    isCharge = false;
                    playerPalette();
                }
            }
            if (climbing)
            {
                climbing = false;
                climbLock = lockPoolRelease(climbLock);
            }
            other.x = x;
            other.y = y + 6;
            other.depth = depth - 10;
            if (yspeed < 0)
                yspeed = 0;
        }
        if (animNameID == 2)
            other.image_index = spriteX - 2;
        else if (other.fire)
            other.image_index = 5;
        else if (isSlide)
            other.image_index = 3;
        else
            other.image_index = 1;

        // if player presses shoot button, attempt to break free of gloop
        if (global.keyShootPressed[playerID] && other.fire == 0)
        {
            other.fire = 5;
            event_perform_object(objGloopBreaker, ev_other, ev_user14);
        }
        other.image_xscale = image_xscale;



        // if breaking free, stop mega man's movement entirely
        if (other.fire > 0)
        {
            other.fire -= 1;
            spriteY = 2;
            if (instance_exists(statusObject))
                statusObject.statusWalkSpeed = 0;
            xspeed = 0;
            if (!other.gloopLock)
                other.gloopLock = lockPoolLock(localPlayerLock[PL_LOCK_MOVE]);
        }
        else if (!ground)
        {
            if (instance_exists(statusObject))
                statusObject.statusWalkSpeed = 0;
            xspeed = 0;
        }
        else if (playerIsLocked(PL_LOCK_MOVE))
        {
            if (instance_exists(statusObject))
                statusObject.statusWalkSpeed = 1.3 / 2;
            other.gloopLock = lockPoolRelease(other.gloopLock);
        }
        else
        {
            if (instance_exists(statusObject))
                statusObject.statusWalkSpeed = 1.3 / 2;
        }
    }
}
if ((entityCanStep()) && !pop)
{
    if (instance_exists(objGloopBreaker))
    {
        with(objGloopBreaker)
        {
            with (other)
            {
                iFrames = 4;
                playSFX(sfxEnemyHit);
                healthpoints -=1;
            }

            instance_destroy();
        }
    }

    if (healthpoints <= 0)
    {
        pop = true;
    }
}
else if (pop)
{
    with (capture)
    {
        if (instance_exists(statusObject))
        {
            statusObject.statusChangedWalk = false;

            // reenable mega man's abilities
            statusObject.statusCanJump = true;
            statusObject.statusCanClimb = true;
            statusObject.statusCanShoot = true;
            statusObject.statusCanSlide = true;
        }
        climbLock = lockPoolRelease(climbLock);
    }
    instance_destroy();
}
if (dead || instance_exists(objSectionSwitcher))
{
    gloopLock = lockPoolRelease(gloopLock);
    with (capture)
    {
        if (instance_exists(statusObject))
        {
            statusObject.statusChangedWalk = false;

            // reenable mega man's abilities
            statusObject.statusCanJump = true;
            statusObject.statusCanClimb = true;
            statusObject.statusCanShoot = true;
            statusObject.statusCanSlide = true;
        }
        climbLock = lockPoolRelease(climbLock);
    }
    dead = true;
}
#define Other_20
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
pop = true;
