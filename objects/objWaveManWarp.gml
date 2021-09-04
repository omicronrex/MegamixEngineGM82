#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
dir = "Right";
spd = 4;

xspeed = 0;
yspeed = 0;

playSFX(sfxWaveManPipe);

global.waveManWarpLock = false;
#define Step_2
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if (dir == "Right")
{
    xspeed = spd;
    yspeed = 0;
    if (instance_place(x, y, objWaveManWarpUp))
    {
        warp = instance_place(x, y, objWaveManWarpUp);
        if (x > warp.x + 8 && warp.object_index == objWaveManWarpUp)
        {
            x = warp.x + 8;
            dir = warp.dir;
            xspeed = 0;
            yspeed = 0;
            playSFX(sfxWaveManPipe);
        }
    }
    else if (instance_place(x, y, objWaveManWarpDown))
    {
        warp = instance_place(x, y, objWaveManWarpDown);
        if (x > warp.x + 8 && warp.object_index == objWaveManWarpDown)
        {
            x = warp.x + 8;
            dir = warp.dir;
            xspeed = 0;
            yspeed = 0;
            playSFX(sfxWaveManPipe);
        }
    }
}
if (dir == "Left")
{
    xspeed = -spd;
    yspeed = 0;
    if (instance_place(x, y, objWaveManWarpUp))
    {
        warp = instance_place(x, y, objWaveManWarpUp);
        if (x > warp.x + 8 && warp.object_index == objWaveManWarpUp)
        {
            x = warp.x + 8;
            dir = warp.dir;
            xspeed = 0;
            yspeed = 0;
            playSFX(sfxWaveManPipe);
        }
    }
    else if (instance_place(x, y, objWaveManWarpDown))
    {
        warp = instance_place(x, y, objWaveManWarpDown);
        if (x > warp.x + 8 && warp.object_index == objWaveManWarpDown)
        {
            x = warp.x + 8;
            dir = warp.dir;
            xspeed = 0;
            yspeed = 0;
            playSFX(sfxWaveManPipe);
        }
    }
}
if (dir == "Up")
{
    yspeed = -spd;
    xspeed = 0;
    if (instance_place(x, y, objWaveManWarpRight))
    {
        warp = instance_place(x, y, objWaveManWarpRight);
        if (y > warp.y && warp.object_index == objWaveManWarpRight)
        {
            y = warp.y;
            dir = warp.dir;
            xspeed = 0;
            yspeed = 0;
            playSFX(sfxWaveManPipe);
        }
    }
    else if (instance_place(x, y, objWaveManWarpLeft))
    {
        warp = instance_place(x, y, objWaveManWarpLeft);
        if (y > warp.y && warp.object_index == objWaveManWarpLeft)
        {
            y = warp.y;
            dir = warp.dir;
            xspeed = 0;
            yspeed = 0;
            playSFX(sfxWaveManPipe);
        }
    }
}
if (dir == "Down")
{
    yspeed = spd;
    xspeed = 0;
    if (instance_place(x, y, objWaveManWarpRight))
    {
        warp = instance_place(x, y, objWaveManWarpRight);
        if (y > warp.y && warp.object_index == objWaveManWarpRight)
        {
            y = warp.y;
            dir = warp.dir;
            xspeed = 0;
            yspeed = 0;
            playSFX(sfxWaveManPipe);
        }
    }
    else if (instance_place(x, y, objWaveManWarpLeft))
    {
        warp = instance_place(x, y, objWaveManWarpLeft);
        if (y > warp.y && warp.object_index == objWaveManWarpLeft)
        {
            y = warp.y;
            dir = warp.dir;
            xspeed = 0;
            yspeed = 0;
            playSFX(sfxWaveManPipe);
        }
    }
}

if (!global.frozen)
{
    x += xspeed;
    y += yspeed;
}

if (instance_exists(objMegaman))
{
    if (!global.waveManWarpLock)
        global.waveManWarpLock = lockPoolLock(
            global.playerLock[PL_LOCK_MOVE],
            global.playerLock[PL_LOCK_TURN],
            global.playerLock[PL_LOCK_SHOOT]);

    with (objMegaman)
    {
        if !instance_exists(objSectionSwitcher)
        {
            x = other.x;
            y = other.y + 4;
            xspeed = 0;
            yspeed = 0;
            blockCollision = false;
        }

        spriteX = 7;
    }
}
if (instance_exists(objSectionSwitcher))
{
    x = objSectionSwitcher.x;
    y = objSectionSwitcher.y - 2;
}
if (instance_exists(objMegaman))
{
    if (place_meeting(x, y, objWaveManWarpStop)
        && !place_meeting(x, y, objSolid))
    {
        with (objMegaman)
        {
            xspeed = other.xspeed;
            yspeed = other.yspeed;
            blockCollision = true;
        }
        global.waveManWarpLock = lockPoolRelease(
            global
            .waveManWarpLock);
        instance_destroy();
    }
}
