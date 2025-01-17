#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();

healthpointsStart = 28;
healthpoints = healthpointsStart;
contactDamage = 5;

// Health Bar
manualColors = true;
healthBarPrimaryColor[1] = make_color_rgb(32, 56, 232);
healthBarSecondaryColor[1] = make_color_rgb(240, 184, 56);

blockCollision = 1;

customPose = true;
stopOnFlash = true;

// AI variables
phase = 0; // 0: select, 1: run, 2: jump, 3: attack
phaseTimer = 0;
dstX = 0;
absorbSFXTimer = 90; // time since last played absorb sfx
charge = 0;

// customize these:
runSpeed = 3.5;

// Music
music = "Mega_Man_1GB.gbs";
musicType = "VGM";
musicTrackNumber = 8;

// Damage Table
enemyDamageValue(objBusterShot, 1);
enemyDamageValue(objBusterShotHalfCharged, 1);
enemyDamageValue(objBusterShotCharged, 3);

// MaGMML3
enemyDamageValue(objSparkChaser, 1);
enemyDamageValue(objLaserTrident, 2);
enemyDamageValue(objWaterShield, 0);
enemyDamageValue(objTornadoBlow, 0);
enemyDamageValue(objThunderBeam, 2);
enemyDamageValue(objBreakDash, 2);
enemyDamageValue(objMagneticShockwave, 6);
enemyDamageValue(objIceWall, 1);

// MaGMML2
enemyDamageValue(objHornetChaser, 1);
enemyDamageValue(objJewelSatellite, 0);
enemyDamageValue(objGrabBuster, 2);
enemyDamageValue(objTripleBlade, 0);
enemyDamageValue(objSlashClaw, 2);
enemyDamageValue(objWheelCutter, 0);
enemyDamageValue(objSakugarne, 4);
enemyDamageValue(objSuperArrow, 1);
enemyDamageValue(objWireAdapter, 1);

// MaGMML1
enemyDamageValue(objMetalBlade, 0);
enemyDamageValue(objGeminiLaser, 2);
enemyDamageValue(objSolarBlaze, 1);
enemyDamageValue(objTopSpin, 0);
enemyDamageValue(objThunderWool, 0);
enemyDamageValue(objPharaohShot, 2);
enemyDamageValue(objBlackHoleBomb, 1);
enemyDamageValue(objMagicCard, 2);

// MaG48HMML
enemyDamageValue(objFlameMixer, 1);
enemyDamageValue(objRainFlush, 1);
enemyDamageValue(objSparkShock, 0);
enemyDamageValue(objSearchSnake, 1);
enemyDamageValue(objTenguBlade, 0);
enemyDamageValue(objTenguDash, 2);
enemyDamageValue(objTenguDisk, 1);
enemyDamageValue(objSaltWater, 2);
enemyDamageValue(objConcreteShot, 1);
enemyDamageValue(objHomingSniper, 4);

// MaG24HMML
enemyDamageValue(objSuperArmBlockProjectile, 2);
enemyDamageValue(objSuperArmDebris, 2);
enemyDamageValue(objChillShot, 0);
enemyDamageValue(objChillSpikeLanded, 0);

// Misc.
enemyDamageValue(objPowerStone, 0);
enemyDamageValue(objPlantBarrier, 0);
enemyDamageValue(objBrickWeapon, 1);
enemyDamageValue(objIceSlasher, 0);
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
// select rectangle box collision mask
mask_index = mskEnkerCollision;

event_inherited();

if (entityCanStep())
{
    if (isIntro)
    {
        // custom intro:
        image_index = 1;
        grav = gravAccel;
        if (y >= ystart)
        {
            image_index = 0;
            image_speed = 0;
            phaseTimer+=1;
            canFillHealthBar = false;
            if (phaseTimer > 30)
            {
                image_index = 7 + ((phaseTimer div 4) mod 6) * (phaseTimer > 48);
                canFillHealthBar = true;
            }
            if (phaseTimer > 75)
            {
                image_index = 0;
            }
            if (phaseTimer > 90)
            {
                phaseTimer = 0;
                image_index = 0;
                isIntro = false;
                grav = gravStart;
                blockCollision = blockCollisionStart;
            }
        }
    }
    if (isFight)
    {
        var arenaCenter; arenaCenter = view_xview[0] + view_wview[0] / 2;

        // actual combat
        if (phase == 0)
        {
            // face correct direction
            if (abs(x - arenaCenter) > 32)
            {
                image_xscale = sign(arenaCenter - x);
            }

            // determine jump or run
            if (random(1) > 0.5)
            {
                phase = 1;

                // find destination to run to:
                dstX = x + image_xscale * max(distanceToSolid(x + image_xscale * 4, y - 20, image_xscale, -1, true),
                    distanceToSolid(x + image_xscale * 4, y - 4, image_xscale, 0, true));
            }
            else
            {
                phase = 2;

                // pick jump destination:
                var deltaX; deltaX = image_xscale * max(distanceToSolid(x + image_xscale * 4, y - 16, image_xscale, -0.7, true),
                    distanceToSolid(x + image_xscale * 4, y - 32, image_xscale, 0), true);

                // consider jumping to center of screen instead:
                if (abs(x - arenaCenter) > 32 && abs(deltaX) > abs(x - arenaCenter) && random(1) > 0.2)
                {
                    deltaX = arenaCenter - x;
                }
                dstX = x + deltaX;
            }
            xspeed = 0;
        }
        startPhase = phase;
        switch (phase)
        {
            case 1: // run
                if (phaseTimer == 0)
                {
                    // begin running:
                    xspeed = image_xscale * runSpeed;
                }

                // climb over short obstacles like quick man
                var i; for ( i = 0; i < 8; i+=1)
                    if (checkSolid(xspeed, 0) && !checkSolid(xspeed, -8) && !checkSolid(0, -1))
                        y -= 1;
                image_index = 2 + (phaseTimer div 4) mod 4;
                if (abs(x - dstX) < 40)
                {
                    xspeed -= sign(xspeed) * 0.185;
                    image_index = 0;
                }
                else
                {
                    // intelligently jump over obstacles in the way
                    if (checkSolid(image_xscale * 32, -8))
                    {
                        var i; for ( i = 1; i < min(12, abs(y - global.sectionTop) / 16); i+=1)
                        {
                            if (checkSolid(0, -16 * i) || checkSolid(image_xscale * 16, -16 * i))
                                break;
                            if (!checkSolid(image_xscale * 32, -16 * i))
                            {
                                phase = 2;
                                phaseTimer = 1;
                                yspeed = -sqrt(2 * grav * i * 16);
                                xspeed = image_xscale * abs((yspeed / grav));
                                exit;
                            }
                        }
                    }
                }
                if (abs(xspeed) < 0.1 && ground)
                {
                    // stop running
                    xspeed = 0;
                    phase = 3;
                }
                break;
            case 2: // jump
                if (phaseTimer == 0)
                {
                    // plan jump
                    var jumpTime; jumpTime = 35;
                    yspeed = -jumpTime * grav / 2;
                }
                if (phaseTimer == 1)
                {
                    var jumpTime; jumpTime = 35;
                    xspeed = (dstX - x) / jumpTime;
                    xspeed -= 8 * sign(xspeed) / jumpTime; // correction for landing location

                    /* y -= 3;
                    if (checkSolid(0, 0))
                        y += 3 ;*/
                }
                image_index = 1;
                if (ground && phaseTimer > 1 && yspeed >= 0)
                {
                    phase = 4;
                    xspeed = 0;
                    image_index = 0;
                }
                break;
            case 3: // charge attack
                if (phaseTimer == 0)
                {
                    calibrateDirection();
                    absorbSFXTimer = 90;
                    charge = 0;
                }
                else if (phaseTimer >= 50 + 10 * min(charge, 6))
                {
                    phase = 5; // lunge
                }
                else
                    xspeed = 0;
                image_index = 7;
                if (charge > 0)
                {
                    image_index = 8 + (phaseTimer div 2) mod (3 + max(charge div 4, 2));
                }

                var succy; succy = y - 32;
                var succx; succx = x; // - 16 * image_xscale;

                // projectiles get sucked in
                with (prtPlayerProjectile)
                {
                    if (object_index != objGrabBuster)
                    {
                        if (sign(xspeed + hspeed) == sign(succx - x) && xspeed != 0)
                        {
                            if (abs(succy - y) < 64)
                            {
                                shiftObject(0, (succy - y) / (abs(x - succx) / abs(xspeed + hspeed)), blockCollision);
                            }
                        }

                        // Destroy bullets when Enker is invincible
                        if (other.iFrames > 0)
                        {
                            if (x >= succx - 10) && (other.image_xscale == -1)
                                || (x <= succx + 10) && (other.image_xscale == 1)
                            {
                                if (pierces < 2) || (object_index == objPharaohShot)
                                {
                                    event_user(EV_DEATH);
                                }
                            }
                        }
                    }
                }

                if (absorbSFXTimer < 90)
                {
                    absorbSFXTimer+=1;
                }
                break;
            case 4: // rest briefly after jumping
                if (ground && phaseTimer < 15)
                {
                    image_index = 0;
                    xspeed = 0;
                }
                else
                {
                    // determine next action
                    if (ground)
                    {
                        if (abs(x - arenaCenter) > 32 || random(1) > 0.5)
                        {
                            phase = 3;
                        }
                        else
                        {
                            phase = 0;
                        }
                    }
                    else
                        phase = 0;
                }
                break;
            case 5: // lunge
                image_index = 0;
                xspeed = 0;

                // edge forward on lunge:
                if (phaseTimer == 9)
                    xspeed = 7 * image_xscale;
                if (phaseTimer >= 10)
                {
                    image_index = 6;
                }
                if (phaseTimer == 10)
                {
                    // shoot
                    with (instance_create(x + image_xscale * 32, y, objEnkerShot))
                    {
                        image_xscale = other.image_xscale;
                        xspeed = image_xscale * 5;
                        yspeed = 0;
                        image_speed = 0;
                        sprite_index = sprEnkerShot;
                        image_index = min(other.charge div 4, 2);
                        switch (image_index)
                        {
                            case 0:
                                contactDamage = 2;
                                playSFX(sfxEnkerShot);
                                break;
                            case 1:
                                contactDamage = 4;
                                playSFX(sfxEnkerShot);
                                break;
                            case 2:
                                contactDamage = 8;
                                playSFX(sfxEnkerShotBig);
                                break;
                        }
                    }
                }

                // determine next action
                if (phaseTimer >= 60)
                    phase = 0;
                break;
        }
        phaseTimer += 1;

        // check if phase has changed and reset some variables
        if (phase != startPhase)
        {
            phaseTimer = 0;
        }
    }
}

mask_index = sprEnker;
#define Other_20
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();

with (objEnkerShot)
{
    instance_destroy();
}
#define Other_21
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
/// absorb shots when charging up
if (image_index >= 7 && image_index <= 12)
{
    if (other.y <= y) || (other.object_index == objMagneticShockwave)
    {
        charge += global.damage;
        charge += 6 * (other.object_index == objBusterShotCharged);
        charge = min(charge, 10);

        if (absorbSFXTimer >= 44)
        {
            playSFX(sfxEnkerCharge);
            absorbSFXTimer = 0;
        }

        if ((other.object_index == objPharaohShot) && (other.sprite_index == sprPharaohShotCharged)
            || (other.object_index == objHomingSniper)) || (other.object_index == objMagneticShockwave)
        {
            charge = 9;
            phaseTimer = 110;
        }

        with (other)
        {
            if (pierces < 2)
            {
                event_user(EV_DEATH);
            }
        }
    }
}

with (objPharaohShot)
{
    extraDamage = 4;
    event_user(EV_DEATH);
}
#define Draw_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
// hack to make hitbox render in the right spot
var bx; bx = x;
var by; by = y;

if (!((iFrames mod 4) < 2 || !iFrames))
{
    x -= 10 * image_xscale;
    y += 16;
}

event_inherited();

x = bx;
y = by;
