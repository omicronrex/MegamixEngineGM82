#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
/// Even weaker than the regular Dachone, this time he's vulnerable all the time.
/// What a valuable limited edition, eh?
event_inherited();

healthpointsStart = 5;
healthpoints = healthpointsStart;
contactDamage = 3;

category = "bulky";

// Enemy specific code
dir = image_xscale;

moveDelay = 0;
ground = false;

// shooting variables
cooldownMax = 60;
cooldownTimer = cooldownMax / 2;

// AI and animation variables
moveDir = 0;
imageTimer = 0;
imageOffset = 0;
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();

if (entityCanStep())
{
    // setup
    if (moveDir == 0)
    {
        calibrateDirection();
        moveDir = image_xscale;
    }

    image_index = imageOffset;

    // turn around when we hit a wall
    if (xcoll != 0)
    {
        moveDir = -moveDir;
    }

    // turn aorund when we come up to a drop
    if (!(positionCollision(x + 16 * moveDir + xspeed, bbox_bottom + 2)))
    {
        moveDir = -moveDir;
    }
    else
    {
        delay = 0;
    }

    // set speed
    if (ground)
    {
        xspeed = 0.66 * moveDir;
    }
    else
    {
        xspeed = 0;
    }

    // play animation forwards or backwards depending on the direction dachone is moving and what direction the sprite is facing.
    if (xspeed != 0)
    {
        imageTimer += 1;
        if (imageTimer == 12)
        {
            var tgx; tgx = x + 12;
            if (instance_exists(target))
                tgx = target.x;
            imageTimer = 0;
            if (moveDir > 0 && tgx > x || moveDir < 0 && tgx < x)
            {
                imageOffset += 1;
            }

            if (moveDir > 0 && tgx < x || moveDir < 0 && tgx > x)
            {
                imageOffset -= 1;
            }
        }

        if (imageOffset >= 4)
        {
            imageOffset = 0;
        }

        if (imageOffset < 0)
        {
            imageOffset = 3;
        }
    }

    // shooting
    if (instance_exists(target))
    {
        // dachone stops shooting if mega man is behind it.
        if (image_xscale > 0 && target.x > x || image_xscale < 0 && target.x < x)
        {
            cooldownTimer += 1;
        }
    }

    if (cooldownTimer >= 60)
    {
        instance_create(x + 16 * image_xscale, y - 4, objCannonjoeBullet);
        cooldownTimer = 0;
        playSFX(sfxEnemyShoot);
    }
}
#define Other_20
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();
instance_create(bboxGetXCenter(),bboxGetYCenter(),objBigExplosion);
playSFX(sfxExplosion2);
#define Other_25
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
/// On spawn
event_inherited();
if (spawned)
{
    image_index = 0;
    moveDir = 0;
    cooldownTimer = cooldownMax / 2;
    xspeed = 0;
    yspeed = 0;
    imageOffset = 0;
}
