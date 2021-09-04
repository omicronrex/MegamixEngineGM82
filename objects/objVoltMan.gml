#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();

healthpointsStart = 28;
healthpoints = healthpointsStart;

pose = sprVoltIntro;
poseImgSpeed = 8 / 60;
contactDamage = 4;
ground = false;
attackTimer = 0;
phase = 0;
myGrav = 1;
jumpsMade = 0;
jumpsMax = 1;
redetectRoof = 0;

// store attackTimer maximums in array for use later.
attackTimerMax[0] = 35;
attackTimerMax[1] = 45;
attackTimerMax[2] = 25;
attackTimerMax[3] = 20;

// Health Bar
healthBarPrimaryColor[1] = 18;
healthBarSecondaryColor[1] = 48;

// Music
music = "Mega_Man_5GB.gbs";
musicType = "VGM";
musicTrackNumber = 5;

// Damage Table
enemyDamageValue(objBusterShot, 3);
enemyDamageValue(objBusterShotHalfCharged, 3);
enemyDamageValue(objBusterShotCharged, 5);

// MaGMML3
enemyDamageValue(objSparkChaser, 1);
enemyDamageValue(objLaserTrident, 3);
enemyDamageValue(objWaterShield, 2);
enemyDamageValue(objTornadoBlow, 1);
enemyDamageValue(objThunderBeam, 0);
enemyDamageValue(objMagneticShockwave, 6);
enemyDamageValue(objIceWall, 2);
enemyDamageValue(objBreakDash, 1);

// MaGMML2
enemyDamageValue(objHornetChaser, 0);
enemyDamageValue(objJewelSatellite, 0);
enemyDamageValue(objGrabBuster, 1);
enemyDamageValue(objTripleBlade, 1);
enemyDamageValue(objWheelCutter, 1);
enemyDamageValue(objSlashClaw, 6);
enemyDamageValue(objSakugarne, 3);
enemyDamageValue(objSuperArrow, 6);
enemyDamageValue(objWireAdapter, 1);

// MaGMML1
enemyDamageValue(objMetalBlade, 4);
enemyDamageValue(objGeminiLaser, 2);
enemyDamageValue(objSolarBlaze, 2);
enemyDamageValue(objTopSpin, 0);
enemyDamageValue(objThunderWool, 0);
enemyDamageValue(objPharaohShot, 1);
enemyDamageValue(objBlackHoleBomb, 1);
enemyDamageValue(objMagicCard, 2);

// MaG48HMML
enemyDamageValue(objFlameMixer, 2);
enemyDamageValue(objRainFlush, 7);
enemyDamageValue(objSparkShock, 0);
enemyDamageValue(objSearchSnake, 2);
enemyDamageValue(objTenguBlade, 1);
enemyDamageValue(objTenguDash, 2);
enemyDamageValue(objTenguDisk, 1);
enemyDamageValue(objSaltWater, 4);
enemyDamageValue(objConcreteShot, 1);
enemyDamageValue(objHomingSniper, 1);

// MaG24HMML
enemyDamageValue(objSuperArmBlockProjectile, 4);
enemyDamageValue(objSuperArmDebris, 4);
enemyDamageValue(objChillShot, 2);
enemyDamageValue(objChillSpikeLanded, 2);

// Misc.
enemyDamageValue(objPowerStone, 1);
enemyDamageValue(objPlantBarrier, 3);
enemyDamageValue(objBrickWeapon, 1);
enemyDamageValue(objIceSlasher, 1);
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();
if (entityCanStep())
{
    if (isFight)
    {
        image_speed = 0;
        grav = 0.25 * myGrav;
        attackTimer += 1;
        if (instance_exists(objVoltBarrier))
        {
            objVoltBarrier.x = x;
            objVoltBarrier.y = y - 4;
        }
        switch (phase)
        {
            case 0: // Idle (standing still)
                if (ground == true)
                {
                    xspeed = 0;
                    sprite_index = sprVoltIdle;
                    jumpsMade = 0;
                }
                else
                    attackTimer = 0;
                if (attackTimer == attackTimerMax[phase])
                {
                    attackTimer = 0;
                    if (!instance_exists(objVoltBarrier))
                        phase = 1;
                    if (instance_exists(objVoltBarrier))
                    {
                        phase = 2;
                        jumpsMax = irandom_range(1, 4);
                    }
                }
                break;
            case 1: // Jump to cieling
            // when the voltRoof detector exists, voltman jumps to its position
                if (instance_exists(objVoltRoofDetector)
                    && ground == true && myGrav == 1)
                {
                    if (objVoltRoofDetector.offRoof == true)
                    {
                        yspeed = ySpeedAim(y, objVoltRoofDetector.y + 16, 0.25 * myGrav);
                        sprite_index = sprVoltJump;
                        image_index = 0;
                    }
                }

                // otherwise he creates the roof detector.
                if (!instance_exists(objVoltRoofDetector))
                {
                    with (objVoltRoofDetector)
                        instance_destroy();
                    VRD = instance_create(x - 8, y, objVoltRoofDetector);
                }
                if (instance_exists(objVoltRoofDetector)
                    && y <= objVoltRoofDetector.y + 24
                    && objVoltRoofDetector.hitRoof == true)
                {
                    myGrav = -1;
                    sprite_index = sprVoltPrepareShield;
                    image_index += 0.75;
                    if (!instance_exists(objVoltBarrier)
                        && attackTimer > attackTimerMax[phase] / 3)
                    {
                        instance_create(x, y, objVoltBarrier);
                        playSFX(sfxElectricShot);
                    }
                }
                else
                    attackTimer = 0;
                if (attackTimer == attackTimerMax[phase])
                {
                    phase = 0;
                    myGrav = 1;
                    y += 2;
                    sprite_index = sprVoltJump;
                    image_index = 1;
                }
                break;
            case 2: // begin jumping around
                if (ground == false)
                    attackTimer = 0;
                if (ground == true && attackTimer <= 5)
                {
                    sprite_index = sprVoltIdle;
                    xspeed = 0;
                }
                if (ground == true && jumpsMade < jumpsMax && attackTimer > 5)
                {
                    yspeed = -6;
                    xspeed = 1.5 * image_xscale;
                    sprite_index = sprVoltJump;
                    image_index = 0;
                    jumpsMade += 1;
                }
                else if (ground == true && jumpsMade == jumpsMax
                    && attackTimer > 5)
                {
                    sprite_index = sprVoltPrepareThrow;
                    attackTimer = 0;
                    phase = 3;
                    xspeed = 0;
                }
                if (yspeed > 0 && ground == false)
                {
                    image_index = 1;
                    xspeed = 1.5 * image_xscale;
                }
                break;
            case 3: // throw shield
                if (sprite_index == sprVoltPrepareThrow)
                    image_index += 0.5;
                if (attackTimer >= attackTimerMax[phase])
                {
                    sprite_index = sprVoltThrowShield;
                    if (image_index < 1)
                        image_index += 0.1;
                }
                if (attackTimer == attackTimerMax[phase] + 10)
                {
                    playSFX(sfxBlockZap);

                    // create twin voltman shots
                    VS = instance_create(x + 16, y - 3, objVoltmanShot);
                    VS.image_xscale = 1;
                    VS = instance_create(x - 16, y - 3, objVoltmanShot);
                    VS.image_xscale = -1;

                    // scatter shield to the four winds
                    if (instance_exists(objVoltBarrier))
                    {
                        VS = instance_create(objVoltBarrier.x, objVoltBarrier.y,
                            objVoltmanDischarge);
                        VS.image_index = 0;
                        VS.xspeed = 2.5;
                        VS.yspeed = -2.5;
                        VS = instance_create(objVoltBarrier.x, objVoltBarrier.y,
                            objVoltmanDischarge);
                        VS.image_index = 1;
                        VS.xspeed = 2.5;
                        VS.yspeed = 2.5;
                        VS = instance_create(objVoltBarrier.x, objVoltBarrier.y,
                            objVoltmanDischarge);
                        VS.image_index = 2;
                        VS.xspeed = -2.5;
                        VS.yspeed = 2.5;
                        VS = instance_create(objVoltBarrier.x, objVoltBarrier.y,
                            objVoltmanDischarge);
                        VS.image_index = 3;
                        VS.xspeed = -2.5;
                        VS.yspeed = -2.5;
                        with (objVoltBarrier)
                            instance_destroy();
                    }
                    attackTimer = -10;
                    sprite_index = sprVoltIdle;
                    phase = 0;
                    with (objVoltRoofDetector)
                        instance_destroy();
                }
                break;
        }

        // Face the player
        if (ground == true)
        {
            calibrateDirection();
        }
    }
}
else
{
    image_speed = 0;
}
#define Other_20
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
with (prtEnemyProjectile)
{
    event_user(EV_DEATH);
}

with (objVoltBarrier)
{
    event_user(EV_DEATH);
}

event_inherited();
