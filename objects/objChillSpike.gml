#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();

blockCollision = 0;
grav = 0;

stopOnFlash = false;
contactDamage = 2;
reflectable = 0;

imageTimer = 0;
imageReset = 0;
imageMax = 2;

hasGravity = true;

ground = false;
toWall = false;
flag = false;

spreadAttack = false;
gravStr = 0.25;
image_speed = 0;

// if yspeed == -5
// yspeed = ySpeedAim(y, objChillSpikeDetector.y, gravAccel);
image_index = imageReset;
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();
if (!global.frozen)
{
    if (!toWall && !flag && !spreadAttack)
    {
        yspeed = -3;
        xspeed = xSpeedAim(x, y, objChillSpikeDetector.x, objChillSpikeDetector.y, yspeed, gravStr);
        flag = true;
    }
    else if (!flag && spreadAttack)
    {
        var angle;
        angle = direction;
        xspeed = cos(degtorad(angle)) * 6;
        yspeed = -sin(degtorad(angle)) * 6;
        gravStr = 0;
        flag = true;
        with (objChillSpikeDetector)
        {
            instance_destroy();
        }
    }
    else if (!flag)
    {
        yspeed = ySpeedAim(y, objChillSpikeDetector.y - 24, gravStr);
        xspeed = xSpeedAim(x, y, objChillSpikeDetector.x, objChillSpikeDetector.y, yspeed, gravStr);
        gravStr = 0.20;
        flag = true;
        with (objChillSpikeDetector)
        {
            instance_destroy();
        }
    }

    imageTimer += 1;
    if (hasGravity)
    {
        grav = gravStr;
        blockCollision = 1;
    }

    if (imageTimer == 3 && image_index < imageMax)
    {
        image_index += 1;
        imageTimer = 0;
    }

    if (imageTimer == 3 && image_index == imageMax)
    {
        image_index = imageReset;
        imageTimer = 0;
    }

    if (ground && !toWall)
    {
        playSFX(sfxChillSpikeLand);
        cS = instance_create(x, y + 9, objChillSpikeSpike);
        cS.respawn = false;
        instance_destroy();
    }
    if (xspeed == 0 && toWall)
    {
        playSFX(sfxChillSpikeLand);
        cS = instance_create(x + speed + (9 * image_xscale), y,
            objChillSpikeSpike);
        cS.sprite_index = sprChillSpikeWall;
        cS.image_xscale = image_xscale * -1;
        cS.respawn = false;
        for (i = 0; i < 16; i += 1)
        {
            with (cS)
            {
                if (!checkSolid(0, 0, 1, 1))
                {
                    x -= image_xscale;
                }
            }
        }
        instance_destroy();
    }
}
#define Collision_objMegaman
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
// sorry that a collision event had to be used......BUT IT WAS THE ONLY WAY

event_inherited();

if (!other.isFrozen)
{
    playSFX(sfxChillSpikeLand);
    with (other)
    {
        global.playerHealth[playerID] -= 2;
        freezeTimer = 60;
        isFrozen = 1;
        xspeed = 0;
        yspeed = 0;
        playerHandleSprites('Normal');
        playerPalette();
    }
    instance_destroy();
}
