#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();

healthpointsStart = 1;
healthpoints = healthpointsStart;

grav = 0;
blockCollision = 0;
bubbleTimer = -1;

// Enemy specific code
canHit = false;
canDamage = false;

actionTimer = 0;
delay = 120;

myBoulder = noone;
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();

if (entityCanStep())
{
    if (instance_exists(target))
    {
        actionTimer += 1;
        if (abs(target.x - x) < 32)
        {
            if (actionTimer >= delay && !instance_exists(myBoulder) && !instance_exists(objDrillBoulderParticle))
            {
                myBoulder = instance_create(x, y, objDrillBoulder);
                myBoulder.respawn = 0;
                actionTimer = 0;
            }
        }
        else
        {
            actionTimer = delay;
        }
    }
}
else if (dead)
{
    actionTimer = 0;
    myBoulder = noone;
}

visible = 0;
