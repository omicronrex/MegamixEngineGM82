#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
// creation code (all optional)
// cAngle = <number>; // the angle the clock arm starts off at.
// length = <number>; // the number of pieces this arm is made of.
// attackTimerMax = <number>; // the amount of time it takes to rotate
// addAngle = <number>; // the angle added as it spins, you can use this to make it smoother or reverse direction.

event_inherited();

healthpointsStart = 1;
healthpoints = healthpointsStart;
contactDamage = 4;

canHit = false;

grav = 0;
bubbleTimer = -1;
cDistance = 0;
pieceGap = 24;
despawnRange = -1;
active = true;
attackTimer = 0;
destroyTimer = 2;
triggerDestroy = -1;
dieToSpikes = false;

hasSpawned = false;

// creation code variables
cAngle = 90;
attackTimerMax = 32;
length = 6;
addAngle = 22.5;
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();
if (entityCanStep())
{
    if (length > 0 && !hasSpawned)
    {
        var i; for ( i = 1; i < length; i+=1)
        {
            var inst; inst = instance_create(x, y, object_index);
            inst.length = 0;
            inst.cDistance = pieceGap * i;
            inst.cAngle = cAngle;
            inst.destroyTimer = 18 + (16 * i);
            inst.attackTimerMax = attackTimerMax;
            inst.addAngle = addAngle;
            inst.respawn = false;
        }
        hasSpawned = true;
        with (object_index)
        {
            attackTimer = 1;
        }
    }

    x = xstart + round(cos(degtorad(cAngle)) * cDistance);
    y = ystart + round(sin(degtorad(cAngle)) * cDistance);

    attackTimer+=1;

    if (triggerDestroy > 0)
    {
        triggerDestroy-=1;
    }

    if (attackTimer == attackTimerMax)
    {
        cAngle += addAngle;
        attackTimer = 1;
    }

    if (destroyTimer < -1 && triggerDestroy == 0)
    {
        destroyTimer+=1;
        attackTimerMax = 9999;
    }
    if (destroyTimer == -1)
    {
        destroyTimer = 0;
        instance_create(x, y, objExplosion);
        dead = true;
        playSFX(sfxEnemyHit);
    }
}
if (dead)
{
    attackTimer = 0;
    destroyTimer = 0;
    hasSpawned = false;
}
