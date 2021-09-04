#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
// Creation code (all optional):
// attackTimerMax = <number> how long DocBaton moves for. default is 70.
// attackTimerMax2 = <number> how long DocBaton waits for. this should be how long you want it to wait for plus the above number, default is 115 (45);
// spd = <number> how fast Docbaton moves. default is 0.5;
event_inherited();
respawn = true;
healthpointsStart = 2;
healthpoints = healthpointsStart;
category = "flying, nature, cluster";
contactDamage = 2;
blockCollision = 0;
grav = 0;

// Enemy specific code
imageOffset = 0;
lastLocationX = 0;
lastLocationY = 0;
attackTimer = 0;
attackTimerMax = 70;
attackTimerMax2 = 115;
spd = 0.5;
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();
if (entityCanStep())
{
    if (instance_exists(target)) // look for target to chase.
    {
        lastLocationX = target.x;
        lastLocationY = target.y;
    }
    attackTimer += 1;

    // as long as docbaton can move, do so and animate.
    if (attackTimer < attackTimerMax)
    {
        mp_linear_step(lastLocationX, lastLocationY, spd, false);
        image_index += 0.125;
    }
    else // otherwise stop animating. (this isn't true to the wonderswan games but looked kinda silly.)
        image_index = 1;
    if (attackTimer >= attackTimerMax2) // when docbaton has waited long enough, resume moving.
        attackTimer = 0;
}
