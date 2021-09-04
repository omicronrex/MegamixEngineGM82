#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();

healthpointsStart = 28;
healthpoints = healthpointsStart;
xOff = 0;
contactDamage = 4;
customPose = true;
ground = false;
attackTimer = 0;
hasTriggeredFall = false;
introType = 0;
bossTriggered = true;
delayUse = false;
attackTimerMax = 48;
phase = 0;
jumpY = -5.5;
setX = 48;
hasFired = false;
strMMX = 0;
strMMY = 0;
grav = 0.24;

// Health Bar
healthBarPrimaryColor[1] = 35;
healthBarSecondaryColor[1] = 40;

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
enemyDamageValue(objLaserTrident, 1);
enemyDamageValue(objWaterShield, 1);
enemyDamageValue(objTornadoBlow, 7);
enemyDamageValue(objThunderBeam, 2);
enemyDamageValue(objBreakDash, 1);
enemyDamageValue(objMagneticShockwave, 1);
enemyDamageValue(objIceWall, 2);

// MaGMML2
enemyDamageValue(objHornetChaser, 5);
enemyDamageValue(objJewelSatellite, 1);
enemyDamageValue(objGrabBuster, 1);
enemyDamageValue(objTripleBlade, 2);
enemyDamageValue(objWheelCutter, 1);
enemyDamageValue(objSlashClaw, 1);
enemyDamageValue(objSakugarne, 2);
enemyDamageValue(objSuperArrow, 1);
enemyDamageValue(objWireAdapter, 4);

// MaGMML1
enemyDamageValue(objMetalBlade, 1);
enemyDamageValue(objGeminiLaser, 2);
enemyDamageValue(objSolarBlaze, 1);
enemyDamageValue(objTopSpin, 1);
enemyDamageValue(objThunderWool, 4);
enemyDamageValue(objPharaohShot, 1);
enemyDamageValue(objBlackHoleBomb, 1);
enemyDamageValue(objMagicCard, 2);

// MaG48MML
enemyDamageValue(objFlameMixer, 2);
enemyDamageValue(objRainFlush, 4);
enemyDamageValue(objSparkShock, 2);
enemyDamageValue(objSearchSnake, 1);
enemyDamageValue(objTenguBlade, 1);
enemyDamageValue(objTenguDash, 1);
enemyDamageValue(objTenguDisk, 3);
enemyDamageValue(objSaltWater, 1);
enemyDamageValue(objConcreteShot, 2);
enemyDamageValue(objHomingSniper, 2);

// MaG48MML
enemyDamageValue(objSuperArmBlockProjectile, 1);
enemyDamageValue(objSuperArmDebris, 1);
enemyDamageValue(objChillShot, 1);
enemyDamageValue(objChillSpikeLanded, 2);

// Misc.
enemyDamageValue(objPowerStone, 1);
enemyDamageValue(objPlantBarrier, 4);
enemyDamageValue(objBrickWeapon, 4);
enemyDamageValue(objIceSlasher, 1);
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
// leave this. this is needed.
event_inherited();

// all of gyro man's events trigger when the game isn't frozen.
if (!global.frozen)
{
    // gyro man's custom intro
    if (startIntro)
    {
        y -= view_hview;
        canFillHealthBar = false;
        image_index = 6;
        startIntro = false;
        isIntro = true;
        visible = true;
        calibrateDirection();
    }
    else if (isIntro)
    {
        // custom intro:
        if (y <= ystart && !hasTriggeredFall)
            y += 4;
        if (y >= ystart || hasTriggeredFall)
        {
            hasTriggeredFall = true;
            y = ystart;
            image_speed = 0;
            attackTimer += 1;
            if (attackTimer < 4 || attackTimer == 6)
                image_index = 0;
            if (attackTimer == 6 || attackTimer == 20)
                image_index = 1;
            if ((attackTimer >= 14 && attackTimer < 20) || (attackTimer >= 28 && attackTimer < 40))
                image_index = 2 + ((attackTimer / 2) mod 2);
            if (attackTimer == 40)
                image_index = 0;
            if (attackTimer == 50)
            {
                canFillHealthBar = true;
                isIntro = false;
                attackTimer = 0;
                hasFired = true;
                grav = gravStart;
                blockCollision = blockCollisionStart;
            }
        }
    }
}
if (entityCanStep())
{
    if (isFight == true)
    {
        image_speed = 0;
        attackTimer += 1;
        if (yspeed != 0) // gyro man's flying animation. this goes through several "phases" so we reference it outside of the phase switch.
            image_index = 6 + ((attackTimer / 2) mod 2);
        if (instance_exists(target))
        {
            strMMX = target.x;
            strMMY = target.y;
        }
        switch (phase)
        {
            case 0: // choose attack
                calibrateDirection();
                image_index = 0;
                if (attackTimerMax == 0) // sometimes gyro man will sit there twiddling his thumbs for a while. this is an uncommon occurance.
                    attackTimerMax = choose(48, 48, 72);
                if (attackTimer >= attackTimerMax && attackTimerMax != 0)
                {
                    attackTimer = 0;
                    attackTimerMax = 48;
                    if (!hasFired) // if gyro man has fired gyro attack, he has a higher chance of gliding into the air, otherwise he has a higher chance of firing gyro attack.
                        phase = choose(1, 1, 2);
                    else
                        phase = choose(1, 2, 2);
                }
                break;
            case 1: // throw gyro attack
                if (attackTimer < 8)
                {
                    calibrateDirection();
                    image_index = 4;
                }
                if (attackTimer == 8)
                {
                    image_index = 5;
                    var sd = instance_create(x, y - 8, objGyroShot); // gyro attack is the vertical vartiety by default, if the xspeed is 1 then it'll find the correct speed in the gyro attack object.
                    sd.xspeed = 1;
                    sd.yspeed = 0;
                }
                if (attackTimer == 24)
                {
                    attackTimer = 0;
                    hasFired = true;
                    phase = 0;
                }
                break;
            case 2: // glide into air
            // animation
                if (attackTimer < 4)
                    image_index = 0;
                if (attackTimer == 6)
                    image_index = 1;
                if (attackTimer >= 14 && attackTimer < 48)
                    image_index = 2 + ((attackTimer / 2) mod 2);

                // start gliding into air
                if (attackTimer == 48)
                {
                    hasFired = false;
                    grav = 0;
                    yspeed = -2;
                    with (instance_create(x, y, objExplosion))
                        sprite_index = sprGyroDust;
                    blockCollision = 0; // disable collision, just in case someone puts in a cieling in the arena
                    phase = 3;
                }
                break;
            case 3: // gliding up
                if (y <= view_yview + view_hview / 2 && !hasFired) // whilst flying, create gyro attack at halfway point of screen.
                {
                    hasFired = true;
                    instance_create(x, y - 8, objGyroShot);
                }
                if (y <= view_yview - 8) // if outside of play arena, goto mega man's position, and then try to fall onto him
                {
                    x = strMMX;
                    yspeed = 0;
                    grav = 0.25;
                    phase = 4;
                }
                break;
            case 4: // falling down
                calibrateDirection();
                if (!place_meeting(x, y, objSolid) && blockCollision == 0) // so long as gyro man isnt colliding with a background, turn collision back on.
                {
                    blockCollision = 1;
                }
                if (ycoll != 0) // reset
                {
                    yspeed = 0;
                    attackTimer = 0;
                    attackTimerMax = 0;
                    hasFired = false;
                    phase = 0;
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
with (objGyroShot)
    instance_destroy();
event_inherited();
