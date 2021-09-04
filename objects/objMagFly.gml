#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
/// Flying magnets that pull Mega Man up and carry him
event_inherited();

healthpointsStart = 1;
healthpoints = healthpointsStart;
contactDamage = 4;

category = "flying";

blockCollision = 0;
grav = 0;

facePlayerOnSpawn = true;

// Enemy specific code
airControlSpeed = 1 / 8; // speed at which player can move up and down on their own
image_speed = 0.2;

tugDist[global.playerCount] = 0;
tugSpeed[global.playerCount] = 0;
tugLock[global.playerCount] = 0;
tugDefer[global.playerCount] = 0;
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();

tugDist[global.playerCount] = 0;
tugSpeed[global.playerCount] = 0;
tugLock[global.playerCount] = 0;
tugDefer[global.playerCount] = 0;

var myID; myID = id;

var canStep; canStep = entityCanStep();
if (canStep)
    image_speed = 0.2;
else
    image_speed = 0;
with (objMegaman)
{
    if (canStep)
    {
        // check if other magfly has lock?
        var otherLock; otherLock = false;
        with (objMagFly)
        {
            if (tugLock[other.playerID] && id != myID)
            {
                otherLock = true;
            }
        }

        // pull mega man if possible
        if (iFrames == 0 && !teleporting && !showReady && !isSlide && !hitLock && !otherLock && !climbing)
        {
            if (x > other.x - 16 && x < other.x + 16
                && y > other.y + 18 && y < other.y + view_hview[0])
            {
                if (!other.tugLock[playerID])
                {
                    other.tugLock[playerID] = lockPoolLock(localPlayerLock[PL_LOCK_GRAVITY]);

                    // ensure lock eventually released
                    other.tugDefer[playerID] = defer(ev_destroy, EV_DEATH, -10000000, lockPoolRelease, makeArray(other.tugLock[playerID]));
                }

                // apply force to mega man
                if (other.tugDist[playerID] >= 0)
                {
                    shiftObject(other.xspeed, 0, true);
                }

                // yspeed acceleration (vertical tug)
                yspeed = 0;
                if (other.tugDist[playerID] < 0)
                {
                    shiftObject(0, -other.tugSpeed[playerID], true);
                    other.tugDist[playerID] += other.tugSpeed[playerID];
                    if (other.tugSpeed[playerID] < 5)
                        other.tugSpeed[playerID] += 0.25;
                }

                // moving up and down
                if (!playerIsLocked(PL_LOCK_AERIAL))
                {
                    shiftObject(0, -global.keyUp[playerID] * other.airControlSpeed + global.keyDown[playerID] * other.airControlSpeed, true);
                }

                // air-jumping
                if (!playerIsLocked(PL_LOCK_JUMP))
                {
                    if (global.keyJumpPressed[playerID])
                    {
                        other.tugDist[playerID] = -32;
                    }
                }

                // ground fix
                repeat (10)
                {
                    if (ground && other.tugSpeed > 3)
                    {
                        shiftObject(0, -0.1, true);
                        checkGround();
                    }
                }
                continue;
            }
        }
    }

    // unlock
    other.tugLock[playerID] = lockPoolRelease(other.tugLock[playerID]);
    if (other.tugDefer[playerID] > 0)
        with (other.tugDefer[playerID])
            instance_destroy();
    other.tugDist[playerID] = -30.5;
    other.tugSpeed[playerID] = 0;
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
    if (x < view_xview[0] + view_wview[0] / 2)
        image_xscale = 1;
    else
        image_xscale = -1;
    xspeed = 1 * image_xscale;
}
