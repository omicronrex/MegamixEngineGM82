#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();

calibrateDirection();

healthpointsStart = 1;
healthpoints = healthpointsStart;
contactDamage = 4;

category = "mets";

facePlayerOnSpawn = true;

// Enemy specific code
phase = 1;
graceWait = 60;
shootWait = 80;
timer = 0;

spd = 1;

animBack = false;
imgSpd = 0.16;
imgIndex = 0;
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();

if (entityCanStep())
{
    switch (phase)
    {
        // wait until popping up
        case 1:
            if (timer >= 60) // <-=1 grace period time here
            {
                if (timer == graceWait)
                {
                    // pop up animation
                    imgIndex += imgSpd * 2;
                    if (imgIndex >= 4)
                    {
                        imgIndex = 5;
                        timer += 1; // I reused timer as a boolean   :P
                    }
                }
                else
                {
                    // wait after popping up
                    timer += 1;
                    if (timer >= graceWait + 30)
                    {
                        phase = 2;
                        imgIndex = 4;
                        timer = 0;
                        xspeed = spd * image_xscale;
                    }
                }
            }
            else
            {
                timer += 1;
            }
            break;

        // JUMP N' SHOOT, JUMP N' SHOOT MAN, RIDIN' ON CARS
        case 2: // animation
            if (ground)
            {
                if (!animBack)
                {
                    imgIndex += imgSpd;
                    if (imgIndex >= 7)
                    {
                        imgIndex = 6;
                        animBack = true;
                    }
                }
                else
                {
                    imgIndex -= imgSpd;
                    if (imgIndex < 4)
                    {
                        imgIndex = 5;
                        animBack = false;
                    }
                }
            }
            else
            {
                imgIndex = 7;
                animBack = false;
            }

            // turn around
            if (instance_exists(target))
            {
                if ((image_xscale < 0 && x < target.x - 48)
                    || (image_xscale > 0 && x > target.x + 48))
                {
                    // <-=1 turn around range here
                    image_xscale = -image_xscale;
                    timer = shootWait;
                }
            }

            // jump
            if (ground && xspeed == 0)
            {
                yspeed = -3;
            }
            xspeed = spd * image_xscale;

            // shoot
            timer -= 1;
            if (timer <= 0)
            {
                turnOffset = 0;
                if (image_xscale < 0)
                {
                    turnOffset = 180;
                }

                var ID;
                for (i = 0; i < 3; i += 1)
                {
                    ID = instance_create(x + image_xscale * 8, spriteGetYCenter(), objEnemyBullet);
                    ID.direction = (i - 1) * 45 + turnOffset;
                    ID.speed = 1.75;
                    ID.xscale = image_xscale;
                    ID.sprite_index = sprEnemyBulletMM6;
                }

                playSFX(sfxEnemyShoot);

                timer = shootWait;
            }
            break;
    }
}
else if (dead)
{
    phase = 1;
    timer = 0;
    xspeed = 0;
    yspeed = 0;
    animBack = false;
    imgIndex = 0;
}

image_index = imgIndex div 1;
#define Other_21
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if (image_index == 0)
{
    other.guardCancel = 1;
}
