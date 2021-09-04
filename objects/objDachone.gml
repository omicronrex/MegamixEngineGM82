#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
/// A very weak midboss, he shoots lasers from his eye and walks towards megaman. he's only vulnerable in the eye.

event_inherited();

healthpointsStart = 5;
healthpoints = healthpointsStart;
contactDamage = 8;
lockTransition = false;


category = "bulky";

dir = image_xscale;

//@cc 0 = blue (default); 1 = green;
col = 0;

init = 1;

// Enemy specific code
moveDelay = 0;

// shooting variables
cooldownMax = 112;
cooldownTimer = cooldownMax / 2;

// AI and animation variables
imageTimer = 0;
imageOffset = 0;
delay = 0;
radius = 128;

calibrateDirection();
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if (init)
{
    init = 0;
    switch (col)
    {
        case 0:
            sprite_index = sprDachoneB;
            break;
        case 1:
            sprite_index = sprDachoneG;
            break;
    }
}

event_inherited();

if (entityCanStep())
{
    // turn around on hitting a wall
    xSpeedTurnaround();

    // activate dachone
    calibrateDirection();
    if (instance_exists(target))
    {
        if (xspeed == 0 && ground && (global.keyShootPressed[target.playerID] || abs(target.x - x) < radius))
        {
            xspeed = image_xscale * 0.5;
        }
    }

    // if boss reaches a platform edge, turn around.
    if (ground)
    {
        if (xspeed > 0)
        {
            xs = bbox_right + 1;
        }
        else
        {
            xs = bbox_left - 1;
        }

        if (!positionCollision(xs, bbox_bottom + 1))
        {
            xspeed *= -1;
        }
    }

    // if boss reaches a screen edge do same.
    if (x >= view_xview + view_wview - 10 && xspeed > 0)
    {
        xspeed = -abs(xspeed);
    }
    else if (x <= view_xview + 10 && xspeed < 0)
    {
        xspeed = abs(xspeed);
    }

    // change image offset depending on the direction dachone is moving and what direction the sprite is facing.
    if (xspeed != 0)
    {
        imageTimer += 1;
        if (imageTimer == 12)
        {
            imageOffset += 1 * image_xscale;
        }
        if (imageTimer == 24)
        {
            playSFX(sfxDachoneWalk);
            imageTimer = 0;
            imageOffset += 1 * image_xscale;
        }

        if (imageOffset >= 4)
        {
            imageOffset = 1;
        }
    }

    // shooting
    cooldownTimer += 1;

    var scaleX;
    scaleX = image_xscale;

    // switch (cooldownTimer)
    //{
    if (cooldownTimer == cooldownMax)
    {
        i = instance_create(x + (image_xscale * 8), y - 4, objDachoneBullet);
        with (i)
        {
            image_xscale = scaleX;
            image_index = 0;
            xspeed = 3 * other.image_xscale;
            yspeed = 0;
            playSFX(sfxDachoneLaser);
        }
    }
    else if (cooldownTimer == cooldownMax + 20)
    {
        i = instance_create(x + (image_xscale * 8), y - 4, objDachoneBullet);
        with (i)
        {
            image_xscale = scaleX;
            image_index = 1;
            xspeed = 2 * other.image_xscale;
            yspeed = 1;
            playSFX(sfxDachoneLaser);
        }
    }
    else if (cooldownTimer == cooldownMax + 40)
    {
        i = instance_create(x + (image_xscale * 8), y - 4, objDachoneBullet);
        with (i)
        {
            image_xscale = scaleX;
            image_index = 2;
            xspeed = 1.5 * other.image_xscale;
            yspeed = 1.5;
            playSFX(sfxDachoneLaser);
        }
    }
    else if (cooldownTimer == cooldownMax + 60)
    {
        i = instance_create(x + (image_xscale * 8), y - 4, objDachoneBullet);
        with (i)
        {
            image_xscale = scaleX;
            image_index = 3;
            xspeed = 1 * other.image_xscale;
            yspeed = 2;
            playSFX(sfxDachoneLaser);
            cooldownTimer = 0;
        }
    }
    else if (cooldownTimer == cooldownMax + 61)
    {
        cooldownTimer = 0;
    }

    //}
}
else if (dead)
{
    deadTimer = 0;
    image_index = 0;
    cooldownTimer = 0;
    xspeed = 0;
    yspeed = 0;
    imageOffset = 0;
}

image_index = imageOffset;
#define Other_21
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if (!(bboxGetYCenterObject(other.id) < y - 6))
{
    other.guardCancel = 1;
}
