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
pierces = 0;

xspeed = 0;
yspeed = 0;
grav = 0;

playSFX(sfxMetalBlade);

image_speed = 0.35;
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
        xspeed = cos(degtorad(dir)) * 4;
        yspeed = -sin(degtorad(dir)) * 4 * sign(image_yscale); // The vertical speed was, for some reason, inverted, which is why I used a minus. Don't ask me what actually caused this behaviour
    }
}
#define Other_22
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
weaponSetup("METAL BLADE", make_color_rgb(136, 112, 0), make_color_rgb(255, 224, 168), sprWeaponIconsMetalBlade);
#define Other_23
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
specialDamageValue("nature", 3);
#define Other_24
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if (global.keyShootPressed[playerID] && !playerIsLocked(PL_LOCK_SHOOT))
{
    i = fireWeapon(16, 3, objMetalBlade, 3, 0.5, 2, 1);
    if (instance_exists(i))
    {
        i.dir = 0;

        if (image_xscale < 0)
        {
            i.dir += 180;
        }

        if (yDir != 0)
        {
            i.dir -= (yDir * 90) * image_xscale;
            if (xDir != 0)
            {
                i.dir += (yDir * 45) * image_xscale;
            }
        }
    }
}
