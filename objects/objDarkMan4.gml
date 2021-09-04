#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();

healthpointsStart = 28;

contactDamage = 5;
customPose = true;
ground = false;

attackTimer = 0;
hasTriggeredFall = false;
introType = 1;
phase = 4;
stopOnFlash = false;

targetPID = 0;

// SET hasCostume IN CREATION CODE:
// 0 = No disguise, 1 = Player disguise, 2 = MM5 Proto Man disguise, 3 = Custom disguise
// For 3, set sprite_index and/or image_index to the sprite/frame you want to use
// e.g. hasCostume = 3, sprite_index = sprQuickMan
hasCostume = 1;

_costume = 0;

shots = 0; // How many shots has Dark Man fired?
shooting = false; // Is Dark Man shooting?
barrier1 = 0; // Barrier 1 - used when returning
barrier2 = 0; // Barrier 2 - used when returning
targX = 0;

// Health Bar
healthBarPrimaryColor[1] = 19;
healthBarSecondaryColor[1] = 13;

// Music
music = "Mega_Man_5.nsf";
musicType = "VGM";
musicTrackNumber = 10;

// Damage Table
enemyDamageValue(objBusterShot, 1);
enemyDamageValue(objBusterShotHalfCharged, 1);
enemyDamageValue(objBusterShotCharged, 3);

// MaGMML3
enemyDamageValue(objSparkChaser, 2);
enemyDamageValue(objLaserTrident, 3);
enemyDamageValue(objWaterShield, 1);
enemyDamageValue(objTornadoBlow, 1);
enemyDamageValue(objThunderBeam, 2);
enemyDamageValue(objBreakDash, 1);
enemyDamageValue(objMagneticShockwave, 6);
enemyDamageValue(objIceWall, 2);

// MaGMML2
enemyDamageValue(objHornetChaser, 4);
enemyDamageValue(objJewelSatellite, 2);
enemyDamageValue(objGrabBuster, 1);
enemyDamageValue(objTripleBlade, 1);
enemyDamageValue(objSlashClaw, 1);
enemyDamageValue(objWheelCutter, 4);
enemyDamageValue(objSakugarne, 3);
enemyDamageValue(objSuperArrow, 1);
enemyDamageValue(objWireAdapter, 2);

// MaGMML1
enemyDamageValue(objMetalBlade, 1);
enemyDamageValue(objGeminiLaser, 2);
enemyDamageValue(objSolarBlaze, 2);
enemyDamageValue(objTopSpin, 0);
enemyDamageValue(objThunderWool, 4);
enemyDamageValue(objPharaohShot, 2);
enemyDamageValue(objBlackHoleBomb, 1);
enemyDamageValue(objMagicCard, 2);

// MaG48HMML
enemyDamageValue(objFlameMixer, 2);
enemyDamageValue(objRainFlush, 4);
enemyDamageValue(objSparkShock, 0);
enemyDamageValue(objSearchSnake, 0);
enemyDamageValue(objTenguBlade, 1);
enemyDamageValue(objTenguDash, 2);
enemyDamageValue(objTenguDisk, 2);
enemyDamageValue(objSaltWater, 2);
enemyDamageValue(objConcreteShot, 1);
enemyDamageValue(objHomingSniper, 2);

// MaG24HMML
enemyDamageValue(objSuperArmBlockProjectile, 2);
enemyDamageValue(objSuperArmDebris, 2);
enemyDamageValue(objChillShot, 1);
enemyDamageValue(objChillSpikeLanded, 4);

// Misc.
enemyDamageValue(objPowerStone, 4);
enemyDamageValue(objPlantBarrier, 1);
enemyDamageValue(objBrickWeapon, 3);
enemyDamageValue(objIceSlasher, 2);
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();

if (!global.frozen)
{
    // Dark Man's custom intro
    if (startIntro)
    {
        if ((hasCostume == 2) && (attackTimer == 0))
        {
            stopMusic();
            playSFX(sfxDarkWhistle);
            attackTimer = 1;
        }
        if (!audio_is_playing(sfxDarkWhistle))
        {
            resumeMusic();
            y -= view_hview;
            canFillHealthBar = false;
            startIntro = false;
            isIntro = true;
            visible = true;
            calibrateDirection();
            grav = gravStart;
        }
    }
    else if (isIntro)
    {
        // custom intro:
        /* if (y <= ystart && !hasTriggeredFall)
        {
            y += 4;
        }*/
        if (y >= ystart || hasTriggeredFall)
        {
            hasTriggeredFall = true;
            y = ystart;
            attackTimer++;
            if (hasCostume != 0)
            {
                if (attackTimer == 10)
                {
                    var i = instance_create(x, y, objBigExplosion);
                    with (i)
                        playSFX(sfxExplosion);
                }
                if (attackTimer == 20)
                {
                    sprite_index = sprDarkMan;
                }
            }
            if (attackTimer == 40)
            {
                image_speed = 0.1;
            }
            if ((attackTimer > 40) && (image_index == 2))
            {
                image_speed = 0;
                canFillHealthBar = true;
                isIntro = false;
                attackTimer = 0;
                grav = gravStart;
                blockCollision = blockCollisionStart;
            }
        }
    }
}

// Actual fight data
if (entityCanStep())
{
    if (isFight)
    {
        if (instance_exists(target))
        {
            targX = target.x;
        }

        switch (phase)
        {
            // Set up barrier
            case 4:
                var i = instance_create(x + 30, y, objDarkBarrier);
                i.dir = -1;
                var i = instance_create(x - 30, y, objDarkBarrier);
                i.dir = 1;
                image_index = 0;
                phase = choose(0, 1);
                break;
            // Fire shots
            case 0:
                attackTimer++;
                if (attackTimer < 20)
                {
                    image_index = 0;
                }
                else
                {
                    if (shots < 3)
                    {
                        image_speed = 0.1;
                        shooting = true;

                        if (image_index == 1)
                        {
                            image_index = 2;
                        }

                        if (image_index == 2.4)
                        {
                            var i = instance_create(x + 24 * image_xscale, y - 6, objEnemyBullet);
                            i.sprite_index = sprDarkShot;
                            i.xspeed = 4 * image_xscale;
                            i.contactDamage = 6;
                            i.stopOnFlash = false;
                            playSFX(sfxEnemyShootClassic);
                        }

                        if (image_index == 3)
                        {
                            image_speed = 0;
                            attackTimer = 0;
                            shots++;
                        }
                    }
                    else
                    {
                        shots = 0;
                        shooting = false;
                        image_speed = 0;
                        attackTimer = -20;
                        calibrateDirection();
                        phase = choose(0, 1);
                    }
                }
                break;
            // Fire barriers
            case 1:
                attackTimer++;
                if (objDarkBarrier.orbit == false)
                {
                    if (attackTimer >= 20)
                    {
                        image_speed = 0.1;
                        if (image_index == 2)
                        {
                            image_index = 3;
                            image_speed = 0;
                            yspeed = -6;
                            xspeed = xSpeedAim(x, y, targX, y);
                            attackTimer = -20;
                            phase = 2;
                        }
                    }
                }
                break;
            // In the air after jump
            case 2:
                if (ground)
                {
                    image_index = 0;
                    xspeed = 0;

                    if (!instance_exists(objDarkBarrier))
                    {
                        var i = instance_create(view_xview, y, objDarkBarrier);
                        i.dir = 1;
                        i.orbit = false;
                        i.comeBack = true;
                        i.stopHere = x - 30;
                        barrier1 = i.id;

                        var i = instance_create(view_xview + view_wview, y, objDarkBarrier);
                        i.dir = -1;
                        i.orbit = false;
                        i.comeBack = true;
                        i.stopHere = x + 30;
                        barrier2 = i.id;
                    }
                    else
                    {
                        if ((barrier1.comeBack == false) && (barrier2.comeBack == false))
                        {
                            objDarkBarrier.orbit = true;
                            calibrateDirection();
                            phase = choose(0, 1);
                        }
                    }
                }
                break;
        }
    }
}
#define Other_20
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();

// Destroy shots upon death
if (instance_exists(objEnemyBullet))
{
    with (objEnemyBullet)
    {
        instance_destroy();
    }
}
#define Draw_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
/// Set up intro appearance
if (isIntro)
{
    switch (hasCostume)
    {
        // No disguise
        case 0:
            drawSelf();
            break;
        // Player disguise
        case 1:
            if instance_exists(target)
            {
                _costume = target.costumeID;
                targetPID = target.playerID;
            }

            if (attackTimer < 10)
            {
                drawPlayer(targetPID, _costume, 0, 0, x, y, image_xscale, image_yscale);
            }
            else if (attackTimer >= 20)
            {
                drawSelf();
            }
            break;
        // MM5 Proto Man disguise
        case 2:
            drawSelf();
            if (attackTimer < 10)
            {
                sprite_index = sprDarkProto;
            }
            else if (attackTimer >= 20)
            {
                sprite_index = sprDarkMan;
            }
            break;
        // Custom disguise
        case 3:
            drawSelf();
            if (attackTimer < 10)
            {
                sprite_index = disguise;
            }
            else if (attackTimer >= 20)
            {
                sprite_index = sprDarkMan;
            }
            break;
    }
}
else
{
    // Use regular Draw code for boss fight
    event_inherited();
}
