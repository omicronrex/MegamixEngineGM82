#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
// this mini boss requires additional objects to be placed in order for it to work. you must place objOctoGeneratorChildSpawner down, as this sets up where the enemies this mini boss
// spawns will enter the arena. if you don't place any, this mini boss will do nothing!!!
// Creation code (all optional):

/*
// childObject[number] = objType - change the type of object(s) that Octo generator spawns.
    Add additional types of objects to the array via the creation code,
    so you can add an object via an additional entry to the array such as childObject[1] = otherObject;
    Be careful, not every object type works, and obviously certain control objects being spawned will crash the game, so be sure to test this out!
*/
// enemiesOnScreen = <number> - // The amount of enemies that Octo generator can have on screen at once.
// initalSpawn = <number> // how many enemies will spawn as the mini boss does.
// enemiesToDefeat = <number> // if not -1, this many enemies must be defeated in order to defeat this mini boss. use with the creation code variable below to force the player to do this.
// variant = 1; // if 1, octo generator will spawn as proto generator, and be immune to all weapons.

event_inherited();
respawn = true;
doesIntro = true;
introSprite = sprOctoGeneratorTeleport;
healthpointsStart = 20;
healthpoints = healthpointsStart;
contactDamage = 6;
blockCollision = 0;
category = "nature";
grav = 0;
facePlayerOnSpawn = false;

despawnRange = -1;

// Enemy specific code
image_speed = 0;
image_index = 0;
phase = 0;
attackTimer = -128;
attackTimerMax = 128;
animTimer = 0;
shotsFired = 0;

childStore[0] = noone;
numA = 0;
numCur = 0;
init = false;
enemiesDefeated = 0;

// creation code variables
childObject[0] = objFatool;
enemiesOnScreen = 2;
initalSpawn = 1;
enemiesToDefeat = -1;
variant = 0;
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if (!init)
{
    init = true;
    attackTimer = -(attackTimerMax + 16);
    if (variant != 0)
    {
        sprite_index = sprProtoGenerator;
        introSprite = sprProtoGeneratorTeleport;
    }
    for (var i = 0; i < enemiesOnScreen; i++)
    {
        childStore[i] = noone;
    }
}
event_inherited();
if (entityCanStep())
{
    if (initalSpawn > 0 && attackTimer >= 0)
    {
        for (var j = 0; j < initalSpawn; j++)
        {
            event_user(2);
            numCur++;
        }
        initalSpawn = 0;
        animTimer = 32;
    }

    numA = 0;
    for (var i = 0; i < array_length_1d(childStore); i++)
    {
        if (instance_exists(childStore[i]))
        {
            numA++;
        }
        else
        {
            numCur = i;
            break;
        }
    }
    if (numA < enemiesOnScreen)
    {
        attackTimer++;
        if (attackTimer == attackTimerMax - 32)
        {
            animTimer = 32;
        }
        if (attackTimer >= attackTimerMax)
        {
            event_user(2);
            attackTimer = 0;
        }
    }
    else
    {
        attackTimer = 0;
    }

    if (animTimer > 0)
    {
        animTimer--;
    }

    switch (animTimer)
    {
        case 31:
        case 32:
            image_index = 1;
            break;
        case 24:
            image_index = 2;
            break;
        case 16:
            image_index = 3;
            break;
        case 8:
            image_index = 4;
            break;
        case 0:
            image_index = 0;
            break;
    }


    if (enemiesDefeated >= enemiesToDefeat && enemiesToDefeat > -1)
    {
        event_user(EV_DEATH);
    }
}
else if (!insideView())
{
    image_index = 0;
    y = ystart;
    x = xstart;
    animTimer = 0;
    attackTimer = 0;
    phase = 0;
    initalSpawn = false;
}
#define Collision_prtPlayerProjectile
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if (variant == 0)
{
    if (!other.canHit)
    {
        other.canHit = false;
        other.canDamage = true;
    }
}

event_inherited();
#define Other_12
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=605
invert=0
arg0=spawnEnemy
*/
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
var obj = noone;  //Clear initial closest object
var disM = 999999; //Maximum distance to check
if (initalSpawn > 0)
{
    var offset = 0;
    if (instance_exists(target))
    {
        offset = x - target.x;
    }
    with (objOctoGeneratorChildSpawnLocation)
    {
        if (!spawned)
        {

            var dis = point_distance(x - 8 * sign(offset), y, other.x, other.y);
            if (dis < disM)
            {
                obj = id;
                disM = dis;
            }
        }
    }
}
else
{
    with (objOctoGeneratorChildSpawnLocation)
    {
        if (!spawned)
        {
            var dis = point_distance(x, y, other.x-(view_wview/2)+irandom(view_wview), other.y);
            if (dis < disM)
            {
                obj = id;
                disM = dis;
            }
        }
    }
}
var currentObj = shotsFired mod array_length_1d(childObject);
var currentEnemy = numCur;
with (obj)
{
    if (!spawned)
    {
        var inst = instance_create(x,view_yview-16,objOctoGeneratorChild);
        inst.child = other.childObject[currentObj];
        inst.parent = other.id;
        inst.spawner = id;
        inst.maxY = y;
        inst.num = currentEnemy;
        other.childStore[currentEnemy] = inst.id;
        with (inst)
        {
            calibrateDirection(objMegaman);
        }
        spawned = true;
        child = inst.id;;
    }
}


shotsFired ++;
//@noformat: it's unclear why, but the beautifier trips up on this
#define Other_20
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();
for (var i = 0; i < array_length_1d(childStore); i++)
{
    if (instance_exists(childStore[i]))
    {
        with (childStore[i])
            event_user(EV_DEATH);
    }
}
#define Other_21
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if (variant == 1)
{
    other.guardCancel = 3;
}
#define Draw_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();
if (variant == 1 && !dead && introTimer == 0)
{
    draw_set_colour(c_white);
    if (enemiesToDefeat - enemiesDefeated <= 9)
    {
        draw_text(x - 7, y - 8, 0);
        draw_text(x + 1, y - 8, max(0, enemiesToDefeat - enemiesDefeated));
    }
    else
    {
        draw_text(x - 7, y - 8, max(0, enemiesToDefeat - enemiesDefeated));
    }
}
