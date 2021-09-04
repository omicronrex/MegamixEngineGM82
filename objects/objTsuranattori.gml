#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
// Creation code (all optional):
// extraBirds = 1; - creates additional birds behind the starting bird

event_inherited();

healthpointsStart = 1;
healthpoints = healthpointsStart;
contactDamage = 2;
respawnRange=0;
despawnRange=16;

category = "flying, bird, cluster";

blockCollision = 0;
grav = 0;

// Enemy specific code
init = 1;
extraBirds = 0;
resetExtraBirds = extraBirds;

// movement variables
xSpeed = 0;
ySpeed = 0;
moveSpeedX = 2;
moveSpeedY = 1.25;

// animation variables
turningFrames = 0;
dir = 0;

// AI variables
radius = 16;
aiTurn = 0;
turnDelay = 200;
delayMove = 2;

// follower bird variables
birdInstanceStore = instance_id;
extraBirdTurn = y + 200;
delayOriginalBird = 0;
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if (init)
{
    resetExtraBirds = extraBirds;
    init = 0;
}

event_inherited();

if (entityCanStep())
{
    // set image scale based on speed
    image_xscale = sign(xspeed);

    // set sprite animation.
    if (image_index < 2.5 && turningFrames <= 0)
    {
        image_index += 0.25;
    }
    else if (image_index >= 2.5 && turningFrames <= 0)
    {
        image_index = 0;
    }
    else
    {
        image_index = 3;
        turningFrames -= 1;
    }

    // round position
    x = ceil(x);
    y = ceil(y);

    // start turn.
    if (delayMove > 0)
    {
        delayMove -= 1;
        visible = 0;
        canHit = false;

        // stay in place
        x -= xspeed;

        if (dir == -1)
        {
            x += (view_xview[0] + view_wview[0]) - bbox_left;
        }
        else
        {
            x += view_xview[0] - bbox_right;
        }
    }
    else
    {
        // reset if it's Time.
        if (!visible)
        {
            visible = true;
            canHit = true;
        }

        // actual AI
        if (instance_exists(target))
        {
            if (abs(target.x - x) <= radius && aiTurn == 0)
            {
                aiTurn = 1;
            }

            if (aiTurn == 1)
            {
                turnDelay -= 1;

                // whilst turned round, the first bird turns back if any of the following are true
                if (turnDelay <= 0 && respawn == 1
                    || abs((target.y + 8) - y) <= 3 && respawn == 1
                    || abs((target.x) - x) >= 108 && respawn == 1)
                {
                    aiTurn = 2;
                    yspeed = 0;

                    // loop through and set follower birds to have a turning y of where the first bird turned.
                    var birdID;
                    birdID = id;
                    var birdTurn;
                    birdTurn = y;
                    with (objTsuranattori)
                    {
                        if (birdInstanceStore == birdID && respawn == 0)
                            extraBirdTurn = birdTurn;
                    }
                }

                // whilst turned round, the follower bird turns back when it reaches the determined y co-ordinate.
                if (y >= extraBirdTurn && respawn == 0)
                {
                    aiTurn = 2;
                    yspeed = 0;
                }
            }
        }
    }

    // set movement speed whilst turned round.
    if (xspeed != (moveSpeedX * -dir) * 0.75 && aiTurn == 1)
    {
        xspeed += 0.5 * -dir;
        turningFrames = 3;
        yspeed = moveSpeedY;
    }

    // set movement speed whilst turning back.
    if (xspeed != moveSpeedX * dir && aiTurn == 2)
    {
        xspeed += 0.5 * dir;
        turningFrames = 3;
    }

    // if any follower birds are still in existance, delay original bird
    if (!respawn)
    {
        var birdID;
        birdID = birdInstanceStore;
        with (objTsuranattori)
        {
            if (id == birdID && respawn)
            {
                delayOriginalBird = 3;
            }
        }
    }
}

// whilst delay original bird is in existance, stop original bird from respawning.
if (delayOriginalBird > 0)
{
    delayOriginalBird -= 1;
    beenOutsideView = false;
}

// reset default values whilst ded.
if (dead && respawn)
{
    extraBirds = resetExtraBirds;
    delayMove = 2;
}
#define Other_20
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();

// if the front bird is shot and killed, then cause all follower birds to make a beeline and sod off.
if (respawn)
{
    var birdID;
    birdID = id;
    with (objTsuranattori)
    {
        if (birdInstanceStore == birdID && respawn == 0)
        {
            aiTurn = 2;
            yspeed = 0;
            xspeed = moveSpeedX * dir;
        }
    }
}
#define Other_25
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();

if (spawned)
{
    // reset variables
    turningFrames = 0;
    dir = 1;
    aiTurn = 0;
    turnDelay = 200;

    // determine initial direction
    if (instance_exists(target))
    {
        if (target.x < x)
        {
            x += (view_xview[0] + view_wview[0]) - bbox_left;
            dir = -1;
        }
        else
        {
            x += view_xview[0] - bbox_right;
            dir = 1;
        }
    }

    xspeed = moveSpeedX * dir;

    // spawn follower birds.
    if (extraBirds > 0)
    {
        var i;
        for (i = 0; i < extraBirds; i += 1)
        {
            var inst;
            var birdID;
            birdID = id;
            inst = instance_create(x + (dir * 2), y, objTsuranattori);
            with (inst)
            {
                // follower bird default values.
                respawn = false;
                birdInstanceStore = birdID;
                delayMove = 16 * (i + 1);
                despawnRange=16*(i+1);
            }
        }

        extraBirds = 0;
    }
}
