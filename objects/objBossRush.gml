#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
teleportX = 0;
teleportY = 0;

active = false;

inst = noone;
lockOn = false;
delay = 0;
hasBossSpawned = false;
bossesDefeated = 0;
clearedBossX[0] = -1;
clearedBossY[0] = -1;

myRoom = room;

// @cc how many bosses need to be defeated
bossesToDefeat = 8;

// @cc the x position of where to teleport to when all bosses are defeated
finalTeleportX = 0;

// @cc the y position of where to teleport to when all bosses are defeated
finalTeleportY = 0;
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if (instance_exists(prtBoss))
{
    hasBossSpawned = true;
    delay = 8;
}

delay-=1;


if (!instance_exists(prtBoss) && hasBossSpawned && !active)
{
    active = true;
    teleportX = global.lastTeleporterX;
    teleportY = global.lastTeleporterY;
}
if (active && !instance_exists(objLifeEnergyBig) && !instance_exists(prtBoss) && delay <= 0 && bossesDefeated < 9999)
{
    lockOn = true;
    clearedBossX[bossesDefeated] = teleportX;
    clearedBossY[bossesDefeated] = teleportY;
    bossesDefeated+=1;
    inst = instance_create(objMegaman.x, objMegaman.y, objTeleporter);
    with (inst)
    {
        if (other.bossesDefeated < other.bossesToDefeat)
        {
            X = other.teleportX;
            Y = other.teleportY;
        }
        if (other.bossesDefeated >= other.bossesToDefeat)
        {
            X = other.finalTeleportX;
            Y = other.finalTeleportY;
            other.bossesDefeated = 9999;
        }
        teleportOnce = true;
        light = -1;
    }
    active = false;
    hasBossSpawned = false;
}
if (!instance_exists(inst))
{
    lockOn = false;
}
if (lockOn)
{
    with (objMegaman)
    {
        var MMID; MMID = playerID;
    }
    inst.playerMet[MMID] = false;
    inst.x = objMegaman.x;
    inst.y = objMegaman.y;
}

if (room != myRoom)
{
    instance_destroy();
}
#define Other_4
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
/// destroy teleporters already cleared
if (bossesDefeated < 9999)
{
    var i; for ( i = 0; i < bossesDefeated; i+=1)
    {
        with (instance_place(clearedBossX[i], clearedBossY[i], objTeleporter))
        {
            instance_destroy();
        }
    }
}
#define Other_5
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
active = false;
hasBossSpawned = false;
#define Draw_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
//
