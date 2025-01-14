#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();

healthpointsStart = 28;
healthpoints = healthpointsStart;

pose = sprToadIntro;
poseImgSpeed = 3 / 60;
contactDamage = 8;

ground = false;
attackTimer = 0;
jumpTimer = 0;
jumpAmount = 0;
canInitShoot = true;
phase = 0; // 0 = nothing; 1 = jumping; 2 = dancing;

startXspeed = xspeed;

// Health Bar
healthBarPrimaryColor[1] = 35;
healthBarSecondaryColor[1] = 48;

// Music
music = "Mega_Man_4.nsf";
musicType = "VGM";
musicTrackNumber = 17;

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
enemyDamageValue(objBreakDash, 4);
enemyDamageValue(objMagneticShockwave, 1);
enemyDamageValue(objIceWall, 2);

// MaGMML2
enemyDamageValue(objHornetChaser, 2);
enemyDamageValue(objJewelSatellite, 1);
enemyDamageValue(objGrabBuster, 1);
enemyDamageValue(objTripleBlade, 2);
enemyDamageValue(objWheelCutter, 2);
enemyDamageValue(objSlashClaw, 4);
enemyDamageValue(objSakugarne, 2);
enemyDamageValue(objSuperArrow, 2);
enemyDamageValue(objWireAdapter, 1);

// MaGMML1
enemyDamageValue(objMetalBlade, 2);
enemyDamageValue(objGeminiLaser, 1);
enemyDamageValue(objSolarBlaze, 1);
enemyDamageValue(objTopSpin, 1);
enemyDamageValue(objThunderWool, 4);
enemyDamageValue(objPharaohShot, 1);
enemyDamageValue(objBlackHoleBomb, 1);
enemyDamageValue(objMagicCard, 2);

// MaG48MML
enemyDamageValue(objFlameMixer, 2);
enemyDamageValue(objRainFlush, 1);
enemyDamageValue(objSparkShock, 2);
enemyDamageValue(objSearchSnake, 5);
enemyDamageValue(objTenguBlade, 1);
enemyDamageValue(objTenguDash, 1);
enemyDamageValue(objTenguDisk, 2);
enemyDamageValue(objSaltWater, 2);
enemyDamageValue(objConcreteShot, 3);
enemyDamageValue(objHomingSniper, 2);

// MaG48MML
enemyDamageValue(objSuperArmBlockProjectile, 1);
enemyDamageValue(objSuperArmDebris, 1);
enemyDamageValue(objChillShot, 1);
enemyDamageValue(objChillSpikeLanded, 4);

// Misc.
enemyDamageValue(objPowerStone, 1);
enemyDamageValue(objPlantBarrier, 1);
enemyDamageValue(objBrickWeapon, 1);
enemyDamageValue(objIceSlasher, 4);
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();

if (entityCanStep())
{
    if (isFight == true)
    {
        switch (phase)
        {
            case 0: // Idle (standing still)
                sprite_index = sprToadIdle;
                image_speed = 0;

                attackTimer -= 1;
                if (attackTimer <= 0)
                {
                    // attackTimer is -1 when first attacking; the first attack is always a jump 'n shoot
                    if (attackTimer == -1
                        || instance_exists(objToadRainParticle))
                        phase = 1;
                    else
                    {
                        // randomize();
                        phase = choose(1,
                            2); // There seems to be a higher chance of him shooting
                    }
                }
                break;



            case 1: // Jumping
                if (attackTimer <= 0)
                    attackTimer = 45;
                if (attackTimer == 30)
                {
                    if (instance_exists(target))
                    {
                        startXScale = image_xscale;

                        // Calculate the time needed to jump to MM's position, and with that, calculate the horizontal speed
                        var dx, initYspeed;
                        dx = spriteGetXCenterObject(target)
                            - spriteGetXCenter();
                        initYspeed = -6.5;

                        var time, yy,
                            yyspeed; // time: How much time (in frames) it would take to land on Mega Man's location
                        yy = bbox_bottom;
                        yyspeed = initYspeed;
                        time = 0;

                        while (yy < target.bbox_bottom || yyspeed < 0)
                        {
                            yyspeed += 0.25;
                            yy += yyspeed;
                            time += 1;
                        }

                        startXspeed = dx / time;
                        yspeed = initYspeed;
                        ground = false;
                    }
                    else
                    {
                        startXScale = image_xscale;
                        startXspeed = 0;
                    }
                }

                if (!checkSolid(startXspeed, 0))
                {
                    xspeed = startXspeed;
                }
                else
                {
                    while (place_meeting(x, y, objSolid))
                        x -= image_xscale;

                    xspeed = 0;
                }


                // Face the player
                sprite_index = sprToadJump;
                if (ground)
                {
                    image_index = 0;
                    xspeed = 0;
                }
                else
                    image_index = 1;

                if ((attackTimer > 1 && ground == true)
                    || (attackTimer > 5 && ground == false))
                    attackTimer -= 1;

                // When grounded, end the jump
                if (ground == true && attackTimer <= 1)
                {
                    attackTimer = 30;
                    phase = 0;
                    sprite_index = sprToadIdle;
                    xspeed = 0;
                    yspeed = 0;
                }
                break;



            case 2: // Dancing
                if (attackTimer <= 0)
                {
                    attackTimer = 120;
                    jumpTimer = 0;

                    sprite_index = sprToadDance;
                    image_index = 0;
                    image_speed = 0;
                }
                image_index += 0.2;
                if (round(image_index) >= image_number)
                    image_index = image_number - 2;
                attackTimer -= 1;
                if (attackTimer == 60)
                {
                    instance_create(x, y, objToadRainParticle);
                    if (instance_exists(target))
                    {
                        with (target)
                        {
                            // manual damage to player
                            if (iFrames == 0 && canHit)
                            {
                                with (other)
                                {
                                    entityEntityCollision();
                                }
                            }
                        }
                    }
                }
                if (attackTimer == 0 || iFrames)
                {
                    phase = 0;
                    attackTimer = 30;
                }
                break;
        }


        // Face the player
        calibrateDirection();
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
with (objToadRainParticle)
    instance_destroy();

event_inherited();
