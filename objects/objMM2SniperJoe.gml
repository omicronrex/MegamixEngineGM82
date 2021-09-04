#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();

/// Is a Sniper Joe that always shoots three bullets and cannot jump.

healthpointsStart = 10;
healthpoints = healthpointsStart;
contactDamage = 4;

category = "joes";

facePlayer = true;

// Enemy specific code
shootTimer = 0;
shooting = false;
shootAmount = 0;

respawnRange = -16;
despawnRange = 16;
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();

if (entityCanStep())
{
    // Shooting
    if (!shooting)
    {
        image_index = 0;
        shootTimer += 1;
        if (shootTimer >= 90)
        {
            shooting = true;
            shootTimer = 0;
        }
    }
    else
    {
        image_index = 1;
        shootTimer += 1;
        if (shootTimer >= 32)
        {
            if (shootAmount < 3)
            {
                shootTimer = 0;
                i = instance_create(x + 6 * image_xscale, y - 9,
                    objEnemyBullet);
                i.xspeed = image_xscale * 2;
                playSFX(sfxEnemyShootClassic);
                shootAmount += 1;
            }
            if (shootAmount >= 3)
            {
                shootTimer = 0;
                shootAmount = 0;
                shooting = false;
            }
        }
    }
}
else if (dead)
{
    shootTimer = 0;
    shooting = true;
    shootAmount = 0;
    image_index = 1;
    yspeed = -3;
}
#define Other_21
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if (image_index == 0)
{
    if (collision_rectangle(x + 10 * image_xscale, y - 3,
        x + 12 * image_xscale, y - 20, other.id, false, false))
    {
        other.guardCancel = 1;
    }
}
