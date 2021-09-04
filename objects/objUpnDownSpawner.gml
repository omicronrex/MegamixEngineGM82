#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
// col = 0 = red, 1 = blue
event_inherited();

healthpointsStart = 1;
healthpoints = healthpointsStart;
contactDamage = 0;

blockCollision = 0;
grav = 0;

// Enemy specific code
cooldownTimer = 0;
col = 0;
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();

if (entityCanStep())
{
    if (cooldownTimer == 0)
    {
        if (instance_exists(target))
        {
            if (abs(target.x - x) < 32)
            {
                i = instance_create(x, y, objUpnDown);
                i.respawn = false;
                i.col = col;
                cooldownTimer = 120; // <-- cooldown time
            }
        }
    }
    else
    {
        cooldownTimer -= 1;
    }
}
else if (dead)
{
    cooldownTimer = 0;
}

visible = 0;
canHit = false;
