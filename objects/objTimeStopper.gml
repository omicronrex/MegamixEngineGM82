#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();

contactDamage = 0;

despawnRange = -1;
shiftVisible = true;

global.timeStopped = true;
animationTimer = 0;
contactDamage = 0;
#define Destroy_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_perform_object(objFlashStopper, ev_destroy, 0);
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_perform_object(objFlashmanTimeStop, ev_step, ev_step_normal);
#define Step_1
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_perform_object(objFlashStopper, ev_step, ev_step_begin);

if (entityCanStep())
{
    if (global.ammo[playerID, global.weapon[playerID]] > 0)
        global.ammo[playerID, global.weapon[playerID]] -= 1 / 15;
    else
        instance_destroy();
}
#define Other_22
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
weaponSetup("TIME STOPPER", global.nesPalette[17], global.nesPalette[44], sprWeaponIconsTimeStopper);
#define Other_24
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
/// EV_WEAPON_CONTROL

if (global.keyShootPressed[playerID] && !playerIsLocked(PL_LOCK_SHOOT)
    && (global.ammo[playerID, global.weapon[playerID]] > 0))
{
    if (!instance_exists(objTimeStopper))
    {
        with (instance_create(x, y, objTimeStopper))
            playerID = other.playerID;
        shootTimer = 0;
        isShoot = 2;
        shootStandStillLock = lockPoolRelease(shootStandStillLock);
        shootStandStillLock = lockPoolLock(localPlayerLock[PL_LOCK_MOVE]);
        xspeed = 0;
        playSFX(sfxTimeStopper);
    }
    else
    {
        with (objTimeStopper)
            if (playerID == other.playerID)
                instance_destroy();
            else
                playSFX(sfxError);
    }
}
