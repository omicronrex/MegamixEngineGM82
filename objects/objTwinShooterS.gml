#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
// creation code
// moveDist = <number>;   - The distance the enemy moves before turning back on itself. Default is 76.;
// cooldownMax = <number>; - How long between firing.
// image_yscale = 1 or -1 //(Use editor for this!!) // if -1, Twin Shooter will go up instead of down at beginning.
event_inherited();
respawn = true;
healthpointsStart = 5;
healthpoints = healthpointsStart;
contactDamage = 3;
category = "floating, cannons";
blockCollision = 1;
grav = 0;
dieToSpikes = 0;
facePlayer = true;

// Enemy specific code
moveDelay = 0;
moveTimer = 0;

// shooting variables
cooldownTimer = 0;
cooldownMax = 152;
direct = -1;
storeYScale = 0;
moveDist = 76;
moveDir = 0;
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();
if (entityCanStep())
{
    if (storeYScale == 0)
        storeYScale = image_yscale;
    image_index += 0.20;
    if ((moveTimer >= moveDist) || (yspeed == 0))
    {
        image_yscale *= -1;
        moveTimer = 0;
    }
    yspeed = 0.5 * image_yscale;
    cooldownTimer += 1;
    if (cooldownTimer >= cooldownMax)
    {
        // Shoot
        cooldownTimer = 0;
        var ID;
        ID = instance_create(x + image_xscale * 3, y - 12,
            objEnemyBullet);
        {
            ID.xspeed = 2 * image_xscale;
            ID.xscale = image_xscale;
            ID.sprite_index = sprTwinShooterSmLaser;
        }
        ID = instance_create(x + image_xscale * 3, y + 12,
            objEnemyBullet);
        {
            ID.xspeed = 2 * image_xscale;
            ID.xscale = image_xscale;
            ID.sprite_index = sprTwinShooterSmLaser;
        }
        playSFX(sfxEnemyShootClassic);
    }
    moveTimer += 0.5;
}
else
{
    if (dead == true)
    {
        if (storeYScale != 0)
            image_yscale = storeYScale;
        moveTimer = 0;
        cooldownTimer = 0;
        image_index = 0;
    }
}
