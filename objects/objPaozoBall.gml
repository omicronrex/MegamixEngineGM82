#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
// Creation code (all optional):

event_inherited();

respawn = false;

healthpointsStart = 15;
healthpoints = healthpointsStart;
contactDamage = 4;

isTargetable = false;

grav = 0;
blockCollision = false;

// Enemy specific code
image_speed = 0;
parent = noone;
canBounce = false;
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();

if (entityCanStep())
{
    if (instance_exists(parent))
    {
        if (parent.dead)
        {
            instance_create(x, y, objBigExplosion);
            instance_destroy();
            exit;
        }
    }
    else
    {
        instance_destroy();
        exit;
    }

    if (x < view_xview[0] + 16 || x > view_xview[0] + view_wview[0] - 16)
        xspeed = 0;

    if (ground && canBounce)
    {
        yspeed = -5;
        canBounce = false;
    }
}
else if (!insideView())
{
    image_index = 0;
}
#define Other_21
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
other.guardCancel = 3;
