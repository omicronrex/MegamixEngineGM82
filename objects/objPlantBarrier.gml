#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();

bulletLimitCost = 1;

contactDamage = 4;

image_speed = (2 / 3);

penetrate = 0;
pierces = 0;

playSFX(sfxBuster);
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();

if (!global.frozen)
{
    if (instance_exists(parent))
    {
        x = spriteGetXCenterObject(parent);
        y = spriteGetYCenterObject(parent);
    }
    else
    {
        instance_destroy();
    }
}
#define Collision_prtEnemyProjectile
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if (canDamage)
{
    switch (other.reflectable)
    {
        case -1:
        case 1:
            with (other)
            {
                instance_destroy();
            }
            instance_destroy();
            break;
    }
}
#define Other_17
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
instance_destroy();
playSFX(sfxReflect);
#define Other_22
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
weaponSetup("PLANT BARRIER", make_color_rgb(248, 88, 152), make_color_rgb(248, 248, 248), sprWeaponIconsPlantBarrier);
#define Other_23
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
///Special Damage
specialDamageValue("aquatic", 6);
specialDamageValue("bird", 2);
specialDamageValue("fire", 1);
#define Other_24
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
// EV_WEAPON_CONTROL

if (global.keyShootPressed[playerID] && !playerIsLocked(PL_LOCK_SHOOT))
{
    i = fireWeapon(0, 0, objPlantBarrier, 1, 2, 1, 0);
}
