#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();

bulletLimitCost = 1;

contactDamage = 2;

penetrate = 0;
pierces = 0;

playSFX(sfxEnemyBoost);

imgIndex = 0;
maxSpeed = 7;

futureGrav = gravAccel * sign(image_yscale);
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();

if (!global.frozen)
{
    if (imgIndex >= 4) // fall
    {
        imgIndex = 4;
        grav = futureGrav;
    }
    else //appear animation
    {
        imgIndex += 0.5;
    }
}

image_index = imgIndex div 1;
//@noformat the beautifier trips up on this file for some reason
#define Other_18
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
// spawn debris upon hitting an enemy and being destroyed
var i;
for (i = 0; i < 4; i++)
{
    debris = instance_create(x, y, objBrickWeaponDebris);
    debris.image_index = i;
    debris.xspeed = random_range(-1.5, 1.5);
    debris.yspeed = -yspeed * 0.8 + random_range(0, 2);
    if (debris.yspeed > 0)
    {
        debris.yspeed = 0;
    }
}
#define Other_22
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
weaponSetup("BLOCK DROP", global.nesPalette[25], global.nesPalette[47], sprWeaponIconsBrickWeapon);
#define Other_23
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
///Special damage
specialDamageValue("bird", 4);
specialDamageValue("cluster", 3);
specialDamageValue("flying", 4);
specialDamageValue("fire", 3);
specialDamageValue("mets", 0);
#define Other_24
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
var xOffset, yOffset, bulletObject, bulletLimit, weaponCost, action, willStop;

xOffset = 32; // x offset from center of player

yOffset = (view_yview[0] - y + 26) * gravDir; // y offset from center of player

bulletObject = objBrickWeapon;
bulletLimit = 1;
weaponCost = 2;
chargedWeaponCost = 4;
action = 2; // 0 - no frame; 1 - shoot; 2 - throw
willStop = 1; // If this is 1, the player will halt on shooting ala Metal Blade.

var chargeTime = 57; // Set charge time for this weapon
var initChargeTime = 20;

// THE MM11 BRICK WEAPON IS COMPLICATED ALSO, OKAY
if (global.keyShootPressed[playerID] && !playerIsLocked(PL_LOCK_SHOOT))
{
    for (z = 0; z <= 3; z += 1)
    {
        i = fireWeapon(xOffset + z * 25, yOffset, bulletObject, bulletLimit * (z == 0), weaponCost * (z == 0), action, willStop);
        if (!instance_exists(i))
        {
            break;
        }
    }
}

//////////////
// Charging //
//////////////

if (global.ammo[playerID, global.weapon[playerID]] >= chargedWeaponCost)
{
    if ((global.keyShoot[playerID] || (isSlide && chargeTimer > 0))
        && !playerIsLocked(PL_LOCK_CHARGE))
    {
        if (!isShoot)
        {
            isCharge = true;
            if (!isSlide)
            {
                initChargeTimer += 1;
            }

            if (initChargeTimer >= initChargeTime)
            {
                chargeTimer += 1;
                if (chargeTimer == 1)
                {
                    playSFX(sfxCharging);
                }

                if (chargeTimer < chargeTime)
                {
                    var chargeTimeDiv, chargeCol;
                    chargeTimeDiv = round(chargeTime / 3);
                    if (chargeTimer < chargeTimeDiv)
                    {
                        chargeCol = make_color_rgb(168, 0, 32); // Dark red
                    }
                    else if (chargeTimer < chargeTimeDiv * 2)
                    {
                        chargeCol = make_color_rgb(228, 0, 88); // Red (dark pink)
                    }
                    else
                    {
                        chargeCol = make_color_rgb(248, 88, 152); // Light red (pink)
                    }

                    if (chargeTimer mod 6 >= 0 && chargeTimer mod 6 < 3)
                    {
                        global.outlineCol[playerID] = chargeCol;
                    }
                    else
                    {
                        global.outlineCol[playerID] = c_black;
                    }
                }
                else
                {
                    if (chargeTimer == chargeTime)
                    {
                        audio_stop_sound(sfxCharging);
                        playSFX(sfxCharged);
                    }

                    switch (floor(chargeTimer / 3 mod 3))
                    {
                        case 0:
                            global.primaryCol[playerID] = global.weaponSecondaryColor[global.weaponID[? objBrickWeapon]];
                            global.secondaryCol[playerID] = c_black;
                            global.outlineCol[playerID] = global.weaponPrimaryColor[global.weaponID[? objBrickWeapon]];
                            break;
                        case 1:
                            global.primaryCol[playerID] = c_black;
                            global.secondaryCol[playerID] = global.weaponPrimaryColor[global.weaponID[? objBrickWeapon]];
                            global.outlineCol[playerID] = global.weaponSecondaryColor[global.weaponID[? objBrickWeapon]];
                            break;
                        case 2:
                            global.primaryCol[playerID] = global.weaponPrimaryColor[global.weaponID[? objBrickWeapon]];
                            global.secondaryCol[playerID] = global.weaponSecondaryColor[global.weaponID[? objBrickWeapon]];
                            global.outlineCol[playerID] = c_black;
                            break;
                    }
                }
            }
        }
    }
    else // Release the charge shot
    {
        if (!playerIsLocked(PL_LOCK_SHOOT) && chargeTimer != 0)
        {
            /////////////////////
            // ACTUAL SHOOTING //
            /////////////////////

            if (chargeTimer >= chargeTime)
            {
                for (q = 0; q <= 1; q += 1)
                {
                    for (z = 0; z <= 7; z += 1)
                    {
                        i = fireWeapon(xOffset / 2 + z * 15, yOffset - 8 + q * 15, bulletObject, bulletLimit * (z + q == 0), chargedWeaponCost * (z + q == 0), action, willStop);
                        if (instance_exists(i))
                        {
                            i.futureGrav += random_range(-0.10, 0.06) + q * 0.16;
                        }
                    }

                    if (!i)
                    {
                        break;
                    }
                }
            }

            playSFX(sfxGutsQuake);

            // reset all charging stuff
            chargeTimer = 0;
            initChargeTimer = 0;
            audio_stop_sound(sfxCharged);
            audio_stop_sound(sfxCharging);
            playerPalette(); // Reset the colors
        }
    }
}
