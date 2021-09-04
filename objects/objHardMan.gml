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
contactDamage = 6;
customPose = true;
ground = false;
attackTimer = 0;
hasTriggeredFall = false;
introType = 0;

bossTriggered = true;
phase = 0;
hasFired = false;
grav = 0.24;
stunLock = false;

child[0] = noone;
child[1] = noone;
shotsFired = 0;

strMMX = 0;
resetGrav = -1;

// Health Bar
healthBarPrimaryColor[1] = 12;
healthBarSecondaryColor[1] = 13;

// Music
music = "Mega_Man_3.nsf";
musicType = "VGM";
musicTrackNumber = 12;

// Damage Table
enemyDamageValue(objBusterShot, 1);
enemyDamageValue(objBusterShotHalfCharged, 1);
enemyDamageValue(objBusterShotCharged, 3);

// MaGMML3
enemyDamageValue(objSparkChaser, 1);
enemyDamageValue(objLaserTrident, 2);
enemyDamageValue(objWaterShield, 0);
enemyDamageValue(objTornadoBlow, 0);
enemyDamageValue(objThunderBeam, 0);
enemyDamageValue(objBreakDash, 3);
enemyDamageValue(objMagneticShockwave, 6);
enemyDamageValue(objIceWall, 2);

// MaGMML2
enemyDamageValue(objHornetChaser, 0);
enemyDamageValue(objJewelSatellite, 0);
enemyDamageValue(objGrabBuster, 2);
enemyDamageValue(objTripleBlade, 0);
enemyDamageValue(objWheelCutter, 0);
enemyDamageValue(objSlashClaw, 2);
enemyDamageValue(objSakugarne, 4);
enemyDamageValue(objSuperArrow, 0);
enemyDamageValue(objWireAdapter, 0);

// MaGMML1
enemyDamageValue(objMetalBlade, 0);
enemyDamageValue(objGeminiLaser, 1);
enemyDamageValue(objSolarBlaze, 4);
enemyDamageValue(objTopSpin, 0);
enemyDamageValue(objThunderWool, 0);
enemyDamageValue(objPharaohShot, 2);
enemyDamageValue(objBlackHoleBomb, 1);
enemyDamageValue(objMagicCard, 2);

// MaG48MML
enemyDamageValue(objFlameMixer, 2);
enemyDamageValue(objRainFlush, 1);
enemyDamageValue(objSparkShock, 0);
enemyDamageValue(objSearchSnake, 0);
enemyDamageValue(objTenguBlade, 0);
enemyDamageValue(objTenguDash, 2);
enemyDamageValue(objTenguDisk, 0);
enemyDamageValue(objSaltWater, 4);
enemyDamageValue(objConcreteShot, 1);
enemyDamageValue(objHomingSniper, 1);

// MaG48MML
enemyDamageValue(objSuperArmBlockProjectile, 0);
enemyDamageValue(objSuperArmDebris, 0);
enemyDamageValue(objChillShot, 0);
enemyDamageValue(objChillSpikeLanded, 1);

// Misc.
enemyDamageValue(objPowerStone, 1);
enemyDamageValue(objPlantBarrier, 0);
enemyDamageValue(objBrickWeapon, 0);
enemyDamageValue(objIceSlasher, 0);
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
// leave this. this is needed.
event_inherited();

// all of yamato man's events trigger when the game isn't frozen.
if (!global.frozen)
{
    // yamato man's custom intro
    if (startIntro)
    {
        y -= view_hview;
        canFillHealthBar = false;
        image_index = 8;
        startIntro = false;
        isIntro = true;
        visible = true;
        calibrateDirection();
    }
    else if (isIntro)
    {
        // custom intro:
        if (y <= ystart && !hasTriggeredFall)
            y += 4;
        if (y >= ystart || hasTriggeredFall)
        {
            // since bosses do not have gravity during intros, we need to reuse this here.
            hasTriggeredFall = true;
            y = ystart + 1;
            image_speed = 0;
            attackTimer += 1;
            if (attackTimer < 8)
                image_index = 0;
            if (attackTimer == 8 || attackTimer == 24)
                image_index = 1;
            if (attackTimer == 16 || attackTimer == 32)
                image_index = 2;
            if (attackTimer == 50)
            {
                image_index = 0;
                canFillHealthBar = true;
                isIntro = false;
                attackTimer = 0;
                hasFired = true;
                storeDirection = image_xscale;
                grav = gravStart;
                blockCollision = blockCollisionStart;
                resetGrav = grav;
            }
        }
    }
}
if (entityCanStep())
{
    if (isFight == true)
    {
        if (instance_exists(target))
        {
            strMMX = target.x;
        }

        image_speed = 0;
        attackTimer+=1;
        switch (phase)
        {
            case 0: // prepare phase!
                xspeed = 0;
                grav = resetGrav;
                if (attackTimer < 16)
                {
                    if (attackTimer > 8)
                    {
                        calibrateDirection();
                    }
                    image_index = 0;
                }
                if (attackTimer == 16)
                {
                    image_index = 1;
                }
                if (attackTimer == 24)
                {
                    hasFired = false;
                    attackTimer = 0;
                    image_index = 2;
                    phase = 1;
                }
                break;
            case 1: // fire hard knuckle
                if (attackTimer == 8)
                {
                    image_index = 3 + 2 * shotsFired;
                }
                if (attackTimer == 24 && shotsFired < 2)
                {
                    image_index = 4 + 2 * shotsFired;
                    child[shotsFired] = instance_create(x, y, objHardManKnuckle);
                    shotsFired += 1;

                    // playSFX(sfxEnemyShoot);
                    attackTimer = 0;
                }
                if (attackTimer == 24 && shotsFired == 2)
                {
                    image_index = 1;
                    attackTimer = 0;
                    phase = 2;
                    shotsFired = 0;
                }
                break;
            case 2: // jump to mega man
                if (attackTimer == 32)
                {
                    image_index = 8;
                    yspeed = -8;
                    xspeed = xSpeedAim(x, y, strMMX, y, yspeed, grav);
                }
                if (!ground)
                {
                    if (abs(x - strMMX) <= 4 || sign(xspeed == 1) && x >= strMMX || sign(xspeed == -1) && x <= strMMX)
                    {
                        xspeed = 0;
                        yspeed = 0;
                        grav = 0;
                        phase = 3;
                        attackTimer = 0;
                    }
                }
                else if (attackTimer > 32 && ground)
                {
                    xspeed = 0;
                    yspeed = 0;
                    phase = 3;
                    attackTimer = 0;
                }
                break;
            case 3: // slam
                if (attackTimer == 8 && image_index < 11)
                {
                    attackTimer = 0;
                    image_index+=1;
                }
                else if (image_index == 11)
                {
                    grav = resetGrav + resetGrav * 0.5;
                }
                if (ground)
                {
                    xspeed = 0;
                    image_index = 12;
                    screenShake(64, 0, 2);
                    playSFX(sfxHardManLand);
                    with (objMegaman)
                    {
                        xspeed = 0;
                        yspeed = 0;
                        other.stunLock = lockPoolLock(localPlayerLock[PL_LOCK_MOVE],
                            localPlayerLock[PL_LOCK_TURN],
                            localPlayerLock[PL_LOCK_SLIDE],
                            localPlayerLock[PL_LOCK_SHOOT],
                            localPlayerLock[PL_LOCK_CLIMB],
                            localPlayerLock[PL_LOCK_SPRITECHANGE],
                            localPlayerLock[PL_LOCK_GRAVITY],
                            localPlayerLock[PL_LOCK_JUMP]);
                    }
                    attackTimer = 0;
                    phase = 4;
                }
                break;
            case 4: // pull out of ground
                if (attackTimer == 64)
                {
                    stunLock = lockPoolRelease(stunLock);

                    image_index = 13;
                    yspeed = -4;
                }
                if (yspeed > 0 && !ground)
                {
                    image_index = 10;
                    attackTimer = 0;
                    phase = 5;
                }
                break;
            case 5: // reset
                if (attackTimer == 8 && image_index > 8)
                {
                    attackTimer = 0;
                    image_index-=1;
                }
                if (ground)
                {
                    attackTimer = 0;
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
with (objHardManKnuckle)
{
    instance_create(x, y, objExplosion);
    instance_destroy();
}

stunLock = lockPoolRelease(stunLock);
event_inherited();
#define Draw_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();
