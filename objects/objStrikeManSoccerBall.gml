#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
/// A soccer ball that flies up when shot, it will damage players and enemies when it falls on them
event_inherited();

// Initialize Entity
canHit = true;
grav = 0;
ground = 1;
blockCollision = 1;
dieToSpikes = 0;
bubbleTimer = -1;
doesTransition = true;
isSolid = 1;
contactDamage = 3;
penetrate = 1;
faction = 7;

// Object specific variables
guardCancel = 0;
sy = y;
descendSpeed = 1.5; // Maximum speed when descending
holdTime = 15;
accelSpeed = -0.35;
ascendSpeed = -2;
accelTime = 15; // in frames
ascendDist = 64;
descendGrav = 0.15; // gravity when descending
acc = 0.1;
phase = 0;
timer = -1;

// Animation
anim = 0;
animTimer = 0;
animFrame = -1;
animSpeed = 0.2;

event_user(1);
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();

/// Step
if (entityCanStep())
{
    // x=xstart;
    var prevAnim = anim;
    healthpoints = 99;
    switch (phase)
    {
        case 0:
            if (timer == -1)
            {
                image_index = 0;
                timer = 0;
                anim = -1;
                grav = 0.25;
            }
            else
                sy = y;
            event_user(0);
            break;
        case 1:
            if (timer == -1)
            {
                anim = 0;
                timer = 0;
                yspeed = -acc;
                animSpeed = 0.25;
                grav = 0;
                playSFX(sfxStrikeManSoccerBall);
            }
            else if (timer == -3)
            {
                anim = 0;
                timer = -2;
                yspeed = ascendSpeed;
                animSpeed = 0.25;
                grav = 0;
                playSFX(sfxStrikeManSoccerBall);
            }
            else
            {
                if (timer >= 0 && timer <= accelTime && yspeed >= accelSpeed)
                {
                    timer += 1;
                    yspeed -= acc;
                    if (yspeed < accelSpeed)
                    {
                        yspeed = accelSpeed;
                    }
                    if (timer > accelTime)
                    {
                        timer = -2;
                        yspeed = ascendSpeed;
                    }
                }
                else if (timer == -2)
                {
                    if (y < sy - ascendDist || yspeed == 0)
                    {
                        phase = 2;
                        timer = -1;
                        if (yspeed != 0)
                            y = sy - ascendDist;
                    }
                    else if (abs(y - (sy - ascendDist)) < holdTime)
                    {
                        yspeed += acc;
                        yspeed = min(accelSpeed, yspeed);
                    }
                    else
                        yspeed = ascendSpeed;
                }
            }
            break;
        case 2:
            if (timer == -1)
            {
                anim = 1;
                animSpeed = 0.2;
            }
            event_user(0);
            if (phase == 2 && ground)
            {
                phase = 0;
                timer = -1;
            }

            if (phase == 2)
            {
                yspeed += descendGrav;
            }
            if (yspeed > descendSpeed)
                yspeed = descendSpeed;

            break;
    }
    if (prevAnim != anim)
    {
        animFrame = -1;
        animTimer = 2;
    }
    animTimer += animSpeed;
    if (animTimer > 1)
    {
        animTimer = 0;
        animFrame += 1;
        if (animFrame > 1)
        {
            animFrame = 0;
        }
        switch (anim)
        {
            case 0:
                image_index = animFrame + 1;
                break;
            case 1:
                image_index = animFrame + 2;
                break;
            case -1:
                break;
        }
    }
}
#define Other_10
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
/// Prevent Crushing entities when falling
if (!ground && yspeed > 0)
{
    var changePhase = false;

    with (prtEntity)
    {
        if (dead)
            continue;
        var ysp;
        if (yspeed > 1)
            ysp = yspeed;
        else
            ysp = 1;
        var prevGround = ground;
        if (!ground && (checkSolid(0, 2)))
            ground = true;

        if ((!ground && blockCollision) || (!blockCollision && isSolid == 0))
            continue;
        var doDamage = false;
        if (((faction == 3 && isSolid == 0) || faction != 3) && object_index != objStrikeManSoccerBall && object_index != objStrikeManSpikeySoccerBall && object_index != prtEnemyProjectile && (object_index == objMagnetBeam || object_index == objIceWall || object_index == objRushJet || object_index == objRushCycle || object_index == objRushCoil || faction == 1 || faction == 3) && place_meeting(x, y - 1 - ysp - other.yspeed, other))
        {
            changePhase = true;
            doDamage = true;
        }
        ground = prevGround;
        if (doDamage)
        {
            global.damage=contactDamage;
            other.guardCancel = 0;
            event_user(11);
            if (other.guardCancel > 0)
                doDamage = false;
        }
        if (canHit && iFrames == 0 && doDamage && penetrate == 0)
        {
            with (other)
                entityEntityCollision();
            hitTimer = 0;
        }
    }

    if (changePhase)
    {
        phase = 1;
        timer = -3;
        yspeed = 0;
        animSpeed = 0.25;
    }
}
#define Other_19
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
iFrames = 0;
#define Other_21
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();
global.damage = 0;
if (phase == 0)
{
    other.guardCancel = 2;
    if (other.penetrate < 1)
    {
        with (other)
            dead = true;
    }
    phase = 1;
    timer = -1;
}
else
{
    other.guardCancel = 1;
}
healthpoints = healthpointsStart;
#define Other_25
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();

/// spawn
if (spawned)
{
    phase = 0;
    timer = -1;
    anim = -1;
    animSpeed = 0.15;
}
