#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();
blockCollision = 0;
grav = 0;
contactDamage = 2;
dir = 0;
stopOnFlash = false;

parent = noone;
phase = 0;
hasItem = noone;
hp = 0;
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();
if (!global.frozen)
{
    // Movement
    xspeed = cos(degtorad(dir)) * 4 * image_xscale;
    yspeed = -sin(degtorad(dir)) * 4;
    image_index += 0.25;
}
else if (!instance_exists(parent))
{
    instance_destroy();
}
#define Other_18
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();

// Create pickup
i = instance_create(bboxGetXCenter(), bbox_top - 2, objMercuryGrabBusterPickup);

with (other)
{
    // Check if the player has bolts or weapon energy to steal
    if ((global.bolts > 0000) || (global.ammo > 0))
    {
        hasItem = choose(0, 1, 2);

        // Steal bolts
        if (hasItem == 2)
        {
            if (global.bolts >= 10)
            {
                // Choose between big or small bolt
                var z; z = choose(0, 1);

                // Take big Bolt
                if (z == 1)
                {
                    with (other.i)
                    {
                        sprite_index = sprBoltBig;
                        hp = 4;

                        global.bolts -= 10;
                    }
                } // Take small bolt
                else
                {
                    with (other.i)
                    {
                        sprite_index = sprBoltSmall;
                        hp = 2;
                        global.bolts -= 2;
                    }
                }
            } // Take small Bolt if the player has less than 10 Bolts
            else if (global.bolts > 0)
            {
                with (other.i)
                {
                    sprite_index = sprBoltSmall;
                    hp = 2;
                    global.bolts -= 2;
                }
            } // If no bolts, take health
            else
            {
                with (other.i)
                {
                    hp = 2;
                }
            }
        }
        // Steal Weapon energy
        else if (hasItem == 1)
        {
            // Choose random weapon to steal from
            var e; e = random(global.totalWeapons);
            {
                // Check if chosen weapon has ammo above 10
                if (global.ammo[e] > 10)
                {
                    // Choose big or small energy
                    var z; z = choose(0, 1);

                    // Take big energy
                    if (z == 1)
                    {
                        with (other.i)
                        {
                            if (global.pickupGraphics)
                            {
                                sprite_index = sprWeaponEnergyBigMM1;
                            }
                            else
                            {
                                sprite_index = sprWeaponEnergyBig;
                            }
                            hp = 4;
                            global.ammo[e] -= 10;
                        }
                    } // Take small energy
                    else
                    {
                        with (other.i)
                        {
                            if (global.pickupGraphics)
                            {
                                sprite_index = sprWeaponEnergySmallMM1;
                            }
                            else
                            {
                                sprite_index = sprWeaponEnergySmall;
                            }
                            hp = 2;
                            global.ammo[e] -= 2;
                        }
                    }
                } // Take small energy if big energy isn't available
                else if (global.ammo[e] > 0)
                {
                    with (other.i)
                    {
                        if (global.pickupGraphics)
                        {
                            sprite_index = sprWeaponEnergySmallMM1;
                        }
                        else
                        {
                            sprite_index = sprWeaponEnergySmall;
                        }
                        hp = 2;
                        global.ammo[e] -= 2;
                    }
                } // Take health if no ammo
                else
                {
                    with (other.i)
                    {
                        hp = 2;
                    }
                }
            }
        } // Steal health
        else
        {
            with (other.i)
            {
                hp = 2;
            }
        }
    }

    // If no bolts or ammo, take health
    with (other.i)
    {
        hp = 2;
    }
}

if (instance_exists(i))
{
    with (i)
    {
        xspeed = 1.25 * sign(other.xspeed);
        yspeed = -2;
        grav = 0.25;
        x += xspeed;
        parent = objMercuryGrabBuster.parent;
    }
}

// Destroy projectile to stop multiple items being stolen with one shot
instance_destroy();
