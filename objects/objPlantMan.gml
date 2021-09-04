#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();

healthpointsStart = 28;
healthpoints = healthpointsStart;
pose = sprPlantIntro;
poseImgSpeed = 10 / 60;
contactDamage = 4;
ground = false;
attackTimer = 0;

// rather than using game maker's image offset features, this time round we're building a more accurate animation system.
imageTimer = 0;
imageTimerMax = 99;

// this is the minmum image_indexs of plant man for any given animation. imageNoMin is what the image_index is set to when plant man has finished an animation.
imageNoMin = 0;
phase = 0;
jumpY = -8;
walkX = 2.5 + ((global.difficulty == DIFF_HARD) * 0.75);
walkDestination = 0;
delay = 0;
guard = 0;

// plant man has a bit of randomised timing shenangians going on. this variable sets it.
// randomize();
randomiser = -1;

// Health Bar
healthBarPrimaryColor[1] = 16;
healthBarSecondaryColor[1] = 35;

// Music
music = "Mega_Man_6.nsf";
musicType = "VGM";
musicTrackNumber = 12;

// Damage Table
enemyDamageValue(objBusterShot, 1);
enemyDamageValue(objBusterShotHalfCharged, 1);
enemyDamageValue(objBusterShotCharged, 3);

// MaGMML3
enemyDamageValue(objSparkChaser, 1);
enemyDamageValue(objLaserTrident, 2);
enemyDamageValue(objWaterShield, 1);
enemyDamageValue(objTornadoBlow, 2);
enemyDamageValue(objThunderBeam, 1);
enemyDamageValue(objBreakDash, 1);
enemyDamageValue(objMagneticShockwave, 2);
enemyDamageValue(objIceWall, 4);

// MaGMML2
enemyDamageValue(objHornetChaser, 4);
enemyDamageValue(objJewelSatellite, 1);
enemyDamageValue(objGrabBuster, 1);
enemyDamageValue(objTripleBlade, 2);
enemyDamageValue(objWheelCutter, 1);
enemyDamageValue(objSlashClaw, 1);
enemyDamageValue(objSakugarne, 2);
enemyDamageValue(objSuperArrow, 1);
enemyDamageValue(objWireAdapter, 1);

// MaGMML1
enemyDamageValue(objMetalBlade, 2);
enemyDamageValue(objGeminiLaser, 1);
enemyDamageValue(objSolarBlaze, 5);
enemyDamageValue(objTopSpin, 1);
enemyDamageValue(objThunderWool, 1);
enemyDamageValue(objPharaohShot, 2);
enemyDamageValue(objBlackHoleBomb, 1);
enemyDamageValue(objMagicCard, 1);

// MaG48HMML
enemyDamageValue(objFlameMixer, 5);
enemyDamageValue(objRainFlush, 3);
enemyDamageValue(objSparkShock, 1);
enemyDamageValue(objSearchSnake, 1);
enemyDamageValue(objTenguBlade, 3);
enemyDamageValue(objTenguDash, 3);
enemyDamageValue(objTenguDisk, 3);
enemyDamageValue(objSaltWater, 2);
enemyDamageValue(objConcreteShot, 3);
enemyDamageValue(objHomingSniper, 1);

// MaG24HMML
enemyDamageValue(objSuperArmBlockProjectile, 1);
enemyDamageValue(objSuperArmDebris, 1);
enemyDamageValue(objChillShot, 2);
enemyDamageValue(objChillSpikeLanded, 4);

// Misc.
enemyDamageValue(objPowerStone, 1);
enemyDamageValue(objPlantBarrier, 0);
enemyDamageValue(objBrickWeapon, 1);
enemyDamageValue(objIceSlasher, 4);
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();
if (randomiser == -1)
{
    randomiser = irandom_range(1, 4);
}
if (entityCanStep())
{
    if (isFight == true)
    {
        image_speed = 0;

        // resets the image timer if plant man ever changes poses
        if (pose != sprite_index)
        {
            pose = sprite_index;
            imageTimer = 0;
        }
        attackTimer += 1;
        if (delay > 0)
            delay -= 1;
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
        switch (phase)
        {
            case 0: // idle - begin animation and play generate plant barrier animation
            // setup animation for this sprite index.
                xspeed = 0;
                randomiser = irandom_range(1, 3);
                sprite_index = sprPlantGeneratePlantBarrier;
                imageNoMin = 0;
                imageTimerMax = 2;
                if (attackTimer >= 6)
                {
                    phase = 1;
                    attackTimer = 0;
                }
                break;
            case 1: // generate plant barrier // pre jump
                if (!instance_exists(objPlantBarrierBoss))
                {
                    guard = 1;
                    var i;
                    for (i = 0; i < 4; i += 1)
                    {
                        WS = instance_create(x, y, objPlantBarrierBoss);
                        WS.cAngle = degtorad(90 * i);
                        WS.image_xscale = image_xscale;
                    }
                    playSFX(sfxBlizzardAttack);
                }
                if (attackTimer <= 9)
                {
                    sprite_index = sprPlantIdle;
                    imageTimerMax = 9999;
                }
                if (attackTimer
                    == 10) // which direction plant man jumps in is determined randomly. i think.
                {
                    if (randomiser mod 2 == 0)
                        image_xscale = -1;
                    else
                        image_xscale = 1;
                }
                if (attackTimer > 9)
                {
                    sprite_index = sprPlantGeneratePlantBarrier;
                    image_index = 1;
                }
                if (attackTimer >= 18)
                {
                    randomiser = irandom_range(1, 3);
                    phase = 2;
                    attackTimer = 0;
                }
                break;
            case 2: // jump!
                xspeed = walkX * image_xscale;
                yspeed = jumpY + randomiser;
                sprite_index = sprPlantJump;
                delay = 5;
                phase = 3;
                break;
            case 3: // rebound off wall and land.
                if (xspeed == 0)
                {
                    image_xscale = image_xscale * -1;
                    xspeed = walkX * image_xscale;
                }
                if (ground == true && delay == 0)
                {
                    // setup next phase - face mega man and play throwing sound effect.
                    playSFX(sfxEnemyShoot);
                    calibrateDirection();
                    phase = 4;
                }
                break;
            case 4: // throw plant barrier!
                guard = 0;
                sprite_index = sprPlantThrow;
                xspeed = 0;
                var plantXS;
                plantXS = image_xscale;
                with (objPlantBarrierBoss)
                    xspeed = 2 * plantXS;
                if (!instance_exists(objPlantBarrierBoss))
                {
                    if (instance_exists(target))
                        walkDestination = target.x;
                    phase = 5;
                }
                break;
            case 5: // walk towards mega man
                if (walkDestination != 0)
                {
                    if (sprite_index != sprPlantWalk)
                    {
                        calibrateDirection();
                        sprite_index = sprPlantWalk;
                        xspeed = walkX * image_xscale;
                        imageNoMin = 0;
                        imageTimerMax = 4;
                    }
                    if ((image_xscale == 1 && x >= walkDestination)
                        || (image_xscale == -1 && x <= walkDestination) || xspeed == 0)
                    {
                        walkDestination = 0;
                        attackTimer = 0;

                        // if on hard mode, there's a chance to shoot his buster
                        if (global.difficulty == DIFF_HARD)
                            phase = choose(0, 6, 6);
                        else
                            phase = 0;
                    }
                }
                else
                {
                    attackTimer = 0;
                    phase = 0;
                }
                break;
            case 6: // hard mode only attack - shoot a few bullets at mega man
                xspeed = 0;
                sprite_index = sprPlantShoot;
                imageNoMin = 0;
                imageTimerMax = 2;
                if (instance_exists(target) && attackTimer <= 140)
                {
                    if (attackTimer mod 30 == 15 && instance_exists(target))
                    {
                        calibrateDirection();
                        var i = instance_create(x + 20 * image_xscale, y - 4, objEnemyBullet);
                        i.sprite_index = sprEnemyBulletMM6;
                        i.contactDamage = 3;
                        i.xspeed = 3 * other.image_xscale;
                        i.yspeed = random_range(-1, 1);
                        playSFX(sfxEnemyShoot);
                    }
                }
                else
                {
                    phase = 0;
                    attackTimer = 0;
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
with (objPlantBarrierBoss)
    instance_destroy();
event_inherited();
#define Other_21
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();

// guard if guarding (!!)
if (guard)
{
    other.guardCancel = 1;
}
#define Draw_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();