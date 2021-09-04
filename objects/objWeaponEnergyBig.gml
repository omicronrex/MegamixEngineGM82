#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();

usePlayerColor = 1;
image_speed = 1 / 6;

hlth = 10;

respawnupondeath = 1;
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();
if (global.pickupGraphics)
{
    sprite_index = sprWeaponEnergyBigMM1;
}
else
{
    sprite_index = sprWeaponEnergyBig;
}
#define Other_10
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
instance_destroy();

var pid; pid = collectPlayer.playerID;
increaseWeapon = global.weapon[pid];

var e; e = global.ammo[pid, global.weapon[pid]];

// Energybalancer
if (global.weapon[pid] == 0 || e == 28)
{
    for (i = 1; i <= global.totalWeapons; i += 1)
    {
        if (e > global.ammo[pid, i])
        {
            increaseWeapon = i;
            e = global.ammo[pid, i];
        }
    }
}

if (e < 28)
{
    global.frozen = true;
    with (objGlobalControl)
    {
        increaseAmmo = other.hlth;
        increaseWeapon = other.increaseWeapon;
        increasePID = pid;
    }
    loopSFX(sfxEnergyRestore);
}
