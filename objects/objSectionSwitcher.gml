#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
global.frozen = true;
global.switchingSections = true;

with (objMegaman)
{
    viewPlayer = 1;
    visible = false;
}

dir = 'x';
num = 1;

mydoor = 0;
door = false;
plat = -1;
platx = 0;
platy = 0;
platv = 0;

darken = 0;
alpha = 0;
darksp = 1 / 16;

triggerPlayer = instance_nearest(x, y, objMegaman);


if (instance_exists(triggerPlayer))
{
    with (triggerPlayer)
    {
        visible = true;

        other.pxs = x;
        other.pys = y;

        other.mydoor = instance_place(x, y, prtBossDoor);
        if (other.mydoor)
        {
            playerSwitchSections();
        }
        if (plat)
        {
            other.plat = plat;
            other.platx = x - plat.x;
            other.platy = y - plat.y;
            other.platv = plat.shiftVisible;
            plat.shiftVisible = 2;
        }

        if (place_meeting(x, y, objFadeTransition))
        {
            other.darken = true;
        }
    }

    doorWait = 4;
    alarm[0] = 1;
}
else
{
    event_user(1);
}

reAndDeactivateObjects(0, 1);

activate = 1;
endit=0;

xvs = view_xview;
yvs = view_yview;

// Variables that can me modified to make switching sections faster/slower
screenSpeed = 4;
screenFixSpeed = 4;
borderDistance = 16;

// Variables that cannot be modified
canProgressDoor = false;
canStep = false;
#define Alarm_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if (door)
{
    alarm[1] = ceil(doorWait / 0.125);
}

canStep = true;
#define Alarm_1
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
canProgressDoor = true;
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
// Moving the screen and player

if (darken && (instance_exists(objMegaman)))
{
    with (objMegaman)
    {
        depth = -1500;
    }
}

if (!instance_exists(triggerPlayer))
{
    endit=1;
    global.switchingSections=false;
    reAndDeactivateObjects(1,0);
    global.switchingSections=true;
    exit;
}

if (canStep) // When the door is closing, we should not move
{
    if (!(door && !canProgressDoor))
    {
        var bor; bor = 0;
        var sp; sp = 0;

        if (dir == 'x') // Set variables for left and right
        {
            var mview; mview = view_xview;
            var sview; sview = view_yview;
            var whview; whview = view_wview;

            var lb; lb = (max(global.sectionTop + global.quadMarginTop, global.borderLockTop) - sview);
            var rb; rb = (min(global.sectionBottom - global.quadMarginBottom, global.borderLockBottom) - (sview + view_hview));
            var dis; dis = (round(triggerPlayer.y) - (sview + view_hview * 0.5));

            if (num == 1)
            {
                var pos; pos = max(global.sectionLeft, global.borderLockLeft);
            }
            else if (num == -1)
            {
                var pos; pos = min(global.sectionRight, global.borderLockRight) - whview;
            }
        }
        else if (dir == 'y') // Set variables for up and down
        {
            var mview; mview = view_yview;
            var sview; sview = view_xview;
            var whview; whview = view_hview;

            var lb; lb = (max(global.sectionLeft, global.borderLockLeft) - sview);
            var rb; rb = (min(global.sectionRight, global.borderLockRight) - (sview + view_wview));
            var dis; dis = round(triggerPlayer.x) - (sview + view_wview * 0.5);

            if (num == 1)
            {
                var pos; pos = max(global.sectionTop + global.quadMarginTop, global.borderLockTop);
            }
            else if (num == -1)
            {
                var pos; pos = min(global.sectionBottom - global.quadMarginBottom, global.borderLockBottom) - whview;
            }
        }

        // Align camera with section borders
        if (lb > 0)
        {
            sview += min(lb, screenFixSpeed);
        }
        else if (rb < 0)
        {
            sview += max(rb, -screenFixSpeed);
        }
        else if (sign(mview - pos) == -num) // Have we reached the threshold?
        {
            if (darken) // Make it dark
            {
                if (alpha < 1)
                {
                    alpha += darksp;
                    exit;
                }
            }

            mview += screenSpeed * num;

            with (triggerPlayer)
            {
                if (!instance_exists(vehicle))
                {
                    playerHandleSprites('Normal'); // Player animation
                }
            }
        }
        else
        {
            mview = pos;

            // Center on the player after scrolling
            if (dis != 0)
            {
                bor = ((-lb * (dis < 0)) + ((rb) * (dis > 0)));
                if (bor > 0)
                {
                    sview += min(abs(dis), bor, screenFixSpeed) * sign(dis);
                }
            }

            if (bor <= 0)
            {
                if (darken) // Light up
                {
                    if (alpha > 0)
                    {
                        alpha -= darksp;
                        exit;
                    }
                }

                if (!mydoor)
                {
                    // finish
                    endit=1;
                    global.switchingSections=0;
                    reAndDeactivateObjects(1, 0);
                    global.switchingSections=1;
                    exit;
                }
                else
                {
                    mydoor.opening = false;
                    mydoor.closing = true;
                    canStep = 0;
                }
            }
        }

        var pt; pt = pos + (((num < 0) * whview) + ((borderDistance * (1 + (dir == 'y' && plat > 0))) * num));

        if (dir == 'x')
        {
            view_xview = mview;
            view_yview = sview;

            with (triggerPlayer)
            {
                x = pt - (pt - other.pxs) * ((abs(pos - mview) / abs(pos - other.xvs)));
                if (plat)
                {
                    plat.x = x - other.platx;
                }
            }
        }
        else if (dir == 'y')
        {
            view_yview = mview;
            view_xview = sview;

            with (triggerPlayer)
            {
                y = pt - (pt - other.pys) * ((abs(pos - mview) / abs(pos - other.yvs)));
                if (plat)
                {
                    plat.y = y - other.platy;
                }
            }
        }
    }
}

// Quick weapon switching
with (triggerPlayer)
{
    playerSwitchWeapons();
}

x = triggerPlayer.x;
y = triggerPlayer.y;
#define Step_2
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if (activate)
{
    reAndDeactivateObjects(1, 0);
    activate = 0;
}
if(endit)
{
    event_user(1);
}
#define Other_11
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
/// end transition

global.switchingSections = false;
instance_activate_object(objMegaman);
if (instance_exists(triggerPlayer))
{
    with (objMegaman)
    {
        visible = true;
        depth = 0;

        // bring all players to same position and state
        x = other.triggerPlayer.x;
        y = other.triggerPlayer.y;

        yspeed = other.triggerPlayer.yspeed;
        xspeed = other.triggerPlayer.xspeed;
        image_xscale = other.triggerPlayer.image_xscale;

        climbLock = lockPoolRelease(climbLock);
        climbing = other.triggerPlayer.climbing;

        if (climbing)
            climbLock = lockPoolLock(localPlayerLock[PL_LOCK_MOVE],
                localPlayerLock[PL_LOCK_SLIDE],
                localPlayerLock[PL_LOCK_GRAVITY],
                localPlayerLock[PL_LOCK_TURN]);

        slideLock = lockPoolRelease(slideLock);
        slideChargeLock = lockPoolRelease(slideChargeLock);
        isSlide = other.triggerPlayer.isSlide;

        if (isSlide)
            slideLock = lockPoolLock(localPlayerLock[PL_LOCK_MOVE], localPlayerLock[PL_LOCK_SHOOT], localPlayerLock[PL_LOCK_TURN]);

        mask_index = other.triggerPlayer.mask_index;
        ladderXScale = -1;

        if (id != other.triggerPlayer)
        {
            slideTimer = slideFrames - 5;
        }

        canStep = true;
        mask_index = other.triggerPlayer.mask_index;
        premask = other.triggerPlayer.premask;
    }
}

// event_user(0);

reAndDeactivateObjects(0, 1);

if (plat)
{
    plat.shiftVisible = platv;
}
canProgressDoor = true;
global.frozen = false;
instance_destroy();
#define Draw_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
// drawSelf();

if (alpha > 0)
{
    draw_sprite_ext(sprDot, 0, view_xview, view_yview, view_wview, view_hview,
        0, c_black, alpha);
}
