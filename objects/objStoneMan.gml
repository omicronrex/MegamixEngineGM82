#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();

healthpointsStart = 28;
healthpoints = healthpointsStart;

healthBarPrimaryColor[1] = 19;
healthBarSecondaryColor[1] = 40;

contactDamage = 4;
grav = 0.24;

customPose = true;
introType = 0;
bossTriggered = true;

ground = false;

xOff = 0;

attackTimer = 0;
hasTriggeredFall = false;

delayUse = false;
attackTimerMax = 145;

phase = 0;
jumpY = -5.5;
setX = 48;
hasFired = false;
collapsePhase = 0;
radius = 72;
strMMX = x;
strMMY = y;

// Health Bar
healthBarPrimaryColor[1] = 33;
healthBarSecondaryColor[1] = 48;

// super arm interaction
category = "superArmTarget";
superArmFlashTimer = 0;
superArmFlashOwner = noone;
superArmFlashInterval = 1;
superArmHoldOwner = noone;
superArmDeathOnDrop = false;
superArmThrown = false;
superArmSquirmTimer = 0;

// Music
music = "Mega_Man_5.nsf";
musicType = "VGM";
musicTrackNumber = 10;

// Damage Table
enemyDamageValue(objBusterShot, 1);
enemyDamageValue(objBusterShotHalfCharged, 1);
enemyDamageValue(objBusterShotCharged, 3);

// MaGMML3
enemyDamageValue(objSparkChaser, 1);
enemyDamageValue(objLaserTrident, 2);
enemyDamageValue(objWaterShield, 2);
enemyDamageValue(objTornadoBlow, 1);
enemyDamageValue(objThunderBeam, 1);
enemyDamageValue(objBreakDash, 4);
enemyDamageValue(objMagneticShockwave, 1);
enemyDamageValue(objIceWall, 2);

// MaGMML2
enemyDamageValue(objHornetChaser, 1);
enemyDamageValue(objJewelSatellite, 4);
enemyDamageValue(objGrabBuster, 1);
enemyDamageValue(objTripleBlade, 1);
enemyDamageValue(objWheelCutter, 1);
enemyDamageValue(objSlashClaw, 2);
enemyDamageValue(objSakugarne, 4);
enemyDamageValue(objSuperArrow, 1);
enemyDamageValue(objWireAdapter, 1);

// MaGMML1
enemyDamageValue(objMetalBlade, 1);
enemyDamageValue(objGeminiLaser, 2);
enemyDamageValue(objSolarBlaze, 1);
enemyDamageValue(objTopSpin, 1);
enemyDamageValue(objThunderWool, 1);
enemyDamageValue(objPharaohShot, 1);
enemyDamageValue(objBlackHoleBomb, 4);
enemyDamageValue(objMagicCard, 2);

// MaG48MML
enemyDamageValue(objFlameMixer, 1);
enemyDamageValue(objRainFlush, 2);
enemyDamageValue(objSparkShock, 1);
enemyDamageValue(objSearchSnake, 1);
enemyDamageValue(objTenguBlade, 1);
enemyDamageValue(objTenguDash, 3);
enemyDamageValue(objTenguDisk, 1);
enemyDamageValue(objSaltWater, 4);
enemyDamageValue(objConcreteShot, 2);
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
enemyDamageValue(objIceSlasher, 2);
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
// leave this. this is needed.
event_inherited();

// all of stone man's events trigger when the game isn't frozen.
if (!global.frozen)
{
    // stone man's custom intro
    if (startIntro)
    {
        y -= view_hview;
        canFillHealthBar = false;
        image_index = 5;
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
            if (attackTimer < 2 || attackTimer == 6)
                image_index = 0;
            if (attackTimer == 6)
                image_index = 6;
            if (attackTimer == 24)
                image_index = 3;
            if (attackTimer == 35)
                image_index = 4;
            if (attackTimer == 64)
                image_index = 0;
            if (attackTimer == 65)
            {
                canFillHealthBar = true;
                isIntro = false;
                attackTimer = 0;
                hasFired = true;
                storeDirection = image_xscale;
                grav = gravStart;
                blockCollision = blockCollisionStart;
            }
        }
    }
}
if (entityCanStep())
{
    // special super arm interaction
    if (superArmHoldOwner != noone)
    {
        superArmSquirmTimer++;
        image_index = 12 + (superArmSquirmTimer div 8 mod 2);
        contactDamage = 0;
        exit;
    }
    if (superArmThrown)
    {
        contactDamage = 0;
        image_index = 12;
        blockCollision = true;
        if (ground)
        {
            superArmThrown = false;
            grav = 0.25;
            phase = 4;
            collapsePhase = 3;
            attackTimer = 0;
            xspeed = 0;
            screenShake(35, 1, 1);
            playSFX(sfxEnemyHit);
            healthpoints -= 4;
            if (healthpoints <= 0)
            {
                event_user(EV_DEATH);
            }
            image_index = 13;
        }
        else
        {
            exit;
        }
    }
    superArmSquirmTimer = 0;

    // normal fight
    if (isFight == true)
    {
        image_speed = 0;
        attackTimer += 1;
        if (instance_exists(target))
        {
            strMMX = target.x;
            strMMY = target.y;
        }
        switch (phase)
        {
            case 0: // choose attack
                image_index = 0;
                calibrateDirection();
                if (attackTimer >= 12 - ((global.difficulty == DIFF_HARD) * 8))
                {
                    if (abs(x - strMMX) < radius)
                    {
                        attackTimer = 0;
                        phase = choose(1, 2);
                    }
                    else
                    {
                        phase = 3;
                    }
                }
                break;
            case 1: // small hop
                yspeed = -6;
                grav = 0.25;
                image_index = 5;
                collapsePhase = 0; // 0 = do not collapse
                phase = 4;
                if (instance_exists(target))
                {
                    xspeed = xSpeedAim(x, y, target.x, target.y, yspeed, grav);
                }
                else
                {
                    xspeed = 0;
                }
                phase = 4;
                break;
            case 2: // large jump
                yspeed = -8;
                grav = 0.25;
                image_index = 5;
                collapsePhase = 1; // 1 = collapse
                if (instance_exists(target))
                {
                    xspeed = xSpeedAim(x, y, target.x, target.y, yspeed, grav);
                }
                else
                {
                    xspeed = 0;
                }
                phase = 4;
                break;
            case 3: // power stone
                if (attackTimer < 32)
                    image_index = 1 + ((attackTimer / 4) mod 2);
                if (attackTimer == 32)
                    image_index = 3;
                if (attackTimer == 40)
                {
                    image_index = 4;
                    playSFX(sfxPowerStone);

                    if (global.difficulty == DIFF_HARD)
                    {
                        for (i = 120; i <= 360; i += 120)
                        {
                            var sd = instance_create(x, y, objStoneManPowerStone);
                            sd.cAngle = i;
                        }
                    }
                    else
                    {
                        instance_create(x, y, objStoneManPowerStone);
                        var sd = instance_create(x, y, objStoneManPowerStone);
                        sd.cAngle = 180;
                    }
                }
                if (attackTimer == 56)
                {
                    attackTimer = 0;
                    phase = 2;
                }
                break;
            case 4: // jumping
                if (collapsePhase < 2 && ground && yspeed >= 0) // choose land type
                {
                    if (collapsePhase == 1)
                    {
                        screenShake(35, 1, 1);
                    }
                    playSFX(sfxBikkyLand);
                    collapsePhase += 2;
                    attackTimer = 0;
                    xspeed = 0;
                    image_index = 0;
                }
                if (collapsePhase == 2) // small hop land
                {
                    switch (attackTimer)
                    {
                        case 3:
                            image_index = 6;
                            break;
                        case 0:
                        case 6:
                            image_index = 0;
                            if (attackTimer >= 6)
                            {
                                attackTimer = 0;
                                collapsePhase = 0;
                                phase = 0;
                            }
                            break;
                    }
                }
                if (collapsePhase == 3) // crumble
                {
                    switch (attackTimer)
                    {
                        case 3:
                            contactDamage = 0;
                            image_index = 6;

                            // summon a hoohoo if on hard mode
                            if (global.difficulty == DIFF_HARD)
                            {
                                with (instance_create(choose(view_xview, view_xview + view_wview), view_yview + 48, objHoohoo))
                                {
                                    despawnRange = 32;
                                    respawn = false;
                                }
                            }
                            break;
                        case 8:
                            image_index = 7;
                            break;
                        case 13:
                        case 58:
                            image_index = 8;
                            break;
                        case 18:
                            image_index = 9;
                            break;
                        case 63:
                            image_index = 10;
                            break;
                        case 68:
                            image_index = 11;
                            break;
                        case 73:
                            image_index = 0;
                            attackTimer = 0;
                            collapsePhase = 0;
                            contactDamage = 4;
                            phase = 0;
                            break;
                    }
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
with (objStoneManPowerStone)
    instance_destroy();
event_inherited();
#define Other_21
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
// guard if collapsing
// Hah! just like my life ;_;
if (collapsePhase == 3)
{
    other.guardCancel = 3;
}
#define Draw_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();

// super arm flash
if (superArmFlashTimer mod (2 * superArmFlashInterval) >= superArmFlashInterval || superArmThrown || superArmHoldOwner != noone)
{
    draw_set_blend_mode(bm_add);
    drawSelf();
    draw_set_blend_mode(bm_normal);
    draw_set_alpha(1);
}
