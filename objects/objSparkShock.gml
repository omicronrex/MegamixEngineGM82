#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=other
*/
event_inherited();

bulletLimitCost = 1;

contactDamage = -1;

penetrate = 0;
pierces = 0;

xspeed = 0;
yspeed = 0;
grav = 0;

image_speed = 0.5;

playSFX(sfxSparkShock);
#define Other_18
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if (other.faction == faction)
{
    exit;
}

if (global.damage == -1)
{
    global.damage = 0;
    if (other.boss > 0)
    {
        global.damage = 1;
    }
}

with (other)
{
    if (canIce)
    {
        entityIceFreeze(180, false, false, 1);
        i = instance_create(bboxGetXCenter(), bboxGetYCenter(), objSparkShockParalyze);
        i.plzTarget = id;
    }
}
#define Other_22
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
weaponSetup("SPARK SHOCK", make_color_rgb(248, 120, 88), make_color_rgb(248, 248, 248), sprWeaponIconsSparkShock);
#define Other_24
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
// EV_WEAPON_CONTROL

if (global.keyShootPressed[playerID] && !playerIsLocked(PL_LOCK_SHOOT))
{
    i = fireWeapon(25, -1, objSparkShock, 2, 1, 1, 0);
    if (i) // set starting speed
    {
        i.xspeed = image_xscale * 5;
    }
}
