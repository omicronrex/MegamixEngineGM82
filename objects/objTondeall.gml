#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
// creation code
// moveDist = <number>;   - The distance the enemy moves before turning back on itself. Default is 32.;
// moveDir = <number>; - The direction the enemy moves. (0 = Horzitonal, 1 = Vertical, 2 = Diagonal Right, 3 = Diagonal Left;

event_inherited();

healthpointsStart = 1;
healthpoints = healthpointsStart;
contactDamage = 4;

category = "floating";

blockCollision = 0;
grav = 0;

// Enemy specific code
moveDelay = 0;
moveTimer = 0;

// shooting variables
shootAngle = 30;
cooldownTimer = 0;
cooldownMax = 152;
direct = -1;

moveDist = 32;
moveDir = 0;
shootAngle = 35;
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();

if (entityCanStep())
{
    image_index += 0.20;

    moveDelay += 1;
    if (moveDelay == 0)
    {
        xspeed = 0;
        yspeed = 0;
    }

    if (moveDir == 0 && moveDelay == 1)
    {
        xspeed = 1 * direct;
        moveDelay = -1;
    }
    else if (moveDir == 1 && moveDelay == 1)
    {
        yspeed = 1 * direct;
        moveDelay = -1;
    }
    else if (moveDir == 2 && moveDelay == 1)
    {
        xspeed = 1 * direct;
        yspeed = 1 * direct;
        moveDelay = -1;
    }
    else if (moveDir == 3 && moveDelay == 1)
    {
        xspeed = -1 * direct;
        yspeed = 1 * direct;
        moveDelay = -1;
    }

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
            getAngle = point_direction(x, y, x + (45 * (direct)),
                45 * (direct));

        var ID;
        ID = instance_create(x + image_xscale * 8, spriteGetYCenter(),
            objMM5AimedBullet);
        {
            ID.dir = getAngle + shootAngle;
            ID.xscale = image_xscale;
        }
        ID = instance_create(x + image_xscale * 8, spriteGetYCenter(),
            objMM5AimedBullet);
        {
            ID.dir = getAngle - shootAngle;
            ID.xscale = image_xscale;
        }
        playSFX(sfxEnemyShootClassic);
    }

    moveTimer += 0.5;
    if (moveTimer >= moveDist)
    {
        direct = 0 - direct;
        moveTimer = 0;
    }
}
else
{
    if (dead == true)
    {
        direct = 1;
        cooldownTimer = 0;
        canShoot = true;
        image_index = 0;
    }
}
