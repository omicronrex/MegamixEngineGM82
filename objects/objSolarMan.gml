#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();

healthpointsStart = 28;

contactDamage = 5;
customPose = true;
ground = false;
stopOnFlash = false;

attackTimer = 0;
hasTriggeredFall = false;
introType = 1;

phase = 0;
realXSpeed = 0; // Use this to remember xspeed

// Set the level of Solar Man's sun - 0 = weakest, 1 = normal, 2 = strongest.
if (global.difficulty == DIFF_HARD)
{
    sunLevel = 2;
    canPraise = true;
}
else
{
    canPraise = false;
    if (global.difficulty == DIFF_EASY)
        sunLevel = 0;
    else
        sunLevel = 1;
}

shots = 0; // How many shots have been fired?
canLean = 0; // Can I lean forwards?
rainSuns = 0; // Will I use my special attack?
chooseJumpX = 0; // solar man's target x position
chooseJumpY = 0; // solar man's target y position
xCross = 0; // how far solar man jumps in x value
jumpDist = 0; // the multiplier for solar man's jumps
ceiling = -1; // stores the y position of the cieling
middlePlatform = 64; // @ cc the size of the middle platform.
hasFired = false;

// Health Bar
manualColors = true;
healthBarPrimaryColor[1] = make_colour_rgb(200, 72, 8); // Orange
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
enemyDamageValue(objSparkChaser, 1);
enemyDamageValue(objLaserTrident, 2);
enemyDamageValue(objWaterShield, 6);
enemyDamageValue(objTornadoBlow, 3);
enemyDamageValue(objThunderBeam, 1);
enemyDamageValue(objBreakDash, 1);
enemyDamageValue(objMagneticShockwave, 2);
enemyDamageValue(objIceWall, 2);

// MaGMML2
enemyDamageValue(objHornetChaser, 2);
enemyDamageValue(objJewelSatellite, 5);
enemyDamageValue(objGrabBuster, 1);
enemyDamageValue(objTripleBlade, 1);
enemyDamageValue(objSlashClaw, 2);
enemyDamageValue(objWheelCutter, 1);
enemyDamageValue(objSakugarne, 0);
enemyDamageValue(objSuperArrow, 1);
enemyDamageValue(objWireAdapter, 4);

// MaGMML1
enemyDamageValue(objMetalBlade, 1);
enemyDamageValue(objGeminiLaser, 2);
enemyDamageValue(objSolarBlaze, 1);
enemyDamageValue(objTopSpin, 5);
enemyDamageValue(objThunderWool, 1);
enemyDamageValue(objPharaohShot, 1);
enemyDamageValue(objBlackHoleBomb, 2);
enemyDamageValue(objMagicCard, 1);

// MaG48HMML
enemyDamageValue(objFlameMixer, 1);
enemyDamageValue(objRainFlush, 5);
enemyDamageValue(objSparkShock, 1);
enemyDamageValue(objSearchSnake, 1);
enemyDamageValue(objTenguBlade, 2);
enemyDamageValue(objTenguDash, 2);
enemyDamageValue(objTenguDisk, 2);
enemyDamageValue(objSaltWater, 2);
enemyDamageValue(objConcreteShot, 1);
enemyDamageValue(objHomingSniper, 1);

// MaG24HMML
enemyDamageValue(objSuperArmBlockProjectile, 1);
enemyDamageValue(objSuperArmDebris, 1);
enemyDamageValue(objChillShot, 1);
enemyDamageValue(objChillSpikeLanded, 1);

// Misc.
enemyDamageValue(objPowerStone, 4);
enemyDamageValue(objPlantBarrier, 0);
enemyDamageValue(objBrickWeapon, 4);
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
    // Solar Man's custom intro
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
        if (attackTimer == 0) && (introType == 1)
        {
            image_index = 1;
        }
        if (y >= ystart || hasTriggeredFall)
        {
            hasTriggeredFall = true;
            y = ystart;

            attackTimer++;
            if (attackTimer < 20) && (attackTimer > 0)
                image_index = 0;
            if (attackTimer == 20)
                image_index = 2;
            if (attackTimer == 30)
                image_index = 3;
            if (attackTimer == 50)
            {
                instance_create(x + 5 * image_xscale, y - 10, objSolarSun);
                playSFX(sfxSolarManSun);
            }
            if (attackTimer > 50)
            {
                with (objSolarSun)
                {
                    if (y > other.y - 13)
                    {
                        y--;
                    }
                    else
                    {
                        if ((image_index == 1.8) && (curSunLevel != sunLevel))
                        {
                            curSunLevel++;
                        }
                    }
                }
            }
            if (attackTimer == 90)
            {
                image_index = 0;
                image_index = 0;
                canFillHealthBar = true;
                isIntro = false;
                attackTimer = 0;
                phase = choose(0, 2);
                grav = gravStart;
                blockCollision = blockCollisionStart;
            }
        }
    }
}
if (entityCanStep())
{
    if (isFight)
    {
        attackTimer++;

        var halfScreen = view_xview + view_wview / 2;
        switch (phase)
        {
            // Jump up
            case 0:
                xCross = 0;
                hasFired = false;
                if (attackTimer == 10)
                {
                    calibrateDirection();
                }
                if (attackTimer == 28)
                {
                    image_index = 4;
                }
                if (attackTimer == 36)
                {
                    image_index = 5;
                    if (ceiling == -1)
                    {
                        for (var i = 0; i < 224; i += 1) // this for loop finds the cieling
                        {
                            if (collision_rectangle(view_xview + 64, y - i, view_xview + view_wview - 64, y - i + 2, objSolid, false, true))
                            {
                                ceiling = y - i;
                                break;
                            }
                            if (i >= 223) // if there somehow isn't a cieling, default to this
                            {
                                ceiling = view_yview + 32;
                            }
                        }
                    }

                    // set yspeed to jump near the cieling
                    yspeed = ySpeedAim(y, ceiling + 40, grav);

                    // choose how far solar man will jump.
                    jumpDist = choose(1, 2, 3);

                    // detect terrain
                    for (var i = 0; i < view_wview / 2; i += 8)
                    {
                        if (checkSolid(i * image_xscale, 0)) // if solar man detects a wall, travel up until he finds the top of a ledge
                        {
                            for (var j = 0; j < view_hview; j += 8)
                            {
                                if (!checkSolid(i * image_xscale, -j)) // if he finds the top of a ledge, shift xcross to just over it.
                                {
                                    xCross = i + 16;
                                    break;
                                }
                            }
                            break;
                        }
                        if (!checkSolid(i * image_xscale, 2)) // if he detects no wall, find the nearest gap in the floor, and set his distance to jump to there.
                        {
                            for (var j = 0; j < view_hview; j++)
                            {
                                if (checkSolid(i * image_xscale, j))
                                {
                                    xCross = i + 8;
                                    break;
                                }
                            }
                            break;
                        }
                    }
                    if (xCross == 0) // if xCross somehow isn't found, default.
                    {
                        xCross = 32;
                    }

                    // store the calculated jump distance
                    var distanceMod = x + (jumpDist * xCross) * image_xscale;

                    // if solar man is near the edge of the arena, set his position to the edge of the arena
                    if (distanceMod < view_xview + 32)
                    {
                        distanceMod = view_xview + 32;
                    }
                    if (distanceMod > view_xview + view_wview - 32)
                    {
                        distanceMod = view_xview + view_wview - 32;
                    }

                    for (var i = 32; i < view_hview; i++) // find the location of the floor to jump to.
                    {
                        if (placeCollision(distanceMod, ceiling + i))
                        {
                            chooseJumpX = distanceMod;
                            chooseJumpY = ceiling + i;
                            break;
                        }
                    }

                    // manual overide the jump distance, so solar man will land in the middle of the screen if he calculates to anywhere near there
                    if (chooseJumpX >= halfScreen - (middlePlatform - 16) && chooseJumpX <= halfScreen + (middlePlatform - 16)) // if near middle, set to middle.
                    {
                        chooseJumpX = halfScreen;
                    }
                }

                // delay jump by 1 frame so xSpeedAim works
                if (attackTimer == 37)
                {
                    xspeed = xSpeedAim(x, y, chooseJumpX, chooseJumpY, yspeed, grav);
                    if (abs(xspeed) < 0.2) // if somehow solar man doesn't find an x speed, set it to 32
                    {
                        xspeed = 1 * image_xscale;
                    }

                    rainSuns = choose(0, 0, 1);
                    canLean = choose(0, 1);
                    phase = 1;
                    attackTimer = 0;
                }
                break;
            // Mid air
            case 1:
                if (!ground)
                {
                    if (abs(xspeed) >= 1 && abs(xspeed) < 2)
                    {
                        if (yspeed >= 0 && !hasFired)
                        {
                            if (instance_exists(objSolarSun))
                            {
                                if (shots < 1)
                                {
                                    image_index = 6;
                                    image_speed = 0.2;

                                    // Fire Solar Blaze
                                    var i = instance_create(x, y, objSolarManBlaze);
                                    i.size = objSolarSun.curSunLevel;

                                    // Reduce size if larger than sunLevel
                                    if (objSolarSun.curSunLevel > sunLevel)
                                    {
                                        objSolarSun.curSunLevel--;
                                        objSolarSun.weakSun = true;
                                    }

                                    // Play sound effects
                                    switch (i.size)
                                    {
                                        case 0:
                                            playSFX(sfxSolarBlazeSmall);
                                            break;
                                        case 1:
                                            playSFX(sfxSolarBlaze);
                                            break;
                                        case 2:
                                            playSFX(sfxSolarBlazeLarge);
                                            break;
                                    }
                                    shots++;
                                    hasFired = true;
                                }
                            }
                        }
                    }
                    else if (abs(xspeed) >= 2)
                    {
                        if (yspeed >= -2.5 && !hasFired || (yspeed >= 2.5 && hasFired))
                        {
                            if (instance_exists(objSolarSun))
                            {
                                if (shots < 2)
                                {
                                    image_index = 6;
                                    image_speed = 0.2;

                                    // Fire Solar Blaze
                                    var i = instance_create(x, y, objSolarManBlaze);
                                    i.size = objSolarSun.curSunLevel;

                                    // Reduce size if larger than sunLevel
                                    if (objSolarSun.curSunLevel > sunLevel)
                                    {
                                        objSolarSun.curSunLevel--;
                                        objSolarSun.weakSun = true;
                                    }

                                    // Play sound effects
                                    switch (i.size)
                                    {
                                        case 0:
                                            playSFX(sfxSolarBlazeSmall);
                                            break;
                                        case 1:
                                            playSFX(sfxSolarBlaze);
                                            break;
                                        case 2:
                                            playSFX(sfxSolarBlazeLarge);
                                            break;
                                    }
                                    shots++;
                                    hasFired = !hasFired;
                                }
                            }
                        }
                    }
                    if (image_index == 7)
                    {
                        image_index = 5;
                        image_speed = 0;
                    }
                } // If on ground...
                else
                {
                    xspeed = 0;
                    if (image_index > 5)
                        image_index = 5;
                    else
                    {
                        if (image_index > 4)
                            image_speed = -0.1;
                        else
                        {
                            image_index = 0;
                            image_speed = 0;
                            shots = 0;
                            attackTimer = 0;

                            // Recharge sun if weakened
                            if ((!instance_exists(objSolarSun)) || (objSolarSun.curSunLevel < sunLevel))
                                phase = 3; // Launch special attack if at sides and are able to
                            else if (canPraise)
                                phase = 4; // Lean if Mega Man is close
                            else if ((instance_exists(target)) && (distance_to_object(target) <= 64) && (canLean == true))
                                phase = 2; // Begin to jump again
                            else
                                phase = 0;
                        }
                    }
                }
                break;
            // Lean down
            case 2:
                if (attackTimer == 20)
                {
                    image_index = 7;
                    calibrateDirection();
                }
                if (attackTimer == 100)
                {
                    attackTimer = 0;
                    image_index = 0;
                    phase = 0;
                }
                break;
            // Recharge sun
            case 3:
                if (attackTimer == 10)
                {
                    image_index = 8;
                }
                if (attackTimer >= 20)
                {
                    if (!instance_exists(objSolarSun))
                    {
                        instance_create(x, y - 13, objSolarSun);
                        playSFX(sfxSolarManSun);
                    }
                    else
                    {
                        with (objSolarSun)
                        {
                            weakSun = false;
                            if (curSunLevel != sunLevel)
                            {
                                curSunLevel++;
                            }
                            else
                            {
                                if (other.attackTimer >= 60)
                                {
                                    other.attackTimer = 0;
                                    other.image_index = 0;
                                    other.phase = 0;
                                }
                            }
                        }
                    }
                }
                break;
            // PRAISE THE SUN
            case 4:
                if ((rainSuns == 1) && (x <= view_xview + 48)
                    || (rainSuns == 1) && (x >= view_xview + view_wview - 48))
                {
                    if (attackTimer >= 10)
                    {
                        if (instance_exists(objSolarSun))
                        {
                            image_index = 8;
                            if ((attackTimer == 20) || (attackTimer == 40) || (attackTimer == 60))
                            {
                                with (objSolarSun)
                                {
                                    // Fire Solar Blaze
                                    var i = instance_create(x, y, objSolarManBlaze);
                                    i.size = curSunLevel;
                                    i.isFlying = true;

                                    // Reduce size if larger than sunLevel
                                    if (curSunLevel > objSolarMan.sunLevel)
                                        curSunLevel--;

                                    // Play sound effects
                                    switch (i.size)
                                    {
                                        case 0:
                                            playSFX(sfxSolarBlazeSmall);
                                            break;
                                        case 1:
                                            playSFX(sfxSolarBlaze);
                                            break;
                                        case 2:
                                            playSFX(sfxSolarBlazeLarge);
                                            break;
                                    }
                                }
                            }
                            if (attackTimer > 80)
                            {
                                attackTimer = 0;
                                image_index = 0;
                                phase = choose(0, 2);
                            }
                        }
                        else
                        {
                            attackTimer = 0;
                            image_index = 0;
                            phase = 0;
                        }
                    }
                }
                else
                {
                    attackTimer = 0;
                    image_index = 0;
                    phase = 0;
                }
                break;
        }
    }
}
#define Other_12
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
for (var i = 0; i < view_wview / 2; i += 8)
{
    if (checkSolid(i * image_xscale, 0))
    {
        for (var j = 0; j < view_hview; j += 8)
        {
            if (!checkSolid(i * image_xscale, -j))
            {
                xCross = i + 16;
                break;
            }
        }
        break;
    }
    if (!checkSolid(i * image_xscale, 2))
    {
        for (var j = 0; j < view_hview; j++)
        {
            if (checkSolid(i * image_xscale, j))
            {
                xCross = i + 8;
                break;
            }
        }
        break;
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
with (objSolarManBlaze)
{
    instance_create(x, y, objExplosion);
    instance_destroy();
}
#define Draw_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();
