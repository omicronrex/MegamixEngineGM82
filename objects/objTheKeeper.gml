#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
/// Place him and fill the guides with solids or whatever you want, if you're not using strike man's tileset
// its recommended to change backSprite to match your tiles.
event_inherited();

// Entity setup
canHit = false;
canDamage = false;
contactDamage = 4;
healthpointsStart = 15;
healthpoints = 15;
blockCollision = false;
grav = 0;
doesIntro = false;
category = "bulky";

// Enemy specific code
mySolid = noone;

//@cc changes the sprite it uses to connect himself to the arena,
// change it if you're not using strike man's tileset
backSprite = noone;

lockID = 0;
leftBound = x + 16;
rightBound = x - 16 + sprite_width;
upperBound = y + 16 * 3 + 4;
sprite_index = sprTheKeeperHead;
x += 16 * 6;
y -= 4;
xstart = x;
ystart = y;

// AI

//@cc Type 0: normal; Type 1: uses it's alternative 3rd attack(harder)
type = 0;

phase = 0; // Intro
timer = -1;

anim = 0;
animFrame = -1;
animSpeed = 0;
animTimer = -1;

leftHand = noone;
rightHand = noone;
ball = noone;
ballDir = 1;
attackCount = 0;
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();
if (entityCanStep())
{
    var prevAnim = anim;

    switch (phase)
    {
        case 0:
            if (timer == -1) // Intro, it finnishes once the animation is finnished
            {
                timer = 0;
                animSpeed = 0;
                global.lockTransition = true;
                lockID = playerLockMovement();
                canHit = false;
                canDamage = false;
            }
            else if (timer >= 0)
            {
                timer += 1;
                if (timer > 60)
                {
                    timer = -2;
                    animSpeed = 0.2;
                    animTimer = -1;
                    animFrame = -1;
                }
            }
            break;
        case -1: // Choose the next attack
            timer = -1;
            if (!instance_exists(ball))
            {
                if (attackCount >= 2)
                {
                    if (type == 0)
                        phase = 2;
                    else
                        phase = 3;
                    attackCount = 0;
                }
                else
                {
                    phase = 1;
                }
            }
            break;
        case 1: // Throw a ball and punch with one hand
            if (timer == -1)
            {
                if (attackCount == 0) // if it's it's first time throwing, choose a random direction for the ball
                    ballDir = choose(-1, 1);
                else
                    ballDir *= -1;
                if (ballDir == 1) // look at the direction the ball is gonna come from
                {
                    anim = 2;
                }
                else
                {
                    anim = 3;
                }
                timer = 1;
                attackCount += 1;
            }
            else if (timer > 0)
            {
                timer += 1;
                if (timer > 30) // wait a bit and create the ball
                {
                    timer = -2;
                    var _x;
                    if (ballDir > 0)
                    {
                        _x = leftBound - 48;
                    }
                    else
                    {
                        _x = rightBound + 48;
                    }
                    ball = instance_create(_x, upperBound - 24, objTheKeeperBall);
                    ball.dir = ballDir;
                    ball.xspeed = ball.dir * 4;
                }
            }
            else if (timer <= -2)
            {
                timer -= 1;
                if (timer < 60) // wait a bit more and make a punch
                {
                    if (ballDir < 0)
                    {
                        leftHand = instance_create(leftBound, upperBound, objTheKeeperHand);
                        leftHand.x += abs(bbox_left - bbox_right) / 2;
                        leftHand.dir = ballDir * -1;
                        leftHand.phase = 0;
                    }
                    else
                    {
                        rightHand = instance_create(rightBound, upperBound, objTheKeeperHand);
                        rightHand.x -= abs(bbox_left - bbox_right) / 2;
                        rightHand.dir = ballDir * -1;
                        rightHand.phase = 0;
                    }
                    timer = 0;
                }
            }
            else if (timer == 0) // wait for the hand to disappear and go back to choose the next attack
            {
                anim = 1;
                if ((ballDir > 0 && !instance_exists(rightHand)) || (ballDir < 0 && !instance_exists(leftHand)))
                    phase = -1;
            }
            break;
        case 2: // Smash with it's hands together
            if (timer == -1)
            {
                anim = 1;
                rightHand = instance_create(rightBound, upperBound, objTheKeeperHand);
                rightHand.x -= abs(bbox_left - bbox_right) / 2;
                rightHand.dir = -1;
                rightHand.phase = 1;
                leftHand = instance_create(leftBound, upperBound, objTheKeeperHand);
                leftHand.x += abs(bbox_left - bbox_right) / 2;
                leftHand.dir = 1;
                leftHand.phase = 1;
                timer = 0;
            }
            else
            {
                if (!instance_exists(rightHand) && !instance_exists(leftHand))
                {
                    phase = -1;
                }
            }
            break;
        case 3: /// One hand advances a bit and goes back up, the other one moves until it hits the wall and then comes back.
            if (timer == -1)
            {
                var rand = irandom(1); // chooses the hand that will come back immmediately at random
                anim = 1;
                rightHand = instance_create(rightBound, upperBound, objTheKeeperHand);
                rightHand.x -= abs(bbox_left - bbox_right) / 2;
                rightHand.dir = -1;
                rightHand.phase = 1;
                leftHand = instance_create(leftBound, upperBound, objTheKeeperHand);
                leftHand.x += abs(bbox_left - bbox_right) / 2;
                leftHand.dir = 1;
                leftHand.phase = 1;
                timer = 0;
                if (rand)
                {
                    leftHand.phase = 2;
                }
                else
                {
                    rightHand.phase = 2;
                }
            }
            else
            {
                if (!instance_exists(rightHand) && !instance_exists(leftHand))
                {
                    phase = -1;
                }
            }
            break;
    }

    // Animate && animation events
    animTimer += animSpeed;
    if (anim != prevAnim)
    {
        animTimer = -1;
        animFrame = -1;
    }
    if (animTimer > 1 || animTimer == -1)
    {
        animFrame += 1;
        animTimer = 0;
        switch (anim)
        {
            case 0: // appear
                if (animFrame > 2) // Begin the fight
                {
                    animFrame = 2;
                    playerFreeMovement(lockID);
                    timer = -1;
                    anim = 1;
                    canHit = true;
                    canDamage = true;
                    phase = -1;
                    attackCount = 0;
                    mySolid = instance_create(x - 16, y - 8, objSolid);
                    mySolid.mask_index = sprTheKeeperBack;
                }
                image_index = animFrame;
                break;
            case 1: // Look at the ball
                if (!instance_exists(ball))
                    image_index = 4;
                else
                {
                    var _x = x + sprite_width / 2;
                    if (_x < ball.x)
                    {
                        image_index = 5;
                    }
                    else if (x > ball.x)
                    {
                        image_index = 3;
                    }
                    else
                    {
                        image_index = 4;
                    }
                }
                break;
            case 2: // Look left
                image_index = 3;
                break;
            case 3: // Look right
                image_index = 5;
                break;
        }
    }
}
else if (dead)
{
    phase = 0;
    timer = -1;
    anim = 0;
    animFrame = -1;
    animSpeed = 0;
    animTimer = -1;
}
#define Other_4
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if (backSprite == noone)
{
    backSprite = sprTheKeeperBack;
}
#define Other_20
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();
if (mySolid != noone)
{
    with (mySolid)
    {
        instance_destroy();
    }
}
global.lockTransition = false;
if (instance_exists(objTheKeeperHand))
{
    with (objTheKeeperHand)
    {
        if (!dead)
        {
            image_speed = -animSpeed;
            yspeed = 0;
            grav = 0;
            xspeed = 0;
            contactDamage = 0;
            phase = -1;
        }
    }
}
if (instance_exists(objTheKeeperBall))
{
    with (objTheKeeperBall)
    {
        if (!dead)
        {
            event_user(10);
            instance_destroy();
        }
    }
}
if (instance_exists(objTheKeeperElectricBarH))
{
    with (objTheKeeperElectricBarH)
    {
        if (!dead)
        {
            instance_create(spriteGetXCenter(), spriteGetYCenter(), objBigExplosion);
            playSFX(sfxMM3Explode);
            instance_destroy();
        }
    }
}
#define Draw_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if (!dead)
{
    if (anim == 0 && phase == 0)
        draw_sprite(backSprite, min(animFrame, 2), x - 16, y - 12);
    else
        draw_sprite(backSprite, 2, x - 16, y - 12);
}
if (phase != 0)
    event_inherited();
else if (!dead && animSpeed != 0)
    drawSelf();
