#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();

bulletLimitCost = 2;

contactDamage = 0.5;

penetrate = 3;
pierces = 2;
attackDelay = 60;

state = 0;
stateTimer = 0;
animTimer = 0;

isLightning = false;
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();

if (!global.frozen)
{
    if (isLightning)
    {
        sprite_index = sprThunderWoolThunder;
        canHit = true;
        exit;
    }

    canHit = false;

    // Animation
    animTimer += 1;

    if (animTimer == 3)
    {
        animTimer = 0;

        // bad code
        var frameswitch;
        frameswitch[0] = 1;
        if (state == 2)
        {
            frameswitch[1] = 4;
        }
        else
        {
            frameswitch[1] = 2;
        }
        frameswitch[2] = 3;
        frameswitch[3] = 0;
        frameswitch[4] = 5;
        frameswitch[5] = 0;

        image_index = frameswitch[image_index];
    }

    stateTimer += 1;

    if (state == 0)
    {
        if (abs(xspeed) > 0)
        {
            xspeed -= (min(abs(xspeed), 0.025) * image_xscale);
        }

        if (y < view_yview + 48 && sign(grav) == 1)
        || (y > view_yview + 224 - 48 && sign(grav) == -1)
        {
            yspeed += (grav * 4) * image_yscale;
        }

        if (instance_exists(parent)) // stop and shoot thunder
        {
            if (checkSolid(0, yspeed) || stateTimer >= 120
            || ((y < view_yview + 32 && sign(grav) == 1) || (y > view_yview + 256 - 32 && sign(grav) == -1)))
            {
                grav = 0;
                state = 1;
                stateTimer = 0;
                xspeed = 0;
                bulletLimitCost = 1;

                yspeed = 0;
            }
        }
    }

    if (state == 1) // slow down, wait
    {
        yspeed += min(-yspeed, 0.2) * image_yscale;

        if (stateTimer >= 20 && yspeed == 0)
        {
            state = 2;
            playSFX(sfxThunderWoolThunder);
            stateTimer = 0;
        }
    }

    if (state == 2) // shoot
    {
        // if being reflected, dont shoot thunderbolts
        if (!canDamage)
        {
            stateTimer = 1;
        }

        if (!(stateTimer mod 5))
        {
            i = instance_create(x, y - 8 * image_yscale, objThunderWool);
            i.isLightning = true;
            i.image_yscale = image_yscale;
            i.yspeed = 8 * image_yscale;
            i.image_speed = 0.25;
            i.bulletLimitCost = 0;
            i.sprite_index = sprThunderWoolThunder;
        }

        if (stateTimer >= 120)
        {
            instance_create(x, y - 8, objExplosion);
            instance_destroy();
        }
    }
}
#define Other_22
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
weaponSetup("THUNDER WOOL", make_color_rgb(112, 112, 112), make_color_rgb(240, 184, 56), sprWeaponIconsThunderWool);
#define Other_23
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
specialDamageValue("flying", 2);
specialDamageValue("aquatic", 2);
#define Other_24
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if (global.keyShootPressed[playerID] && !playerIsLocked(PL_LOCK_SHOOT))
{
    i = fireWeapon(16, -1, objThunderWool, 2, 2, 1, 0);
    if (i) // set starting speed
    {
        i.xspeed = 1 * image_xscale;
        i.yspeed = -0.25 * sign(image_yscale);
        i.grav = -0.1 * sign(image_yscale);

        playSFX(sfxThunderWoolRise);
    }
}
