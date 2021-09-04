#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
// Please don't.

event_inherited();

healthpointsStart = 10;
healthpoints = healthpointsStart;
contactDamage = 4;

category = "joes";

facePlayerOnSpawn = true;

// Enemy specific code
shootTimer = 0;
shooting = false;
shootAmount = 0;
shootTotal = 0;
jumpCount = 0;

myDir = -1;
xs = 0;
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();

if (entityCanStep())
{
    // if it's on the ground, check if the player is behind it, by comparing what myDir is
    //( set on spawn), and the image_xscale attempting to be set relative to the player.
    // if they're not equal, jump and try to catch up with the player.

    if (ground)
    {
        var rn = irandom(1);
        calibrateDirection();
        if (image_xscale != myDir)
        {
            yspeed = -6;
            xspeed = image_xscale * 2;
            xs = xspeed;
            ground = false;
        }
        else if (!shooting && shootTimer >= 89 && jumpCount >= 2)
        {
            jumpCount = 0;
            shooting = true;
            shootTimer = 0;
            shootTotal = irandom(3) + 1;
        }
        else if (!shooting && shootTimer >= 89 && rn == 1)
        {
            yspeed = -6;
            xspeed = 0;
            xs = xspeed;
            shootTimer = 0;
            ground = false;
            jumpCount += 1;
        }
    }


    // Shooting
    if (!shooting)
    {
        // reset animation if it's returning from shooting
        if (image_index > 0 && !(shootTimer mod 10))
        {
            image_index -= 1;
        }
        shootTimer += 1; // increment shooting timer
        if (shootTimer >= 90)
        {
            shooting = true;
            shootTimer = 0;
            shootTotal = irandom(3) + 1;
            jumpCount = 0;
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
            shootTimer += 1;
            if (shootTimer >= 30)
            {
                if (shootAmount < shootTotal)
                {
                    shootTimer = 0;
                    var i = instance_create(x + (12 * image_xscale), y - 8, objEnemyBullet);
                    i.xspeed = image_xscale * 4;
                    i.sprite_index = sprCrazyRazyBullet;
                    playSFX(sfxEnemyShootClassic); // shoooot
                    shootAmount += 1;
                }
                if (shootAmount >= shootTotal)
                {
                    shootTimer = 0;
                    shootAmount = 0;
                    shooting = false;
                }
            }
        }
    }

    if (ground)
    {
        sprite_index = sprMM1SniperJoe;
        xspeed = 0;
        xs = 0;
    }
    else
    {
        shootTimer = 0;
        shooting = false;
        sprite_index = sprMM1SniperJoeJump;
        xspeed = xs;
    }
}
#define Other_21
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
// if image_index is shield up, and you're not shooting sniper joe in the back or whatever, reflect bullets
if (sprite_index != sprMM1SniperJoeJump && image_index == 0)
{
    if (collision_rectangle(x + 12 * image_xscale, y - 3, x + 14 * image_xscale, y - 20, other.id, false, false))
    {
        other.guardCancel = 1;
        if (!shooting)
            shootTimer = 0;
    }
}
#define Other_25
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
/// On spawn
event_inherited();
myDir = image_xscale;
shootTimer = 0;
shooting = false;
shootAmount = 0;
image_index = 0;
jumpCount = 0;
