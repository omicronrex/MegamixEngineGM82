#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();
sprite_index = sprBladeManSeeSawMiddle;
mask_index = sprBladeManSeeSawMiddle;

isSolid = 0;
respawn = true;

respawnRange = -1;
despawnRange = -1;

// shift for upper platform
pux = 27;
puy = 19;

// shift for lower platform
pdx = 29;
pdy = 10;

changeDir = false; // true - change direction to opposite

canBacktrack = 0;

// Waiting time before backtracking
backtrackTimerMax = 300;

mySpeed = 0;
mySpeedMax = 1;
phase = 7;
backtrackTimer = 0;

firstPlatform = noone;
secondPlatform = noone;
lastRail = noone;

xOffset = 6;
yOffset = 6;
image_speed = 0;

canDraw = true;
animImage = 0;

startLeftPos = 0;
startRightPos = 1;

if(image_xscale==-1)
{
    startLeftPos = 1;
    startRightPos = 0;
}

image_xscale = 1;
initp = true;
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();
if (entityCanStep())
{
    // if (dir == "fall") print ("Fall!");
    if (bumped)
    {
        if (phase != 6)
        {
            phase = 0;
            animImage = 0;
            canBacktrack = true;
        }
        mySpeed = 0;
    }
    if (changeDir)
    {
        switch (dir)
        {
            case "right":
                dir = "left";
                break;
            case "left":
                dir = "right";
                break;
            case "down":
                dir = "up";
                break;
            case "up":
                dir = "down";
                break;
        }
        changeDir = false;
    }
    if (initp)
    {
        initp = false;
        if(startLeftPos)
        {
            firstPlatform = instance_create(x + pux + 8, y + pdy, objBladeManSeeSawPlatform);
            firstPlatform.xPosition = 1;
        }
        else
        {
            firstPlatform = instance_create(x - pdx + 7, y + pdy, objBladeManSeeSawPlatform);
            firstPlatform.xPosition = -1;
        }
        if(startRightPos)
        {
            secondPlatform = instance_create(x + pux + 8, y - puy, objBladeManSeeSawPlatform);
            secondPlatform.xPosition = 1;
        }
        else
        {
            secondPlatform = instance_create(x - pdx + 7, y - puy, objBladeManSeeSawPlatform);
            secondPlatform.xPosition = -1;
        }

        firstPlatform.parent = id;
        secondPlatform.parent = id;

        firstPlatform.yPosition = 1;
        firstPlatform.centerShift = (power(pdx, 2) + power(pdy, 2) - power(pux, 2) - power(puy, 2)) / (2 * puy + 2 * pdy);
        firstPlatform.radiusSquare = power(pdx, 2) + power(pdy - firstPlatform.centerShift, 2);

        firstPlatform.xMain = x + 7;
        firstPlatform.yMain = y;
        firstPlatform.xspeedMain = xspeed;
        firstPlatform.yspeedMain = yspeed;

        firstPlatform.yMin = puy;
        firstPlatform.yMax = pdy;

        secondPlatform.yPosition = -1;
        secondPlatform.centerShift = (power(pdx, 2) + power(pdy, 2) - power(pux, 2) - power(puy, 2)) / (2 * puy + 2 * pdy);
        secondPlatform.radiusSquare = power(pdx, 2) + power(pdy - secondPlatform.centerShift, 2);

        secondPlatform.xMain = x + 7;
        secondPlatform.yMain = y;
        secondPlatform.xspeedMain = xspeed;
        secondPlatform.yspeedMain = yspeed;

        secondPlatform.yMin = puy;
        secondPlatform.yMax = pdy;
    }
    else
    {
        if (phase < 5)
            backtrackTimer += 1;

        firstPlatform.xMain = x + 7;
        firstPlatform.yMain = y;
        firstPlatform.xspeedMain = xspeed;
        firstPlatform.yspeedMain = yspeed;

        secondPlatform.xMain = x + 7;
        secondPlatform.yMain = y;
        secondPlatform.xspeedMain = xspeed;
        secondPlatform.yspeedMain = yspeed;

        if (firstPlatform.phase == 1 && secondPlatform.phase == 0)
        {
            playSFX(sfxBladeManSeeSawCart1);
            secondPlatform.phase = 3;

            if (phase == 5 || phase == 6)
                changeDir = true;
            if (phase != 4)
                phase = 1;
            backtrackTimer = 0;
            animImage = 0;
            canBacktrack = true;
        }

        if (firstPlatform.phase == 0 && secondPlatform.phase == 1)
        {
            playSFX(sfxBladeManSeeSawCart1);
            firstPlatform.phase = 3;

            if (phase == 5 || phase == 6)
                changeDir = true;
            if (phase != 4)
                phase = 1;
            backtrackTimer = 0;
            animImage = 0;
            canBacktrack = true;
        }

        if (instance_exists(lastRail))
        {
            if (lastRail.dir == 6)
            {
                if (phase >= 5)
                    phase = 7;
                else
                    phase = 4;
            }
        }

        if (backtrackTimer == backtrackTimerMax)
        {
            if (phase != 4)
                changeDir = true;
            phase = 5;
            animImage = 0;
            backtrackTimer = 0;
        }

        switch (phase)
        {
            case 0:
            case 4:
            case 7:
                mySpeed = 0;
                animImage = 0;
                break;
            case 1:
                if (mySpeed < mySpeedMax)
                {
                    mySpeed += 0.05;
                }
                if (mySpeed >= mySpeedMax)
                {
                    mySpeed = mySpeedMax;
                    phase = 2;
                }
                break;
            case 2:
                if (firstPlatform.phase == 0 && secondPlatform.phase == 0)
                {
                    phase = 3;
                }
                break;
            case 3:
                if (mySpeed > 0)
                {
                    mySpeed -= 0.02;
                }
                if (mySpeed <= 0)
                {
                    mySpeed = 0;
                    phase = 0;
                }
                break;
            case 5:
                mySpeed = 0;
                if ((animImage div 6) mod 2 == 1)
                {
                    canDraw = false;
                    image_index = 8;
                }
                else
                {
                    canDraw = true;
                    if (canBacktrack && animImage div 6 != 0 && animImage mod 6 == 0)
                        playSFX(sfxBladeManSeeSawCart2);
                }
                animImage += 1;
                if (animImage >= 48 && canBacktrack)
                {
                    canBacktrack = 0;
                    phase = 6;
                    animImage = 0;
                    canDraw = true;
                    mySpeed = mySpeedMax;
                    playSFX(sfxBladeManSeeSawCart3);
                }
                break;
        }
    }

    // middle platform animation
    if (canDraw || (phase != 6 && phase != 5))
    {
        switch (dir)
        {
            case "right":
                if (phase != 4)
                    image_index = 0;
                else
                    image_index = 2;
                break;
            case "left":
                if (phase != 4)
                    image_index = 2;
                else
                    image_index = 0;
                break;
            case "down":
                if (phase != 4)
                    image_index = 4;
                else
                    image_index = 6;
                break;
            case "up":
                if (phase != 4)
                    image_index = 6;
                else
                    image_index = 4;
                break;
            case "fall":
                image_index = 8;
                break;
        }
    }

    if (mySpeed != 0)
    {
        animImage += 1;
        if (animImage mod 6 >= 3)
            image_index += 1;
        if (animImage >= 6)
            animImage = 0;
    }

    if (instance_exists(secondPlatform))
    {
        with (secondPlatform)
        {
            canStep = true;
            event_perform(ev_step, ev_step_normal);
            canStep = false;
        }
    }
    if (instance_exists(firstPlatform))
    {
        with (firstPlatform)
        {
            canStep = true;
            event_perform(ev_step, ev_step_normal);
            canStep = false;
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
if(spawned)
{
    init = true;
    initp = true;
    phase = 7;
    backtrackTimer = 0;
    if (instance_exists(firstPlatform))
    {
        with (firstPlatform)
            instance_destroy();
    }
    if (instance_exists(secondPlatform))
    {
        with (secondPlatform)
            instance_destroy();
    }
}
