#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
/// A robot bomb that wakes up when megaman gets close, once awaken it will chase megaman and
// explode after some time
event_inherited();
contactDamage = 3;
healthpointsStart = 2;
itemDrop = -1;
grav = 0;

//@cc How fast it can move
speedLimit = 2.5;

//@cc How fas it accelerates
accel = 0.096;

//@cc if true enemies will take damage from its explosion
harmEnemies = false;

timer = 0;
waitTimer = 0;
awaken = false;
deathTimer = 0;

//@cc how much it lives
deathTime = 60 * 4; // Explode in 4 seconds


animFrame = 0;
animOffset = 0;
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();

if (entityCanStep())
{
    if (!awaken)
    {
        animFrame = 0;
        animOffset = 0;
        if (waitTimer == 0)
        {
            if (timer >= 360)
                timer = 0;
            yspeed = sin(degtorad(timer)) * 0.3;
            if (yspeed == 0)
            {
                waitTimer = 10; // wait a bit beffore reversing its motion
            }
            timer += 2;
        }
        else
        {
            waitTimer--;
        }

        if (instance_exists(target) && distance_to_point(target.x, target.y) < 24)
        {
            awaken = true;
            timer = 0;
        }
    }
    else
    {
        animFrame += 0.1;
        if (floor(animFrame) > 1)
            animFrame = 0;

        timer += 1;
        if (timer < 10)
        {
            image_index = animOffset * 2 + animFrame + awaken;
            exit;
        }
        deathTimer += 1;
        if (deathTimer > deathTime)
        {
            dead = true;
            var i = instance_create(x, y, objHarmfulExplosion);
            i.damageEnemies = harmEnemies;
            playSFX(sfxMM9Explosion);
        }
        else
        {
            if (deathTimer > deathTime - 60) // Flash before exploding
            {
                animFrame += 0.1; // Animate faster
                animOffset += 0.25;
                if (floor(animOffset) > 1)
                    animOffset = 0;
            }
        }
        var tx = 0;
        var ty = 0;
        var rest = false;
        if (instance_exists(target))
        {
            tx = target.x;
            ty = target.y;
        }
        else
        {
            tx = xstart;
            ty = ystart;
            deathTimer = 0;
            if (abs(x - xstart) <= abs(xspeed))
            {
                x = xstart;
                xspeed = 0;
            }
            if (abs(y - ystart) <= abs(yspeed))
            {
                yspeed = 0;
                y = ystart;
            }
            if (y == ystart && x == xstart)
            {
                timer = 0;
                waitTimer = 0;
                awaken = false;
                deathTimer = 0;
                rest = true;
                xspeed = 0;
                yspeed = 0;
                x = xstart;
                y = ystart;
            }
        }
        if (!rest)
        {
            var angle = wrapAngle(point_direction(x, y, tx, ty));

            // Accelerate towards target limited to 8 directions
            if (x != tx)
            {
                xspeed += accel * cos(degtorad(angle));
            }
            if (y != ty)
            {
                yspeed += accel * -sin(degtorad(angle));
            }

            // Limit its overall speed
            var lenSQ = (xspeed * xspeed) + (yspeed * yspeed);
            if (lenSQ > speedLimit * speedLimit)
            {
                var len = sqrt(lenSQ);
                xspeed /= len;
                yspeed /= len;
                xspeed *= speedLimit;
                yspeed *= speedLimit;
            }
        }

        // Keep it inside water
        mask_index = sprDot;
        if (place_meeting(xprevious, yprevious, objWater) && !place_meeting(x, y, objWater))
        {
            var i = instance_place(xprevious, yprevious, objWater);
            if (i != noone)
            {
                if (y <= i.bbox_top)
                {
                    y = i.bbox_top + 1;
                    yspeed = 0;
                }
                else if (y >= i.bbox_bottom)
                {
                    y = i.bbox_bottom - 1;
                    yspeed = 0;
                }

                if (x <= i.bbox_left)
                {
                    x = i.bbox_left + 1;
                    xspeed = 0;
                }
                else if (x >= i.bbox_right)
                {
                    x = i.bbox_right - 1;
                    xspeed = 0;
                }
            }
        }
        mask_index = sprOkosutobon;
    }
    image_index = animOffset * 2 + animFrame + awaken;
}
#define Other_18
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();
if (!awaken)
{
    awaken = true;
    timer = 0;
}
#define Other_21
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();
if (!awaken)
{
    awaken = true;
    timer = 0;
}
#define Other_23
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
// Set damage values
global.damage = 0; // Make invincible
event_inherited(); // Allow custom weakness in creation code
#define Other_25
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();
timer = 0;
waitTimer = 0;
awaken = false;
deathTimer = 0;
visible = true;
