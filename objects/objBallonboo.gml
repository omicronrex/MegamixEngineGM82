#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();
healthpointsStart = 3;
contactDamage = 3;
grav = 0;
blockCollision = 0;

category = "flying";

// Enemy specific code
enemyDamageValue(objHornetChaser, 3);
enemyDamageValue(objSparkChaser, 3);

bursted = false;
timer = 0;
animFrame = 0;
sinTimer = 0;
vDir = -1;
yPivot = 0;
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();

if (entityCanStep())
{
    if (!bursted)
    {
        if (timer == 0) // Move Up and down, for a better way to do this check okosutobon
        {
            if (abs(y - yPivot) < 56)
            {
                if (abs(yspeed) < 0.6)
                    yspeed += 0.035 * vDir;
            }
            else
            {
                if (abs(yspeed) > 0.35)
                {
                    yspeed -= 0.0225 * vDir;
                }
            }
        }



        if (abs(y - yPivot) >= 64)
        {
            y = yPivot + 64 * vDir;
            yspeed = 0;
            timer = 1;
            vDir *= -1;
            yPivot = y;
        }
        if (animFrame > 0)
        {
            animFrame -= 0.10;
            if (animFrame < 0)
                animFrame = 0;
        }
        if (timer > 0)
        {
            if (timer == 1)
            {
                // Shoot;
                timer += 1;
                animFrame = 1.99;
                playSFX(sfxEnemyShootClassic);
                var i = instance_create(x, y + 16 * image_yscale, objEnemyBullet);
                i.spd = 3;
                var xDir = -1;
                if (instance_exists(target) && target.x > x)
                    xDir = 1;
                i.dir = point_direction(i.x, i.y, i.x + 4 * xDir, i.y + 6 * image_yscale);
            }
            else
            {
                timer += 1;
                if (timer > 30)
                    timer = 0;
            }
        }
    }
    else
    {
        if (animFrame < 2)
        {
            animFrame = 2;
        }
        else
        {
            animFrame += 0.25;
            if (animFrame > 7)
                animFrame = 2;
        }
        timer += 1;
        var tx = x + xspeed;
        var ty = y + yspeed;
        if (timer < 200)
        {
            if (instance_exists(target))
            {
                tx = target.x;
                ty = target.y;
            }
        }

        var dir = -1 + 2 * (tx > x);
        xspeed += dir * 0.123;
        dir = -1 + 2 * (ty > y);
        yspeed += dir * 0.123;

        // Limit its overall speed
        var lenSQ = (xspeed * xspeed) + (yspeed * yspeed);
        if (lenSQ > 5 * 5)
        {
            var len = sqrt(lenSQ);
            xspeed /= len;
            yspeed /= len;
            xspeed *= 5;
            yspeed *= 5;
        }
        image_xscale = sign(xspeed);
    }
    image_index = floor(animFrame);
}
#define Other_20
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();
if (!bursted)
{
    var i = instance_create(x, y, objBallonbooDead);
    i.grav = -image_yscale * 0.1;
}
#define Other_21
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();
if (!bursted && other.bbox_bottom < y + 8)
{
    playSFX(sfxBalloonboo);
    global.damage = 0;
    bursted = true;
    var dir = -1 + 2 * (other.x > x);
    xspeed = -3.4 * dir;
    yspeed = -0.5;
    other.guardCancel = 2;
    {
        if (other.penetrate == 0)
            other.dead = true;
    }
}
#define Other_25
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();
bursted = false;
image_xscale = 1;
timer = 0;
sinTimer = 0;
vDir = -1;
yPivot = y;
animFrame = 0;
