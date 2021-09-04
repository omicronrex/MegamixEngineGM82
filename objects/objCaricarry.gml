#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
// Creation code (all optional):

event_inherited();

dir = 1;
alarm[0] = 1;

healthpointsStart = 6;
healthpoints = healthpointsStart;
contactDamage = 3;

category = "rocky";

// Enemy specific code
spd = 1.6;
acc = 0.25;

turnTimerStart = round(((4 * 16) / spd) + (spd / acc) * 2);
turnTimer = round((turnTimerStart / 2) - (spd / acc) * 2);

shooting = false;
animTimer = 0;
shootTimer = 0;
prevHealth = healthpoints;
beginMoveTimer = 0;
globalDir = 1;
#define Alarm_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
globalDir = dir;
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();

if (entityCanStep())
{
    // Movement
    if (beginMoveTimer < 7)
    {
        beginMoveTimer += 1;
        xspeed = 0;
        dir = globalDir;
    }
    else
    {
        if (shooting == false)
        {
            turnTimer -= 1;
            if (turnTimer <= 0 || checkSolid(xspeed, -1) || checkFall(dir,1))
            {
                dir = -dir;
                turnTimer = turnTimerStart;
            }

            if (dir == 1)
            {
                if (xspeed < spd)
                    xspeed += acc;
                if (xspeed > spd)
                    xspeed = spd;
            }
            else
            {
                if (xspeed > -spd)
                    xspeed -= acc;
                if (xspeed < -spd)
                    xspeed = -spd;
            }
        }
        else
        {
            xspeed = 0;

            shootTimer += 1;
            if (shootTimer >= 42)
            {
                shootTimer = 0;
                shooting = false;
                turnTimer += round(spd / acc);
                image_index = 0;
            }
        }
    }

    // Animation
    if (!shooting)
    {
        animTimer += 1;
        if (animTimer >= 5)
        {
            if (image_index == 1)
                image_index = 0;
            else
                image_index = 1;

            animTimer = 0;
        }
    }
    else
    {
        animTimer += 1;
        if (animTimer >= 5)
        {
            if (image_index == 3)
                image_index = 2;
            else
                image_index = 3;

            animTimer = 0;
        }
    }


    // Shooting
    if (healthpoints > 0 && healthpoints < prevHealth && shooting == false)
    {
        shooting = true;
        image_index = 2;

        calibrateDirection();
        with (instance_create(x + image_xscale * 9, y - 11,
            objCaricarryRockBounce))
        {
            image_xscale = other.image_xscale;
        }
        image_xscale = 1;
    }

    prevHealth = healthpoints;
}
else if (dead)
{
    image_index = 0;
    shooting = false;
    xspeed = dir * spd;
    turnTimer = round((turnTimerStart / 2) - (spd / acc) * 2);
    animTimer = 0;
    shootTimer = 0;
    dir = globalDir;
    beginMoveTimer = 0;
    xspeed = 0;
}
#define Other_20
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();

with (instance_create(x - 16, y, objNewShotmanBullet))
{
    image_xscale = -1;
    xspeed = -1.2;
    yspeed = -2.5;
    stopAtSolid = true;
    sprite_index = sprCaricarryRock;
}

with (instance_create(x + 16, y, objNewShotmanBullet))
{
    image_xscale = 1;
    xspeed = 1.2;
    yspeed = -2.5;
    stopAtSolid = true;
    sprite_index = sprCaricarryRock;
}

with (instance_create(x - 8, y - 8, objNewShotmanBullet))
{
    image_xscale = -1;
    xspeed = -0.5;
    yspeed = -4;
    stopAtSolid = true;
    sprite_index = sprCaricarryRock;
}

with (instance_create(x + 8, y - 8, objNewShotmanBullet))
{
    image_xscale = 1;
    xspeed = 0.5;
    yspeed = -4;
    stopAtSolid = true;
    sprite_index = sprCaricarryRock;
}
