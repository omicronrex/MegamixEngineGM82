#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
/// This big elephant that sucks and throws his ball.
event_inherited();

respawn = true;
introSprite = sprPaozoTeleport;

healthpointsStart = 15;
healthpoints = healthpointsStart;
contactDamage = 5;
category = "bulky, nature";

// Creation code

//@cc 0 = red (pushes ball); 1 = green (bounces ball)
type = 0;

// Enemy specific code
init = true;
ball = noone;
image_speed = 0;
phase = 0;
timer = 0;
suckTimer = -1;
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if (init)
{
    init = false;
    switch (type)
    {
        case 0:
            sprite_index = sprPaozo;
            break;
        case 1:
            sprite_index = sprPaozoGreen;
            break;
    }
}

event_inherited();

if (entityCanStep()
    && introTimer <= 0)
{
    ballPosX = x + 36 * image_xscale;
    ballPosY = y - 15;

    if (timer > 0)
        timer -= 1;

    if (!instance_exists(ball))
    {
        ball = instance_create(ballPosX, ballPosY, objPaozoBall);
        if (type == 1)
            ball.sprite_index = sprPaozoBallGreen;
        ball.parent = id;
        suckTimer = -1;
        phase = 0;
        timer = 20;
        image_index = 0;
    }

    switch (phase)
    {
        case 0:
            ball.x = ballPosX;
            ball.y = ballPosY;

            if (timer == 0)
            {
                phase = 1;
                timer = 36;
                image_index = 1;
                ball.image_speed = .3;
                ball.xspeed = 2 * image_xscale;
                ball.grav = .4;
                ball.blockCollision = true;
                if (type == 1)
                {
                    ball.yspeed = -6;
                    ball.canBounce = true;
                }
            }
            break;
        case 1:
            if (timer == 32)
                image_index = 2;
            if (timer == 18)
                image_index = 3;
            if (timer == 10)
                image_index = 0;
            if (timer < 10 && ball.xspeed != 0)
                timer = 10;
            if (timer == 8)
            {
                playSFX(sfxPaozoSuckIn);
                image_index = 4;
                suckTimer = 0;
            }
            if (timer == 0)
                phase = 2;
            break;
        case 2:
            if (!(ball.x > ballPosX - 2 &&
                ball.x < ballPosX + 2 &&
                ball.y > ballPosY - 2 &&
                ball.y < ballPosY + 2))
            {
                with (ball)
                {
                    grav = 0;
                    blockCollision = false;

                    moveTowardPoint(other.ballPosX, other.ballPosY, 2);
                }
            }
            else
            {
                suckTimer = -1;
                image_index = 0;
                ball.image_speed = 0;
                ball.image_index = 0;
                ball.x = ballPosX;
                ball.y = ballPosY;
                ball.xspeed = 0;
                ball.yspeed = 0;
                ball.canBounce = false;
                phase = 0;
                timer = 20;
            }
            break;
    }

    if (suckTimer > -1)
    {
        with (objMegaman)
        {
            if ((x <= other.x - 26 && other.image_xscale == -1)
                || (x >= other.x + 26 && other.image_xscale == 1))
                playerBlow(-.9 * other.image_xscale);
        }

        if (suckTimer < 3)
        {
            suckTimer += 1;
        }
        else
        {
            if (image_index == 4)
                image_index = 5;
            else
                image_index = 4;
            suckTimer = 0;
        }
    }
}
else if (!insideView())
{
    // something something
}
