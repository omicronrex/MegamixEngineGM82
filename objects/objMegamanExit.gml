#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();

despawn = false;

type = 1;

timer = 0;
drawMe = 1;

pid = 0;
cid = 0;

myRoom = -1;
X = -1;
Y = -1;
newStage = false;
returnToHub = true;
isExternal = false;
externalRoomFilename = "";

teleportLock = -1;

if (global.teleportSound)
{
    warpOutSFX = sfxTeleportOutClassic;
}
else
{
    warpOutSFX = sfxTeleportOut;
}
#define Other_10
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
instance_destroy();

if (((isExternal&&externalRoomFilename=="")||(!isExternal && myRoom <= 0)) && !returnToHub)
{
    global.frozen = false;

    with (objMegaman)
    {
        x = other.X;
        y = other.Y;

        xspeed = 0;
        yspeed = 0;

        iFrames = 0;
        isSlide = false;
        mask_index = mskMegaman;
        slideTimer = 0;
        isShoot = false;

        visible = 1;

        setSection(x, y, 1);
        playerCamera(1);
        reAndDeactivateObjects(1, 1);

        if (other.type < 3)
        {
            teleporting = 1;
            teleportTimer = 0;
            landy = y;

            teleportLock = lockPoolLock(
                localPlayerLock[PL_LOCK_MOVE],
                localPlayerLock[PL_LOCK_PHYSICS],
                localPlayerLock[PL_LOCK_SHOOT],
                localPlayerLock[PL_LOCK_CLIMB],
                localPlayerLock[PL_LOCK_CHARGE],
                localPlayerLock[PL_LOCK_PAUSE],
                localPlayerLock[PL_LOCK_TURN],
                localPlayerLock[PL_LOCK_GRAVITY],
                localPlayerLock[PL_LOCK_SLIDE],
                );
        }
    }
}
else
{
    if (newStage)
    {
        // begin new a stage
        assert((myRoom != -1 || (isExternal&&(externalRoomFilename!=""))), "mega man exit set to go to a new stage but didn't set the room.");

        goToLevel(myRoom, true);
    }
    else if (myRoom != -1 || (isExternal&&(externalRoomFilename!="")))
    {
        // do not start new level -=1 just teleport
        global.hasTeleported = 1;
        global.teleportX = X;
        global.teleportY = Y;

        global.nextRoom = myRoom;
    }
    else if (returnToHub)
    {
        returnFromLevel();
    }
}
#define Draw_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
timer += 1;

var t; t = floor(timer * 0.3);

if (type < 3)
{
    var ximg; ximg = 10;
    var yimg; yimg = 8;

    switch (floor(t))
    {
        case 0:
            ximg += 2;
            break;
        case 1:
            ximg += 0;
            if (!audio_is_playing(warpOutSFX))
            {
                playSFX(warpOutSFX);
            }
            break;
        case 2:
            ximg += 1;
            break;
        case 4:
            if (type == 1)
            {
                vspeed = -8;
            }
            else
            {
                drawMe = 0;
            }
            break;
    }
}
else
{
    var ximg; ximg = 0 + min(4, t);
    var yimg; yimg = 11;

    if (t == 0)
    {
        if (!audio_is_playing(sfxDoorEnter))
        {
            playSFX(sfxDoorEnter);
        }
    }
}

if (t == 9)
{
    event_user(0);
}

if (drawMe)
{
    drawPlayer(pid, cid, ximg, yimg, x, y, image_xscale, image_yscale);
}

// stop moving pls
with objMegaman
{
    xspeed = 0;
    yspeed = 0;
}
