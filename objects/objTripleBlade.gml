#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();

bulletLimitCost = 1;

contactDamage = 1;

penetrate = 0;
pierces = 1;

xspeed = 0;
yspeed = 0;
grav = 0;

if (!parent.ground)
{
    y += parent.image_yscale;
}

playSFX(sfxTripleBlade);
#define Other_22
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
weaponSetup("TRIPLE BLADE", make_color_rgb(184, 0, 184), make_color_rgb(252, 252, 252), sprWeaponIconsTripleBlade);
#define Other_23
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
specialDamageValue("bulky", 3);
#define Other_24
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
var xOffset, yOffset, bulletObject, bulletLimit, weaponCost, action, willStop;

xOffset = 16; // x offset from center of player
yOffset = 0; // y offset from center of player
bulletObject = objTripleBlade;
bulletLimit = 1;
weaponCost = 1;
action = 1; // 0 - no frame; 1 - shoot; 2 - throw
willStop = 0; // If this is 1, the player will halt on shooting ala Metal Blade.

// TRIPLE BLADE IS COMPLICATED OK
if (global.keyShootPressed[playerID] && !playerIsLocked(PL_LOCK_SHOOT))
{
    for (z = 0; z <= 2; z += 1)
    {
        i = fireWeapon(xOffset, yOffset, bulletObject, bulletLimit * (z == 0), weaponCost * (z == 0), action, willStop);
        if (i)
        {
            i.image_index = z;
            i.speed = 5;

            if (image_xscale == -1)
            {
                i.direction += 180;
            }

            if (ground ^^ gravDir == -1)
            {
                i.direction += z * 15 * image_xscale;
            }
            else
            {
                i.direction -= z * 15 * image_xscale;
                if (z > 0)
                {
                    i.image_index += 2;
                }
            }

            if (gravDir == -1)
            {
                i.image_yscale *= -1;
            }
        }
        else
        {
            break;
        }
    }
}
