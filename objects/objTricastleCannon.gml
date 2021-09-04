#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();
blockCollision = false;
grav = 0;
canHit = false;
healthpointsStart = 9001;


animSpeed = 0;
animFrame = 0;
angle = 90;
newAngle = 90;
timer = 0;
image_speed = 0;
bullet = noone;
bx = -1;
by = -1;
bxspeed = 0;
respawn = 0;


shoot = false;
#define Destroy_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if (instance_exists(bullet))
{
    with (bullet)
        instance_destroy();
}
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();

if (entityCanStep())
{
    if (angle != newAngle) // Transition between angles
    {
        timer += 1;
        if (timer > 10)
        {
            timer = 0;
            if (angle < newAngle)
                angle += 45;
            else
                angle -= 45;
        }
        if (angle > 180)
            angle = 180;
        if (angle < 0)
            angle = 0;
    }
    if (shoot && angle == newAngle) // if it's in the right it can shoot
    {
        animSpeed = 0.1;
        shoot = false;
    }
    animFrame += animSpeed;
    if (animFrame > 2)
    {
        animFrame = 0;
        animSpeed = 0;
    }

    var of = 0;
    if (angle == 180)
        of = 12;
    else if (angle == 135)
        of = 9;
    else if (angle == 90)
        of = 6;
    else if (angle == 45)
        of = 3;
    image_index = of + floor(animFrame);
    if (animFrame == 2)
    {
        playSFX(sfxCannonShoot);
        bullet = instance_create(x, y, objEnemyBullet);
        bullet.sprite_index = sprTricastleCannonBall;
        bullet.image_speed = 0;
        bullet.target = self.target;
        with (bullet)
        {
            blockCollision = 0;
            yspeed = -1.5 - abs(sin(degtorad(other.angle))) * 2;
            if (sin(degtorad(other.angle) == 0))
                yspeed = 0;

            grav = 0.2;
            explodeOnContact = true;
            contactDamage = 4;
            var tx = 0;
            var ty = 0;
            if (instance_exists(target))
            {
                tx = target.x;
                ty = target.y;
            }
            x = other.bbox_left + abs(other.bbox_left - other.bbox_right) / 2 + cos(degtorad(other.angle)) * 16;
            y = other.y - sin(degtorad(other.angle)) * 16 - 4;
            xspeed = other.bxspeed;
        }
    }

    if (!instance_exists(bullet) && bullet != noone)
    {
        if (angle != 90)
        {
            newAngle = 90;
            timer = 0;
        }
        bullet = noone;
    }
}
#define Other_10
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
/// aim and shoot
if (instance_exists(target))
{
    if (target.x < bbox_right + 16 && target.x > bbox_left + 16)
        newAngle = 90;
    else if (target.x <= bbox_left && target.x > bbox_left - 90)
        newAngle = 180;
    else if (target.x <= bbox_left - 90)
        newAngle = 90 + 45;
    else if (target.x > bbox_right && target.x < bbox_right + 90)
        newAngle = 0;
    else if (target.x >= bbox_right + 90)
        newAngle = 45;

    timer = 0;
    shoot = true;
    var ysp = -1.5 - abs(sin(degtorad(newAngle))) * 2;
    bxspeed = xSpeedAim(bbox_left + abs(bbox_left - bbox_right) / 2 + cos(degtorad(newAngle)) * 16, y - sin(degtorad(newAngle)) * 16, target.x, target.y, ysp, 0.2);
}
