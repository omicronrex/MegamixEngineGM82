#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();
contactDamage = 4;
blockCollision = 0;
stopOnFlash = false;
grav = 0;
spd = 4;
xspeed = spd;
yspeed = 0;

delay = 0;
reflectable = false;
calibrateDirection();
image_speed = 0;

explodeDelay = 8;
explodeRadius = 32;
isActive = false;
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();
if (!global.frozen)
{
    if (instance_exists(target))
    {
        if (abs(x - target.x) <= explodeRadius)
        {
            isActive = true;
        }
    }
    else
    {
        explodeDelay -= 0.25;
    }

    if (isActive)
    {
        explodeDelay--;
    }

    if (explodeDelay <= 0)
    {
        var i = instance_create(x, y, objDustManDebris);
        i.xspeed = 2;
        i.yspeed = 2;
        i.image_index = 4;
        i = instance_create(x, y, objDustManDebris);
        i.xspeed = -2;
        i.yspeed = 2;
        i.image_index = 3;
        i = instance_create(x, y, objDustManDebris);
        i.xspeed = 2;
        i.yspeed = -2;
        i.image_index = 1;
        i = instance_create(x, y, objDustManDebris);
        i.xspeed = -2;
        i.yspeed = -2;
        i.image_index = 0;
        instance_destroy();
    }
}
