#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();

healthpointsStart = 28;
healthpoints = healthpointsStart;

stopOnFlash = true;

pose = sprPharaohPose;
poseImgSpeed = 3 / 60;
contactDamage = 4;

ground = false;
attackTimer = 0;
jumpTimer = 0;
jumpAmount = 0;
canInitShoot = true;
phase = 0; // 0 = nothing; 1 = jumping; 2 = jumping and shooting; 3 = shooting the big shot

// Health Bar
healthBarPrimaryColor[1] = 33;
healthBarSecondaryColor[1] = 40;

// Music
music = "Mega_Man_4.nsf";
musicType = "VGM";
musicTrackNumber = 17;

// Damage Table
enemyDamageValue(objBusterShot, 1);
enemyDamageValue(objBusterShotHalfCharged, 1);
enemyDamageValue(objBusterShotCharged, 3);

// MaGMML3
enemyDamageValue(objSparkChaser, 4);
enemyDamageValue(objLaserTrident, 2);
enemyDamageValue(objWaterShield, 2);
enemyDamageValue(objTornadoBlow, 1);
enemyDamageValue(objThunderBeam, 2);
enemyDamageValue(objBreakDash, 1);
enemyDamageValue(objMagneticShockwave, 1);
enemyDamageValue(objIceWall, 1);

// MaGMML2
enemyDamageValue(objHornetChaser, 2);
enemyDamageValue(objJewelSatellite, 2);
enemyDamageValue(objGrabBuster, 1);
enemyDamageValue(objTripleBlade, 2);
enemyDamageValue(objWheelCutter, 2);
enemyDamageValue(objSlashClaw, 1);
enemyDamageValue(objSakugarne, 3);
enemyDamageValue(objSuperArrow, 2);
enemyDamageValue(objWireAdapter, 1);

// MaGMML1
enemyDamageValue(objMetalBlade, 2);
enemyDamageValue(objGeminiLaser, 4);
enemyDamageValue(objSolarBlaze, 2);
enemyDamageValue(objTopSpin, 1);
enemyDamageValue(objThunderWool, 1);
enemyDamageValue(objPharaohShot, 1);
enemyDamageValue(objBlackHoleBomb, 1);
enemyDamageValue(objMagicCard, 2);

// MaG48MML
enemyDamageValue(objFlameMixer, 2);
enemyDamageValue(objRainFlush, 1);
enemyDamageValue(objSparkShock, 4);
enemyDamageValue(objSearchSnake, 2);
enemyDamageValue(objTenguBlade, 2);
enemyDamageValue(objTenguDash, 3);
enemyDamageValue(objTenguDisk, 2);
enemyDamageValue(objSaltWater, 2);
enemyDamageValue(objConcreteShot, 1);
enemyDamageValue(objHomingSniper, 1);

// MaG48MML
enemyDamageValue(objSuperArmBlockProjectile, 1);
enemyDamageValue(objSuperArmDebris, 1);
enemyDamageValue(objChillShot, 1);
enemyDamageValue(objChillSpikeLanded, 2);

// Misc.
enemyDamageValue(objPowerStone, 1);
enemyDamageValue(objPlantBarrier, 1);
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
    if (isFight == true)
    {
        switch (phase)
        {
            case 0: // Idle (standing still)
                sprite_index = sprPharaohStand;
                image_speed = 0;

                attackTimer -= 1;
                if (attackTimer <= 0)
                {
                    if (attackTimer
                        == -1) // It's -1 when first attacking; the first attack is always a jump 'n shoot
                        phase = 2;
                    else
                    {
                        // randomize();

                        // Add a new attack to the pool if playing on Hard
                        if (global.difficulty == DIFF_HARD)
                        {
                            phase = choose(1, 2, 3,
                                3, 4); // There seems to be a higher chance of him shooting
                        } // normal mode
                        else
                        {
                            phase = choose(1, 2, 3,
                                3); // There seems to be a higher chance of him shooting
                        }
                    }
                }
                break;



            case 1: // Jumping
                if (attackTimer <= 0)
                {
                    attackTimer = 35 - (global.difficulty == DIFF_HARD * 10);

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
                if (instance_exists(target))
                {
                    if (startXScale == -1)
                    {
                        if (x > target.x)
                            sprite_index = sprPharaohJump;
                        else
                            sprite_index = sprPharaohJumpBack;
                    }
                    else
                    {
                        if (x > target.x)
                            sprite_index = sprPharaohJumpBack;
                        else
                            sprite_index = sprPharaohJump;
                    }
                }


                // When grounded, end the jump
                if (ground == true)
                {
                    phase = 0;
                    sprite_index = sprPharaohStand;
                    xspeed = 0;
                    yspeed = 0;
                }
                break;



            case 2: // Jumping 'n shooting
                if (attackTimer <= 0)
                {
                    attackTimer = 35 - (global.difficulty == DIFF_HARD * 10);
                    jumpTimer = 0;

                    startXScale = image_xscale;
                    yspeed = -5;
                    sprite_index = sprPharaohJump;
                    ground = false;
                }

                if (sprite_index == sprPharaohJump
                    || sprite_index == sprPharaohJumpBack)
                {
                    jumpTimer += 1;
                    if (jumpTimer >= 10)
                    {
                        sprite_index = sprPharaohJumpShoot;
                        image_index = 0;
                        image_speed = 6 / 60;
                    }
                }
                else if (sprite_index == sprPharaohJumpShoot
                    || sprite_index == sprPharaohJumpShootBack)
                {
                    if (floor(image_index) == 1)
                    {
                        if (canInitShoot == true)
                        {
                            canInitShoot = false;

                            var box;
                            if (image_xscale == 1)
                                box = bbox_right;
                            else
                                box = bbox_left;

                            instance_create(box, y - 8, objPharaohManShot);
                        }

                        image_speed = 6 / 60;
                    }
                    else if (ceil(image_index) == image_number - 1)
                    {
                        image_index = image_number - 1;
                        image_speed = 0;
                    }
                    else
                    {
                        image_speed = 6 / 60;
                    }
                }

                if (!checkSolid(startXScale * 2, 0))
                {
                    xspeed = startXScale * 2;
                }
                else
                {
                    while (place_meeting(x, y, objSolid))
                        x -= image_xscale;

                    xspeed = 0;
                }


                // Either jump again or end the phase
                if (ground == true)
                {
                    if (jumpAmount == 0)
                    {
                        sprite_index = sprPharaohJump;
                        jumpTimer = 0;
                        jumpAmount = 1;
                        canInitShoot = true;
                        yspeed = -5;
                    }
                    else
                    {
                        jumpAmount = 0;
                        canInitShoot = true;
                        phase = 0;
                        sprite_index = sprPharaohStand;
                        xspeed = 0;
                        yspeed = 0;
                    }
                }


                // Face the player
                if (instance_exists(target))
                {
                    if (startXScale == -1)
                    {
                        if (sprite_index == sprPharaohJump
                            || sprite_index == sprPharaohJumpBack)
                        {
                            if (x > target.x)
                                sprite_index = sprPharaohJump;
                            else
                                sprite_index = sprPharaohJumpBack;
                        }
                        else if (sprite_index == sprPharaohJumpShoot
                            || sprite_index == sprPharaohJumpShootBack)
                        {
                            if (x > target.x)
                                sprite_index = sprPharaohJumpShoot;
                            else
                                sprite_index = sprPharaohJumpShootBack;
                        }
                    }
                    else
                    {
                        if (sprite_index == sprPharaohJump
                            || sprite_index == sprPharaohJumpBack)
                        {
                            if (x > target.x)
                                sprite_index = sprPharaohJumpBack;
                            else
                                sprite_index = sprPharaohJump;
                        }
                        else if (sprite_index == sprPharaohJumpShoot
                            || sprite_index == sprPharaohJumpShootBack)
                        {
                            if (x > target.x)
                                sprite_index = sprPharaohJumpShootBack;
                            else
                                sprite_index = sprPharaohJumpShoot;
                        }
                    }
                }
                break;



            case 3: // Shooting a big shot
                if (attackTimer <= 0)
                {
                    attackTimer = 35 - (global.difficulty == DIFF_HARD * 10);
                    jumpTimer = 0;

                    sprite_index = sprPharaohCharge;
                    image_speed = 0.25;
                    image_index = 0;
                }

                if (sprite_index
                    == sprPharaohCharge) // This extra code is to make sure the animation resumes after pausing and unpausing
                    image_speed = 0.25;
                else if (sprite_index == sprPharaohCharge2)
                    image_speed = 0.07;
                else if (sprite_index == sprPharaohCharge3)
                    image_speed = 1;

                jumpTimer += 1; // It's not really a timer for jumping, but rather for releasing the shot; however, reusing this variable saves initializing a new one
                if (jumpTimer >= 40)
                {
                    if (jumpTimer == 40)
                    {
                        sprite_index = sprPharaohCharge2;
                        image_index = 0;
                        image_speed = 0.07;
                    }
                    else if (jumpTimer == 60)
                    {
                        sprite_index = sprPharaohCharge3;
                        image_index = 1;
                        image_speed = 1;
                    }
                    else if (jumpTimer == 70)
                    {
                        sprite_index = sprPharaohShoot;

                        var shootID, box;
                        if (image_xscale == 1)
                            box = bbox_right + 10;
                        else
                            box = bbox_left - 10;

                        shootID = instance_create(box, y + 2,
                            objPharaohManShotBig);
                        shootID.image_xscale = image_xscale;

                        // Curve the waves if on Hard Mode
                        if (global.difficulty == DIFF_HARD && instance_exists(target))
                        {
                            if (target.y > y + 8)
                            {
                                shootID.yspeed = 1;
                            }
                            else if (target.y < y - 8)
                            {
                                shootID.yspeed = -1;
                            }
                        }
                    }
                    else if (jumpTimer == 75)
                    {
                        phase = 0;
                        sprite_index = sprPharaohStand;
                        xspeed = 0;
                        yspeed = 0;
                    }
                }
                break;


            case 4: // Hard Mode exclusive attack
                if (attackTimer <= 0)
                {
                    attackTimer = 35 - (global.difficulty == DIFF_HARD * 10);
                    jumpTimer = 0;

                    sprite_index = sprPharaohCharge;
                    image_speed = 0.25;
                    image_index = 0;
                }

                jumpTimer += 1; // It's not really a timer for jumping, but rather for releasing the shot; however, reusing this variable saves initializing a new one

                if (jumpTimer == 40)
                {
                    playSFX(sfxSolarBlaze);
                    instance_create(x, y, objPharaohManShotHardmode);
                }

                if (jumpTimer == 80)
                {
                    phase = 0;
                    jumpTimer = 0;
                    sprite_index = sprPharaohStand;
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
with (objPharaohManShot)
    instance_destroy();
with (objPharaohManShotBig)
    instance_destroy();
with (objPharaohManShotHardmode)
    instance_destroy();

event_inherited();
