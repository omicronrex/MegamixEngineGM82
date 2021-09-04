#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();

bulletLimitCost = 1;

contactDamage = 0;

isSolid = 2;

// magnet beam never hits enemies
canHit = false;

despawnRange = -1;

// magnet beam specific:
extendSpeed = 4;
extended = 0;

// timers
timer = 0;
deathTimer = 0;

// is currently extending
growing = true;
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();

if (!global.frozen)
{
    timer += 1;

    if (growing)
    {
        growing = false;
        if (instance_exists(parent))
        {
            with (parent)
            {
                if (global.keyShoot[playerID] && global.ammo[playerID, global.weapon[playerID]] > 0)
                {
                    if (!playerIsLocked(PL_LOCK_SHOOT))
                    {
                        // drain ammo
                        global.ammo[playerID, global.weapon[playerID]] = max(0, global.ammo[playerID, global.weapon[playerID]] - 1 / 30 / (global.energySaver + 1));

                        // Shoot a dummy bullet to get Mega Man's shoot coordinates
                        i = fireWeapon(20, -3, prtPlayerProjectile, 0, 0, 0, 0);
                        other.x = i.x;
                        other.y = i.y;
                        with (i)
                        {
                            instance_destroy();
                        }

                        other.image_xscale = image_xscale;
                        other.image_yscale = image_yscale;

                        other.growing = true;
                        shootTimer = 0;
                        isShoot = 1;
                    }
                }
            }
        }

        extended += extendSpeed;
        deathTimer = extended / 4 + (2.5 * room_speed);
    }
    else
    {
        deathTimer-=1;
        if (!deathTimer)
        {
            event_user(EV_DEATH);
        }
    }

    image_xscale = floor(max(16, extended) / sprite_get_width(sprite_index)) * sign(image_xscale);
}
#define Other_22
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
weaponSetup("MAGNET BEAM", -1, -1, sprWeaponIconsMagnetBeam);
#define Other_24
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
// EV_WEAPON_CONTROL

if (global.keyShootPressed[playerID] && !playerIsLocked(PL_LOCK_SHOOT))
{
    i = fireWeapon(20, -3 * image_yscale, objMagnetBeam, 3, 1, 1, 0);
    if (instance_exists(i))
    {
        playSFX(sfxBlockZap);
        i.xst = i.x - x;
        i.yst = i.y - y;
    }
}
#define Draw_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if (!dead)
{
    // flicker before disappearing:
    if (growing || deathTimer >= 48 || (deathTimer mod 12 >= 6))
    {
        var length; length = abs(floor(sprite_width));
        var sLength; sLength = length;
        var img; img = sprite_get_width(sprite_index) - ((timer / 2) mod sprite_get_width(sprite_index));

        while (length > 0)
        {
            var draw; draw = min(sprite_get_width(sprite_index) - img, length);

            draw_sprite_part_ext(sprite_index, 0, img, 0, draw, sprite_height * image_yscale, round(x) + ((sLength - length) * sign(image_xscale)), round(y), sign(image_xscale), image_yscale, global.primaryCol[playerID], 1);
            draw_sprite_part_ext(sprite_index, 1, img, 0, draw, sprite_height * image_yscale, round(x) + ((sLength - length) * sign(image_xscale)), round(y), sign(image_xscale), image_yscale, global.secondaryCol[playerID], 1);

            length -= draw;
            img = 0;
        }

        var i; for ( i = 0; i < 2; i+=1)
        {
            var xs; xs = 0;

            if (i == 0)
            {
                var xs; xs = sLength * sign(image_xscale);
            }
            else if (growing)
            {
                continue;
            }

            draw_sprite_ext(sprMagnetBeamEnd, floor(timer / 4), x + xs, round(y), 1, image_yscale, image_angle, global.primaryCol[playerID], image_alpha);
            draw_sprite_ext(sprMagnetBeamEnd, floor(timer / 4) + 1, x + xs, round(y), 1, image_yscale, image_angle, global.secondaryCol[playerID], image_alpha);
        }
    }
}
