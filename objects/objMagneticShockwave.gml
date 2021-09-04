#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();

bulletLimitCost = 1;

contactDamage = 2;

penetrate = 1;
pierces = 2;
attackDelay = 9;

playSFX(sfxEnemyBoost);

imgIndex = 0;
imgSpeed = 0.05;
spawnTimer = 10;

number = 0;

timer = 0;
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();

if (!global.frozen)
{
    // Animation + destroying
    imgIndex += 0.2;

    if (imgIndex >= image_number)
    {
        instance_destroy();
    }

    if (number < 4)
    {
        if (spawnTimer) // spreading across
        {
            spawnTimer--;
            if (!spawnTimer && insideView())
            {
                i = instance_create(x + (28 * image_xscale), y, objMagneticShockwave);
                i.number = number + 1;
                i.image_xscale = image_xscale;
                i.image_yscale = image_yscale;
            }
        }
    }

    if (timer == 0)
    {
        // screenShake(2, 1, 1);
        if (!positionCollision(x - 8, y + image_yscale) || !positionCollision(x + 8, y + image_yscale))
        {
            i = instance_create(x, y, objSingleLoopEffect);
            i.sprite_index = sprExplosion;
            i.image_index = 1;
            i.image_speed = 0.15;
        }
    }

    timer++;
    if (!(timer mod 3))
    {
        i = instance_create(irandom_range(x - 7, x + 7), y, objSingleLoopEffect);
        i.sprite_index = sprMagneticShockwaveParticle;
        i.image_speed = 0.4;
        i.vspeed = (-irandom(25) / 10 * (1 - ((timer mod 6) == 0) * 1.33)) * image_yscale;
    }
}

image_index = floor(imgIndex);
#define Other_17
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
playSFX(sfxReflect);

repeat (32)
{
    i = instance_create(irandom_range(bbox_left, bbox_right), irandom_range(bbox_top, bbox_bottom), objSingleLoopEffect);
    i.sprite_index = sprMagneticShockwaveParticle;
    i.image_speed = 0.25;
    i.vspeed = -0.1 * image_yscale;
}

event_user(EV_DEATH);
#define Other_22
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
weaponSetup("MAGNETIC SHOCKWAVE", make_color_rgb(96, 48, 136), make_color_rgb(248, 80, 0), sprWeaponIconsMagneticShockwave);
#define Other_23
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
specialDamageValue("bulky", 4);
specialDamageValue("joes", 1);
specialDamageValue("shielded", 1);
specialDamageValue("shield attackers", 1);
specialDamageValue("mets", 0);
#define Other_24
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if (global.keyShootPressed[playerID] && !playerIsLocked(PL_LOCK_SHOOT) && !shootStandStillLock)
{
    fireWeapon(28, 13, objMagneticShockwave, 1, 4, 1, 1);
}
