#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
// creation code
// moveDist = <number>;   - The distance the enemy moves before turning back on itself. Default is 168.;
// cooldownMax = <number>; - How quickly the enemy shoots. The default is 120;
// spd = <number>; - How quickly the enemy moves. Should be a number that divides evenly into moveDist or else this won't work.

event_inherited();

respawn = true;

healthpointsStart = 1;
healthpoints = healthpointsStart;
contactDamage = 2;
category = "flying, nature";

blockCollision = 0;
grav = 0;

facePlayerOnSpawn = true;

// Enemy specific code
moveDelay = 0;
moveTimer = 0;

// shooting variables
cooldownMax = 120;
cooldownTimer = round(cooldownMax / 2);
spd = 1;

moveDist = 168;
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();

if (entityCanStep())
{
    // animat tomsmort
    image_index += 0.20;

    // move tomsmort
    xspeed = spd * image_xscale;

    // constantly add to cooldown timer, when this reaches his determined maximum, tomsmort fires
    cooldownTimer += 1;
    if (cooldownTimer >= cooldownMax)
    {
        // Shoot
        cooldownTimer = 0;
        var getAngle;

        // If megaman exists, grab his angle, otherwise grab some random different angle.
        if (instance_exists(target))
            getAngle = point_direction(x, y, target.x, target.y);
        else
            getAngle = point_direction(x, y, x + (45 * (image_xscale)),
                45 * (image_xscale));

        // create bullet
        var ID;
        ID = instance_create(x + image_xscale * 8, spriteGetYCenter(),
            objCFTFAimedBullet);
        {
            ID.dir = getAngle;
            ID.xscale = image_xscale;
        }
        playSFX(sfxEnemyShootClassic);
    }

    // constantly increase movetimer by how far tomsmsort has moved. once it has reached its predetermined distance, turn tomsmort around.
    moveTimer += spd;
    if (moveTimer >= moveDist)
    {
        image_xscale = 0 - image_xscale;
        moveTimer = 0;
    }
}
else
{
    if (dead == true)
    {
        moveTimer = 0;
        cooldownTimer = 0;
        canShoot = true;
        image_index = 0;
    }
}
