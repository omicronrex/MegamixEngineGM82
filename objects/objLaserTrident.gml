#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();

bulletLimitCost = 1;

contactDamage = 1;

image_speed = 0.5;

penetrate = 3;
pierces = 2;
attackDelay = 8;

timer = 0;

playSFX(sfxLaserTrident);
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();

if (!global.frozen)
{
    if (canDamage)
    {
        if (abs(xspeed) < 6)
        {
            xspeed += image_xscale * 0.575;
        }
    }
    else
    {
        timer++;

        if (instance_exists(entity) && timer < 180)
        {
            shiftObject((entity.x - entityx) - x, (entity.y - entityy) - y, blockCollision);
        }
        else
        {
            grav = 0.15 * image_yscale;
            if (timer mod 2)
            {
                visible = !visible;
            }
        }
    }
}
#define Other_17
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
canHit = false;
canDamage = 0;

entity = other.id;
entityx = other.x - x;
entityy = other.y - y;

playSFX(sfxReflect);
image_speed /= 4;
xspeed = -0.5 * image_xscale;

repeat (2)
{
    image_yscale *= -1;
    with (instance_create(x + 8 * image_xscale, y + 5 * image_yscale, objMegamanSweat))
    {
        image_xscale = other.image_xscale;
        image_yscale = other.image_yscale;
    }
}
#define Other_22
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
weaponSetup("LASER TRIDENT", make_color_rgb(113, 130, 246), make_color_rgb(231, 191, 60), sprWeaponIconsLaserTrident);
#define Other_23
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
/// special damage

specialDamageValue("joes", 4);
specialDamageValue("shielded", 2);
specialDamageValue("shield attackers", 2);
specialDamageValue("primate", 3);
#define Other_24
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
// EV_WEAPON_CONTROL

if (global.keyShootPressed[playerID] && !playerIsLocked(PL_LOCK_SHOOT))
{
    i = fireWeapon(25, -1, objLaserTrident, 3, 0.5, 1, 0);
    if (i) // set starting speed
    {
        i.xspeed = image_xscale * 0.5;
    }
}
