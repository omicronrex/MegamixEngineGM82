#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();
faction = 0;
canHit = false;
respawn = false;
despawnRange = -1;
respawnRange = -1;
bubbleTimer = -1;
canDamage = false;
isSolid = 2;
doesTransition = false;
grav = 0;
blockCollision = false;

parent = noone;
moveTimer = 0;
moveSpeed = 0.2;
moveAmount = 1;
yspeed = moveAmount;
range = 8;
gravDir = 1;
#define Destroy_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if (instance_exists(parent))
    parent.segmentCount -= 1;
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
xprevious = x;
yprevious = y;

x += xspeed;
y += yspeed;
entityPlatform();
yspeed = 0;
var hasParent; hasParent = instance_exists(parent);
if (!hasParent || (hasParent && parent.dead))
{
    instance_destroy();
    exit;
}
if (entityCanStep())
{
    if (instance_exists(objMegaman))
    {
        var prevGrav; prevGrav = gravDir;
        gravDir = objMegaman.gravDir;
        if (prevGrav != gravDir)
        {
            instance_destroy();
            exit;
        }
    }
    if (moveTimer >= 1)
    {
        moveTimer = 0;
        yspeed = moveAmount * gravDir;
    }
    else
    {
        moveTimer += moveSpeed;
    }

    if (hasParent)
    {
        var origin; origin = parent.y;
        if (gravDir == -1)
            origin = parent.y + 16;
        if (abs(y - origin) > range)
            y = origin;
    }
}
#define Draw_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
/*
///Debug
var color; color = draw_get_color();
draw_rectangle(x,y,x-1+image_xscale*16,y,0);
color=draw_get_color();
*/
exit;
