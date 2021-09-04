#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();

yspeed = 0;
xspeed = 0;
grav = -0.1;

panicTimer = 0;

objectCopy = noone;
#define Destroy_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
/// Delete copy
if (objectCopy != noone)
{
    instance_activate_object(objectCopy);

    if (instance_exists(objectCopy))
    {
        with (objectCopy)
        {
            instance_destroy();
        }
    }

    objectCopy = noone;
}
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if (!global.frozen)
{
    x += xspeed;
    y += yspeed;
    yspeed += grav;

    if (yspeed < -5)
    {
        yspeed = -5;
    }

    if (sprite_xoffset != 0)
    {
        panicTimer += 1;
        if (panicTimer == 20)
        {
            panicTimer = 0;
            image_xscale = -image_xscale;
        }
    }

    // prevent random item drops
    if (instance_place(x, y, objExplosion))
    {
        with (instance_place(x, y, objExplosion))
        {
            if (myItem <= 0)
            {
                instance_destroy();
                visible = 0;
            }
        }
    }
}
#define Draw_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
/// Draw copy

instance_activate_object(objectCopy);

objectCopy.x = x;
objectCopy.y = y;
objectCopy.image_xscale = image_xscale;
objectCopy.dead = false;
objectCopy.healthpoints = 1;

with (objectCopy)
{
    event_perform(ev_draw, 0);
}

instance_deactivate_object(objectCopy);
