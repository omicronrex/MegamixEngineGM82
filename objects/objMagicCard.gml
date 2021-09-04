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
despawnRange = 64;

pickup = 0;
boomerangBack = false;

image_speed = 0.15;

playSFX(sfxMagicCard);
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
        // slow down
        if (!boomerangBack)
        {
            if (sprite_index == sprMagicCard)
            {
                xspeed -= (0.2 * image_xscale);
            }
            else
            {
                yspeed += 0.2 * sign(image_yscale);
            }

            // start boomeranging back to player
            if ((sprite_index == sprMagicCard && abs(xspeed) <= 0.5)
                || (sprite_index == sprMagicCardVertical && abs(yspeed) <= 0.5))
            {
                boomerangBack = true;
                if (sprite_index == sprMagicCard)
                {
                    speed = abs(xspeed);
                    xspeed = 0;
                }
                else
                {
                    speed = abs(yspeed);
                    yspeed = 0;
                }
            }
        }

        // actual boomerang
        if (boomerangBack && instance_exists(parent))
        {
            speed += 0.2;
            mp_linear_step(parent.x, parent.y, speed, false);

            if (place_meeting(x, y, parent) && !pickup) // die on contact with parent if no item is held
            {
                instance_destroy();
            }
        }

        // pick up items
        if (!pickup && instance_exists(parent)) // Collect pickups
        {
            if (place_meeting(x, y, prtPickup))
            {
                pickup = instance_place(x, y, prtPickup);
                if (pickup.grabable)
                {
                    pickup.depth = depth - 1;
                    with (object_index)
                    {
                        if (id != other.id)
                        {
                            if (pickup == other.pickup)
                            {
                                other.pickup = 0;
                            }
                        }
                    }
                }
                else
                {
                    pickup = 0;
                }
            }
        }
        if (pickup) // Control collected pickup
        {
            if (instance_exists(pickup))
            {
                pickx = spriteGetXCenterObject(pickup) - pickup.x;
                picky = spriteGetYCenterObject(pickup) - pickup.y;
                pickup.x = x - pickx + 2 * image_xscale;
                pickup.xspeed = 0;
                pickup.y = y - picky + 2;
                pickup.yspeed = 0;
            }
            else
            {
                pickup = 0;
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
weaponSetup("MAGIC CARD", make_color_rgb(112, 112, 112), make_color_rgb(248, 112, 176), sprWeaponIconsMagicCard);
#define Other_23
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
specialDamageValue("joes", 4);
#define Other_24
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if (global.keyShootPressed[playerID] && !playerIsLocked(PL_LOCK_SHOOT))
{
    i = fireWeapon(16, 2, objMagicCard, 3, 1, 2, 1);
    if (instance_exists(i))
    {
        if ((global.keyUp[playerID] && gravDir == 1) || (global.keyDown[playerID] && gravDir == -1))
        {
            i.yspeed = -6.0 * image_yscale;
            i.sprite_index = sprMagicCardVertical;
        }
        else
        {
            i.xspeed = image_xscale * 5.5; // zoom
        }
    }
}
