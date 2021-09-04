#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();

bulletLimitCost = 1;

contactDamage = 0;

penetrate = 3;
pierces = 0;

timer = 0;

scalespeed = 0.5;
scalegrav = 0.025;

phase = 1;
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();

if (entityCanStep())
{
    if (phase == 1)
    {
        image_xscale += scalespeed * dir;
        image_yscale += scalespeed;

        scalespeed -= scalegrav;

        if (abs(image_xscale) == 0.1)
        {
            a = instance_create(x, y, objWeaponExplosion);
            a.contactDamage = 99;

            if (target)
            {
                rn = point_direction(x, y, target.x, target.y);
            }
            else
            {
                rn = irandom(45);
            }

            playSFX(sfxEnkerShotBig);
            screenShake(16, 2, 2);
            event_user(EV_DEATH);

            for (i = 0; i < 8; i+=1)
            {
                z = instance_create(x, y, object_index);
                z.phase = 2;
                z.speed = 5;
                z.direction = rn + (i * 45);
                z.image_xscale = choose(1, -1);
                z.dir = choose(1, -1);
                z.contactDamage = choose(69, 666, 420, 360, 42);

                instance_create(x + irandom(48) * choose(1, -1), y + irandom(48) * choose(1, -1), objBigExplosion);
            }
        }
    }
    else
    {
        timer+=1;
        if (timer >= 30)
        {
            if (checkSolid(0, 0))
            {
                event_user(EV_ATTACK);
                event_user(EV_DEATH);
            }
        }
    }

    image_angle += (6 + (phase == 2) * 4) * dir;
}
#define Other_18
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if (phase == 2)
{
    instance_create(x, y, objWeaponExplosion);

    global.damage = 0;
    i = instance_create(x, y, objDamagePopup);
    i.str = choose(choose("WOW!", "NICE", "*_*", "DEADLY", "MEME", "DELET THIS", "THE END IS NOW", "9001", "An Excellent#Explosion", "NICE"),choose("WOW?", "I HOPE I WIN", "KABOOM!", "GOOD JOB M8", "Is this loss?", "STALE MEME", "TOO OP#PLS NERF", "Y U NO#SHUUT?", "MEGA MAN#DOES HIS#TAXES", "MEME"));
    i.timer -= 60;

    global.damage = contactDamage;

    repeat (3)
    {
        instance_create(x + irandom(32) * choose(1, -1), y + irandom(32) * choose(1, -1), objWeaponExplosion);
    }

    playSFX(sfxGutsQuake);
    playSFX(sfxMM3Explode);
    screenShake(50, 4, 4);
}
#define Other_22
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
weaponSetup("S.PAKKAJOE", global.nesPalette[6], global.nesPalette[40], sprWeaponIconsSkeletuppinPakkajoe);
#define Other_24
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if (global.keyShootPressed[playerID] && !playerIsLocked(PL_LOCK_SHOOT))
{
    i = fireWeapon(16, 0, objSkeletuppinPakkajoe, 1, 0.1, 2, 1);
    if (instance_exists(i))
    {
        i.dir = image_xscale;
        i.image_xscale = 0.1 * i.dir;
        i.image_yscale = 0.1;

        playSFX(sfxSkeletuppinPakkajoe);
    }
}
