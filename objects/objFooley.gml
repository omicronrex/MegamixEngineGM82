#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
// I've heard Fooley Cooley is a good anime, but I've never seen the appeal, personally.
// Oh, also it can slow down time for Mega Man. Good for it.

event_inherited();

healthpointsStart = 2;
healthpoints = healthpointsStart;
contactDamage = 2;

blockCollision = false;
grav = 0;
facePlayerOnSpawn = true;

category = "flying";

image_speed = 0.1;

moveTimer = 60;
shootTimer = 30;
timeSlow = 2;
drawTimer = 4;
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();
if (entityCanStep())
{
    moveTimer-=1;
    if ((moveTimer <= 30) && (moveTimer > 0))
    {
        timeSlow-=1;
        if (timeSlow == 0)
        {
            if (sprite_index == sprFooley)
            {
                sprite_index = sprFooleyTimeSlow;
                timeSlow = 2;
            }
            else
            {
                sprite_index = sprFooley;
                timeSlow = 2;
            }
        }
    }

    if (moveTimer == 0)
    {
        sprite_index = sprFooley;
        playSFX(sfxTimeStopper);
        timeSlow = 15;
    }

    if (moveTimer < 0)
    {
        if instance_exists(target)
        {
            with (target)
            {
                // if there is no status effect object for current player, create one.
                if (!instance_exists(statusObject))
                {
                    statusObject = instance_create(x, y, objStatusEffect);
                }
                else
                {
                    statusObject.statusWalkSpeed = 1.3 / 2;
                    statusObject.statusChangedWalk = true;
                    statusObject.statusJumpSpeed = 4.75 / 2;
                    statusObject.statusChangedJump = true;
                    gravfactor = 0.25;
                    if (isHit)
                    {
                        gravfactor = 1;
                    }
                }
            }
        }

        drawTimer-=1;
        if (drawTimer == 0)
        {
            if instance_exists(target)
            {
                if (target.inked == false)
                {
                    target.inked = true;
                }
                else
                {
                    target.inked = false;
                }
            }
            drawTimer = 4;
        }

        // Create flash
        timeSlow-=1;
        if (timeSlow == 0)
        {
            if (!instance_exists(objFooleyFlash))
            {
                instance_create(x, y, objFooleyFlash);
            }
            else
            {
                with (objFooleyFlash)
                {
                    instance_destroy();
                }
            }
            timeSlow = 15;
        }

        // Shoot
        shootTimer-=1;
        if (shootTimer == 0)
        {
            instance_create(x, y, objFooleyShot);
            playSFX(sfxEnemyShootClassic);
            shootTimer = 30;
        }
    }
}
else if (dead)
{
    healthpoints = healthpointsStart;
    moveTimer = 60;
    shootTimer = 30;
    drawTimer = 4;
    timeSlow = 2;

    if (instance_exists(target))
    {
        with (target)
        {
            inked = false;

            if (instance_exists(statusObject))
            {
                statusObject.statusChangedWalk = false;
                statusObject.statusChangedJump = false;
                gravfactor = 1;
            }
        }
    }
    if (instance_exists(objFooleyFlash))
    {
        with (objFooleyFlash)
        {
            instance_destroy();
        }
    }
}
#define Other_25
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();
xspeed = 0.5 * image_xscale;
