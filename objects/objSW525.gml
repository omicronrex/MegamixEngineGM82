#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
// creation code (all optional)
// startDir = <number> (1 = starts rightside up; -1 = starts upside down (default) )

event_inherited();

healthpointsStart = 1;
healthpoints = healthpointsStart;
contactDamage = 3;

category = "grounded";

facePlayerOnSpawn = true;

// Enemy specific code
startDir = -1;
image_yscale = startDir;
gravityDir = startDir;

explodeWait = 350;
explodeWaitExtra = 30; // <-- for the extra time to play the animation
explodeTimer = 0;
trackRange = 20;

spd = 1.4;

imgSpd = 0.2;
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
    grav = gravityDir * gravAccel;

    explodeTimer += 1;
    if (explodeTimer < explodeWait && ground)
    {
        // animation
        imgIndex += imgSpd;
        if (imgIndex >= 5)
        {
            imgIndex = 0;
        }

        // gravity switch stuff
        if (instance_exists(target))
        {
            if (target.image_yscale != image_yscale && target.bbox_left
                < bbox_right && target.bbox_right > bbox_left)
            {
                gravityDir = -gravityDir;
                image_yscale = -image_yscale;
            }
        }

        // turn around stuff
        turn = false;
        if (xspeed == 0)
        {
            turn = true;
        }

        if (instance_exists(target))
        {
            if ((image_xscale < 0 && x < target.x - trackRange)
                || (image_xscale > 0 && x > target.x + trackRange))
            {
                turn = true;
            }
        }

        if (turn)
        {
            image_xscale = -image_xscale;
        }

        xspeed = spd * image_xscale;
    }
    else
    {
        xspeed = 0;

        // animation
        imgIndex += imgSpd * 3;
        if (explodeTimer < explodeWait + explodeWaitExtra
            && imgIndex >= 6)
        {
            imgIndex = 4;
        }

        if (explodeTimer < explodeWait + explodeWaitExtra * 2
            && imgIndex >= 7)
        {
            imgIndex = 5;
        }

        // self destruct
        if (explodeTimer >= explodeWait + explodeWaitExtra * 2)
        {
            instance_create(x, y, objHarmfulExplosion);

            healthpoints = 0;
            event_user(EV_DEATH);

            playSFX(sfxExplosion2);
        }
    }

    if (!ground)
    {
        xspeed = 0;
    }
}
else if (dead)
{
    explodeTimer = 0;
    xspeed = 0;
    yspeed = 0;
    imgIndex = 0;
    image_yscale = startDir;
    gravityDir = startDir;
}

image_index = imgIndex div 1;
#define Other_25
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();

if (spawned)
{
    xspeed = spd * image_xscale;
}
