#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();

healthpointsStart = 1;
healthpoints = healthpointsStart;
contactDamage = 6;

category = "cluster, rocky";

bubbleTimer = -1;

// Enemy specific code
action = 0;
actionTimer = 0;

ground = 1;
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();

if (entityCanStep())
{
    if (action == 0)
    {
        if (yspeed == 0 && ground)
        {
            image_index += 1;
            action += 1;
            canHit = false;
        }
    }
    else
    {
        actionTimer += 1;
        if (actionTimer >= 6)
        {
            for (b = 0; b < 4; b += 1)
            {
                i = instance_create(x, y - 6, objDrillBoulderParticle);
                i.image_index = b;
                i.grav = 0.25;
                i.xspeed = irandom(10) * 0.1 * choose(1, -1);
                i.yspeed = -irandom(550) * 0.01;
            }
            dead = 1;
            visible = 0;
        }
    }
}
else if (dead)
{
    action = 0;
    actionTimer = 0;
    canHit = true;
    image_index = 0;
}
