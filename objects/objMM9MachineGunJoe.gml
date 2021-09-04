#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();

healthpointsStart = 6;
healthpoints = healthpointsStart;
contactDamage = 3;

category = "joes";

// Enemy specific code
shootTimer = 0;
shooting = false;
shootAmount = 0;

myDir = -1;
calibrateDirection();
radius = 1.5 * 16; // 1.5 tiles; the radius that MM needs to enter to trigger the jumping of the Joe
resetDir = 0;
waitCount = 0;
shootCount = 0;
jumpCount = 0;
yspeedJump = -6; // change this to alter the yspeed when the Joe jumps
shootCountMax = 2;
jumpCountMax = 3;
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();

if (entityCanStep())
{
    if (resetDir)
    {
        calibrateDirection(); // face player when it spawns
        myDir = image_xscale;
        resetDir = 1;
    }

    // if it's on the ground, check if the player is nearby it
    // if nearby, jump
    if (ground)
    {
        if (!shooting)
        {
            calibrateDirection();
        }
        if (shootCount >= shootCountMax)
        {
            waitCount += 1
            if waitCount >=60
            {
                yspeed = yspeedJump;
                ground = false;
                jumpCount++;
                waitCount = 0;
                if (!instance_exists(target))
                {
                    shootCount = 0;
                    jumpCount = 0;
                }
                else if (instance_exists(target))
                {
                    if (point_distance(x, 0, target.x, 0) > radius || jumpCount >= jumpCountMax)
                    {
                        shootCount = 0;
                        jumpCount = 0; // Stops Jumping if you are too far away or the Joe has reached the maximum amount of consecutive jumps
                    }
                }
            }
        }
    }

    // Shooting
    if (!shooting)
    {
        // reset animation if it's returning from shooting
        if (image_index > 0 && shootTimer mod 10 == 0)
        {
            image_index -= 1;
        }
        shootTimer += 1; // increment shooting timer
        if (shootTimer >= 90)
        {
            shooting = true;
            shootTimer = 0;
        }
    }
    else
    {
        if (image_index < 2) // if it's getting ready to shoot, play animation
        {
            image_index += 0.1;
        }
        else
        {
            if waitCount < 3
            {
                waitCount += 1
            }
            else
            {
                shootTimer += 1;
                if (shootTimer >= 6)
                {
                    if (shootAmount < 7)
                    {
                        shootTimer = 0;
                        var shootID, box;

                        // set spawn point for bullet based on xscale
                        if (image_xscale == 1)
                        {
                            box = bbox_right;
                        }
                        else
                        {
                            box = bbox_left;
                        }
                        shootID = instance_create(box, y - 8, objEnemyBullet);
                        shootID.xspeed = image_xscale * 4;
                        shootID.image_xscale = image_xscale;
                        shootID.sprite_index = sprMM9MachineGunJoeBullet;
                        shootAmount++;
                    }
                    if (shootAmount >= 7)
                    {
                        shootTimer = 0;
                        shootAmount = 0;
                        shooting = false;
                        shootCount++;
                        waitCount = 0;
                    }
                }
            }
        }
    }

    // if it's on the ground, set jump sprite
    // if it isn't, set regular sprite, and make sure it's not sliding on the ground
    if (!ground)
    {
        shootTimer = 0;
        shooting = false;
        sprite_index = sprMM9MachineGunJoeJump;
    }
    if (ground)
    {
        sprite_index = sprMM9MachineGunJoe;
    }
}
else if (dead)
{
    shootTimer = 0;
    shooting = false;
    shootAmount = 0;
    image_index = 0;
    resetDir = 0;
    shootCount = 0;
    jumpCount = 0;
}
#define Other_21
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
// if image_index is shield up, and you're not shooting sniper joe in the back or whatever, reflect bullets
if (sprite_index != sprMM9MachineGunJoeJump && image_index == 0)
{
    if (collision_rectangle(x + 12 * image_xscale, y - 3,
        x + 14 * image_xscale, y - 20, other.id, false, false))
    {
        other.guardCancel = 1;
    }
}
#define Other_23
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
specialDamageValue(objFlameMixer, 666);
