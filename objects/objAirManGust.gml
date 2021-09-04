#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();

contactDamage = 3;
blockCollision = 0;
stopOnFlash = false;
canHit = true;
isTargetable = false;

grav = 0;

number = 0;

spd = 5.5;
phase = 0; // 0 = idling; 1 = getting into position and flying forward
timer = 0;

xspeed = 0;
yspeed = 0;

reflectable = 0;

if (instance_exists(objAirMan))
{
    x = objAirMan.x;
    y = objAirMan.y;

    xspeed = (xstart - x) / 20;
    yspeed = (ystart - y) / 20;
}
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if (!instance_exists(objAirMan))
{
    instance_destroy();
    exit;
}
event_inherited();

if (global.frozen == false)
{
    image_speed = 0.3;
    if (phase == 1)
        timer += 1;
    if (phase == 0)
    {
        if ((x <= xstart && xspeed < 0)
            || (x >= xstart && xspeed > 0))
        {
            xspeed = 0;
            x = xstart;
        }
        if ((y <= ystart && yspeed < 0)
            || (y >= ystart && yspeed > 0))
        {
            yspeed = 0;
            x = xstart;
        }
        if (xspeed == 0
            && yspeed == 0)
            phase = 1;
    }

    if (phase == 1
        && timer >= 40)
        xspeed += 0.1 * image_xscale;
    if (instance_exists(target))
    {
        if (phase == 2
            && target.y > y)
            phase = 0;
    }
    else
        phase = 0;
}
else
{
    image_speed = 0;
}
#define Other_21
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
other.guardCancel = 3;
