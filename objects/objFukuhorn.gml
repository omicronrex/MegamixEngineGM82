#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
// When Mega Man is far away, it aims its gun at him and fires based on where he is.
// When it gets close, it charges at him before stopping and repeating.
// For Metall Sniper, set col to 1 in creation code.

event_inherited();

healthpointsStart = 1;
healthpoints = healthpointsStart;
contactDamage = 4;

category = "mets, cannons";

radius = 4 * 16; // Gives four blocks of space for Mega Man to trigger charging

facePlayerOnSpawn = true;

// Enemy specific code
phase = 1;
canShoot = true;
animTimer = 8;
angle = 0; // 0 = Facing ahead.

col = 0; // 0 = Fukuhorn; 1 = Metall Sniper;
shootTimer = 120; // Cooldown time between shots
chargeDelay = 20; // wait before charging
moveTimer = 40; // How long can I move for?
hideTimer = 20; // Stay hidden for minimum amount of time
moves = 0; // Number of times I've moved
imgSpd = 0.16;
animBack = false;

init = 1;
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();

if (init)
{
    init = 0;
    image_index = 1;

    switch (col) // Switch sprites between Metall Sniper and Fukuhorn in creation code
    {
        case 1:
            sprite_index = sprMetSniper;
            break;
        default:
            sprite_index = sprFukuhorn;
            break;
    }
}

if (entityCanStep())
{
    switch (phase)
    {
        case 1: // Guarding/Aiming
            if (instance_exists(target)) // Check to see if player exists
            {
                // Target player and fire
                shootTimer -= 1; // Decrease time until shoot.
                hideTimer -= 1;

                // Get target
                megaDir = point_direction(x, y, target.x, target.y + 5);

                // Set angle
                if (image_index < 4)
                {
                    if (image_xscale == 1)
                    {
                        if ((megaDir >= 0) && (megaDir < 22))
                        {
                            angle = 0;
                            image_index = 1;
                        }
                        else if ((megaDir >= 22) && (megaDir < 45))
                        {
                            angle = 22;
                            image_index = 2;
                        }
                        else if ((megaDir >= 45) && (megaDir < 90))
                        {
                            angle = 45;
                            image_index = 3;
                        }
                        else if (megaDir > 270)
                        {
                            angle = 338;
                            image_index = 0;
                        }
                    }
                    else if (image_xscale == -1)
                    {
                        if ((megaDir <= 180) && (megaDir > 158))
                        {
                            angle = 180;
                            image_index = 1;
                        }
                        else if ((megaDir <= 158) && (megaDir > 135))
                        {
                            angle = 158;
                            image_index = 2;
                        }
                        else if ((megaDir <= 135) && (megaDir > 90))
                        {
                            angle = 135;
                            image_index = 3;
                        }
                        else if (megaDir > 180)
                        {
                            angle = 203;
                            image_index = 0;
                        }
                    }
                    angle = wrapAngle(angle);
                }

                // Fire
                if (shootTimer == 0)
                {
                    var i = instance_create(x + 8 * image_xscale, y - 5, objMM2MetBullet);
                    i.dir = angle;
                    i.image_xscale = image_xscale;
                    playSFX(sfxEnemyShootClassic);
                    shootTimer = 120;
                }

                // Check if player is close
                if ((distance_to_object(target) <= radius) && (hideTimer <= 0))
                {
                    // pop out - only start animations if canShoot == false
                    if (canShoot == true)
                    {
                        canShoot = false;
                        image_index = 4;
                        phase = 2;
                    }
                }
            }
            break;
        case 2: // Up/Charging
            if (moves < 2)
            {
                if (chargeDelay != 0)
                {
                    animTimer--;
                    if (animTimer == 0)
                    {
                        image_index = 6;
                        animTimer = 8;
                    }

                    if (image_index == 6)
                    {
                        chargeDelay -= 1;
                    }
                }
                else
                {
                    xspeed = 2 * image_xscale;
                    moveTimer -= 1;
                    if (moveTimer == 0)
                    {
                        chargeDelay = 20;
                        xspeed = 0;
                        moveTimer = 40;
                        if (instance_exists(target))
                        {
                            if (target.x >= x)
                            {
                                image_xscale = 1;
                            }
                            else if (target.x < x)
                            {
                                image_xscale = -1;
                            }
                        }
                        moves++;
                    }

                    // Animation
                    if (!animBack)
                    {
                        image_index += imgSpd;
                        if (image_index >= 8)
                        {
                            image_index = 6;
                            animBack = true;
                        }
                    }
                    else
                    {
                        image_index -= imgSpd;
                        if (image_index <= 5)
                        {
                            image_index = 6;
                            animBack = false;
                        }
                    }
                }
            }
            else // Go back under cannon after moving twice
            {
                animTimer--;
                if ((animTimer == 0) && (image_index > 4))
                {
                    image_index = 4;
                    animTimer = 8;
                }
                if ((animTimer == 0) && (image_index == 4))
                {
                    image_index = 1;
                    canShoot = true;
                    shootTimer = 120;
                    hideTimer = 20;
                    moves = 0;
                    phase = 1;
                    animTimer = 8;
                }
            }
            break;
    }
}
else if (dead)
{
    phase = 1;
    shootTimer = 120;
    moves = 0;
    canShoot = true;
    chargeDelay = 20;
    moveTimer = 40;
    image_index = 1;
    animBack = false;
    animTimer = 8;
    xspeed = 0;
    angle = 0;
}
#define Other_21
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
/// Reflect shots with cannon
if (image_index < 4)
{
    other.guardCancel = 1;
}
