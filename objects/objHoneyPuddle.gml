#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();

respawn = false;
contactDamage = 0;

canHit = false;
itemDrop = -1;

respawnRange = -1;
despawnRange = -1;

shiftVisible = 1;
blockCollision = 0;
grav = 0;

stopOnFlash = false;

caughtPlayer = noone;
despawnTimer = 0;
caughtTimer = 0;
honeyLock = false;
#define Destroy_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();

honeyLock = lockPoolRelease(honeyLock);
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();
if (!dead && !global.frozen && !global.timeStopped)
{
    if (!instance_exists(caughtPlayer))
    {
        with (objMegaman)
        {
            with (other)
            {
                if (place_meeting(x, y, other) && other.ground /*&& other.bbox_bottom <= bbox_bottom */ )
                {
                    caughtPlayer = other.id;
                    caughtXScalePrev = other.image_xscale;
                    other.xspeed = 0;
                    other.isSlide = 0;
                    honeyLock = lockPoolLock(
                        other.localPlayerLock[PL_LOCK_MOVE],
                        other.localPlayerLock[PL_LOCK_SLIDE],
                        other.localPlayerLock[PL_LOCK_GRAVITY],
                        other.localPlayerLock[PL_LOCK_SHOOT],
                        other.localPlayerLock[PL_LOCK_CLIMB]);
                }
            }
        }
    }
    else
    {
        // trap player
        with (caughtPlayer)
        {
            climbing = false;
            isShoot = 0;
            isSlide = false;
            mask_index = mskMegaman;
            xspeed = 0;
        }
        caughtPlayer.x = x;
        caughtPlayer.y = y - (caughtPlayer.bbox_bottom - caughtPlayer.y) + 1;

        // time player is caught
        if (caughtTimer >= 8 + ((global.difficulty == DIFF_HARD) * 2))
        {
            honeyLock = lockPoolRelease(honeyLock);
            instance_create(x, y, objExplosion);
            instance_destroy();
            exit;
        }
    }

    // despawn timer
    despawnTimer += 1;
    if (despawnTimer >= 370)
    {
        honeyLock = lockPoolRelease(honeyLock);
        instance_destroy();
        exit;
    }
    else if (despawnTimer >= 300)
    {
        if (despawnTimer mod 2)
        {
            visible = !visible;
        }
    }
}
#define Step_2
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if (!dead && !global.frozen && !global.timeStopped)
{
    if (instance_exists(caughtPlayer))
    {
        with (caughtPlayer)
        {
            spriteX = 13;
            playerPalette(); // Reset colors

            // player wiggle
            if (image_xscale != other.caughtXScalePrev)
            {
                other.caughtTimer+=1;
            }
            other.caughtXScalePrev = image_xscale;
            if(isLocked(other.honeyLock))
            {
                lockPoolRelease(other.honeyLock);
            }
        }
    }
}
