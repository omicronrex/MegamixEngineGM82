#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();

/// Create Event
healthpointsStart = 6;
healthpoints = healthpointsStart;
contactDamage = 4;
facePlayerOnSpawn = true;
category = "nature";
facePlayer = true;

// Enemy Specific code
attackTimer = 0;
attackTime = 60;
animSpeed = 0.2;
animFrame = 0;
canShoot = false;
prevYspeed = 0;
bullets[0] = noone;
bullets[1] = noone;
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();

/// Enemy AI

if (entityCanStep())
{
    var prevCanShoot; prevCanShoot = canShoot;
    if (instance_exists(target))
    {
        if (abs(x - target.bbox_left + (abs(target.bbox_left - target.bbox_right) / 2)) < 16 * 4)
        {
            canShoot = true;
        }
        else
            canShoot = false;
        if (instance_exists(bullets[0]) || instance_exists(bullets[1]))
            canShoot = false;
    }
    else
        canShoot = false;

    if (sign(prevYspeed) == -1 && yspeed >= 0 && floor(animFrame != 0))
    {
        event_user(0);
        animFrame = 3;
    }

    if (ground && yspeed == 0 && floor(animFrame) != 1)
        animFrame = 0;
    else if (ground && yspeed == 0 && floor(animFrame >= 3))
        attackTimer = 0;

    if (!ground)
        canShoot = false;
    if (!prevCanShoot && canShoot && animFrame == 0)
        attackTimer = attackTime + 1;

    if (attackTimer > attackTime)
    {
        if (ground && animFrame == 0)
        {
            animFrame = 1;
        }
        else if (ground && floor(animFrame == 2))
        {
            yspeed = -5;
            attackTimer = 0;
        }
    }

    if (ycoll != 0 && ground)
        playSFX(sfxHeavyLand);

    if (floor(animFrame) == 1 || floor(animFrame) >= 3)
    {
        animFrame += animSpeed;
        if (floor(animFrame) > 5)
            animFrame = 5;
    }
    image_index = animFrame;
    prevYspeed = yspeed;
}
#define Other_10
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
/// Shoot
var count; count = 0;
var i; for ( i = -1; i < 2; i += 2)
{
    var bullet; bullet = instance_create(x, y, objEnemyBullet);
    bullet.sprite_index = sprBombomboyBullet;
    bullet.x = x;
    bullet.y = bbox_top + 2;
    bullet.yspeed = -3;
    bullet.xspeed = i * 1.3;
    bullet.image_xscale = i;
    bullet.contactDamage = 4;
    bullet.blockCollision = false;
    bullet.grav = 0.25;
    bullets[count] = bullet;

    count += 1;
}
playSFX(sfxCannonShoot);
#define Other_23
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
specialDamageValue(objMagneticShockwave, 3);
#define Other_25
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
/// spawn Event
animFrame = 0;
attackTimer = 0;
