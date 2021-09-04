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

attackDelay = 16;

timer = 0;
charging = true;
extraDamage = 0;

despawnRange = 48; // don't die when going above the screen ;_;
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();

var ammo; ammo = global.ammo[playerID, global.weapon[playerID]];
if (ammo <= 0 && charging)
{
    instance_destroy();
    exit;
}

if (!global.frozen)
{
    if (charging)
    {
        if (instance_exists(parent)) // Set position to above the player's head
        {
            x = parent.x + parent.image_xscale;
            y = parent.y - (20 * sign(image_yscale));
            image_yscale = parent.image_yscale;
        }
        else
        {
            instance_destroy();
        }

        timer += 1; // initialization timer
        if (timer < 10) // pause for charge
        {
            canHit = false;
            canDamage = 0;
        }
        else
        {
            canHit = true;
            canDamage = 1;
            if (ammo >= 2)
            {
                image_speed = 1 / 7;
                if (ammo == 2 && floor(image_index) > 6)
                    image_index = 5;
                if (sprite_index == sprPharaohShotCharging) // After fully charging, change sprites
                {
                    if (floor(image_index) > 9)
                    {
                        sprite_index = sprPharaohShotCharged;
                        pierces = 1;
                        extraDamage = 4;
                        cost = 3;
                    }
                }
            }
        }

        if (instance_exists(parent))
        {
            var canShoot; canShoot = false;
            with (parent)
            {
                canShoot = !playerIsLocked(PL_LOCK_SHOOT);
            }

            if (!global.keyShoot[parent.playerID] && canShoot) // LET GO OF CHARGE AND SHOOT
            {
                canDamage = true;
                var xs; xs = 16;
                if (!parent.ground && (parent.isShoot < 3))
                {
                    xs -= 5;
                }
                x = parent.x + (xs) * parent.image_xscale;
                y = parent.y + 4 * parent.image_yscale;
                parent.shootTimer = 0;
                parent.isShoot = 2;

                charging = false;

                var cost;

                if (sprite_index == sprPharaohShotCharging)
                {
                    playSFX(sfxPharaohShot);
                    sprite_index = sprPharaohShot;
                    cost = 1;
                }
                else
                {
                    playSFX(sfxPharaohShotCharged);
                    image_speed = (1 / 7);
                    bulletLimitCost = 3;
                    pierces = 1;
                    cost = 3;
                }

                if (global.ammo[playerID, global.weapon[playerID]] > 0)
                {
                    global.ammo[playerID, global.weapon[playerID]] -= (cost / (global.energySaver + 1));
                }

                // Set speed regardless of charge level
                xspeed = parent.image_xscale * 4.5;
                yspeed = 4.5 * (-global.keyUp[parent.playerID] + global.keyDown[parent.playerID]) * sign(image_yscale);
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
if (charging)
{
    playSFX(sfxReflect);
    instance_destroy();
}
else
{
    event_inherited();
}
#define Other_18
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();

// depend ammo count on current state
var cost;

if (sprite_index == sprPharaohShotCharging)
{
    cost = 1;
}
else
{
    cost = 3;
}

if (charging)
{
    if (global.ammo[playerID, global.weapon[playerID]] > 0)
    {
        global.ammo[playerID, global.weapon[playerID]] -= (cost / (global.energySaver + 1));
    }
}

// Charged Pharaoh Shots only do two extra points of damage to bosses unless specified
// in their User Event 11 code
if (object_is_ancestor(other,prtBoss))
{
    if(sprite_index = sprPharaohShotCharged)
        extraDamage = 2;
}

global.damage += extraDamage;
#define Other_22
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
weaponSetup("PHARAOH SHOT", make_color_rgb(252, 116, 96), make_color_rgb(252, 188, 176), sprWeaponIconsPharaohShot);
#define Other_24
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if (global.keyShoot[playerID] && !playerIsLocked(PL_LOCK_SHOOT)
&& global.ammo[playerID, global.weapon[playerID]] > 0)
{
    fireWeapon(0, 0, objPharaohShot, 2, 0, 0, 0);
}
