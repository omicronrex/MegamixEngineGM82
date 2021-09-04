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
attackTimerMax = 145;
phase = 0;
jumpY = -5.5;
setX = 48;
hasFired = false;
shotsFired = 0;
drawLSpark = false;
grav = 0.24;

// Health Bar
healthBarPrimaryColor[1] = 32;
healthBarSecondaryColor[1] = 40;

// Music
music = "Mega_Man_3.nsf";
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
enemyDamageValue(objThunderBeam, 1);
enemyDamageValue(objBreakDash, 2);
enemyDamageValue(objMagneticShockwave, 0);
enemyDamageValue(objIceWall, 1);

// MaGMML2
enemyDamageValue(objHornetChaser, 1);
enemyDamageValue(objJewelSatellite, 2);
enemyDamageValue(objGrabBuster, 2);
enemyDamageValue(objTripleBlade, 2);
enemyDamageValue(objWheelCutter, 4);
enemyDamageValue(objSlashClaw, 1);
enemyDamageValue(objSakugarne, 1);
enemyDamageValue(objSuperArrow, 2);
enemyDamageValue(objWireAdapter, 2);

// MaGMML1
enemyDamageValue(objMetalBlade, 4);
enemyDamageValue(objGeminiLaser, 1);
enemyDamageValue(objSolarBlaze, 1);
enemyDamageValue(objTopSpin, 1);
enemyDamageValue(objThunderWool, 1);
enemyDamageValue(objPharaohShot, 1);
enemyDamageValue(objBlackHoleBomb, 2);
enemyDamageValue(objMagicCard, 2);

// MaG48MML
enemyDamageValue(objFlameMixer, 2);
enemyDamageValue(objRainFlush, 4);
enemyDamageValue(objSparkShock, 4);
enemyDamageValue(objSearchSnake, 0);
enemyDamageValue(objTenguBlade, 5);
enemyDamageValue(objTenguDash, 5);
enemyDamageValue(objTenguDisk, 5);
enemyDamageValue(objSaltWater, 2);
enemyDamageValue(objConcreteShot, 1);
enemyDamageValue(objHomingSniper, 0);

// MaG48MML
enemyDamageValue(objSuperArmBlockProjectile, 4);
enemyDamageValue(objSuperArmDebris, 4);
enemyDamageValue(objChillShot, 1);
enemyDamageValue(objChillSpikeLanded, 2);

// Misc.
enemyDamageValue(objPowerStone, 4);
enemyDamageValue(objPlantBarrier, 1);
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

// all of spark man's events trigger when the game isn't frozen.
if (entityCanStep())
{
    // spark man's custom intro
    if (startIntro)
    {
        y -= view_hview;
        canFillHealthBar = false;
        image_index = 7;
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
            // since bosses do not have gravity during intros, we need to reuse this here.
            hasTriggeredFall = true;
            y = ystart;
            image_speed = 0;
            attackTimer += 1;
            if (attackTimer < 8)
                image_index = 0;
            if (attackTimer == 8)
                image_index = 1;
            if (attackTimer == 12)
                image_index = 2;
            if (attackTimer == 16)
                drawLSpark = true;
            if (attackTimer == 24 || attackTimer == 32)
            {
                drawLSpark = false;
                image_index = 5;
            }
            if (attackTimer == 28 || attackTimer == 36)
                image_index = 6;
            if (attackTimer == 40)
                image_index = 1;
            if (attackTimer == 50)
            {
                canFillHealthBar = true;
                isIntro = false;
                grav = gravStart;
                blockCollision = blockCollisionStart;
                attackTimer = 0;
                hasFired = true;
                storeDirection = image_xscale;
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
        switch (phase)
        {
            case 0: // jump! for my love, jump in!
                if (attackTimer == 0)
                {
                    setX = 8;
                    if (!hasFired)
                    {
                        image_xscale = storeDirection;
                        phase = choose(0, 0, 1);
                    }
                    else
                    {
                        if (x >= view_xview + 72 && x <= (view_xview + view_wview) - 72)
                            image_xscale = storeDirection;
                        else
                        {
                            if (x < view_xview + view_wview / 2)
                                image_xscale = 1;
                            else
                                image_xscale = -1;
                            storeDirection = image_xscale;
                        }
                        phase = 0;
                        hasFired = false;
                    }
                }
                if (attackTimer == 4)
                {
                    var i; for ( i = 8; i <= 48; i += 1)
                    {
                        if (!(place_meeting(x + setX * image_xscale, y, objSolid)))
                            setX += 1;
                        else
                        {
                            if (x + setX * image_xscale < (view_xview + view_wview / 2) - 32 || x + setX * image_xscale > (view_xview + view_wview / 2) + 32)
                                setX += 16;
                            else if (x + setX * image_xscale >= (view_xview + view_wview / 2) - 32 && x + setX * image_xscale <= (view_xview + view_wview / 2) + 32)
                                setX = -9999;
                            break;
                        }
                        if (i == 48)
                            setX = 40;
                    }
                    if (setX != -9999)
                        sd = instance_create(x + setX * image_xscale, y, objEnemyBullet);
                    else
                        sd = instance_create(view_xview + view_wview / 2, y, objEnemyBullet);
                    sd.contactDamage = 0;
                    sd.reflectable = false;
                    sd.trigWall = false;
                    sd.despawnRange=-1;
                    sd.image_alpha = 0;
                    if (sd.x > view_xview + 26 && sd.x < (view_xview + view_wview) - 26)
                    {
                        var i; for ( i = 32; i < 256; i += 1)
                        {
                            with (sd)
                            {
                                if (place_meeting(x, y, objSolid))
                                {
                                    y -= 1;
                                    trigWall = true;
                                }
                                else
                                    break;
                            }
                            if (place_meeting(x, y, objSolid) || y <= view_yview + 16)
                            {
                                if (x < view_xview + view_wview / 2)
                                    storeDirection = 1;
                                else
                                    storeDirection = -1;
                                image_xscale = storeDirection;
                            }
                        }
                    }
                    else
                    {
                        with (sd)
                            instance_destroy();
                        if (x < view_xview + view_wview / 2)
                            storeDirection = 1;
                        else
                            storeDirection = -1;

                        // storeDirection *= -1;
                        image_xscale = storeDirection;
                        hasFired = true;
                        shotsFired += 1;
                        attackTimer = -4;
                    }
                }
                else if (attackTimer == 5)
                {
                    image_index = 7;
                    if (sd.trigWall)
                    {
                        sd.y -= 48;
                        yspeed = ySpeedAim(y, sd.y, grav);
                        sd.y += 32;
                    }
                    else
                    {
                        sd.y += 32;
                        yspeed = -5;
                    }
                }
                if (attackTimer >= 6 && xspeed == 0)
                {
                    var sx; sx =view_xview;
                    var sy; sy =view_yview;
                    if(instance_exists(sd))
                    {
                        sx=sd.x;
                        sy=sd.y;
                    }
                    xspeed = xSpeedAim(x, y, sx, sy, yspeed, grav);

                }
                if (attackTimer > 6 && yspeed >= 0 && ground)
                {
                    with (sd)
                        instance_destroy();
                    xspeed = 0;
                    shotsFired += 1;
                    image_index = 2;
                    attackTimer = -4;
                }
                break;
            case 1: // use spark shot
                if ((attackTimer) < 5)
                {
                    storeDirection = image_xscale;
                    image_index = 1;
                }
                else
                    calibrateDirection();
                if (attackTimer == 11 || attackTimer == 19 || attackTimer == 60 || attackTimer == 64)
                    image_index = 5;
                if (attackTimer == 15 || attackTimer == 24 || attackTimer == 68 || attackTimer == 72)
                    image_index = 6;
                if (attackTimer == 30)
                {
                    playSFX(sfxElecnShoot);
                    image_index = 0;
                    var a;
                    var spark;
                    for (a = 0; a <= 360; a += 45)
                    {
                        spark = instance_create(x, y - sprite_height * 0.2, objElecnSpark);
                        spark.direction = a;
                        spark.sprite_index = sprSparkmanLittleShot;
                        spark.contactDamage = 2;
                    }
                }
                if (attackTimer == 76)
                    image_index = 2;
                if (attackTimer == 84)
                    drawLSpark = true;
                if (attackTimer == 92)
                    image_index = 3;
                if (attackTimer == 100)
                {
                    drawLSpark = false;
                    image_index = 4;
                    playSFX(sfxSparkShock);
                    with (instance_create(x + 16 * image_xscale, y, objSparkmanProjectile))
                    {
                        if (instance_exists(target))
                        {
                            dir = point_direction(spriteGetXCenter(), spriteGetYCenter(),
                                spriteGetXCenterObject(target),
                                spriteGetYCenterObject(target));
                        }
                        else
                            dir = 0;
                    }
                }
                if (attackTimer == 128)
                {
                    image_index = 6;
                }
                if (attackTimer == 136)
                {
                    image_index = 2;
                    hasFired = true;
                    attackTimer = -24;
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
with (objElecnSpark)
    instance_destroy();
with (objSparkmanProjectile)
    instance_destroy();
event_inherited();
#define Draw_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();

if ((iFrames mod 4) < 2 || !iFrames)
{
    if (drawLSpark)
    {
        if (image_index != 3)
        {
            draw_sprite(sprSparkmanBigShot, (attackTimer / 4) mod 2, round(x), round(y - 16));
        }
        else
        {
            draw_sprite(sprSparkmanBigShot, (attackTimer / 4) mod 2, round(x - 6 * image_xscale), round(y - 16));
        }
    }
}
