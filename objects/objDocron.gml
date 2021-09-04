#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();

healthpointsStart = 1;
healthpoints = healthpointsStart;
contactDamage = 4;

category = "grounded";

facePlayerOnSpawn = true;

// Enemy specific code
image_speed = 0.2;

action = 2;
actionTimer = 0;
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();

if (entityCanStep())
{
    xSpeedTurnaround();

    if (action == 0)
    {
        if (yspeed == 0 && ground)
        {
            yspeed = -2;
            action += 1;
            ground = 0;
        }
    }
    if (action == 1)
    {
        if (yspeed == 0 && ground)
        {
            action += 1;
            sprite_index = sprDocron;
        }
    }

    if (!respawn)
    {
        actionTimer += 1;
        if (actionTimer >= 300)
        {
            instance_create(bboxGetXCenter(), bboxGetYCenter(), objExplosion);
            instance_destroy();
        }
    }

    xspeed = image_xscale * ground;
}
else if (dead)
{
    action = 0;
    image_index = 0;
}
