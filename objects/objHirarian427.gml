#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
// Creation code (all optional):
// col = <number> (0 = green (default); 1 = red; 2 = game gear colouration)

event_inherited();

respawn = true;

healthpointsStart = 1;
healthpoints = healthpointsStart;
contactDamage = 5;

blockCollision = 0;
grav = 0;

facePlayerOnSpawn = true;

// Enemy specific code
activated = false;
onFloor = false;
radius = 72;

imageOffset = 0;
imageTimer = 0;
imageTimerMax = 4;

col = 0;
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();

if (entityCanStep())
{
    // if not activated, change diretion.
    if (!activated)
    {
        calibrateDirection();
    }

    // basic AI, if Mega Man is within range, activate hirarian.
    if (instance_exists(target))
    {
        if (!activated && abs(target.x - x) <= radius)
        {
            activated = true;
        }
    }

    // if Hirarian has hit wall, explode.
    if (activated&&xcoll != 0)
    {
        instance_create(x, spriteGetYCenter(), objHarmfulExplosion);
        playSFX(sfxExplosion);
        dead = true;
    }

    // whilst activated, hiriran is subject to gravity and can move.
    if (activated)
    {
        blockCollision = 1;
        grav = gravAccel;
        x = ceil(x);

        // when landing on ground for first time, set Xspeed and start animation.
        if (xspeed == 0 && yspeed == 0 && onFloor == false)
        {
            xspeed = 2 * image_xscale;
            onFloor = true;
            imageOffset = 2;
        }

        // if falling, set animation to frame 1.
        if (yspeed != 0 && imageOffset < 2)
        {
            xspeed = 0;
            imageOffset = 1;
            onFloor = false;
        }
        else if (yspeed != 0 && imageOffset >= 2)
        {
            xspeed = 0;
            onFloor = false;
        }

        // animation setup

        if (imageOffset >= 2)
            imageTimer += 1;

        if (imageTimer == imageTimerMax && imageOffset < 4)
        {
            imageOffset += 1;
            imageTimer = 0;
        }
        if (imageTimer == imageTimerMax && imageOffset == 4)
        {
            imageOffset = 2;
            imageTimer = 0;
        }
    }
}

image_index = (5 * col) + imageOffset;
#define Other_25
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();

image_index = 0;

if(spawned)
{

    activated = false;
    onFloor = false;
    imageOffset = 0;
    imageTimer = 0;

    blockCollision = 0;
    grav = 0;
    yspeed=0;
    xspeed=0;
    xcoll=0;
}
