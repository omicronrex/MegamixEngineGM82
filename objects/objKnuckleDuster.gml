#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
// Creation code (all optional): this mini boss requires additional objects to be placed in order for it to work. placing the objKnuckleDusterPlatform itself will work just fine, but for some added fun, here are a few options.

/*
// acceptableTarget[number] = objType - change the type of object(s) that Knuckle Duster attempts to destroy.
    Add additional types of objects to the array via the creation code,
    so you can add an object via an additional entry to the array such as accceptableTarget[1] = otherObject;
    Be careful, not every object type works, and obviously certain control objects being destroyed will crash the game, so be sure to test this out!
    For the nasty bags of washing out there, no it does *not* work on objMegaman.
    Knuckle Duster will outright ignore any object not in this array.
*/
// findMegaman = true - if this is true, knuckleDuster will lock onto the nearest acceptable target object near where mega man is, rather than find the nearest object by itself.
// chaseMegaman = false - if this is false, then KnuckleDuster will not chase Mega Man after he has destroyed all his acceptable targets. This will cause knuckle duster to destroy itself.
// restoreObjects = false - if this is false, then KnuckleDuster will not restore destroyed objects when it dies.

event_inherited();
respawn = true;
doesIntro = false;
healthpointsStart = 24;
healthpoints = healthpointsStart;
contactDamage = 6;
blockCollision = 0;
grav = 0;
facePlayerOnSpawn = false;

despawnRange = -1;

// Enemy specific code
image_speed = 0;
image_index = 0;
phase = 0;
attackTimer = 0;
attackTimerMax = 8;
animTimer = 0;
setY = 0;
shotsFired = 1;

nearInst = noone;
grabbedObject = false;
storeSprite = sprKnuckleDusterPlatform;
storeXOffset = 0;
storeYOffset = 0;
storeXScale = 1;
storeYScale = 1;
storeImageIndex = 0;
reactTrigger = false;

lastLocationX = -1;
lastLocationY = -1;
spd = 2;

nearInst = noone;


// creation code variables
acceptableTarget[0] = objKnuckleDusterPlatform;
findMegaman = false;
chaseMegaman = true;
restoreObjects = true;
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();
if (entityCanStep())
{
    if (attackTimer <= 0 && phase == 0) // setup knuckle duster
    {
        attackTimer = 0;
        y = view_yview + view_hview + 20;
        if (!findMegaman)
        {
            x = (view_xview + view_wview / 2) + ((shotsFired mod 8) * 32) * (1 - (shotsFired mod 2) * 2); // alternate sides and increase width from center. this replicates the R&F code, i think.
        }
        else
        {
            if (instance_exists(target)) // otherwise head to the nearest object next to megaman.
            {
                x = target.x;
            }
        }
    }

    if (instance_exists(prtBoss)) // reset attack timer if a boss is currently doing their intro animation - this is only to prevent crashes. yes knuckle duster can destroy bosses.
    {
        if (prtBoss.isIntro || !prtBoss.isFight)
        {
            attackTimer = 0;
        }
    }
    attackTimer += 1;

    // check whether all relevant objects have been destroyed.
    var destroyCheck = true;
    for (var j = 0; j < array_length_1d(acceptableTarget); j++)
    {
        if (instance_exists(acceptableTarget[j]))
        {
            destroyCheck = false;
        }
    }

    if (attackTimer >= 10 && phase == 0 && !destroyCheck) // if not, find the highest object of the type that is nearest to the player
    {
        var checkX = 999;
        var oldX = 9999;
        var checkY = 1;
        var oldY = 0;
        for (var i = 0; i < array_length_1d(acceptableTarget); i++)
        {
            if (instance_exists(acceptableTarget[i]))
            {
                var tempHand = id;
                with (instance_nearest(x, view_yview, acceptableTarget[i]))
                {
                    if (!dead)
                    {
                        checkX = abs(x - other.x);
                        checkY = abs(view_yview - y);
                        var tempNear = id;
                        if (checkX < oldX)
                        {
                            other.nearInst = tempNear;
                            oldX = checkX;
                        }
                    }
                }
            }
        }
        if (instance_exists(nearInst))
        {
            x = spriteGetXCenterObject(nearInst);
            phase = 1;
            setY = spriteGetYCenterObject(nearInst) - view_yview;
        }
        else
            phase = 1;
    }


    if (destroyCheck && !grabbedObject && chaseMegaman) // if the hand has destroyed all its other targets, it chases mega man, provided its told to. this replicates the behaviour found in r&fWS
    {
        if (instance_exists(target)) // look for target to chase.
        {
            lastLocationX = target.x;
            lastLocationY = target.y;
        }
        attackTimer += 1;

        if (attackTimer > attackTimerMax)
        {
            mp_linear_step(lastLocationX, lastLocationY, spd, false);
            xspeed = 0;
            yspeed = 0;
        }
    }

    if (phase == 1)
    {

        // move up, and track the object its supposed to grab
        yspeed = -2;
        if (instance_exists(nearInst))
        {
            x = spriteGetXCenterObject(nearInst);
            setY = spriteGetYCenterObject(nearInst) - view_yview;
            if (y <= view_yview + setY + 16) // if it has found the object, grab the graphic for the object. this will be applied via draw effect.
            {
                storeSprite = nearInst.sprite_index;
                storeXOffset = nearInst.x - x;
                storeYOffset = nearInst.y - y;
                storeImageIndex = nearInst.image_index;
                storeXScale = nearInst.image_xscale;
                storeYScale = nearInst.image_yscale;
                with (nearInst)
                {
                    instance_create(spriteGetXCenter(), spriteGetYCenter(), objExplosion);

                    dead = true;
                }
                instance_deactivate_object(nearInst);
                grabbedObject = true;
                phase = 2;
            }
        }
        else
            phase = 3;
    }

    if (phase == 2)
    {
        yspeed = -1;
        if (y <= (view_yview + setY) - 40)
        {
            yspeed = 0;
            attackTimer = 0;
            phase = 3;
            image_index = 1;
            for (var i = 0; i < 5; i += 1)
            {
                if (i != 2)
                {
                    var inst;
                    instance_create(x, y - 8, objExplosion);
                    inst = instance_create(x, y - 8, objNewShotmanBullet);
                    inst.grav = 0.25;
                    inst.xspeed = -1.25 + (0.625 * i);
                    inst.yspeed = -4;
                    inst.contactDamage = 0;
                    inst.sprite_index = sprKnuckleDusterDebry;
                    inst.image_index = irandom(4);
                }
            }
            instance_activate_object(nearInst);
            with (nearInst) // take the grabbed object, temporaily shift it to the hand position, run its death event, then put it back.
            {
                var oldY = y;
                y = other.y;
                if (object_is_ancestor(self, prtBoss) || object_is_ancestor(self, prtMiniBoss))
                {
                    event_user(EV_DEATH);
                }
                else
                {
                    event_user(EV_DEATH);
                }
                y = oldY;
            }
            instance_deactivate_object(nearInst);
            playSFX(sfxEnemyHit);
            grabbedObject = false;
        }
    }

    if (phase == 3) // reset the knuckle duster
    {
        if (attackTimer >= 32)
        {
            yspeed = max(1, (view_yview + (view_hview - y)) / 24); // speed up if up the top of the screen, slow down when it reaches the lower portions.
            image_index = 0;
        }
        if (y >= view_yview + view_hview + 20) // when it goes off the bottom of the screen, reset.
        {
            shotsFired += 1;
            setY = 0;
            attackTimer = -999;
            phase = 0;
            yspeed = 0;
            nearInst = noone;
            if (destroyCheck && !chaseMegaman) // if no instances exist and it isnt supposed to chase mega man, destroy it.
            {
                global.lockTransition = false;
                instance_destroy();
            }
        }
    }
}
else if (!insideView())
{
    image_index = 0;
    y = ystart;
    x = xstart;
    animTimer = 0;
    attackTimer = 0;
    phase = 0;
}
if (dead) // when this miniboss is dead, restore objects unless otherwise told not to.
{
    grabbedObject = false;
    if (restoreObjects)
    {
        reactTrigger = false;
        for (var i = 0; i < array_length_1d(acceptableTarget); i++)
        {
            instance_activate_object(acceptableTarget[i]);
            with (acceptableTarget[i])
            {
                if (!insideSection(x, y))
                {
                    instance_deactivate_object(self);
                }
                else
                {
                    if (dead)
                    {
                        dead = false;
                        instance_create(spriteGetXCenter(), spriteGetYCenter(), objExplosion);
                    }
                }
            }
        }
    }
}
#define Draw_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if (grabbedObject)
{
    draw_sprite_ext(storeSprite, storeImageIndex, x + storeXOffset, y + storeYOffset, storeXScale, storeYScale, image_angle, image_blend, image_alpha);
}
if (!(attackTimer == 0 && phase == 0))
{
    event_inherited();
}

// debug
// draw_sprite(sprite_index,0,(view_xview + view_wview/2) + (shotsFired * 32) * (1-(shotsFired mod 2)*2),view_yview+32);