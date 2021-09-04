#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();

healthpointsStart = 28;
healthpoints = healthpointsStart;
xOff = 0;
contactDamage = 4;
customPose = true;
ground = false;
attackTimer = 0;
hasTriggeredFall = false;
introType = 1;
bossTriggered = true;
delayUse = false;
attackTimerMax = 145;
phase = 0;
jumpY = -5.5;
setX = 0;
delay = 0;
storeSpeed = 0;
hasFired = false;
shotsFired = 0;
suckSpeed = -1.75;
timeStopLock = false;
grav = 0.25;

// Health Bar
healthBarPrimaryColor[1] = 7;
healthBarSecondaryColor[1] = 21;

// Music
music = "Mega_Man_5GB.gbs";
musicType = "VGM";
musicTrackNumber = 6;

// Damage Table
enemyDamageValue(objBusterShot, 1);
enemyDamageValue(objBusterShotHalfCharged, 1);
enemyDamageValue(objBusterShotCharged, 3);

// MaGMML3
enemyDamageValue(objSparkChaser, 0);
enemyDamageValue(objLaserTrident, 2);
enemyDamageValue(objWaterShield, 0);
enemyDamageValue(objTornadoBlow, 1);
enemyDamageValue(objThunderBeam, 4);
enemyDamageValue(objMagneticShockwave, 2);
enemyDamageValue(objIceWall, 2);
enemyDamageValue(objBreakDash, 0);

// MaGMML2
enemyDamageValue(objHornetChaser, 2);
enemyDamageValue(objJewelSatellite, 5);
enemyDamageValue(objGrabBuster, 0);
enemyDamageValue(objTripleBlade, 1);
enemyDamageValue(objWheelCutter, 2);
enemyDamageValue(objSlashClaw, 1);
enemyDamageValue(objSakugarne, 1);
enemyDamageValue(objSuperArrow, 2);
enemyDamageValue(objWireAdapter, 2);

// MaGMML1
enemyDamageValue(objMetalBlade, 1);
enemyDamageValue(objGeminiLaser, 1);
enemyDamageValue(objSolarBlaze, 2);
enemyDamageValue(objTopSpin, 0);
enemyDamageValue(objThunderWool, 4);
enemyDamageValue(objPharaohShot, 1);
enemyDamageValue(objBlackHoleBomb, 0);
enemyDamageValue(objMagicCard, 2);

// MaG48HMML
enemyDamageValue(objFlameMixer, 2);
enemyDamageValue(objRainFlush, 1);
enemyDamageValue(objSparkShock, 2);
enemyDamageValue(objSearchSnake, 0);
enemyDamageValue(objTenguBlade, 2);
enemyDamageValue(objTenguDash, 0);
enemyDamageValue(objTenguDisk, 2);
enemyDamageValue(objSaltWater, 0);
enemyDamageValue(objConcreteShot, 4);
enemyDamageValue(objHomingSniper, 2);

// MaG24HMML
enemyDamageValue(objSuperArmBlockProjectile, 1);
enemyDamageValue(objSuperArmDebris, 1);
enemyDamageValue(objChillShot, 0);
enemyDamageValue(objChillSpikeLanded, 2);

// Misc.
enemyDamageValue(objPowerStone, 1);
enemyDamageValue(objPlantBarrier, 2);
enemyDamageValue(objBrickWeapon, 2);
enemyDamageValue(objIceSlasher, 1);
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
// leave this. this is needed.
event_inherited();

// all of saturn's events trigger when the game isn't frozen.
if (!global.frozen)
{
    // saturn's custom intro
    if (startIntro)
    {
        y -= view_hview;
        canFillHealthBar = false;
        image_index = 5;
        startIntro = false;
        isIntro = true;
        visible = true;
        calibrateDirection();
    }
    else if (isIntro)
    {
        // custom intro:
        if (!hasTriggeredFall)
        {
            image_index = 5;
        }
        if (y >= ystart || hasTriggeredFall)
        {
            // since bosses do not have gravity during intros, we need to reuse this here.
            hasTriggeredFall = true;
            y = ystart;
            image_speed = 0;
            if (!instance_exists(objSaturnRing))
                attackTimer += 1;
            if (attackTimer < 15)
                image_index = 0;
            if (attackTimer == 15)
            {
                image_index = 1;
                with (instance_create(x, y, objSaturnRing))
                {
                    alarm[0] = 0;
                    xspeed = 0;
                }
                attackTimer = 16;
            }
            if (attackTimer == 17)
                image_index = 2;
            if (attackTimer == 25)
                image_index = 3;
            if (attackTimer == 40)
            {
                canFillHealthBar = true;
                isIntro = false;
                attackTimer = 0;
                blockCollision = 1;
                grav = gravAccel;
            }
        }
    }
}
if (entityCanStep())
{
    if (isFight == true)
    {
        image_speed = 0;
        attackTimer += 1;
        switch (phase)
        {
            case 0: // choose attack
                image_index = 0;
                if (instance_exists(prtPlayerProjectile) && attackTimer < 20 && !delayUse)
                    bossTriggered = true;
                if (attackTimer == 40)
                {
                    attackTimer = 0;
                    if (bossTriggered)
                    {
                        phase = choose(4, 7);
                        bossTriggered = false;
                    }
                    else
                        phase = 1;
                }
                break;
            case 1: // throw ring and slide
                delayUse = false;
                if (attackTimer == 1)
                {
                    image_index = 1;
                    with (instance_create(x, y, objSaturnRing))
                        image_xscale = other.image_xscale;
                }
                if (attackTimer == 16)
                {
                    xspeed = 3.5 * image_xscale;
                    image_index = 4;
                    attackTimer = 0;
                    phase = 2;
                }
                break;
            case 2: // turn around
                if (((checkSolid(2 * image_xscale, -1, 0, 1)) || storeSpeed != 0) && ground)
                {
                    xspeed = 0;
                    attackTimer = 0;
                    image_xscale *= -1;
                    image_index = 1;
                    shotsFired = 0;
                    if (storeSpeed == 0)
                        phase = 3;
                    else
                    {
                        storeSpeed = 0;
                        phase = 0;
                    }
                }
                break;
            case 3: // catch!
                if (!instance_exists(objSaturnRing))
                {
                    playSFX(sfxCricket);
                    image_index = 0;
                    attackTimer = 0;
                    phase = 0;
                }
                break;
            case 4: // time freeze begin
                delayUse = true;
                if (attackTimer == 15)
                {
                    setX = 0;
                    yspeed = jumpY;
                    image_index = 5;
                }
                if (attackTimer == 16)
                {
                    var i; for ( i = 32; i < 256; i += 1)
                    {
                        if (checkSolid(i * image_xscale, y, 0, 1))
                            break;
                        else
                            setX += 1;
                    }
                    xspeed = xSpeedAim(x, y, x + (setX + 16) * image_xscale, y + 16, yspeed, grav);
                }
                if ((image_xscale == 1 && x >= view_xview + view_wview / 2) || (image_xscale == -1 && x <= view_xview + view_wview / 2))
                {
                    storeSpeed = abs(xspeed);
                    yspeed = 0;
                    grav = 0;
                    xspeed = 0;
                    attackTimer = 0;
                    phase = 5;
                }
                break;
            case 5: // time freeze!
                if (attackTimer < 32)
                    image_index = 6;
                if (attackTimer == 32)
                {
                    screenFlash(25);
                    timeStopLock = playerTimeStopped();
                    playSFX(sfxTimeStopper);
                }
                if (attackTimer > 48 && attackTimer mod 8 == 0 && shotsFired < 15)
                {
                    playSFX(sfxEnemyShootClassic);
                    with (instance_create(x, y, objSaturnBullet))
                    {
                        dir = 292.5 + other.shotsFired * 22.5;
                        dir = dir mod 360;
                        image_xscale = other.image_xscale;
                    }
                    shotsFired += 1;
                }
                if (shotsFired == 15)
                {
                    attackTimer = 0;
                    phase = 6;
                }
                break;
            case 6: // unfreeze time!
                if (attackTimer == 32)
                {
                    image_index = 5;
                    timeStopLock = playerTimeRestored(timeStopLock);
                    calibrateDirection();
                    xspeed = storeSpeed * image_xscale;
                    grav = 0.25;
                    phase = 2;
                }
                break;
            case 7: // black hole
                delayUse = true;
                image_index = 7 + (attackTimer / 3) mod 3;
                //canHit = false;
                with (prtPlayerProjectile)
                {
                    if (xspeed != 0 || yspeed != 0)
                        mp_linear_step(other.x + 16 * other.image_xscale, other.y + 24, 8, false);
                    if (((x >= other.x + 12 && x <= other.x + 20 && other.image_xscale == 1) || (x >= other.x - 20 && x <= other.x - 12 && other.image_xscale == -1))
                        && y >= other.y + 22 && y <= other.y + 26)
                    {
                        if (object_index != objThunderBeam) && (object_index != objThunderWool)
                        && (object_index != objConcreteShot) && (object_index != objJewelSatellite)
                            instance_destroy();
                    }
                }
                with (objMegaman)
                {
                    if (!climbing)
                    {
                        shiftObject(other.suckSpeed * other.image_xscale, 0, 1);
                    }
                }
                if (attackTimer >= 256)
                {
                    attackTimer = 0;
                    canHit = true;
                    phase = 0;
                }
                break;
        }
    }
}
else
{ }
#define Other_20
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
with (objSaturnRing)
{
    instance_create(x, y, objExplosion);
    instance_destroy();
}
with (objSaturnBullet)
{
    instance_destroy();
}
if (lockPoolExists(timeStopLock))
{
    timeStopLock = playerTimeRestored(timeStopLock);
}
event_inherited();
#define Other_21
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if (phase == 7)
{
    if (other.object_index == objThunderBeam) || (other.object_index == objThunderWool)
    || (other.object_index == objConcreteShot) || (other.object_index == objJewelSatellite)
    {
        attackTimer = 0;
        canHit = true;
        phase = 0;
    }
    else
        other.guardCancel = 2;
}
#define Draw_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();
