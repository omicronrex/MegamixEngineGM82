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
pierces = 1;

xspeed = 0;
yspeed = 0;
grav = 0;

image_index = 0;
image_speed = 0;

angle = 0;
centerX = 0;
centerY = 0;
dist = 16;

playSFX(sfxPowerStone);

despawnRange = 96;
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();

if (!global.frozen && canDamage)
{
    // Growing animation
    if (image_index < image_number - 1)
    {
        image_index += 12 / 60;
    }

    // Movement
    angle += min(12, 7 / (dist / 80));
    dist += 2;
    x = centerX + (cos(degtorad(angle))) * dist;
    y = centerY - (sin(degtorad(angle))) * dist;
}
#define Other_22
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
weaponSetup("POWER STONE", make_color_rgb(124, 8, 0), make_color_rgb(255, 255, 255), sprWeaponIconsPowerStone);
#define Other_23
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
/// special damage

specialDamageValue("flying", 4);
specialDamageValue("floating", 4);
#define Other_24
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
// EV_WEAPON_CONTROL

if (global.keyShootPressed[playerID] && !playerIsLocked(PL_LOCK_SHOOT) && !instance_exists(objPowerStone))
{
    for (var angle = 0; angle < 360; angle += 120)
    {
        i = fireWeapon(cos(degtorad(angle)) * 16, -(sin(degtorad(angle)) * 16), objPowerStone, 3, (1 / 3), 0, 0);
        if (i) // set starting speed
        {
            i.angle = angle;
            i.centerX = spriteGetXCenter();
            i.centerY = spriteGetYCenter();
        }
    }
}
