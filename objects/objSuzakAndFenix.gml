#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();

// General
canIce = false;
healthpointsStart = 20;
healthpoints = healthpointsStart;
contactDamage = 4;
rescursiveExplosion = false;
grav = 0;
respawnRange = 1;
despawnRange = 1;
blockCollision = 0;

// Enemy Specific Code

screenX = 0;

// AI
Other = noone;
isMaster = false;
high = true;
startHigh = high;
init = 0;
prevP0Timer = 0;

minX = 0;
maxX = 999;
minY = y;
maxY = 999;
readyToSwitch = false;

masterTimer = 0;
timer = 0;
masterPhase = 0;
phase = 0;

shootCount = 0;
shootMax = 0;
hasSwitched = false;

// Animation
animTimer = 0;
anim = 0;
endFrame = 3;
currentFrame = 19;
animSpeed = 0;
loopAnim = true;
nextAnim = 0;
image_speed = 0;
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();

if (introTimer > 0 && doesIntro)
{
    image_xscale = xscaleStart;
}

if (entityCanStep() && introTimer <= 0)
{
    image_speed = 0;
    var alone = true;


    if (instance_number(objSuzakAndFenix) > 1)
    {
        var i = 0;
        with (objSuzakAndFenix)
        {
            if (entityCanStep())
            {
                i += 1;
            }
        }
        if (i > 1)
            alone = false;
    }

    if ((!alone && isMaster) || alone)
    {
        switch (masterPhase) // coordinate actions
        {
            case 0: // wait and shoot
                if (masterTimer == -1)
                {
                    phase = 0;
                    timer = -1;
                    shootCount = 0;
                    if (!alone)
                    {
                        Other.phase = 0;
                        Other.timer = -1;
                        Other.shootCount = 0;
                    }
                    shootMax = irandom(2) + 1;
                    if (shootMax == 1)
                    {
                        if (hasSwitched)
                            hasSwitched = false;
                        else
                        {
                            shootMax += 1;
                            hasSwitched = true;
                        }
                    }
                    else
                        hasSwitched = true;
                }
                masterTimer += 1;
                if (masterTimer > 5)
                {
                    masterPhase = 1;
                    masterTimer = -1;
                    if (!alone)
                        other.shootMax = shootMax;
                }
                break;
            case 1: // shoot if possible
                if (!alone && isMaster && Other.high)
                {
                    Other.phase = 1;
                    Other.timer = -1;
                }
                if ((high || alone) || (!alone && Other.high == high))
                {
                    phase = 1;
                    timer = -1;
                }
                else if (phase != 0 && !high && !alone)
                {
                    phase = 0;
                    timer = -1;
                }
                if (!alone && Other.phase != 0 && !Other.high)
                {
                    Other.phase = 0;
                    Other.timer = -1;
                }
                masterPhase = 2;
                masterTimer = -1;
                break;
            case 2: // wait for the shooting phase
                if (alone && anim == 1 || !alone && (anim == 1 || Other.anim == 1) && masterTimer == -1)
                    masterTimer = 0;
                if (masterTimer != -1)
                    masterTimer += 1;
                if (masterTimer > 30 && (shootCount + 1 < shootMax || (!instance_exists(objSFFire) || alone)))
                {
                    shootCount += 1;
                    if (!alone)
                        Other.shootCount = shootCount;
                    if (shootCount >= shootMax)
                    {
                        masterPhase = 3;
                        masterTimer = -1;
                    }
                    else
                    {
                        masterPhase = 4;
                        masterTimer = -1;
                    }
                }
                break;
            case 3: // Switch sides
                if (masterTimer == -1)
                {
                    if (true)
                    {
                        phase = 3;
                        timer = -1;
                        yspeed = 0;
                        if (!alone && isMaster)
                        {
                            Other.phase = 3;
                            Other.timer = -1;
                            Other.yspeed = 0;
                        }
                        masterTimer = 0;
                    }
                }
                else if (anim == 0)
                {
                    if (!alone && isMaster)
                    {
                        if (Other.anim == 0)
                        {
                            masterPhase = 0;
                            masterTimer = -1;
                        }
                    }
                    else if (alone)
                    {
                        masterPhase = 0;
                        masterTimer = -1;
                    }
                }
                break;
            case 4: // Fly up/down
                if (masterTimer == -1)
                {
                    phase = 2;
                    timer = -1;
                    if (!alone && isMaster)
                    {
                        Other.phase = 2;
                        Other.timer = -1;
                    }
                    masterTimer = 0;
                }
                else
                {
                    if ((alone && timer == -3) || (!alone && isMaster && timer == -3 && Other.timer == -3))
                    {
                        masterPhase = 1;
                        masterTimer = -1;
                    }
                }
                break;
        }
    }
    if (!alone && isMaster) // Synchronize masterTimer and masterPhase with the other active instance in case the master dies
    {
        Other.masterTimer = masterTimer;
        Other.masterPhase = masterPhase;
    }

    if (phase == 0 || phase == 1)
    {
        if (high)
        {
            if (y > minY + 10)
            {
                yspeed -= 0.035;
            }
            else
            {
                yspeed += 0.035;
            }
        }
        else
        {
            if (y >= maxY - 10)
            {
                yspeed -= 0.035;
            }
            else
            {
                yspeed += 0.035;
            }
        }
    }

    switch (phase) // do actions, if timer is -1 that means it hasn't started its current phase
    {
        case 0: // Idle
            if (timer == -1)
            {
                nextAnim = 0;
                timer = 0;
                loopAnim = true;
            }
            else if (timer == -2)
            {
                if (anim == 0)
                {
                    timer = 0;
                }
            }
            else if (timer >= 0)
            { }
            break;
        case 1: // Shoot
            if (timer == -1)
            {
                nextAnim = 2;
                timer = 0;
                loopAnim = true;
            }
            else
            {
                timer += 1;
                if (timer > 20 && anim == 2 && anim == nextAnim)
                {
                    nextAnim = 1;
                    loopAnim = false;
                }
                if (anim == 0)
                {
                    phase = 0;
                }
            }
            break;
        case 2: // Ascend or descend
            if (timer == -1)
            {
                nextAnim = 2;
                loopAnim = true;
                timer = -2;
                readyToSwitch = false;
            }
            else if (timer == -2) // sinchronize
            {
                if (high && y < minY)
                {
                    yspeed += 0.2;
                }
                else if (high && y > minY)
                {
                    yspeed -= 0.2;
                }
                if (!high && y > maxY)
                {
                    yspeed -= 0.2;
                }
                else if (!high && y < maxY)
                {
                    yspeed += 0.2;
                }
                if (abs(yspeed) > 1)
                {
                    yspeed = sign(yspeed) * 1;
                }
                if ((high && (abs(y - minY) < 2)) || (!high && (abs(y - maxY) < 2)))
                    readyToSwitch = true;

                if ((readyToSwitch && alone) || (readyToSwitch && !alone && Other.readyToSwitch))
                {
                    timer = 0;
                    yspeed = 0;
                    nextAnim = 2;
                    loopAnim = true;
                }
            }
            else if (timer >= 0)
            {
                if (high && y < maxY)
                {
                    yspeed += 0.2;
                }
                else if (!high && y > minY)
                {
                    yspeed -= 0.2;
                }
                if (abs(yspeed) > 2)
                {
                    yspeed = sign(yspeed) * 2;
                }
                if (high && y >= maxY)
                {
                    y = maxY;
                    timer = -3;
                    high = false;
                    yspeed = 0;
                }
                else if (!high && y <= minY)
                {
                    y = minY;
                    timer = -3;
                    high = true;
                    yspeed = 0;
                }
            }
            break;
        case 3: // Switch sides
            if (timer == -1)
            {
                nextAnim = 2;
                timer = 0;
                yspeed = 0;
                readyToSwitch = false;
            }
            else
            {
                if (anim != 4 && anim != 3)
                {
                    if (high && y < minY)
                    {
                        yspeed += 0.2;
                    }
                    else if (high && y > minY)
                    {
                        yspeed -= 0.2;
                    }
                    if (!high && y > maxY)
                    {
                        yspeed -= 0.2;
                    }
                    else if (!high && y < maxY)
                    {
                        yspeed += 0.2;
                    }
                    if (abs(yspeed) > 1)
                    {
                        yspeed = sign(yspeed) * 1;
                    }
                }
                else
                {
                    yspeed = 0;
                }

                timer += 1;
                if (timer > 20 && ((high && (abs(y - minY) < 2)) || (!high && (abs(y - maxY) < 2))))
                    readyToSwitch = true;
                if (anim == 2 && ((readyToSwitch && alone) || (!alone && readyToSwitch && Other.readyToSwitch)))
                {
                    timer = 0;
                    nextAnim = 3;
                    loopAnim = false;
                    yspeed = 0;
                }
                else if (anim == 4)
                {
                    xspeed = 4 * image_xscale;
                    if (image_xscale == 1)
                    {
                        if (x > maxX)
                        {
                            nextAnim = 5;
                            loopAnim = false;
                            timer = -2;
                            xspeed = 0;
                            x = maxX;
                            image_xscale = -1;
                            phase = 0;
                        }
                    }
                    else
                    {
                        if (x < minX)
                        {
                            nextAnim = 5;
                            loopAnim = false;
                            timer = -2;
                            xspeed = 0;
                            x = minX;
                            image_xscale = 1;
                            phase = 0;
                        }
                    }
                }
            }
            break;
        case 4:
            break;
        case 5:
            break;
    }

    // Handle Animations
    var changeFrame = false;
    animTimer += animSpeed;
    if (nextAnim != anim)
    {
        anim = nextAnim;
        switch (anim)
        {
            case 0: // regular flying loop
                animSpeed = 0.2;
                endFrame = 3;
                break;
            case 1: // shoot animation
                animSpeed = 0.1;
                endFrame = 3;
                break;
            case 2: // fast flying loop
                animSpeed = 0.35;
                endFrame = 3;
                break;
            case 3: // prepare for heat man's attack
                animSpeed = 0.4;
                endFrame = 4;
                break;
            case 4: // heat man's attack
                animSpeed = 0.5;
                endFrame = 2;
                break;
            case 5:
                animSpeed = 0.4;
                endFrame = 4;
                break;
        }
        currentFrame = -1;
        changeFrame = true;
        animTimer = 0;
    }

    if (animTimer > 1)
    {
        animTimer = 0;
        changeFrame = true;
    }
    if (changeFrame)
    {
        currentFrame += 1;
        if (currentFrame > endFrame)
        {
            if (loopAnim)
            {
                currentFrame = 0;
            }
            else
            {
                currentFrame = endFrame;
                animSpeed = 0;
                event_user(0);
            }
        }
        switch (anim)
        {
            case 0:
                image_index = currentFrame;
                break;
            case 1:
                image_index = currentFrame + 4;
                if (currentFrame == 2)
                {
                    if (high)
                        event_user(1);
                    else
                        event_user(2);
                }
                break;
            case 2:
                image_index = currentFrame;
                break;
            case 3:
                image_index = currentFrame + 8;
                if (currentFrame == 0)
                {
                    playSFX(sfxSFDash);
                }
                break;
            case 4:
                image_index = currentFrame + 13;
                break;
            case 5:
                image_index = 8 + (4 - currentFrame);
                break;
        }
    }
    if (anim == 3 || anim == 4 || anim == 5)
    {
        mask_index = mskSF2;
    }
    else
    {
        mask_index = mskSF1;
    }
}
#define Step_1
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();

/// Misc. initialization
if (init == 1)
{
    var mapY = floor(y / 224);
    var screenYBottom = mapY * 224 + 224;
    init = 0;
    while (!place_meeting(x, y + 1, objSolid) && bbox_bottom < screenYBottom)
    {
        y = y + 1;
    }
    y -= 4;
    maxY = y;
    if (high)
    {
        y = minY;
    }
    else
    {
        ystart = y;
    }
    var mapX = floor(x / 256);
    screenX = mapX * 256;
    if (xscaleStart == -1)
    {
        maxX = x;
        minX = screenX + (abs((screenX + 256) - x));
    }
    else
    {
        minX = x;
        maxX = (screenX + 256) - (abs(x - screenX));
    }
    startHigh = high;
}
else if (init == 2)
{
    init = 0;


    var total = 0;
    with (objSuzakAndFenix)
    {
        if (entityCanStep())
            total += 1;
    }

    if (total > 1)
    {
        assert(total <= 2, "Too many active Suzak and Fenix");
        var i = 0;
        with (objSuzakAndFenix)
        {
            if (isMaster)
                i += 1;
        }
        if (i == 0)
        {
            isMaster = true;
            with (objSuzakAndFenix)
            {
                if (!isMaster && entityCanStep())
                {
                    other.Other = self;
                    Other = other;
                }
            }
        }
    }
}
#define Other_10
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
/// AnimationEnd: ;
switch (anim)
{
    case 1:
        nextAnim = 0;
        loopAnim = true;
        break;
    case 3:
        nextAnim = 4;
        loopAnim = true;
        break;
    case 5:
        nextAnim = 0;
        break;
}
#define Other_11
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
/// Shoot
var i;
i = 2.5;
repeat (3)
{
    var iD;
    iD = instance_create(x + image_xscale * 10, y - 10, objSFFire);
    with (iD)
    {
        if (other.image_xscale == 1)
            xspeed = xSpeedAim(x, y, other.screenX + (i * 32), other.minY, yspeed, grav);
        else
            xspeed = xSpeedAim(x, y, other.screenX + 256 - (i * 32), other.minY, yspeed, grav);
    }
    i = i + 1;
}
playSFX(sfxSFFlame);
#define Other_12
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
/// Shoot(low)
var i;
i = 2.5;
repeat (3)
{
    var iD;
    iD = instance_create(x + image_xscale * 10, y - 10, objSFFire);
    with (iD)
    {
        if (other.image_xscale == 1)
            xspeed = xSpeedAim(x, y, other.screenX + (i * 24), other.minY, yspeed, grav);
        else
            xspeed = xSpeedAim(x, y, other.screenX + 256 - (i * 24), other.minY, yspeed, grav);
    }
    i = i + 1;
}
playSFX(sfxSFFlame);
#define Other_20
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
/// On Death
event_inherited();
init = 0;
#define Other_21
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if (anim == 3 || anim == 4 || anim == 5)
{
    other.guardCancel = 3;
}
#define Other_25
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
/// On spawn
event_inherited();
if (spawned)
{
    image_xscale = xscaleStart;
    phase = 0;
    masterPhase = 0;
    timer = -1;
    masterTimer = -1;
    shootCount = 0;
    shootMax = 0;
    high = startHigh;
    prevP0Timer = 3.14;
    updateTimer = true;
    introTimer = 288 + 15;
    init = 2;
    isMaster = false;
    animTimer = 0;
    anim = 0;
    nextAnim = 0;
    endFrame = 3;
    currentFrame = 4;
    animSpeed = 0.2;
}
else
{
    init = 0;
}
#define Draw_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();
