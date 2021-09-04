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
respawn = false;
healthpointsStart = 1;
healthpoints = healthpointsStart;
contactDamage = 3;
blockCollision = 0;
grav = 0;

// Enemy specific code
imageOffset = 0;
lastLocationX = 0;
lastLocationY = 0;
attackTimer = 0;
attackTimerMax = 64;
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
    image_index += 0.125;
    if (instance_exists(target)) // look for target to chase.
    {
        lastLocationX = target.x;
        lastLocationY = target.y;
    }
    attackTimer += 1;

    // as long as docbaton can move, do so and animate.
    if (attackTimer > attackTimerMax)
    {
        mp_linear_step(lastLocationX, lastLocationY, spd, false);
        xspeed = 0;
        yspeed = 0;
    }
}
#define Collision_objMegaman
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
with (other)
{
    // manual damage to player
    if (iFrames == 0 && canHit)
    {
        with (other)
        {
            entityEntityCollision();
        }
    }
}

if (contactDamage > 0)
{
    instance_destroy();
}
#define Other_20
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
dead = true;
instance_create(x, y, objExplosion);
