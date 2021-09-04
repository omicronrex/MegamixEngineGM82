#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();

bulletLimitCost = 1;

contactDamage = 2;

image_speed = 0.15;

penetrate = 3;
pierces = 0;

xspeed = 0;
yspeed = 0;
grav = 0;

playSFX(sfxIceSlasher);
#define Other_18
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
with (other)
{
    entityIceFreeze(360, false, false, 0);
}
#define Other_22
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
weaponSetup("ICE SLASHER", global.nesPalette[15], global.nesPalette[26], sprWeaponIconsIceSlasher);
#define Other_24
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
var xOffset, yOffset, bulletObject, bulletLimit, weaponCost, action, willStop;

xOffset = 16; // x offset from center of player
yOffset = 0; // y offset from center of player
bulletObject = objIceSlasher;
bulletLimit = 2;
weaponCost = 1;
action = 1; // 0 - no frame; 1 - shoot; 2 - throw
willStop = 0; // If this is 1, the player will halt on shooting ala Metal Blade.

if (global.keyShootPressed[playerID] && !playerIsLocked(PL_LOCK_SHOOT))
{
    i = fireWeapon(xOffset, yOffset, bulletObject, bulletLimit, weaponCost, action, willStop);

    // set starting speed
    if (instance_exists(i))
    {
        i.xspeed = image_xscale * 5;
    }
}
