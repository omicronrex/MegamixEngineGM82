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
contactDamage = 6;
customPose = true;
manualColors = true;
ground = false;
attackTimer = 0;
hasTriggeredFall = false;
introType = 0;
image_speed = 0;
shakeTimer = 0;
phase = 0;
setY = 0;
storeY = ystart;
delay = 0;
hasFired = false;
shotsFired = 0;
grav = 0.25;

// Health Bar
healthBarPrimaryColor[1] = make_colour_rgb(216, 40, 0);
healthBarSecondaryColor[1] = make_colour_rgb(248, 248, 248);

// Music
music = "Mega_Man_3GB.gbs";
musicType = "VGM";
musicTrackNumber = 9;

// Damage Table
enemyDamageValue(objBusterShot, 1);
enemyDamageValue(objBusterShotHalfCharged, 1);
enemyDamageValue(objBusterShotCharged, 3);

// MaGMML3
enemyDamageValue(objSparkChaser, 1);
enemyDamageValue(objLaserTrident, 2);
enemyDamageValue(objWaterShield, 2);
enemyDamageValue(objTornadoBlow, 0);
enemyDamageValue(objThunderBeam, 1);
enemyDamageValue(objBreakDash, 4);
enemyDamageValue(objMagneticShockwave, 6);
enemyDamageValue(objIceWall, 1);

// MaGMML2
enemyDamageValue(objHornetChaser, 1);
enemyDamageValue(objJewelSatellite, 2);
enemyDamageValue(objGrabBuster, 1);
enemyDamageValue(objTripleBlade, 0);
enemyDamageValue(objWheelCutter, 0);
enemyDamageValue(objSlashClaw, 4);
enemyDamageValue(objSakugarne, 2);
enemyDamageValue(objSuperArrow, 2);
enemyDamageValue(objWireAdapter, 1);

// MaGMML1
enemyDamageValue(objMetalBlade, 1);
enemyDamageValue(objGeminiLaser, 5);
enemyDamageValue(objSolarBlaze, 2);
enemyDamageValue(objTopSpin, 0);
enemyDamageValue(objThunderWool, 0);
enemyDamageValue(objPharaohShot, 1);
enemyDamageValue(objBlackHoleBomb, 1);
enemyDamageValue(objMagicCard, 2);

// MaG48HMML
enemyDamageValue(objFlameMixer, 2);
enemyDamageValue(objRainFlush, 3);
enemyDamageValue(objSparkShock, 0);
enemyDamageValue(objSearchSnake, 0);
enemyDamageValue(objTenguBlade, 0);
enemyDamageValue(objTenguDash, 4);
enemyDamageValue(objTenguDisk, 0);
enemyDamageValue(objSaltWater, 5);
enemyDamageValue(objConcreteShot, 1);
enemyDamageValue(objHomingSniper, 1);

// MaG24HMML
enemyDamageValue(objSuperArmBlockProjectile, 1);
enemyDamageValue(objSuperArmDebris, 1);
enemyDamageValue(objChillShot, 0);
enemyDamageValue(objChillSpikeLanded, 0);

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
// punk is based off his gameboy counterpart, but he uses the speed of his mega man 10 version due to screen size.
// leave this. this is needed.
event_inherited();

// all of punk's events trigger when the game isn't frozen.
if (!global.frozen)
{
    // during punk's intro, shake the screen even outside the fight.
    if (shakeTimer > 0)
    {
        shakeTimer -= 1;
        screenShake(2, 1, 1);
    }
    if (entityCanStep())
    {
        // Punk's custom intro
        if (startIntro)
        {
            calibrateDirection();
            y -= view_hview;
            canFillHealthBar = false;
            image_index = 9;
            startIntro = false;
            isIntro = true;
            visible = true;
        }
        else if (isIntro)
        {
            // custom intro:
            attackTimer += 1;
            if ((y <= ystart && !hasTriggeredFall) && attackTimer < 1000)
            {
                if (attackTimer > 64)
                    yspeed = 2;
                else
                {
                    if (attackTimer mod 4 == 1)
                        instance_create(x, y + 16, objPunkDebris);
                    shakeTimer = 20;
                }
                image_index = 9 + ((attackTimer / 4) mod 2);
                while (place_meeting(x, y, objSolid) && (!hasTriggeredFall || attackTimer < 1000))
                {
                    with (instance_place(x, y, objSolid))
                    {
                        if (image_xscale > 1 || image_yscale > 1)
                        {
                            splitSolid();
                        }
                        else
                        {
                            instance_create(bboxGetXCenter(), bboxGetYCenter(),
                                objExplosion);
                            playSFX(sfxEnemyHit);
                            playSFX(sfxPunkEntrance);
                            instance_create(x, y, objRollingDrillField);
                            instance_deactivate_object(id);
                        }
                    }
                }
            }
            if ((y >= view_yview + view_hview / 2 || hasTriggeredFall) && attackTimer < 1000)
            {
                if (!hasTriggeredFall && !ground)
                {
                    attackTimer = 0;
                    hasTriggeredFall = true;
                    yspeed = 0;
                    image_index = 8;
                }
                image_speed = 0;
                if (attackTimer == 10)
                    image_index = 7;
                if (attackTimer == 20)
                    image_index = 6;
                if (attackTimer == 30)
                    image_index = 3;
                if (attackTimer > 20 && hasTriggeredFall)
                {
                    blockCollision = 1;
                    grav = gravAccel;
                    if (ground)
                    {
                        hasTriggeredFall = false;
                        attackTimer = 1000;
                        image_index = 1;
                    }
                }
            }
            if (ground && !hasTriggeredFall)
            {
                canFillHealthBar = true;
                if (attackTimer == 1015 || attackTimer == 1055)
                    image_index = 0;
                if (attackTimer == 1025 || attackTimer == 1045 || attackTimer == 1080)
                    image_index = 1;
                if (attackTimer == 1035)
                    image_index = 2;
                if (attackTimer > 1090)
                {
                    attackTimer = 0;
                    isIntro = false;
                    grav = gravStart;
                    blockCollision = blockCollisionStart;
                    //image_index = 0;
                }
            }
        }
    }
    if (isFight == true)
    {
        image_speed = 0;
        attackTimer += 1;
        switch (phase)
        {
            case 0: // stand
                switch (attackTimer) // setup punk animation
                {
                    case 40:
                        image_index = 1;
                        setY = choose(0, 1, 2); // choose which height punk will fly across with.
                        storeY = y; // store punk's current y co-ordinate for comparsion's sake.
                        break;
                    case 48:
                        image_index = 6;
                        break;
                    case 56:
                        image_index = 7;
                        break;
                    case 64:
                        image_index = 8;
                        break;
                    case 72:
                        shotsFired = 1;
                        break;
                }
                if (shotsFired >= 1) // ball form animation
                    image_index = 9 + ((attackTimer / 4) mod 2);
                if (shotsFired >= 1 && shotsFired < 4) // these events will trigger whilst punk is in ball form.
                {
                    mask_index = mskPunk2;
                    if (ground && yspeed >= 0)
                    {
                        yspeed = -4;
                        shotsFired += 1;
                    }
                }
                if (shotsFired == 3 && yspeed > 0) // punk can fly across the screen at one of two heights, if he has fallen lower than the determined height, start flying across screen.
                {
                    if (setY == 0 && y >= storeY - 17)
                    {
                        yspeed = 0;
                        grav = 0;
                        y = storeY - 16;
                        shotsFired = 4;
                        attackTimer = 1000;
                    }
                    if (setY == 1 && y >= storeY - 5)
                    {
                        yspeed = 0;
                        grav = 0;
                        y = storeY - 4;
                        shotsFired = 4;
                        attackTimer = 1000;
                    }
                    if (setY == 2 && y >= storeY - 33)
                    {
                        yspeed = 0;
                        grav = 0;
                        y = storeY - 32;
                        shotsFired = 4;
                        attackTimer = 1000;
                    }
                }
                if (attackTimer >= 1005) // there is a brief delay to give the player a chance to react - punk is *quick*.
                {
                    xspeed = 6 * image_xscale;
                    playSFX(sfxScrewCrusher);
                    phase = 1;
                    ground = false;
                }
                break;
            case 1: // turn around
                if (attackTimer > 1000) // ball form animation
                    image_index = 9 + ((attackTimer / 4) mod 2);
                if (xcoll != 0) // if punk collides with a wall, turn around and reset his collision mask.
                {
                    shakeTimer = 20;
                    playSFX(sfxCommandoQuake);
                    image_xscale *= -1;
                    xspeed = 0;
                    mask_index = mskPunk1;
                    attackTimer = 0;
                }
                switch (attackTimer) // setup punk animation
                {
                    case 1:
                        image_index = 8;
                        shotsFired = 0;
                        break;
                    case 9:
                        image_index = 7;
                        break;
                    case 17:
                        image_index = 6;
                        break;
                    case 25:
                        image_index = 3;
                        break;
                    case 33:
                        grav = 0.25;
                        break;
                }
                if (ground)
                    image_index = 1;
                if (ground && attackTimer > 56 - (setY * 10))
                {
                    phase = 2;
                    image_index = 2;
                    attackTimer = -8;
                }
                break;
            case 2: // throw screw crusher
                if (ground && yspeed >= 0 && attackTimer >= 0)
                    image_index = 1;
                if (ground && yspeed >= 0 && attackTimer >= 16)
                {
                    yspeed = choose(-4,-5,-6);
                    shotsFired += 1;
                    image_index = 3;
                    attackTimer = -9999;
                }
                if (!ground && yspeed >= 0 && !place_meeting(x, y + 24, objSolid) && !place_meeting(x, y + 24, objTopSolid))
                    image_index = 4;
                if (!ground && yspeed >= 0 && !hasFired && (place_meeting(x, y + 24, objSolid) || place_meeting(x, y + 24, objTopSolid)))
                {
                    image_index = 5;
                    playSFX(sfxScrewCrusher);
                    instance_create(x + 4 * image_xscale, y - 4, objPunkScrewCrusher);
                    hasFired = true;
                }
                if (ground && hasFired)
                {
                    hasFired = false;
                    if (shotsFired == 3)
                    {
                        shotsFired = 0;
                        attackTimer = 0;
                        phase = 0;
                        image_index = 0;
                    }
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
event_inherited();

with (objPunkScrewCrusher)
    instance_create(x, y, objExplosion);
instance_destroy();
#define Other_21
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
// guard if in a ball
if (image_index >= 7)
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
