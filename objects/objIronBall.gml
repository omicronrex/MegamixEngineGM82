#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();

healthpointsStart = 28;
healthpoints = healthpointsStart;
imageOffset = 0;
contactDamage = 3;
customPose = true;
ground = false;
grav = 0.10;
spd = 1.5;
phase = 0;
shotsFired = 0;
attackTimer = 0;
healthBarPrimaryColor[1] = 18;
healthBarSecondaryColor[1] = 40;
hasTriggeredFall = false;

laserSpeed = 2;

yStore = choose(1, -1);

// Music
music = "WilyTowerBossTheme.vgm";
musicType = "VGM";
musicTrackNumber = 0;

// Damage Tables
enemyDamageValue(objBusterShot, 1);
enemyDamageValue(objBusterShotHalfCharged, 1);
enemyDamageValue(objBusterShotCharged, 3);

// MaGMML3
enemyDamageValue(objSparkChaser, 2);
enemyDamageValue(objLaserTrident, 2);
enemyDamageValue(objWaterShield, 1);
enemyDamageValue(objTornadoBlow, 1);
enemyDamageValue(objThunderBeam, 4);
enemyDamageValue(objBreakDash, 1);
enemyDamageValue(objMagneticShockwave, 2);
enemyDamageValue(objIceWall, 1);

// MaGMML2
enemyDamageValue(objHornetChaser, 2);
enemyDamageValue(objJewelSatellite, 1);
enemyDamageValue(objGrabBuster, 4);
enemyDamageValue(objTripleBlade, 0);
enemyDamageValue(objWheelCutter, 0);
enemyDamageValue(objSlashClaw, 2);
enemyDamageValue(objSakugarne, 0);
enemyDamageValue(objSuperArrow, 2);
enemyDamageValue(objWireAdapter, 1);

// MaGMML1
enemyDamageValue(objMetalBlade, 1);
enemyDamageValue(objGeminiLaser, 2);
enemyDamageValue(objSolarBlaze, 1);
enemyDamageValue(objTopSpin, 0);
enemyDamageValue(objThunderWool, 4);
enemyDamageValue(objPharaohShot, 1);
enemyDamageValue(objBlackHoleBomb, 1);
enemyDamageValue(objMagicCard, 2);

// MaG48HMML
enemyDamageValue(objFlameMixer, 2);
enemyDamageValue(objRainFlush, 2);
enemyDamageValue(objSparkShock, 4);
enemyDamageValue(objSearchSnake, 1);
enemyDamageValue(objTenguBlade, 1);
enemyDamageValue(objTenguDash, 1);
enemyDamageValue(objTenguDisk, 2);
enemyDamageValue(objSaltWater, 2);
enemyDamageValue(objConcreteShot, 1);
enemyDamageValue(objHomingSniper, 2);

// MaG24HMML
enemyDamageValue(objSuperArmBlockProjectile, 1);
enemyDamageValue(objSuperArmDebris, 1);
enemyDamageValue(objChillShot, 1);
enemyDamageValue(objChillSpikeLanded, 1);

// Misc.
enemyDamageValue(objPowerStone, 4);
enemyDamageValue(objPlantBarrier, 1);
enemyDamageValue(objBrickWeapon, 1);
enemyDamageValue(objIceSlasher, 1);
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
// leave this. this is needed.
event_inherited();

// all of iron balls's events trigger when the game isn't frozen.
if (entityCanStep())
{
    // iron balls's custom intro
    if (startIntro)
    {
        calibrateDirection();
        y -= view_hview;
        canFillHealthBar = false;
        image_index = 0;
        startIntro = false;
        isIntro = true;
        visible = true;
    }
    else if (isIntro)
    {
        // custom intro:
        if (y <= ystart && !hasTriggeredFall)
        {
            y += 4;
        }
        if (y >= ystart || hasTriggeredFall)
        {
            hasTriggeredFall = true;
            blockCollision = blockCollisionStart;
            grav = gravStart;
            if (y >= ystart && yspeed >= 0)
            {
                shotsFired+=1;
                yspeed = -3;
                playSFX(sfxTeckyun);
            }

            if (shotsFired >= 3)
            {
                canFillHealthBar = true;
                shotsFired = 0;
                attackTimer = 0;
                isIntro = false;
            }
        }
    }
}
if (entityCanStep())
{
    with (objGeminiManLaser) // this code delays the gemini laser for a few frames, so it gives the long laser effect.
    {
        if (bounces < 0)
        {
            x = xstart;
            y = ystart;
            bounces += other.laserSpeed / 2;
        }
        if (bounces >= 3) // since gemini laser dont disable themselves, do it here.
        {
            blockCollision = 0;
        }
    }
    if (isFight)
    {
        attackTimer += 1;
        switch (phase)
        {
            case 0: // bounce around
                if (healthpoints <= healthpointsStart / 2) // change phases!
                {
                    attackTimer = 0;
                    phase = 2;
                }
                if (image_index > 0)
                {
                    image_index -= 0.125;
                }
                grav = 0.25;
                if (xspeed == 0) // force speed to happen in case it ever gets reset to 0.
                {
                    xspeed = spd * image_xscale;
                }
                if (ground) // jump
                {
                    yspeed = -6 + irandom(4) / 2;
                    playSFX(sfxTeckyun);
                    shotsFired += 1 + choose(0, 0, 0, 0, 0, 1, 1, 2); // sometimes iron ball will jump fewer than 3 times, this is determined randomly.
                }
                if (xcoll != 0)
                {
                    image_xscale *= -1;
                    xspeed *= -1;
                    playSFX(sfxTeckyun);
                }
                if (shotsFired >= 3 && yspeed >= 0 && !ground) // after 3 (or fewer) jumps, change phases
                {
                    shotsFired = 0;
                    attackTimer = 0;
                    xspeed = 0;
                    yspeed = 0;
                    grav = 0;
                    phase = 1;
                    if (spd > 3)
                    {
                        spd = 1.5;
                    }
                }
                break;
            case 1: // shoot gemini lasers
                if (instance_exists(objGeminiManLaser) && shotsFired == 0)
                {
                    shotsFired = 1;
                }
                if (image_index < 2)
                {
                    image_index += 0.125;
                }
                else if (shotsFired == 0 && (!instance_exists(objGeminiManLaser) || (global.difficulty == DIFF_HARD)) && attackTimer > 24) // only fire gemini lasers if none exists
                {
                    shotsFired = 1;
                    var sideShot; sideShot = choose(0, 1, 2, 3);
                    playSFX(sfxGeminiLaser);


                    var i; for ( i = 0; i < 2 + (global.difficulty == DIFF_HARD); i+=1)
                    {
                        var j; for ( j = -laserSpeed * 3; j < 0; j += laserSpeed)
                        {
                            switch (sideShot) // vary laser shot and direction depending on randomly chosen side
                            {
                                case 0:
                                case 4:
                                    with (instance_create(x + 12, y - 16, objGeminiManLaser))
                                    {
                                        xspeed = other.laserSpeed;
                                        yspeed = -other.laserSpeed;
                                        bounces = j; // "bounce" variable is used as a sort of timer to delay the gemini laser with code above.
                                    }
                                    break;
                                case 1:
                                    with (instance_create(x + 12, y + 8, objGeminiManLaser))
                                    {
                                        xspeed = other.laserSpeed;
                                        yspeed = other.laserSpeed;
                                        bounces = j;
                                    }
                                    break;
                                case 2:
                                    with (instance_create(x - 12, y + 8, objGeminiManLaser))
                                    {
                                        xspeed = -other.laserSpeed;
                                        yspeed = other.laserSpeed;
                                        bounces = j;
                                    }
                                    break;
                                case 3:
                                    with (instance_create(x - 12, y - 16, objGeminiManLaser))
                                    {
                                        xspeed = -other.laserSpeed;
                                        yspeed = -other.laserSpeed;
                                        bounces = j;
                                    }
                                    break;
                            }
                        }
                        with (objGeminiManLaser) // setup initial gemini laser state for each created.
                        {
                            instance_create(x, y, objExplosion);
                            sprite_index = sprGeminiLaserReflect;
                            image_xscale = sign(xspeed);
                            image_yscale = sign(yspeed);
                        }
                        var oldShot; oldShot = sideShot;
                        while (sideShot == oldShot)
                        {
                            sideShot = choose(0, 1, 2, 3);
                        }
                    }
                }
                if (attackTimer == 70) // reset to phase 0
                {
                    attackTimer = 0;
                    phase = 0;
                }
                break;
            case 2: // move towards middle
                xspeed = 0;
                yspeed = 0;
                grav = 0;
                spd = 1;
                mp_linear_step(view_xview + view_wview / 2, view_yview + view_hview / 2, spd, false);

                // when middle is reached, change animation.
                if (x >= (view_xview + view_wview / 2) - 1 && x <= (view_xview + view_wview / 2) + 1 && y >= (view_yview + view_hview / 2) - 1 && y <= (view_yview + view_hview / 2) + 1)
                {
                    x = (view_xview + view_wview / 2);
                    y = (view_yview + view_hview / 2);
                    image_index = 3;

                    if (attackTimer >= 64)
                    {
                        image_index = 4;
                        attackTimer = 0;
                        phase = 3;
                    }
                }
                else
                {
                    attackTimer = 0;
                    if (image_index > 0)
                    {
                        image_index -= 0.125;
                    }
                }
                break;
            case 3: // bounce around room
                {
                    if (abs(xspeed) != spd)
                    {
                        xspeed = spd * image_xscale;
                    }
                    if (abs(yspeed) != spd)
                    {
                        yspeed = spd * yStore;
                    }

                    // rebounce around room
                    if (xcoll != 0)
                    {
                        xspeed *= -1;
                        image_xscale *= -1;
                        playSFX(sfxTeckyun);
                    }

                    if (spd > 4.5)
                    {
                        spd = 4.5;
                    }

                    if (ycoll != 0)
                    {
                        yspeed *= -1;
                        yStore *= -1;
                        playSFX(sfxTeckyun);
                    }

                    if (attackTimer == 120) // fire bomber pepe's egg of all things
                    {
                        // Vary dropped object based on difficulty
                        var objectToDrop;

                        if (global.difficulty == DIFF_HARD)
                        {
                            objectToDrop = objPipiEgg;
                        }
                        else
                        {
                            objectToDrop = objBomberPepeEgg;
                        }

                        with (instance_create(x, y, objectToDrop))
                        {
                            itemDrop = -1;
                            playSFX(sfxEnemyDrop);

                            if (objectToDrop == objBomberPepeEgg)
                            {
                                if (instance_exists(target))
                                {
                                    xspeed = sign(x - target.x) * 2; // find mega man
                                }
                                else
                                {
                                    xspeed = image_xscale * 2;
                                }
                            }
                        }
                        attackTimer = 0;
                    }
                }
        }
    }
}
#define Other_20
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
with (objGeminiManLaser)
    instance_destroy();
with (objBomberPepeEgg)
{
    instance_create(x, y, objExplosion);
    instance_destroy();
}
with (objHarmfulExplosion)
    instance_destroy();
event_inherited();
#define Other_21
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();
if (image_index < 2 || image_index == 3)
{
    other.guardCancel = 3;
}
else
    spd += 0.25;
