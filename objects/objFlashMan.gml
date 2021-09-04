#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();

healthpointsStart = 28;
healthpoints = healthpointsStart;
stopOnFlash = false;
pose = sprFlashIntro;
poseImgSpeed = 10 / 60;
image_index = 6;
contactDamage = 4;

ground = false;
attackTimer = 0;
beginAttackTimer = false;

phase = 0;
phaseTimer = 0;
flashTimer = 0;

// edit these in creation code
jumpHeight = 42;
walkSpeed = 1;
flashInterval = 5 * 60;
shootTime = 60;
isHard = false;
doFlash = 1;

// Health Bar
healthBarPrimaryColor[1] = 15;
healthBarSecondaryColor[1] = 40;

// Music
music = "Mega_Man_2.nsf";
musicType = "VGM";
musicTrackNumber = 17;

// Damage Tables
enemyDamageValue(objBusterShot, 2);
enemyDamageValue(objBusterShotHalfCharged, 2);
enemyDamageValue(objBusterShotCharged, 4);

// MaGMML3
enemyDamageValue(objSparkChaser, 1);
enemyDamageValue(objLaserTrident, 2);
enemyDamageValue(objWaterShield, 2);
enemyDamageValue(objTornadoBlow, 1);
enemyDamageValue(objThunderBeam, 2);
enemyDamageValue(objBreakDash, 2);
enemyDamageValue(objMagneticShockwave, 6);
enemyDamageValue(objIceWall, 1);

// MaGMML2
enemyDamageValue(objHornetChaser, 1);
enemyDamageValue(objJewelSatellite, 2);
enemyDamageValue(objGrabBuster, 2);
enemyDamageValue(objTripleBlade, 3);
enemyDamageValue(objSlashClaw, 1);
enemyDamageValue(objWheelCutter, 4);
enemyDamageValue(objSakugarne, 2);
enemyDamageValue(objSuperArrow, 2);
enemyDamageValue(objWireAdapter, 1);

// MaGMML1
enemyDamageValue(objMetalBlade, 4);
enemyDamageValue(objGeminiLaser, 4);
enemyDamageValue(objSolarBlaze, 2);
enemyDamageValue(objTopSpin, 1);
enemyDamageValue(objThunderWool, 2);
enemyDamageValue(objPharaohShot, 2);
enemyDamageValue(objBlackHoleBomb, 1);
enemyDamageValue(objMagicCard, 2);

// MaG48HMML
enemyDamageValue(objFlameMixer, 2);
enemyDamageValue(objRainFlush, 1);
enemyDamageValue(objSparkShock, 0);
enemyDamageValue(objSearchSnake, 1);
enemyDamageValue(objTenguBlade, 2);
enemyDamageValue(objTenguDash, 2);
enemyDamageValue(objTenguDisk, 1);
enemyDamageValue(objSaltWater, 2);
enemyDamageValue(objConcreteShot, 2);
enemyDamageValue(objHomingSniper, 4);

// MaG24HMML
enemyDamageValue(objSuperArmBlockProjectile, 2);
enemyDamageValue(objSuperArmDebris, 2);
enemyDamageValue(objChillShot, 2);
enemyDamageValue(objChillSpikeLanded, 4);

// Misc.
enemyDamageValue(objPowerStone, 2);
enemyDamageValue(objPlantBarrier, 6);
enemyDamageValue(objBrickWeapon, 2);
enemyDamageValue(objIceSlasher, 2);
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
        image_speed = 0;
        sprite_index = sprFlashman;

        var prevPhase = phase;

        switch (phase)
        {
            case 0: // walking/jumping
                xspeed = image_xscale * walkSpeed;
                flashTimer++;

                if (ground && flashTimer >= flashInterval)
                {
                    phase = 1;
                    break;
                }
                if (ground)
                {
                    // walk animation
                    image_index = 7 + (phaseTimer div 8) mod 4;

                    // consider jumping:
                    var doJump = false;

                    // if a player is shooting
                    for (var i = 0; i < global.playerCount; i++)
                        if (global.keyShootPressed[i])
                            doJump = true;

                    if (checkSolid(walkSpeed * 2 * image_xscale, 0))
                        doJump = true;

                    if (doJump)
                    {
                        // plan jump
                        yspeed = -sqrt(abs(2 * grav * jumpHeight));

                        // turn around if wall reached
                        if (checkSolid(walkSpeed * 2 * image_xscale, 0) && checkSolid(walkSpeed * 2 * image_xscale, -jumpHeight))
                            image_xscale *= -1;
                    }
                }
                else
                {
                    // in air
                    image_index = 6;
                }
                if (abs(x - view_xview[0] - view_wview[0] / 2) >= view_wview[0] / 2 - 16)
                    image_xscale = -sign(x - view_xview[0] - view_wview[0] / 2);
                break;
            case 1: // begin flash
                if (ground)
                {
                    xspeed = 0;
                    flashTimer = 0;
                    image_index = 2 + (phaseTimer div 8);

                    if (image_index >= 6)
                    {
                        if (isHard)
                        {
                            if (doFlash)
                                doFlash = choose(0, 1);
                            else
                            {
                                doFlash = 1;
                            }
                            if (!doFlash)
                            {
                                phase = 2;
                                phaseTimer = 30;
                                image_index = 0;
                                calibrateDirection();
                                playSFX(sfxFakeTimeStopper);
                                break;
                            }
                        }
                        phase = 2;
                        screenFlash(2);
                        playSFX(sfxTimeStopper);
                        instance_create(x, y, objFlashmanTimeStop);
                        calibrateDirection();
                    }
                }
                break;
            case 2: // prepare to shoot
                image_index = 0;
                if (phaseTimer >= 8)
                    image_index = 11;
                if (phaseTimer >= 42)
                    phase = 3;
                break;
            case 3: // shooting
                image_index = 11;
                if (phaseTimer mod 6 == 2)
                {
                    with (instance_create(x + 24 * image_xscale, y, objEnemyBullet))
                    {
                        sprite_index = sprFlashShot;
                        xspeed = 5.5 * other.image_xscale;
                        yspeed = random(2) - 1;
                        playSFX(sfxEnemyShootClassic);
                        stopOnFlash = false;
                    }
                }
                if (phaseTimer >= shootTime)
                {
                    if (isHard && !doFlash)
                    {
                        phase = 1;

                        calibrateDirection();
                        xspeed = 2 * image_xscale;
                        image_index = 6;

                        // plan jump
                        yspeed = -sqrt(abs(2 * grav * jumpHeight));

                        // turn around if wall reached
                        if (checkSolid(walkSpeed * 2 * image_xscale, 0) && checkSolid(walkSpeed * 2 * image_xscale, -jumpHeight))
                            image_xscale *= -1;
                    }
                    else
                        phase = 0;
                    with (objFlashmanTimeStop)
                        instance_destroy();
                }
                break;
        }

        phaseTimer++;

        // new phase -- reset timer
        if (prevPhase != phase)
        {
            phaseTimer = 0;
        }
    }

    // Heal from the Time Stopper
    if (instance_exists(objTimeStopper)) // && (phase == 0)
    {
        healthpoints += 28;
        stopOnFlash = true;
    }
    else
    {
        stopOnFlash = false;
    }
}
#define Other_20
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();

with (objFlashmanTimeStop)
    instance_destroy();
with (objEnemyBullet)
{
    instance_destroy();
}
#define Other_25
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();
if (spawned)
{
    if (isHard)
    {
        flashInterval = 3.75 * 60;
    }
}
