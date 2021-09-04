#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
// Creation code (all optional):
// image_xscale = 1 or -1 //(Use editor for this!!) determines starting direction of mini boss.

event_inherited();
respawn = true;
introSprite = sprStompyTeleport;
healthpointsStart = 22;
healthpoints = healthpointsStart;
contactDamage = 5;
blockCollision = 1;
grav = 0.15 * image_yscale;
facePlayerOnSpawn = true;
category = "bulky";

// Enemy specific code
image_speed = 0;
image_index = 0;
storeXScale = 0;
phase = 0;

// event triggers
doQuake = false;
turnTrigger = false;
findYSpeed = false;

attackTimer = 0;
attackTimerMax = 40;
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();
if (entityCanStep()
    && introTimer <= 0)
{
    dir = image_xscale;

    if (storeXScale == 0)
    {
        if (instance_exists(target)) // since minibosses usually only face one direction, here we set the direction of Stompy
            image_xscale = sign(x - target.x) * -1;
        storeXScale = image_xscale;
    }

    if (doQuake) // quake effect is reused throughout, so i made it a event trigger to not reuse code.
    {
        screenShake(20, 2, 2);
        playSFX(sfxGutsQuake);
        doQuake = false;
    }

    if (findYSpeed) // find the y speed for a jump. this code is reused throughout, so its also been made a trigger event to not reuse code.
    {
        setY = 32;
        var i; for ( i = 32; i < 224; i+=1)
        {
            if //( place_meeting(x, (y - i) - 40, objSolid))
            (checkSolid(0, -(i)))
            {
                setY -= 32;
                break;
            }
            else
            {
                setY += 1;
            }
        }
        yspeed = ySpeedAim(y, y - setY, grav);
        findYSpeed = false;
    }

    attackTimer += 1;
    switch (phase)
    {
        case 0: // jump across screen
            if (attackTimer == attackTimerMax - 1)
            {
                findYSpeed = true;
            }
            if (attackTimer >= attackTimerMax)
            {
                var setX; setX = 32;
                var i; for ( i = 32; i < view_wview; i+=1)
                {
                    if //( place_meeting(x+i*image_xscale,y,objSolid))
                    (checkSolid(i * image_xscale, 0))
                    {
                        break;
                    }
                    else
                    {
                        setX += 1;
                    }
                }
                xspeed = xSpeedAim(x, y, x + setX * image_xscale, y, yspeed, grav);
                image_index = 1;
                phase = 1;
            }
            break;
        case 1: // land after long jump
            if (ground && yspeed >= 0)
            {
                image_index = 0;
                image_xscale *= -1;
                xspeed = 0;
                doQuake = true;
                var spawnOffset; spawnOffset = 32;
                var i; for ( i = 0; i < 4; i+=1)
                {
                    var inst; inst = instance_create(x + spawnOffset * image_xscale, view_yview, objStompyProjectile);
                    if (i mod 2 == 1)
                    {
                        inst.grav *= 0.75;
                        inst.parent = id;
                    }
                    spawnOffset += 32 + (choose(0, 1) * 16);
                }
                attackTimer = -attackTimerMax * 2;
                phase = 2;
            }
            break;
        case 2: // begin jumping across screen;
            if (attackTimer == attackTimerMax)
            {
                xspeed = 1.5 * image_xscale;
                findYSpeed = true;
                image_index = 1;
                phase = 3;
            }
            break;
        case 3: // hit floor and drop projectile
            if (abs(xspeed) > 0 && yspeed > 0)
            {
                xspeed -= 0.125 * image_xscale;
            }
            if (checkSolid(10 * image_xscale, 0))
            {
                turnTrigger = true;
                x -= image_xscale;
                xspeed = 0;
            }
            if (ground && yspeed >= 0)
            {
                image_index = 0;
                xspeed = 0;
                doQuake = true;
                var inst; inst = instance_create(x - 24 * image_xscale, view_yview, objStompyProjectile);
                inst.parent = id;
                attackTimer = 0;
                if (turnTrigger)
                {
                    image_xscale *= -1;
                    phase = 0;
                    turnTrigger = false;
                }
                else
                {
                    phase = 2;
                }
            }
            break;
    }
}
else if (!insideView())
{
    image_index = 0;
    y = ystart;
    x = xstart;
    if (instance_exists(target) && !dead)
    {
        image_xscale = sign(x - target.x) * -1;
    }
    attackTimer = 0;
    phase = 0;
    doQuake = false;
    turnTrigger = false;
    findYSpeed = false;
}
#define Other_20
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
facePlayerOnSpawn = false;
with (objStompyProjectile)
{
    if (parent == other.id)
    {
        instance_destroy();
    }
}
event_inherited();
#define Draw_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();
