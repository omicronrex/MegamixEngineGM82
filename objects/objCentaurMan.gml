#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
// Creation code (all optional):
// randomSpawn = true; -
event_inherited();

healthpointsStart = 28;
healthpoints = healthpointsStart;

pose = sprCentaurIntro;
poseImgSpeed = 12 / 60;
contactDamage = 4;

ground = false;
attackTimer = 0;

//@cc use this if you want Centaur Man to teleport to random locations rather than on top of mega man. only use this if you are particularly dickish.
randomSpawn = false;

// rather than using game maker's image offset features, this time round we're building a more accurate animation system.
imageTimer = 0;
imageTimerMax = 99;

// this is the minmum image_indexs of centaur man for any given animation. imageNoMin is what the image_index is set to when centaur man has finished an animation.
imageNoMin = 0;

phase = 0;
oldPhase = 4;

jumpY = -4;
walkX = 1.5;

walkSound = false;
canJump = false;
hasFired = false;

// this is set to true to begin with to stop the unfair attack of centaur man using centaur flash straight away. it also stops him from firing twice in a row through using centaur flash and then a regular shot, or visa versa.
hasCentaurFlashed = true;

delay = 0;

// plant man has a bit of randomised timing shenangians going on. this variable sets it.
randomiser = irandom_range(1, 4);
timeStopLock = false;

// Health Bar
healthBarPrimaryColor[1] = 35;
healthBarSecondaryColor[1] = 40;

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
enemyDamageValue(objLaserTrident, 4);
enemyDamageValue(objWaterShield, 1);
enemyDamageValue(objTornadoBlow, 1);
enemyDamageValue(objThunderBeam, 2);
enemyDamageValue(objBreakDash, 2);
enemyDamageValue(objMagneticShockwave, 1);
enemyDamageValue(objIceWall, 2);

// MaGMML2
enemyDamageValue(objHornetChaser, 0);
enemyDamageValue(objJewelSatellite, 0);
enemyDamageValue(objGrabBuster, 1);
enemyDamageValue(objTripleBlade, 4);
enemyDamageValue(objWheelCutter, 1);
enemyDamageValue(objSlashClaw, 1);
enemyDamageValue(objSakugarne, 1);
enemyDamageValue(objSuperArrow, 3);
enemyDamageValue(objWireAdapter, 2);

// MaGMML1
enemyDamageValue(objMetalBlade, 4);
enemyDamageValue(objGeminiLaser, 2);
enemyDamageValue(objSolarBlaze, 1);
enemyDamageValue(objTopSpin, 1);
enemyDamageValue(objThunderWool, 1);
enemyDamageValue(objPharaohShot, 2);
enemyDamageValue(objBlackHoleBomb, 1);
enemyDamageValue(objMagicCard, 2);

// MaG48HMML
enemyDamageValue(objFlameMixer, 1);
enemyDamageValue(objRainFlush, 1);
enemyDamageValue(objSparkShock, 1);
enemyDamageValue(objSearchSnake, 2);
enemyDamageValue(objTenguBlade, 4);
enemyDamageValue(objSaltWater, 1);
enemyDamageValue(objConcreteShot, 1);
enemyDamageValue(objHomingSniper, 2);

// MaG24HMML
enemyDamageValue(objSuperArmBlockProjectile, 1);
enemyDamageValue(objSuperArmDebris, 1);
enemyDamageValue(objChillShot, 1);
enemyDamageValue(objChillSpikeLanded, 4);

// Misc.
enemyDamageValue(objPowerStone, 1);
enemyDamageValue(objPlantBarrier, 1);
enemyDamageValue(objBrickWeapon, 1);
enemyDamageValue(objIceSlasher, 1);
#define Alarm_7
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=605
invert=0
arg0=centaur man has teleported
*/
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if (objCentaurDetector.shuntedIntoRoof == false
    && objCentaurDetector.hitFloor == true)
{
    calibrateDirection();
    y = objCentaurDetector.y;
    x = objCentaurDetector.x;
    drawBoss = true;
}
#define Alarm_8
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=605
invert=0
arg0=randomiser
*/
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if (hasCentaurFlashed == false)
    randomiser = irandom_range(1, 4);
else
    randomiser = irandom_range(2, 3);
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

        // resets the image timer if centaur man ever changes poses
        if (pose != sprite_index)
        {
            pose = sprite_index;
            imageTimer = 0;
        }

        // prevent centaur man from using the same action twice in a row
        if (randomiser == oldPhase)
        {
            if (hasCentaurFlashed == false)
                randomiser = irandom_range(1, 4);
            else
                randomiser = irandom_range(2, 3);
        }

        // because centaur man is being a git and sometimes selecting to fire centaur flash and a regular shot and i have no idea why, i am forcing the issue here.
        if ((hasCentaurFlashed == true && randomiser == 1)
            || (hasCentaurFlashed == true && randomiser == 4))
            randomiser = irandom_range(2, 3);

        if (phase > 0 && phase != oldPhase)
            oldPhase = phase;

        if (phase > 1 && phase < 4 && hasCentaurFlashed == true)
            hasCentaurFlashed = false;

        // create teleport detector if it doesn't already exist. this ensures centaur man can't get stuck.
        if (!instance_exists(objCentaurDetector))
            instance_create(x, view_yview + 112, objCentaurDetector);

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

        // reset walk sound variable if not walking.
        if (phase != 2)
            walkSound = false;

        // centaur man's attack pattern appears to be completely random, welp.. at the very least he doesn't perform the same action twice in a row.

        switch (phase)
        {
            case 0: // initial idle
                calibrateDirection();
                xspeed = 0;
                imageNoMin = 0;
                imageTimerMax = 9999;
                sprite_index = sprCentaurIdle;
                hasFired = false;
                if (attackTimer >= 25)
                {
                    alarm[8] = 1;
                    timeStopLock = playerTimeRestored(timeStopLock);
                    delay = 5;
                    phase = randomiser;

                    attackTimer = 0;
                }
                break;
            case 1: // shoot centaur shot
                xspeed = 0;
                imageTimerMax = 10;
                imageNoMin = 1;
                sprite_index = sprCentaurShoot;
                if (hasFired == false && image_index == 1)
                {
                    cS = instance_create(x + (20 * image_xscale), y + 3,
                        objCentaurShot);
                    cS.image_xscale = image_xscale;
                    cS.xspeed = 2 * cS.image_xscale;
                    hasFired = true;
                    hasCentaurFlashed = true;
                    delay = 56;
                }

                // for some stupid reason this thing ins't working ARGGGH
                if (hasFired == true)
                    image_index = 1;
                if (instance_exists(objCentaurShot))
                    delay = 56;
                if (!instance_exists(objCentaurShot)
                    && hasFired == true && delay == 0)
                {
                    xspeed = 0;
                    phase = 0;
                }
                break;
            case 2: // walk
                imageNoMin = 0;
                oldPhase = 2;

                // detect upper wall - this determines whether centaur man can jump or not. this is not part of the original pattern but was added for more options in room design:
                if (!checkSolid(3 * image_xscale, -32, 0, 1))
                {
                    canJump = true;
                }
                else
                    canJump = false;

                // if centaur man hits a wall, he stops and performs another random action.
                if (xspeed == 0 && delay == 0 && canJump == false)
                {
                    xspeed = 0;
                    attackTimer = 0;
                    image_xscale = image_xscale * -1;
                    phase = 0;
                }

                // if centaur man hits a wall he can jump over, he does so
                if (xspeed == 0 && delay == 0 && canJump == true
                    && ground == true)
                {
                    yspeed = jumpY;
                    delay = 5;
                    sprite_index = sprCentaurJump;
                }

                // when centaur man hits the ground, continue walking.
                if (ground == true && delay <= 1
                    && sprite_index != sprCentaurWalk)
                {
                    sprite_index = sprCentaurWalk;
                    imageTimerMax = 7;
                    xspeed = walkX * image_xscale;
                }

                // animation / sfx setup
                // if centaur man is walking, play his walking sound, if he's jumping, set his jumping frames to the appropriate one.
                if (sprite_index == sprCentaurWalk)
                {
                    switch (image_index)
                    {
                        case 1:
                            if (walkSound == false)
                                playSFX(sfxCentaurWalk);
                            walkSound = true;
                            break;
                        case 3:
                            walkSound = false;
                            break;
                    }
                }
                else if (sprite_index == sprCentaurJump)
                {
                    xspeed = walkX * image_xscale;
                    walkSound = false;
                    imageTimerMax = 9999;
                    if (yspeed <= 0)
                        image_index = 0;
                    else
                        image_index = 1;
                }
                break;
            case 3: // teleport - start teleport animation, turn indrawBoss for a period, then teleport to mega man's location. location is determined by position of detector.
                calibrateDirection();
                imageNoMin = 0;
                contactDamage = 0;
                canHit = false;
                if (hasFired == false && attackTimer < 20)
                {
                    attackTimer = 0;
                    sprite_index = sprCentaurTeleport;
                    playSFX(sfxCentaurTeleport);
                    imageTimerMax = 2;
                    hasFired = true;
                }
                if (hasFired == true && attackTimer >= 20 && attackTimer < 120)
                {
                    drawBoss = false;
                }
                if (attackTimer >= 120 && hasFired == true)
                {
                    hasFired = false;
                    playSFX(sfxCentaurTeleport);
                    alarm[7] = 2;
                }
                if (attackTimer >= 160)
                {
                    attackTimer = 0;
                    canHit = true;
                    contactDamage = 4;
                    phase = 0;
                }
                break;
            case 4: // centaur flash!
                sprite_index = sprCentaurFlash;
                if (image_index != 1)
                {
                    calibrateDirection();
                    imageNoMin = 1;
                    imageTimerMax = 16;
                    hasFired = false;
                }
                if (image_index == 1 && hasFired == false && delay == 0)
                {
                    playSFX(sfxCentaurFlash);
                    instance_create(view_xview + (view_wview / 2),
                        view_yview + (view_hview / 2), objCentaurFlash);
                    hasFired = true;
                    timeStopLock = playerTimeStopped();
                    with (objWheelCutter)
                    {
                        attached = false;
                    }
                    delay = 55;
                    hasCentaurFlashed = true;
                }
                if (attackTimer >= 50)
                {
                    delay = 10;
                    attackTimer = 0;
                    hasFired = false;
                    phase = 1;
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
// restore time and destroy additional projectiles.
playerTimeRestored(timeStopLock);

with (objCentaurShot)
{
    instance_destroy();
}
with (objCentaurSecondaryBullet)
{
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
