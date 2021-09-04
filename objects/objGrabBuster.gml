#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();

bulletLimitCost = 1;

contactDamage = 1;

image_speed = 0.3;

penetrate = 0;
pierces = 0;

xspeed = 0;
yspeed = 0;
grav = 0;

playSFX(sfxGrabBuster);
#define Other_18
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if (global.damage != 0)
{
    with (other)
    {
        if (instance_exists(other.parent))
        {
            global.playerProjectileCreator = other.parent;
        }
        else
        {
            global.playerProjectileCreator = objMegaman;
        }

        i = instance_create(bboxGetXCenter(), bbox_top - 2, objGrabBusterPickup);
        if (instance_exists(i))
        {
            i.xspeed = 1.25 * sign(other.xspeed);
            i.yspeed = -2;
            i.grav = 0.25;
            i.depth = depth - 1;
            i.x += i.xspeed;
        }
    }
}
#define Other_22
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
weaponSetup("GRAB BUSTER", make_color_rgb(88, 216, 84), make_color_rgb(248, 184, 248), sprWeaponIconsGrabBuster);
#define Other_23
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
specialDamageValue("semi bulky", 3);
#define Other_24
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
var xOffset, yOffset, bulletObject, bulletLimit, weaponCost, action, willStop;

xOffset = 13; // x offset from center of player
yOffset = 0; // y offset from center of player
bulletObject = objGrabBuster;
bulletLimit = 3;
weaponCost = 2;
action = 1; // 0 - no frame; 1 - shoot; 2 - throw
willStop = 0; // If this is 1, the player will halt on shooting ala Metal Blade.

if (global.keyShootPressed[playerID] && !playerIsLocked(PL_LOCK_SHOOT))
{
    i = fireWeapon(xOffset, yOffset, bulletObject, bulletLimit, weaponCost, action, willStop);

    // set starting speed
    if (i)
    {
        i.xspeed = image_xscale * 2;
    }
}
