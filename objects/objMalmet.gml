#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
// An enemy that slowly flies towards Mega Man, occasionally firing shots.
event_inherited();

healthpointsStart = 4;
contactDamage = 2;
blockCollision = 0;

grav = 0;
facePlayer = true;
category = "flying";

// Enemy specific variables
imgIndex = 0;
imgSpd = 0.5;
shootTimer = 120;

// @cc - Determines the time it takes for Malmet to fire a shot
shootDelay = 120;

animBack = false;
targX = -1;
targY = -1;
accel = 0.01;
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();

if (entityCanStep())
{
    // Set target
    targX = -1;
    if (instance_exists(target))
    {
        targX = bboxGetXCenterObject(target);
        targY = bboxGetYCenterObject(target);
    }

    if (targX != -1)
    {
        correctDirection(point_direction(bboxGetXCenter(), bboxGetYCenter(), targX, targY), 1);

        if (speed == 0)
        {
            speed = 1;
        }
    }

    // Shoot
    shootTimer--;
    if (shootTimer <= 0)
    {
        var i = instance_create(x, y, objEnemyBullet);
        i.contactDamage = 2;
        with (i)
        {
            aimAtTarget(2);
        }
        playSFX(sfxEnemyShootClassic);

        shootTimer = shootDelay;
    }

    // Animation
    if (animBack == false)
    {
        imgIndex += imgSpd;
        if (imgIndex >= 3)
        {
            imgIndex = 2;
            animBack = true;
        }
    }
    else
    {
        imgIndex -= imgSpd;
        if (imgIndex < 0)
        {
            imgIndex = 1;
            animBack = false;
        }
    }
}
else if (dead)
{
    healthpoints = healthpointsStart;
    imgIndex = 0;
    animBack = false;
    shootTimer = shootDelay;
    targX = -1;
    targY = -1;
}

image_index = imgIndex div 1;
#define Other_25
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();

if (spawned)
{
    if (instance_exists(target))
    {
        direction = 225;
        if (image_xscale == 1)
        {
            direction += 60;
        }

        targX = bboxGetXCenterObject(target);
        targY = bboxGetYCenterObject(target);
    }
}
