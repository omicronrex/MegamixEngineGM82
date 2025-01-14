#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();

healthpointsStart = 28;

contactDamage = 4;
customPose = true;
ground = false;
attackTimer = 0;
hasTriggeredFall = false;
introType = 1;

// stopOnFlash = false;

phase = 0;
hasFired = false;

// Difficulty options
if (global.difficulty == DIFF_HARD)
{
    canWave = true;
}
else
{
    canWave = false;
}

// Health Bar
manualColors = true;
healthBarPrimaryColor[1] = make_colour_rgb(0, 144, 0); // Green
healthBarSecondaryColor[1] = make_colour_rgb(240, 184, 56); // Yellow

// Music
music = "Mega_Man_10.nsf";
musicType = "VGM";
musicTrackNumber = 18;

// Damage Table
enemyDamageValue(objBusterShot, 1);
enemyDamageValue(objBusterShotHalfCharged, 1);
enemyDamageValue(objBusterShotCharged, 3);

// MaGMML3
enemyDamageValue(objSparkChaser, 2);
enemyDamageValue(objLaserTrident, 2);
enemyDamageValue(objWaterShield, 1);
enemyDamageValue(objTornadoBlow, 1);
enemyDamageValue(objThunderBeam, 2);
enemyDamageValue(objBreakDash, 5);
enemyDamageValue(objMagneticShockwave, 2);
enemyDamageValue(objIceWall, 3);

// MaGMML2
enemyDamageValue(objHornetChaser, 2);
enemyDamageValue(objJewelSatellite, 2);
enemyDamageValue(objGrabBuster, 1);
enemyDamageValue(objTripleBlade, 2);
enemyDamageValue(objSlashClaw, 1);
enemyDamageValue(objWheelCutter, 4);
enemyDamageValue(objSakugarne, 2);
enemyDamageValue(objSuperArrow, 1);
enemyDamageValue(objWireAdapter, 1);

// MaGMML1
enemyDamageValue(objMetalBlade, 4);
enemyDamageValue(objGeminiLaser, 2);
enemyDamageValue(objSolarBlaze, 1);
enemyDamageValue(objTopSpin, 0);
enemyDamageValue(objThunderWool, 1);
enemyDamageValue(objPharaohShot, 1);
enemyDamageValue(objBlackHoleBomb, 1);
enemyDamageValue(objMagicCard, 2);

// MaG48HMML
enemyDamageValue(objFlameMixer, 2);
enemyDamageValue(objRainFlush, 2);
enemyDamageValue(objSparkShock, 1);
enemyDamageValue(objSearchSnake, 1);
enemyDamageValue(objTenguBlade, 1);
enemyDamageValue(objTenguDash, 4);
enemyDamageValue(objTenguDisk, 2);
enemyDamageValue(objSaltWater, 5);
enemyDamageValue(objConcreteShot, 1);
enemyDamageValue(objHomingSniper, 1);

// MaG24HMML
enemyDamageValue(objSuperArmBlockProjectile, 1);
enemyDamageValue(objSuperArmDebris, 1);
enemyDamageValue(objChillShot, 1);
enemyDamageValue(objChillSpikeLanded, 1);

// Misc.
enemyDamageValue(objPowerStone, 1);
enemyDamageValue(objPlantBarrier, 6);
enemyDamageValue(objBrickWeapon, 1);
enemyDamageValue(objIceSlasher, 1);
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();

if (!global.frozen)
{
    // Commando Man's custom intro
    if (startIntro)
    {
        y -= view_hview;
        canFillHealthBar = false;
        startIntro = false;
        isIntro = true;
        visible = true;
        calibrateDirection();
        grav = gravStart;
    }
    else if (isIntro)
    {
        // custom intro:
        /* if (y <= ystart && !hasTriggeredFall)
            y += 4 ;*/
        if (attackTimer == 0) && (introType == 1)
        {
            image_index = 1;
        }
        if (y >= ystart || hasTriggeredFall)
        {
            // since bosses do not have gravity during intros, we need to reuse this here.
            hasTriggeredFall = true;
            y = ystart; //+ 1;
            image_speed = 0;
            attackTimer += 1;
            if (introType == 1)
            {
            if (attackTimer == 1)
            {
                playSFX(sfxCommandoQuake);
                screenShake(10, 1, 1);
            }
            if (attackTimer < 8)
                image_index = 2;
            if (attackTimer == 8)
                image_index = 3;
            }
            if (attackTimer == 16)//30
                image_index = 4;
            if (attackTimer == 24)//38
                image_index = 5;
            if (attackTimer == 46)//60
            {
                image_index = 0;
            }
            if (attackTimer == 60)
            {
                canFillHealthBar = true;
                isIntro = false;
                grav = gravStart;
                blockCollision = blockCollisionStart;
                attackTimer = 0;
                phase = choose(0, 1, 2, 3);
            }
        }
    }
}
if (entityCanStep())
{
    if (isFight)
    {
        var lastTime;
        if (attackTimer == 8)
        {
            calibrateDirection();
        }
        attackTimer+=1;
        switch (phase)
        {
            // Shoot Commando Bomb from ground
            case 0:
                if (attackTimer == 40)
                {
                    image_index = 6;
                }
                if (attackTimer == 50)
                {
                    image_index = 7;
                    var i; i = instance_create(x + 32 * image_xscale, y, objCommandoBomb);
                    i.image_xscale = image_xscale;
                    i.xspeed = 3 * image_xscale;
                    playSFX(sfxCommandoBombLaunch);
                }
                if (attackTimer == 54)
                {
                    image_index = 6;
                }
                if (attackTimer == 60)
                {
                    image_index = 0;
                    attackTimer = 0;
                    phase = choose(0, 1, 2, 3);
                }
                break;
            // Regular jump
            case 1:
                if (attackTimer == 20)
                {
                    image_index = 8;
                    yspeed = -6;
                    xspeed = 1 * image_xscale;
                }
                if (attackTimer > 20)
                {
                    if (yspeed == 0)
                    {
                        if (attackTimer <= 45)
                        {
                            grav = 0;
                            xspeed = 0;

                            // Fire Commando Bomb
                            if (!hasFired)
                            {
                                image_index = 10;
                                var i; i = instance_create(x + 32 * image_xscale, y, objCommandoBomb);
                                i.image_xscale = image_xscale;
                                i.xspeed = 3 * image_xscale;
                                i.canTurn = true;
                                playSFX(sfxCommandoBombLaunch);
                                hasFired = true;
                            }
                        }
                        if (attackTimer == 49)
                        {
                            image_index = 9;
                        }
                        if (attackTimer == 60)
                        {
                            grav = 0.25;
                            image_index = 8;
                            xspeed = 1 * image_xscale;
                        }

                        // If landing on ground...
                        if (ground)
                        {
                            xspeed = 0;
                            image_index = 0;
                            if (attackTimer >= 110)
                            {
                                attackTimer = 0;
                                hasFired = false;
                                phase = choose(0, 1, 2, 3);
                            }
                        }
                    }
                }
                break;
            // High jump/ground pound
            case 2:
                if (attackTimer == 20)
                {
                    image_index = 8;
                    yspeed = -7;
                    xspeed = 1 * image_xscale;
                }
                if (attackTimer > 20)
                {
                    if (yspeed == 0)
                    {
                        if (attackTimer <= 49)
                        {
                            grav = 0;
                            xspeed = 0;

                            // Fire Commando Bomb
                            if (!hasFired)
                            {
                                image_index = 10;
                                var i; i = instance_create(x + 32 * image_xscale, y, objCommandoBomb);
                                i.image_xscale = image_xscale;
                                i.xspeed = 3 * image_xscale;
                                i.canTurn = true;
                                playSFX(sfxCommandoBombLaunch);
                                hasFired = true;
                            }
                        }
                        if (attackTimer == 53)
                        {
                            image_index = 9;
                        }
                        if (attackTimer == 60)
                        {
                            grav = 0.25;
                            image_index = 1;
                        }

                        // If landing on ground...
                        if (ground)
                        {

                            if (attackTimer <= 90)
                            {
                                // Shake ground
                                if (hasFired == true)
                                {
                                    playSFX(sfxCommandoQuake);
                                    screenShake(30, 1, 1);
                                    image_index = 2;
                                    hasFired = false;

                                    // Stun Mega Man
                                    if (instance_exists(objMegaman))
                                    {
                                        with (objMegaman)
                                        {
                                            playerGetShocked(false, 0, true, 20);
                                        }
                                    }
                                }
                            }
                            if (attackTimer == 94)
                            {
                                image_index = 3;
                            }
                            if (attackTimer >= 120)
                            {
                                attackTimer = 0;
                                image_index = 0;
                                phase = choose(0, 1, 2, 3);
                            }
                        }
                    }
                }
                break;
            // Ground punch
            case 3:
                if (canWave)
                {
                    if (attackTimer == 20)
                    {
                        xspeed = 1 * image_xscale;
                        yspeed = -6;
                        image_index = 1;
                    }
                    if ((ground) && (attackTimer > 20))
                    {
                        xspeed = 0;
                        if (attackTimer == 70)
                        {
                            image_index = 11;
                            if (!hasFired)
                            {
                                playSFX(sfxCommandoQuake);
                                screenShake(30, 1, 1);

                                // Create ground wave
                                var i; i = instance_create(x + 32 * image_xscale, y + 17, objCommandoGroundWave);
                                i.image_xscale = image_xscale;

                                // Stun Mega Man
                                if (instance_exists(objMegaman))
                                {
                                    with (objMegaman)
                                    {
                                        playerGetShocked(false, 0, true, 20);
                                    }
                                }
                                hasFired = true;
                            }
                        }
                        if (attackTimer == 74)
                        {
                            image_index = 12;
                        }
                        if (attackTimer == 90)
                        {
                            image_index = 0;
                        }
                        if (attackTimer == 110)
                        {
                            attackTimer = 0;
                            hasFired = false;
                            phase = choose(0, 1, 2, 3);
                        }
                    }
                }
                else
                {
                    attackTimer = 0;
                    phase = choose(0, 1, 2);
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

// Destroy projectiles on death
with (objCommandoBomb)
{
    instance_create(x, y, objExplosion);
    instance_destroy();
}
with (objCommandoBombExplosion)
{
    instance_destroy();
}
with (objCommandoGroundWave)
{
    instance_destroy();
}
