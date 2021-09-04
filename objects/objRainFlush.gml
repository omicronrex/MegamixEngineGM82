#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();

bulletLimitCost = 1;

contactDamage = 2;
canDamage = 0;
despawnRange = -1;

image_speed = 0.75;

penetrate = 3;
pierces = 2;
attackDelay = 8;

timer = 0;
raining = false;

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
    if (!raining)
    {
        if (abs(yspeed) < 5)
        {
            yspeed -= 0.575 * sign(image_yscale);
        }

        if ((y < view_yview[0] && sign(image_yscale) == 1)
            || (y > view_yview[0] + view_hview[0] && sign(image_yscale) == -1))
        {
            yspeed = 0;
            visible = false;
            raining = true;
        }
    }
    else
    {
        x = view_xview[0] + view_wview / 2;
        y = view_yview[0] + view_hview / 2;

        timer++;

        if (timer == 30)
        {
            visible = true;
            sprite_index = sprRainFlushParticle;
        }

        if (timer > 30)
        {
            if (timer >= 110)
            {
                instance_destroy();
                exit;
            }

            if (timer mod 10 == 1)
            {
                playSFX(sfxRainFlush);
            }

            if (timer mod 32 == 2)
            {
                with (prtEntity)
                {
                    if (insideView()&&global.factionStance[other.faction, faction] && canHit && !dead && !iFrames)
                    {
                        with (other)
                        {
                            entityEntityCollision();
                        }
                    }
                }
            }
        }
    }
}
#define Other_22
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
weaponSetup("RAIN FLUSH", make_color_rgb(184, 248, 24), make_color_rgb(255, 255, 255), sprWeaponIconsRainFlush);
#define Other_23
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
/// special damage

specialDamageValue("fire", 4);
#define Other_24
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
// EV_WEAPON_CONTROL

if (global.keyShootPressed[playerID] && !playerIsLocked(PL_LOCK_SHOOT))
{
    i = fireWeapon(4, -16, objRainFlush, 1, 4, 2, 0);
    if (i) // set starting speed
    {
        i.yspeed = -0.5;
    }
}
#define Draw_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if (raining)
{
    for (i = 1; i <= 16; i += 1)
    {
        // regular grav
        if sign(image_yscale) == 1
        {
            draw_sprite(sprite_index, -1,
                view_xview + view_wview - ((timer * 4 + i * 64) mod view_wview),
                view_yview + ((timer * 4 + i * 128) mod view_hview));
        }
        // reverse grav
        else
        {
            draw_sprite_ext(sprite_index, -1,
                view_xview + view_wview - ((timer * 4 + i * 64) mod view_wview),
                view_yview + view_hview - ((timer * 4 + i * 128) mod view_hview),
                1, -1, image_angle, image_blend, image_alpha);
        }
    }
}
else
{
    drawSelf();
}
