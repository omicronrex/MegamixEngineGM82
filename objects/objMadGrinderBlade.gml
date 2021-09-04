#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();

respawn = false;

healthpointsStart = 999;
healthpoints = healthpointsStart;
contactDamage = 0;

isTargetable = false;


facePlayerOnSpawn = true;
blockCollision = true;

// Enemy specific code
xspeed = 0;
yspeed = -3;

image_speed = 0;
image_index = 0;
grav = 0.15;
spd = 1.25;

parent = noone;
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();

if (entityCanStep())
{
    if (!place_meeting(x, y, objMadGrinder))
    {
        contactDamage = 4;
    }
    else
    {
        contactDamage = 0;
    }

    image_index += 0.5;


    if (blockCollision)
    {
        xspeed = spd * image_xscale;
        if (ground)
        {
            spd += 0.125;
        }
    }


    if (blockCollision && (xcoll != 0 || x <= view_xview || x >= view_xview + view_wview))
    {
        image_xscale *= -1;
        yspeed = -6;
        blockCollision = false;
        xspeed = xSpeedAim(x, y, parent.x + 16 * parent.image_xscale, parent.y - 24, yspeed);
    }

    if (place_meeting(x, y, parent) && !blockCollision)
    {
        parent.hasCutter = true;
        instance_destroy();
    }
}
else if (dead)
{
    xspeed = 0;
    yspeed = 0;
    image_index = 0;
}
#define Other_20
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
instance_create(x, y, objExplosion);
instance_destroy();
#define Other_21
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
other.guardCancel = 3;
