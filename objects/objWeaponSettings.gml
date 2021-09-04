#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
// Allows you to tweak weapons on a per-level basis.
// Creation code options:

// setWeaponLocked(objWhatever,true/false);

// Examples:
// setWeaponLocked(objBreakDash,true);
// setWeaponLocked(objMagnetBeam,true);
/*
This object must be placed for this effect; do not use room creation code for this.
objGlobalControl resets infiniteEnergy to zero on a room begin unless this
object exists.
*/

//@cc if true weapons wont be unlocked until the level ends
onlyUnlockOnLevelEnd = false;

//@cc script that runs when the level begins(won't run after respawning)
levelStartScript = scrNoEffect;

//@cc script that runs when the level ends
levelEndScript = scrNoEffect;

var j; for (j = 0; j <= global.totalWeapons; j+=1)
{
    global.infiniteEnergy[j] = false;
}
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if (global.weaponLocked[0])
{
    global.weaponLocked[0] = false;
    global.lockBuster = true;
}
#define Other_5
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
// weapon clean up
if(onlyUnlockOnLevelEnd)
    exit;

global.lockBuster = false;

for (i = 0; i <= global.totalWeapons; i += 1)
{
    global.weaponLocked[i] = false;
    global.infiniteEnergy[i] = false;
}
#define Other_10
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
//On level start
script_execute(levelStartScript);
#define Other_11
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
script_execute(levelEndScript);
if(!onlyUnlockOnLevelEnd)
    exit;
global.lockBuster = false;

for (i = 0; i <= global.totalWeapons; i += 1)
{
    global.weaponLocked[i] = false;
    global.infiniteEnergy[i] = false;
}
