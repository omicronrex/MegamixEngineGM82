#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
/// Create Event
event_inherited();
contactDamage = 5;
healthpointsStart = 10;
healthpoints = 10;
facePlayerOnSpawn = false;
category = "grounded, bulky, shielded";

// @cc - Change colour: 0 (default) = red, 1 = green
col = 0;

// Enemy specific code
// Constants
speed1 = 0.75;
speed2 = 0.45;
maxDist = 16 * 3;

// Variables
phase = 0;
timer = 60;
shielded = true;
detectsShot = false;
mask_index = sprKakinbatank;
animFrame = 0;
prevX = x;
xscaleStart = image_xscale;
init = 1;
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();

//Change colours
if (init)
{
    switch(col)
    {
        case 1:
            sprite_index = sprKakinbatankGreen;
            break;
        default:
            sprite_index = sprKakinbatank;
            break;
    }
    init = 0;
}

if (entityCanStep())
{
    if (shielded)
    {
        switch (phase)
        {
            case 0: // Sleep
                if (timer < 60)
                {
                    timer += 1;
                    xspeed = 0;
                }
                else
                {
                    if (detectsShot)
                    {
                        detectsShot = false;
                        prevX = x;
                        phase = 1;
                        timer = 0;
                    }
                    else
                    {
                        animFrame += 0.015;
                        if (floor(animFrame) > 1)
                            animFrame = 0;
                    }
                }
                break;
            case 1: // Move forward
                if (timer == 0)
                {
                    animFrame = 2;
                    xspeed = 0;
                }
                if (timer > 45)
                {
                    xspeed = speed1 * image_xscale;
                    if ((instance_exists(target) && target.bbox_left < bbox_right + 16 && target.bbox_right > bbox_left - 16) || (instance_exists(target) && sign(x - target.x) == image_xscale))
                    {
                        phase = 3;
                        timer = 0;
                    }
                    var onLimit = sign(x - (prevX + maxDist * image_xscale)) == image_xscale;
                    if (checkFall(32*sign(image_xscale)) || onLimit)
                    {
                        if (onLimit)
                        {
                            x = prevX + maxDist * image_xscale;
                        }
                        xspeed = 0;
                        if (phase == 1)
                            phase = 2;
                        timer = 0;
                    }
                    animFrame += 0.2;
                    if (floor(animFrame) > 3)
                        animFrame = 2;
                }
                else
                    timer += 1;
                break;
            case 2: // Retreat
                if (timer > 60)
                {
                    xspeed = -speed2 * image_xscale;
                    animFrame += 0.1;
                    if (floor(animFrame) > 3)
                        animFrame = 2;
                    if (sign(x - xstart) != image_xscale || xcoll != 0)
                    {
                        x = xstart;
                        phase = 0;
                        timer = 0;
                        xspeed = 0;
                    }
                    if (detectsShot)
                    {
                        detectsShot = false;
                        prevX = x;
                        phase = 1;
                        timer = 0;
                    }
                }
                else
                    timer += 1;
                break;
            case 3: // Drop shield
                if (timer == 0)
                    animFrame = 4;
                xspeed = 0;
                if (timer < 30)
                {
                    timer += 1;

                    // Vibreate;
                    animFrame += 0.2;
                    if (floor(animFrame) > 5)
                        animFrame = 4;
                }
                else
                {
                    animFrame += 0.3;
                    if (floor(animFrame) > 10)
                    {
                        animFrame = 12;
                        shielded = false;
                        phase = 0;
                        timer = 0;
                        mask_index = mskKakinbatank;
                    }


                    if (animFrame > 7)
                    {
                        if (instance_exists(objMegaman))
                        {
                            var collided = collision_rectangle(x, y, x + 48 * image_xscale, y - 30, objMegaman, false, true);
                            if (collided != noone)
                            {
                                with (collided)
                                {
                                    if (canHit && iFrames == 0)
                                    {
                                        with (other)
                                            entityEntityCollision();
                                    }
                                }
                            }
                        }
                    }
                }
                break;
        }
    }
    else
    {
        switch (phase)
        {
            case 0:
                if (instance_exists(target) && sign(x - target.x) == image_xscale)
                {
                    phase = 1;
                    timer = 0;
                }
                else
                {
                    timer += 1;
                    if (timer < 30)
                        animFrame = 12;
                    else
                    {
                        if (timer == 30)
                        {
                            animFrame = 13;
                            var i = instance_create(x, y, objEnemyBullet);
                            i.contactDamage = 3;
                            i.sprite_index = sprKakinbatankBullet;
                            i.image_speed = 0;
                            if (col == 1)
                            {
                                i.image_index = 1; // Green bullets
                            }
                            else
                            {
                                i.image_index = 0; // Red bullets
                            }
                            i.x = x + 4 * image_xscale;
                            i.y = y - 36;
                            i.target = target;
                            i.yspeed = -4;
                            i.blockCollision = false;
                            i.grav = 0.35;
                            if (instance_exists(target))
                            {
                                with (i)
                                {
                                    xspeed = xSpeedAim(x, y, target.x, target.y, yspeed, grav, 4);
                                }
                            }
                        }

                        if (timer > 47)
                            animFrame = 12;
                        if (timer > 60)
                            timer = 0;
                    }
                }
                break;
            case 1:
                if (timer == 0)
                {
                    timer = 1;
                    animFrame = 11;
                }
                else
                {
                    animFrame += 0.1;
                    if (floor(animFrame) > 11)
                    {
                        phase = 0;
                        image_xscale *= -1;
                        timer = 0;
                    }
                }
                break;
        }
    }
    if (detectsShot)
        detectsShot = false;
    image_index = floor(animFrame);
}
#define Other_20
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
/// Death Event
event_inherited();
instance_create(bbox_left + abs(bbox_left - bbox_right) / 2, bbox_top + abs(bbox_top - bbox_bottom) / 2, objBigExplosion);
playSFX(sfxMM9Explosion);
#define Other_21
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
/// Reflect shots
detectsShot = true;
if (mask_index == mskKakinbatank || (sign(x - other.x) == image_xscale))
    exit;

if (collision_rectangle(x + 12 * image_xscale, y, x + 28 * image_xscale, y - 47, other, false, true))
{
    other.guardCancel = 1;
}
#define Other_25
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
/// spawn Event
event_inherited();
mask_index = sprKakinbatank;
phase = 0;
timer = 60;
attackTimer = 0;
shielded = true;
detectsShot = false;
animFrame = 0;
y -= 1;
image_xscale = xscaleStart;
