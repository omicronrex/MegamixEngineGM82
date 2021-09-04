#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();

bulletLimitCost = 1;

contactDamage = 2;

image_speed = 0.2;

penetrate = 0;
pierces = 0;

xspeed = 0;
yspeed = 0;
grav = 0;

timer = 0;
isWave = false;

playSFX(sfxSolarBlaze);
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();

if (!global.frozen)
{
    if (!isWave) // solar blaze and its waves are one object
    {
        // slow down
        if (abs(xspeed) > 0)
        {
            xspeed -= 0.25 * image_xscale;
        }

        // blowup timer
        timer += 1;
        if (timer == 30 && canDamage)
        {
            event_user(EV_DEATH);
        }
    }
    else
    {
        // MM10 behavior
        penetrate = 2;
        pierces = 2;
    }
}
#define Other_20
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();

if (!isWave)
{
    playSFX(sfxSolarBlazePop);
    repeat (2)
    {
        image_xscale *= -1;

        i = instance_create(x, y, objSolarBlaze);
        i.isWave = true;
        i.sprite_index = sprSolarBlazeWave;
        i.image_xscale = image_xscale;
        i.xspeed = 5 * image_xscale;
        i.bulletLimitCost = 0;
    }
}
#define Other_22
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
weaponSetup("SOLAR BLAZE", make_color_rgb(216, 40, 0), make_color_rgb(240, 184, 56), sprWeaponIconsSolarBlaze);
#define Other_23
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
specialDamageValue("cannons", 4);
#define Other_24
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
var xOffset, yOffset, bulletObject, bulletLimit, weaponCost, action, willStop;

xOffset = 16; // x offset from center of player
yOffset = 0; // y offset from center of player
bulletObject = objSolarBlaze;
bulletLimit = 2;
weaponCost = 1;
action = 1; // 0 - no frame; 1 - shoot; 2 - throw
willStop = 0; // If this is 1, the player will halt on shooting ala Metal Blade.

if (global.keyShootPressed[playerID] && !playerIsLocked(PL_LOCK_SHOOT))
{
    var i = fireWeapon(xOffset, yOffset, bulletObject, bulletLimit, weaponCost, action, willStop);
    if (instance_exists(i))
    {
        i.xspeed = image_xscale * 4.25; // zoom
    }
}
