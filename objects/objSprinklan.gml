#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
// Creation code (all optional):
// col = <number> (0 = blue (default); 1 = purple; 2 = orange)
// slowSpeed = <number>. Speed, in pixels per frame, when not aligned with target
// fastSpeed = <number>. Speed, in pixels per frame, when aligned with target and moving toward it

event_inherited();

healthpointsStart = 256; // placeholder
healthpoints = healthpointsStart;
contactDamage = 3;

// Enemy specific code
col = 0; // 0 = blue; 1 = purple; 2 = orange
init = 1;

image_speed = 0;
xdir = image_xscale;
image_xscale = 1;
timer = 0;
animFrame = -1;
frameOffset = 0;
animSpeed = 0.25;
animTimer = -1;
anim = 0;

stopped = false;
shootCount = 0;
shootMax = 4;
stopTimer=0;

slowSpeed = 0.5;
fastSpeed = 2.15;
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();
if (init)
{
    init = 0;
    frameOffset = 6 * col;
}
if (entityCanStep())
{
    var prevAnim; prevAnim = anim;

    if (!stopped)
    {
        if(stopTimer==0)
        {
            animSpeed = 0;
            anim = 0;

            if (xcoll != 0)
            {
                xdir *= -1;
            }
            if (ground)
            {
                if (!positionCollision(x + 8 * xdir, bbox_bottom + 2))
                {
                    xdir *= -1;
                    stopTimer=45;
                    xspeed=0;
                }
            }
            if(stopTimer==0)
            {
                // set slow speed as default for frame
                xspeed = slowSpeed;

                // speed up if lined up with target
                if (instance_exists(target))
                {
                    if (target.bbox_bottom + 1 <= bbox_bottom + 2
                        && abs(target.y - y) < 8)
                    {
                        if (sign(target.x - x) == xdir)
                            xspeed = fastSpeed;
                    }
                }
                xspeed *= xdir; // base xspeed by direction
            }
        }
        else
        {
            xspeed=0;
            stopTimer-=1;
        }
    }
    else
    {
        stopTimer=0;
        animSpeed = 0.25;
        anim = 1;

        // Move again once it's shot enough
        if (shootCount >= shootMax && animFrame == 0)
        {
            stopped = false;
            shootCount = 0;
            anim = 0;
            mask_index = sprSprinklan;
        }
    }

    if (!ground)
    {
        xspeed = 0;
    }

    // Animate
    animTimer += animSpeed;
    if (anim != prevAnim)
    {
        animTimer = -1;
        animFrame = -1;
    }
    if (animTimer > 1 || animTimer == -1)
    {
        animTimer = 0;
        animFrame += 1;
        if (anim == 0)
        {
            animFrame = 0;
        }
        else if (anim == 1)
        {
            if (animFrame > 5)
                animFrame = 0;
            else if (animFrame == 2 || animFrame == 5)
                event_user(0);
        }
    }
    image_index = 6*col + animFrame;
}
#define Other_10
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
/// Shooting
playSFX(sfxSprinklanShoot);
mask_index = mskSprinklanBig;
shootCount += 1;
var dir;
if (animFrame == 2)
    dir = 1;
else
    dir = -1;
var bullet; bullet = instance_create(x + 7 * dir, y - 16, objEnemyBullet);
bullet.xspeed = dir * 2;
bullet.grav = 0.25;
bullet.yspeed = -2 - irandom(2);
#define Other_21
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if (global.damage > 0)
{
    healthpoints = global.damage;
}
else
{
    stopped = true;
    xspeed = 0;
}
#define Other_23
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
// Set all weapons to do no damage
global.damage = 0;

// certain weapons will only stop it - these kill it
specialDamageValue(objTopSpin, 3);
specialDamageValue(objBlackHoleBomb, 3);
specialDamageValue(objThunderBeam, 3);
specialDamageValue(objBreakDash, 3);
specialDamageValue(objChillSpikeLanded, 3);
specialDamageValue(objTenguDash, 3);
specialDamageValue(objSkeletuppinPakkajoe, 3);
#define Other_25
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();
if(spawned)
{
    stopTimer = 0;
    image_index = 0;
    stopped = false;
    shootCount = 0;
    anim = 0;
    mask_index = sprSprinklan;
}
