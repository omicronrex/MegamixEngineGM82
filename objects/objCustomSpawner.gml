#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
/// Custom Spawners are very versatile. They can be set to spawn virtually anything, and with strange use, can even
// just be used as objects that execute a script every frame. Their purpose should be fairly self explanatory.


despawnRange = -1;

event_inherited();

respawn = true;

healthpointsStart = 1;
healthpoints = healthpointsStart;
contactDamage = 0;

blockCollision = 0;
grav = 0;

// Enemy specific code

//@cc The object to spawn.
object = objLifeEnergyBig;

//@cc How long until the spawner starts spawning objects normally.
startWait = 0;

//@cc The wait time between each object spawn.
spawnWait = 480;
timer = 0;

//@cc The limit to how many of the object the spawner can spawn. 0 = infinite (default: 0)
limit = 0;

//@cc whether to only count objects this spawner created for the limit. (default: false)
countOwn = false;

//@cc The Game Maker script to execute within the object. If you put, say, xspeed = -3 in your script called scrMySpawner,
// and the object is set to objEnemyBullet, then the spawner will create a bullet moving left. (This is an alternative to the code variable above,
// and is more reliable since GML code execution from a string is not fully-featured.)
script = scrNoEffect;

//@cc string containing GML code to execute. If you put, say, code = "xspeed = -3" and the object is set to objEnemyBullet,
// then the spawner will create a bullet moving left.
code = "";

//@cc object should be shifted horizontally to the nearest screen left/right edge when it is created?
shiftEdgeHorizontal = false;

//@cc object should be shifted vertically to the nearest screen top/bottom edge when it is created?
shiftEdgeVertical = false;

// size of the spawned object list
spawnN = 0;

// number of spawned objects still alive
spawnedCount = 0;

alarm[0] = 1;

canHit = false;
image_speed = 0;
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();

if (entityCanStep())
{
    timer -= 1;

    // if counting own spawns, check if any have died:
    if (countOwn)
    {
        var atEnd; atEnd = true;
        var i; for ( i = spawnN - 1; i >= 0; i-=1)
        {
            if (atEnd && spawnList[i] == noone)
            {
                spawnN-=1;
            }
            else
            {
                if (!instance_exists(spawnList[i]))
                {
                    spawnList[i] = noone;
                    if (atEnd)
                        spawnN-=1;
                    spawnedCount-=1;
                }
                else
                    atEnd = false;
            }
        }
    }

    // attempt to spawn an object:
    if (timer <= 0)
    {
        // reset timer
        timer = spawnWait;

        // determine if constraints allow us to spawn an object:
        var allowSpawn; allowSpawn = false;
        if (limit == 0)
            allowSpawn = true;
        else if (!countOwn && instance_number(object) < limit)
            allowSpawn = true;
        else if (countOwn && spawnedCount < limit)
            allowSpawn = true;
        if (allowSpawn)
        {
            // spawn the object:
            var obj; obj = instance_create(x + 8, y + 8, object);

            // keep tally if counting own:
            if (countOwn)
            {
                spawnList[spawnN] = obj; spawnN+=1
                spawnedCount+=1;
            }

            // setup spawned object by running custom code:
            with (obj)
            {
                // shift horizontally/vertically if necessary:
                if (other.shiftEdgeHorizontal)
                {
                    x = arrayNearest(
                        makeArray(view_xview[0] - (bbox_right - x) + 1,
                        view_xview[0] + view_wview[0] + (x - bbox_left) - 1),
                        x);
                }
                if (other.shiftEdgeVertical)
                {
                    y = arrayNearest(
                        makeArray(view_yview[0] - (bbox_bottom - y) + 1,
                        view_yview[0] + view_hview[0] + (y - bbox_top) - 1),
                        y);
                }

                // setup
                respawn = false;
                script_execute(other.script);
                if (other.code != "")
                    stringExecutePartial(other.code);
            }
        }
    }
}
else if (dead)
{
    timer = startWait;
}
#define Other_4
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
/// Initialize timer
timer = startWait;
#define Draw_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=605
invert=0
arg0=
*/
