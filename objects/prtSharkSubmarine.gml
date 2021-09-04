#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();

firstStep = 1;

_endStageBehavior = 0;
healthpointsStart = 28;
healthpoints = healthpointsStart;
despawnRange = -1;
stopOnFlash = false;
introType = 0;
visible = true;
canHit = false;
shiftVisible = 2;
blockCollision = 0;
killed = false;
facePlayerOnSpawn = false;
allDead = false;
respawnRange = -1;
stop = false;
grav = 0;
contactDamage = 5;
destroyOnDeath = false;
isTargetable = false;

speedToMove = 0.5; // The absolute value for yspeed;

yHighOffset = -48; // Smallest number yCurrOffset can reach.
yLowOffset = 48; // Largest number yCurrOffset can reach.

globalYHighOffset = -48; // Smallest number yCurrOffset can reach(in scrolling sections).
globalYLowOffset = 16; // Largest number yCurrOffset can reach(in scrolling sections).
leftShark = noone;
rightShark = noone;

attackTimer = 0;

// Handled by leftShark
introTimer = 120;
jetTimer = 0; // Controls the timing for jet animations.
jetIndex = 0; // Controls what image index the jet animations have.
goingUp = true; // Offset decreases if true and increases if false.
yCurrOffset = 0; // Keeps track of the height changes for the shark.

endOfStageBoss = false;

// Health Bar
healthBarPrimaryColor[1] = 25;
healthBarSecondaryColor[1] = 52;

// Music
music = "Mega_Man_9.nsf";
musicType = "VGM";
musicTrackNumber = 16;

// Damage Table
enemyDamageValue(objBusterShot, 2);
enemyDamageValue(objBusterShotHalfCharged, 2);
enemyDamageValue(objBusterShotCharged, 4);

// MaGMML3
enemyDamageValue(objSparkChaser, 2);
enemyDamageValue(objLaserTrident, 4);
enemyDamageValue(objWaterShield, 1);
enemyDamageValue(objTornadoBlow, 4);
enemyDamageValue(objThunderBeam, 3);
enemyDamageValue(objBreakDash, 1);
enemyDamageValue(objMagneticShockwave, 3);
enemyDamageValue(objIceWall, 0);

// MaGMML2
enemyDamageValue(objHornetChaser, 2);
enemyDamageValue(objJewelSatellite, 1);
enemyDamageValue(objGrabBuster, 2);
enemyDamageValue(objTripleBlade, 5);
enemyDamageValue(objSlashClaw, 1);
enemyDamageValue(objWheelCutter, 1);
enemyDamageValue(objSakugarne, 1);
enemyDamageValue(objSuperArrow, 2);
enemyDamageValue(objWireAdapter, 3);

// MaGMML1
enemyDamageValue(objMetalBlade, 2);
enemyDamageValue(objGeminiLaser, 4);
enemyDamageValue(objSolarBlaze, 2);
enemyDamageValue(objTopSpin, 1);
enemyDamageValue(objThunderWool, 2);
enemyDamageValue(objPharaohShot, 1);
enemyDamageValue(objBlackHoleBomb, 1);
enemyDamageValue(objMagicCard, 3);

// MaG48HMML
enemyDamageValue(objFlameMixer, 2);
enemyDamageValue(objRainFlush, 4);
enemyDamageValue(objSparkShock, 5);
enemyDamageValue(objSearchSnake, 1);
enemyDamageValue(objTenguBlade, 1);
enemyDamageValue(objTenguDash, 1);
enemyDamageValue(objTenguDisk, 2);
enemyDamageValue(objSaltWater, 1);
enemyDamageValue(objConcreteShot, 1);
enemyDamageValue(objHomingSniper, 3);

// MaG24HMML
enemyDamageValue(objSuperArmBlockProjectile, 1);
enemyDamageValue(objSuperArmDebris, 1);
enemyDamageValue(objChillShot, 0);
enemyDamageValue(objChillSpikeLanded, 0);

// Misc.
enemyDamageValue(objPowerStone, 2);
enemyDamageValue(objPlantBarrier, 1);
enemyDamageValue(objBrickWeapon, 2);
enemyDamageValue(objIceSlasher, 0);
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();

// Handle intro.
if (!global.frozen && !killed && !allDead)
{
    jetTimer+=1;
    if (jetTimer >= 6)
    {
        jetTimer = 0;
        jetIndex+=1;
    }

    // Starting the intro animation
    if (startIntro)
    {
        startIntro = false;
        isIntro = true;
        visible = true;
    }
    else if (isIntro)
    {
        if (introTimer > 0)
        {
            introTimer-=1;
            if (introTimer <= 0)
            {
                isIntro = false;
                var defaultMotion; defaultMotion = 0;
                with (prtSharkSubmarine)
                {
                    if (id != other && startRef == other.startRef)
                    {
                        defaultMotion = true;
                        break;
                    }
                }
                if (defaultMotion)
                {
                    yHighOffset = globalYHighOffset; // Smallest number yCurrOffset can reach.
                    yLowOffset = globalYLowOffset; // Largest number yCurrOffset can reach.
                }
            }
        }
        else
        {
            isIntro = false;
            canFillHealthBar=true;
        }
    }
}

if (!global.frozen && !allDead && (!stop || (stop && y != ystart)))
{
    if (isFight == true || killed)
    {
        if (!stop)
        {
            // Determine which direction the shark moves.
            if (yCurrOffset <= yHighOffset) // Too high.
            {
                goingUp = false;
            }
            else
            {
                if (yCurrOffset >= yLowOffset) // Too low.
                {
                    goingUp = true;
                }
            }
        }

        // Set the direction the shark moves.
        if (goingUp) // Going up.
        {
            yspeed = -speedToMove;
        }
        else // Going down.
        {
            yspeed = speedToMove;
        }

        if (stop)
        {
            if (sign(y - ystart) == sign(yspeed))
            {
                y = ystart;
                yspeed = 0;
                global.lockTransition = false;
            }
        }

        // Keeps track of the y offset.
        yCurrOffset += yspeed;
    }
}
#define Step_1
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();
if (firstStep)
{
    firstStep = 0;
    instance_activate_object(prtSharkSubmarine);
    if (!isStart)
        event_user(0);
    if (!isEnd)
        event_user(1);
    with (prtSharkSubmarine)
    {
        if (!insideSection(x, y))
            instance_deactivate_object(id);
    }
}
#define Other_4
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
/// Connect body
instance_activate_object(prtSharkSubmarine);
endRef = noone;
startRef = noone;
leftShark = instance_place(x - 48, y, prtSharkSubmarine);
rightShark = instance_place(x + 48, y, prtSharkSubmarine);
isStart = false;
isEnd = false;
if (rightShark == noone)
{
    endRef = self;
    isEnd = true;
}
if (leftShark == noone)
{
    startRef = self;
    isStart = true;
}
_endStageBehavior = useEndStageBehavior;
#define Other_10
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
/// Get start

if (!isStart)
{
    if (leftShark.leftShark == noone)
        startRef = leftShark;
    else
    {
        with (leftShark)
            event_user(0);
        startRef = leftShark.startRef;
    }
}

/// Left Shark Connection
// invoked in the spawn event of prtSharkSubmarine
// returns the id of the left-most prtSharkSubmarine in the chain of them

/*
var nextShark; nextShark = instance_place(x - 3, y, prtSharkSubmarine);
if (instance_exists(nextShark))
{
    var leftReturn; leftReturn = noone;
    with (nextShark)
    {
        if (x < other.x && ystart == other.ystart)
        {
            event_user(0);
            leftShark.sharkAmount+=1;
            other.leftReturn = leftShark;
        }
    }
    if (!instance_exists(leftReturn))
    {
        sharkAmount+=1;
        endOfStageBoss = useEndStageBehavior;
        leftReturn = id;
    }
    leftShark = leftReturn;
}
else
{
    sharkAmount+=1;
    endOfStageBoss = useEndStageBehavior;
    leftShark = id;
}
*/
#define Other_11
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
/// GetEnd

if (!isEnd)
{
    if (rightShark.rightShark == noone)
        endRef = rightShark;
    else
    {
        with (rightShark)
            event_user(1);
        endRef = rightShark.endRef;
    }
}

/// Right Shark Connection
// invoked in the spawn event of prtSharkSubmarine

/*
var nextShark; nextShark = instance_place(x + 3, y, prtSharkSubmarine);
if (instance_exists(nextShark))
{
    with (nextShark)
    {
        if (x > other.x && ystart == other.ystart)
        {
            if (!instance_exists(leftShark))
            {
                leftShark = other.leftShark;
                leftShark.sharkAmount+=1;
                event_user(1);
            }
        }
    }
}
*/
#define Other_20
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if (killed)
    exit;
if (!killed && isFight)
    killed = true;

allDead = true;
stop = true;
with (prtSharkSubmarine)
{
    if (insideSection(x,y)&&id != other.id && startRef == other.startRef)
        other.stop = false;
}
instance_activate_object(prtSharkSubmarine);
if (instance_exists(startRef))
{
    var ref; ref = startRef;

    while (ref != noone)
    {
        if (!ref.killed)
        {
            allDead = false;
        }
        ref.introTimer = 0;
        ref = ref.rightShark;
    }
}
else
{
    show_error("Error, something went wrong with the shark and it doesn't know what happened", 1);
}
with (prtSharkSubmarine)
{
    if (other.startRef == startRef && other.allDead)
        allDead = true;
    if (!insideSection(x, y))
    {
        instance_deactivate_object(id);
    }
}
if (allDead)
{
    useEndStageBehavior = _endStageBehavior;
    stop = true;
    doPlayerExplosion = true;
}
else
{
    useEndStageBehavior = false;
    itemDrop = -1;
    doPlayerExplosion = false;
}
event_inherited();
instance_create(bboxGetXCenter(), bboxGetYCenter() - 10, objBigExplosion);
instance_create(bboxGetXCenter() + 32, bboxGetYCenter(), objBigExplosion);
instance_create(bboxGetXCenter() - 32, bboxGetYCenter(), objBigExplosion);
playSFX(sfxMM9Explosion);
if (!allDead)
    dead = false;
if (stop && y != ystart)
{
    global.lockTransition = true;
    if (y < ystart)
    {
        goingUp = false;
        yspeed = speedToMove;
    }
    else
    {
        goingUp = true;
        yspeed = -speedToMove;
    }
}

// Do explosion Here

if (allDead)
{
    instance_activate_object(prtSharkSubmarine);
    yspeed = 0;
    with (prtSharkSubmarine)
    {
        if (startRef == other.startRef)
        {
            if (!insideSection(x, y))
                instance_destroy();
            else // Explode
            {
                instance_create(bboxGetXCenter(), bboxGetYCenter() - 10, objBigExplosion);
                instance_create(bboxGetXCenter() + 32, bboxGetYCenter(), objBigExplosion);
                instance_create(bboxGetXCenter() - 32, bboxGetYCenter(), objBigExplosion);
                playSFX(sfxMM9Explosion);
                instance_destroy();
            }
        }
    }
}
#define Other_25
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if (killed)
    spawned = false;
event_inherited();
if (killed)
    dead = true;
if (spawned)
{
    visible = 1;
    drawBoss = true;
}
#define Draw_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if (introTimer <= 0)
{
    draw_sprite_ext(sprite_index, -1, x, round(y), image_xscale,
        image_yscale, image_angle, image_blend, image_alpha);
}
else
{
    draw_sprite_ext(sprite_index, -1, x, round(y), image_xscale,
        image_yscale, image_angle, c_black,
        1);
    draw_sprite_ext(sprite_index, -1, x, round(y), image_xscale,
        image_yscale, image_angle, image_blend,
        1 - ((floor(introTimer / (30 / 2)) * (30 / 2)) / 30) / 2);
}
