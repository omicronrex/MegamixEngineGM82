#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();

respawn = true;

healthpointsStart = 3;
healthpoints = healthpointsStart;
contactDamage = 3;

facePlayerOnSpawn = true;

// Enemy specific code
moveTimer = 0;
directionStore = 0;

image_speed = 0.125;

moveDist = 64;

spawnHead = true;
spawnHeadReset = spawnHead;
init = 1;
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if (init)
{
    init = 0;
    spawnHeadReset = spawnHead;
}

event_inherited();

if (entityCanStep())
{
    xSpeedTurnaround();

    if (xspeed == 0 && yspeed == 0)
    {
        xspeed = 1 * image_xscale;
    }

    // turn round
    moveTimer += 1;
    if (moveTimer >= moveDist)
    {
        xspeed = -xspeed;
        image_xscale = -image_xscale;
        directionStore = image_xscale;
        moveTimer = 0;
    }

    // if direction is different to direction store, reset move timer.
    if (image_xscale != directionStore)
    {
        directionStore = image_xscale;
        moveTimer = 0;
    }

    // if it walks off an edge, turn round.
    if (!ground)
    {
        xspeed = -xspeed;
        x += xspeed * 2;
        image_xscale = -image_xscale;
        directionStore = image_xscale;
        moveTimer = 0;
    }

    // spawn head
    if (spawnHead)
    {
        var inst;
        var headID;
        headID = id;
        inst = instance_create(x, y - 32, objPukapucker_Top);
        with (inst)
        {
            // attached head default values.
            respawn = false;
            bodyInstanceStore = headID;
        }
        spawnHead = false;
    }
}
else if (dead)
{
    xspeed = 0;
    yspeed = 0;
    image_index = 0;
    directionStore = image_xscale;
    moveTimer = 0;
    spawnHead = spawnHeadReset;
}
