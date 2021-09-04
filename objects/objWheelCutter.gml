#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();

bulletLimitCost = 1;

contactDamage = 2;

image_speed = 0.6;

penetrate = 1;
pierces = 2;
attackDelay = 16;

attached = true;

bounceTimes = 0;
wallwait = 0;

jumpSpeed = 7;
accel = 0.25;
stepend = 0;
maxVspeed = 7;

playSFX(sfxWheelCutter1);
dieToSpikes = 0;
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();

if (attached)
{
    if (instance_exists(parent))
    {
        stepend = 0;
        event_user(0);
        parent.shootTimer = 0;
    }
}

if (!global.frozen)
{
    if (attached /*&& !global.playerFrozen */ ) // If Wheel Cutter is attached...
    {
        if (checkSolid(0, 2 * image_yscale)) // If connecting with solid surface...
        {
            with (parent)
            {
                if (!climbing)
                {
                    accel = other.accel * 2;
                    if (yspeed * gravDir > -jumpSpeed)
                    {
                        yspeed -= accel * gravDir;
                    }
                    if (yspeed * gravDir > 0)
                    {
                        yspeed -= accel * 2 * gravDir;
                    }
                    if (yspeed * gravDir < -jumpSpeed)
                    {
                        yspeed = -jumpSpeed * gravDir;
                    }
                }
            }
        }
    }
    else // If Wheel Cutter is not attached...
    {
        if (abs(xspeed) < 5)
        {
            xspeed += 0.05 * image_xscale;
        }

        if (!bounceTimes)
        {
            xspeed = 0;
            if (ground)
            {
                bounceTimes += 1;
            }
        }

        if (ycoll != 0) // bounce from ground
        {
            if ((ycoll > 0 && image_yscale > 0) || (ycoll < 0 && image_yscale < 0))
            {
                ground = false;
                yspeed = -ycoll * 0.5;
                if ((yspeed > -0.5 && sign(image_yscale) == 1) || (yspeed < 0.5 && sign(image_yscale) == -1))
                {
                    yspeed = 0;
                    ground = true;
                }
                bounceTimes += 1;
            }
            else
            {
                instance_destroy();
                instance_create(x, y, objExplosion);
            }
        }

        if (checkSolid(image_xscale, 0))
        {
            wallwait += 1;
            if (wallwait > 10)
            {
                if (yspeed == 0)
                {
                    playSFX(sfxWheelCutter2);
                }
                /*if ((yspeed > -jumpSpeed && sign(image_yscale) == 1) || (yspeed < jumpSpeed && sign(image_yscale) == -1))
                {
                    yspeed = max(yspeed - (accel), -jumpSpeed);
                }*/
                yspeed -= gravAccel * 2 * sign(image_yscale);
            }
            /*else
            {
                yspeed = 0;
            }*/
        }
        else
        {
            wallwait = 0;
        }
    }
}
#define Step_2
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();

stepend = 1;
if (attached && instance_exists(parent))
{
    event_user(0);
}
#define Other_10
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
var detach; detach = !global.keyShoot[playerID];
if (global.playerHealth[playerID] <= 0)
{
    detach = 1;
}

if (detach || parent.isSlide || parent.teleporting || parent.isHit)
{
    attached = 0;
    grav = 0.25 * sign(image_yscale);
    blockCollision = 1;
    attackDelay = 8;
    if (checkSolid(0, 0))
    {
        instance_destroy();
        instance_create(x, y, objExplosion);
    }
    exit;
}

with (parent)
{
    if (climbing)
    {
        other.yy = 3;
        other.xx = 17;
    }
    else if (!ground)
    {
        other.yy = -1;
        other.xx = 19;
    }
    else
    {
        if (stepTimer >= stepFrames)
        {
            other.yy = 4;
            other.xx = 21;
        }
        else
        {
            other.yy = 4;
            other.xx = 23;
        }
    }
}

if (stepend == 0)
{
    xx = 19;
}

image_xscale = parent.image_xscale;
image_yscale = parent.image_yscale;
x = parent.x + xx * image_xscale;
y = parent.y + yy * image_yscale;
#define Other_22
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
/// Set Mega Man's palette
weaponSetup("WHEEL CUTTER", make_color_rgb(112, 112, 112), make_color_rgb(252, 252, 252), sprWeaponIconsWheelCutter);
#define Other_23
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
/// Set special damage values
specialDamageValue("nature", 3);
specialDamageValue("grounded", 3);
#define Other_24
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
// only fire if megaman isnt in shooting animation
if (global.keyShootPressed[playerID] && !playerIsLocked(PL_LOCK_SHOOT))
{
    if (!isShoot)
    {
        i = fireWeapon(13, 0, objWheelCutter, 3, 1, 1, 0);
        if (i)
        {
            i.jumpSpeed = jumpSpeed;
            i.maxVspeed = maxVspeed;
        }
    }
}
