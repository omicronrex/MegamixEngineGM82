#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
// Creation code (all optional):
// infiniteCrashBombs = true; -
event_inherited();

healthpointsStart = 28;
healthpoints = healthpointsStart;
pose = sprCrashIntro;
poseImgSpeed = 4 / 60;
contactDamage = 4;
ground = false;
attackTimer = 0;
beginAttackTimer = false;

// rather than using game maker's image offset features, this time round we're building a more accurate animation system.
imageTimer = 0;
imageTimerMax = 99;

// this is the minmum image_indexs of crash man for any given animation. imageNoMin is what the image_index is set to when plant man has finished an animation.
imageNoMin = 0;
attackTimerMax = 145;
phase = 0;
jumpY = -6.5;
walkX = 1.3;
delay = 0;
hasFired = false;

//@cc use this if you want Crash Man to use infinite Crash Bombs. only use this if you are particularly dickish.
infiniteCrashBombs = false;

stopOnFlash = false;

// Health Bar
healthBarPrimaryColor[1] = 19;
healthBarSecondaryColor[1] = 40;

// Music
music = "Mega_Man_2.nsf";
musicType = "VGM";
musicTrackNumber = 17;

// Damage Table
enemyDamageValue(objBusterShot, 1);
enemyDamageValue(objBusterShotHalfCharged, 1);
enemyDamageValue(objBusterShotCharged, 3);

// MaGMML3
enemyDamageValue(objSparkChaser, 1);
enemyDamageValue(objLaserTrident, 2);
enemyDamageValue(objWaterShield, 1);
enemyDamageValue(objTornadoBlow, 6);
enemyDamageValue(objThunderBeam, 1);
enemyDamageValue(objBreakDash, 2);
enemyDamageValue(objMagneticShockwave, 1);
enemyDamageValue(objIceWall, 1);

// MaGMML2
enemyDamageValue(objHornetChaser, 1);
enemyDamageValue(objJewelSatellite, 0);
enemyDamageValue(objGrabBuster, 2);
enemyDamageValue(objTripleBlade, 0);
enemyDamageValue(objWheelCutter, 0);
enemyDamageValue(objSlashClaw, 4);
enemyDamageValue(objSakugarne, 3);
enemyDamageValue(objSuperArrow, 2);
enemyDamageValue(objWireAdapter, 1);

// MaGMML1
enemyDamageValue(objMetalBlade, 0);
enemyDamageValue(objGeminiLaser, 2);
enemyDamageValue(objSolarBlaze, 1);
enemyDamageValue(objTopSpin, 4);
enemyDamageValue(objThunderWool, 1);
enemyDamageValue(objPharaohShot, 1);
enemyDamageValue(objBlackHoleBomb, 1);
enemyDamageValue(objMagicCard, 2);

// MaG48HMML
enemyDamageValue(objFlameMixer, 1);
enemyDamageValue(objRainFlush, 0);
enemyDamageValue(objSparkShock, 1);
enemyDamageValue(objSearchSnake, 1);
enemyDamageValue(objTenguBlade, 4);
enemyDamageValue(objTenguDash, 4);
enemyDamageValue(objTenguDisk, 4);
enemyDamageValue(objSaltWater, 2);
enemyDamageValue(objConcreteShot, 2);
enemyDamageValue(objHomingSniper, 0);

// MaG24HMML
enemyDamageValue(objSuperArmBlockProjectile, 1);
enemyDamageValue(objSuperArmDebris, 1);
enemyDamageValue(objChillShot, 1);
enemyDamageValue(objChillSpikeLanded, 2);

// Misc.
enemyDamageValue(objPowerStone, 0);
enemyDamageValue(objPlantBarrier, 0);
enemyDamageValue(objBrickWeapon, 0);
enemyDamageValue(objIceSlasher, 0);
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
// crash man was made to showcase how simple a robot master can be created - anyone who knows code should be able to look at this and modify crash man to suit their purpose.
// i've gone into greater detail with comments in this robot master. if you were to modify any robot master for your stage - crash man is a good one to start with!
// leave this. this is needed.
event_inherited();

// all of crash man's events trigger when the game isn't frozen. he isn't weak to flash stopper, so no need to check whether that is used or not!
if (entityCanStep())
{
    if (isFight == true)
    {
        // this sets up crash man's movement variables.
        image_speed = 0;

        // if crash man is walking, he turns around when he hits a wall, otherwise he doesn't.
        if (sprite_index == sprCrashWalk)
        {
            xSpeedTurnaround();
            if (checkSolid(28 * sign(xspeed), 0))
            {
                if (!checkSolid(-28 * sign(xspeed), 0))
                {
                    xspeed *= -1;
                    image_xscale *= -1;
                }
            }
        }

        // resets the image timer if crash man ever changes poses
        if (pose != sprite_index)
        {
            pose = sprite_index;
            imageTimer = 0;
        }

        // these control various timers crash man uses - attackTimer and delay.
        // attackTimer can trigger an attack to occur after a certain amount of ticks. (around 145)
        // Delay - Delay is useful to use to stop code from firing too quickly.
        if (beginAttackTimer == true)
            attackTimer += 1;
        if (delay > 0)
            delay -= 1;

        // this is the animation system. don't touch this.
        imageTimer += 1;
        if (imageTimer >= imageTimerMax && image_index < image_number - 1)
        {
            imageTimer = 0;
            image_index += 1;
        }
        if (imageTimer >= imageTimerMax && image_index == image_number - 1)
        {
            imageTimer = 0;
            image_index = imageNoMin;
        }

        // this is crash man's AI -
        // 0: walk until he hits a wall, turn around.
        // 1: jump when the fire button is pressed, or when he reaches a certain attack timer.
        // 2: fire when he reachs the apex of his jump. the aiming of the projectile is handled by the projetile itself.
        // 3: reset everything when he hits the ground.
        switch (phase)
        {
            case 0: // walk
            // crash man walk speed is dependant on what direction he is facing.
                xspeed = walkX * image_xscale;

                // this sets up the animation system. crash man changes animation frames every 8 ticks, and resets to the first frame of his animation.
                sprite_index = sprCrashWalk;
                imageNoMin = 0;
                imageTimerMax = 8;
                if (instance_exists(target))
                {
                    megax = target.x;

                    // if the shoot button is pressed, or crash man reaches a certain timer, he changes to phase 1, jumping.
                    if ((global.keyShootPressed[target.playerID])
                        || (attackTimer >= attackTimerMax))
                    {
                        beginAttackTimer = true;
                        sprite_index = sprCrashJump;
                        phase = 1;
                        attackTimer = 0;

                        // absolute returns a positive value, even if the input is a negative number.
                        randomiser = floor(abs(megax - x) / 32) * 0.5;
                        if (randomiser > 3)
                            randomiser = 3;
                        randomiser += irandom_range(0, 2) * 0.5;
                    }
                }
                break;
            case 1: // jump
                if (ground == true && delay == 0)
                {
                    // delay is added to prevent this triggered before he leaves the ground. this shouldn't be needed, but might be if you do anything more complex.
                    delay = 4;
                    calibrateDirection();
                    yspeed = jumpY;

                    // crash man's jumping speed is chosen randomly, with the value the randomiser has found above.
                    xspeed = randomiser * image_xscale;
                }
                if (ground == false && delay == 0)
                {
                    calibrateDirection();
                }

                // when crash man reaches the apex of his jump, he changes to phase 2
                if (ground == false && yspeed >= 0)
                {
                    phase = 2;
                    imageNoMin = 2;
                    imageTimerMax = 8;
                    sprite_index = sprCrashFire;
                    image_index = 1;
                }
                break;
            case 2: // fire crash bomber
                calibrateDirection();

                // when crash man hits a certain animation frame, he fires the crash bomb. he only fires if a crash bomb is not in existance.
                if (image_index == 2 && hasFired == false)
                {
                    if ((!instance_exists(objCrashBomber)
                        && infiniteCrashBombs == false)
                        || (infiniteCrashBombs == true))
                    {
                        cB = instance_create(x + (6 * image_xscale), y + 9,
                            objCrashBomber);
                        cB.image_xscale = image_xscale;
                        hasFired = true;
                    }
                    else
                        hasFired = true;
                }

                // when crash man hits the ground, he resets completely.
                if (ground == true)
                {
                    imageTimer = 0;
                    attackTimer = 0;
                    phase = 0;
                    hasFired = false;
                    delay = 0;
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
with (objHarmfulExplosion)
    instance_destroy();
with (objCrashBomber)
{
    instance_create(x, y, objExplosion);
    instance_destroy();
}
event_inherited();
#define Draw_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();
