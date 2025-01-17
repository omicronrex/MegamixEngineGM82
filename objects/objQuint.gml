#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();

healthpointsStart = 28;
healthpoints = healthpointsStart;

// Health Bar
healthBarPrimaryColor[1] = 22;
healthBarSecondaryColor[1] = 35;

pose = sprQuintIntro;
sprite_index = pose;
poseImgSpeed = 8 / 60;
contactDamage = 4;
ground = false;
attackTimer = 0;
jumpTimer = 0;
jumpAmount = 0;
canInitShoot = true;
phase = 0;

// Sprites 0 = no cutter, 1 = cutter
cutter = 1;
spriteStand[0] = sprCutStandShame;
spriteRun[0] = sprCutRunShame;
spriteJump[0] = sprCutJumpShame;
spriteStand[1] = sprCutStand;
spriteRun[1] = sprCutRun;
spriteJump[1] = sprCutJump;

teleportSakugarne = false;
teleporting = true;
teleportTimer = 0;
teleportY = 0;
teleportIndex = 0;
teleportX = x;

bouncePhase = 2;
getLastY = 0;

// Music
music = "Mega_Man_2GB.gbs";
musicType = "VGM";
musicTrackNumber = 16; // Default track: An ode to humanity's sins

// Damage Table
enemyDamageValue(objBusterShot, 1);
enemyDamageValue(objBusterShotHalfCharged, 1);
enemyDamageValue(objBusterShotCharged, 3);

// MaGMML3
enemyDamageValue(objSparkChaser, 2);
enemyDamageValue(objLaserTrident, 2);
enemyDamageValue(objWaterShield, 1);
enemyDamageValue(objTornadoBlow, 1);
enemyDamageValue(objThunderBeam, 4);
enemyDamageValue(objBreakDash, 1);
enemyDamageValue(objMagneticShockwave, 2);
enemyDamageValue(objIceWall, 2);

// MaGMML2
enemyDamageValue(objHornetChaser, 1);
enemyDamageValue(objJewelSatellite, 2);
enemyDamageValue(objGrabBuster, 2);
enemyDamageValue(objTripleBlade, 2);
enemyDamageValue(objWheelCutter, 2);
enemyDamageValue(objSlashClaw, 1);
enemyDamageValue(objSakugarne, 4);
enemyDamageValue(objSuperArrow, 2);
enemyDamageValue(objWireAdapter, 1);

// MaGMML1
enemyDamageValue(objMetalBlade, 2);
enemyDamageValue(objGeminiLaser, 2);
enemyDamageValue(objSolarBlaze, 1);
enemyDamageValue(objTopSpin, 1);
enemyDamageValue(objThunderWool, 5);
enemyDamageValue(objPharaohShot, 2);
enemyDamageValue(objBlackHoleBomb, 1);
enemyDamageValue(objMagicCard, 1);

// MaG48HMML
enemyDamageValue(objFlameMixer, 2);
enemyDamageValue(objRainFlush, 1);
enemyDamageValue(objSparkShock, 1);
enemyDamageValue(objSearchSnake, 1);
enemyDamageValue(objTenguBlade, 2);
enemyDamageValue(objTenguDash, 0);
enemyDamageValue(objTenguDisk, 2);
enemyDamageValue(objSaltWater, 1);
enemyDamageValue(objConcreteShot, 4);
enemyDamageValue(objHomingSniper, 2);

// MaG24HMML
enemyDamageValue(objSuperArmBlockProjectile, 1);
enemyDamageValue(objSuperArmDebris, 1);
enemyDamageValue(objChillShot, 1);
enemyDamageValue(objChillSpikeLanded, 0);

// Misc.
enemyDamageValue(objPowerStone, 1);
enemyDamageValue(objPlantBarrier, 1);
enemyDamageValue(objBrickWeapon, 1);
enemyDamageValue(objIceSlasher, 4);
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();

if (entityCanStep())
{
    if (isFight && !teleporting)
    {
        switch (phase)
        {
            case 0:
                sprite_index = sprQuintJump;
                if (ground)
                {
                    if (round(x) != round(teleportX))
                    {
                        yspeed = -6;
                        xspeed = arcCalcXspeed(yspeed, 0.25, round(x), y, round(teleportX),
                            y);
                    }
                    else
                    {
                        xspeed = 0;
                        phase = 1;
                    }
                }
                break;
            case 1: // Idle (standing still)
            case 3: // Idle (standing still) Big rock
                sprite_index = sprQuintSakugarne;
                if (image_index < 2 - 0.1)
                {
                    image_index += 0.1;
                }
                else
                {
                    image_index = 0;
                    if (attackTimer >= 0)
                    {
                        if (phase == 1)
                        {
                            for (i = -2; i <= 2; i += 1)
                                if (i != 0)
                                {
                                    rock = instance_create(x, y + 8,
                                        objSakugarneRock);
                                    rock.yspeed = -abs(i) * 2;
                                    rock.xspeed = i;
                                }
                        }
                        else
                        {
                            for (i = -1; i <= 1; i += 1)
                                if (i != 0)
                                {
                                    rock = instance_create(x, y + 4,
                                        objSakugarneBigRock);
                                    rock.yspeed = -abs(i) * 6;
                                    rock.xspeed = i * 3;
                                    attackTimer = 15;
                                }
                        }
                    }
                }
                attackTimer -= 1;
                if ((attackTimer <= 0 && bouncePhase == 2)
                    || (attackTimer <= -60 && bouncePhase == 4))
                {
                    phase = bouncePhase;
                }
                calibrateDirection();
                break;
            case 2: // Jumping
            case 4: // Sakugarne Toss
                image_index = 1;
                if (instance_exists(objSakugarneToss))
                {
                    sprite_index = sprQuintJump;
                    objSakugarneToss.x = x + xspeed;
                    objSakugarneToss.image_xscale = image_xscale;
                    phase = 2;
                }
                else
                {
                    sprite_index = sprQuintSakugarne;
                }
                if (attackTimer <= 0)
                {
                    attackTimer = 35;
                    if (instance_exists(target))
                    {
                        startXScale = image_xscale;
                        yspeed = -6.5;
                        if (phase == 4)
                            startXspeed = arcCalcXspeed(yspeed, 0.25, x, y,
                                spriteGetXCenterObject(target), y) * 1.5;
                        else
                            startXspeed = arcCalcXspeed(yspeed, 0.25, x, y,
                                spriteGetXCenterObject(target), y);
                        ground = false;
                    }
                    else
                    {
                        startXScale = image_xscale;
                        startXspeed = 0;
                    }
                }
                if (phase == 4)
                {
                    if (collision_line(x, y, x + image_xscale * 128, y + 256,
                        target, 1, 1) && !instance_exists(objSakugarneToss))
                    {
                        instance_create(x, y, objSakugarneToss);
                    }
                }
                if (!checkSolid(startXspeed, 0))
                {
                    xspeed = startXspeed;
                }
                else
                {
                    while (checkSolid(0, 0, 1, 1))
                    {
                        x -= image_xscale;
                    }
                    xspeed = 0;
                }

                // When grounded, end the jump
                if (ground)
                {
                    phase = choose(1, 3);
                    bouncePhase = choose(2, 4);
                    xspeed = 0;
                    yspeed = 0;
                }
                break;
        }
    }
}
#define Other_4
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
while (teleportX > x - 48 && !checkSolid(teleportX, 0, 1, 1))
{
    teleportX -= 4;
}
#define Other_20
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
with (prtEnemyProjectile)
{
    event_user(EV_DEATH);
    {
        instance_create(x, y, objExplosion);
    }
}

event_inherited();
#define Draw_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();

if (teleporting && isFight)
{
    if (round(view_yview[0] - 32 + teleportY) >= y)
    {
        if (teleportTimer == 0)
        {
            playSFX(sfxTeleportIn);
        }

        // Done teleporting; play a little animation before giving Mega Man control
        draw_sprite_ext(sprRushTeleport, teleportIndex, round(teleportX),
            round(view_yview[0] + teleportY - 24), image_xscale,
            image_yscale, image_angle, c_white, 1);
        if (teleportTimer == 2)
        {
            teleportIndex = 1;
        }
        else if (teleportTimer == 4)
        {
            teleportIndex = 0;
        }
        else if (teleportTimer == 6)
        {
            teleportIndex = 2;
        }
        else if ((teleportTimer == 9 && !collision_rectangle(x - 5, bbox_top,
            x + 5, bbox_bottom, objSolid, false, false))
            || (teleportTimer == 15 && collision_rectangle(x - 5, bbox_top,
            x + 5, bbox_bottom, objSolid, false, false)))
        {
            teleporting = false;
            teleportTimer = 0;
            teleportY = 0;
            if (!collision_rectangle(x - 5, bbox_top, x + 5, bbox_bottom,
                objSolid, false, false))
            {
                canCoil = true;
            }
            exit;
        }
        if (entityCanStep())
        {
            teleportTimer += 1;
        }
    }
    else
    {
        // Teleporting downwards
        draw_sprite_ext(sprRushTeleport, teleportIndex, round(teleportX),
            round(view_yview[0] + teleportY - 24), image_xscale,
            image_yscale, image_angle, c_white, 1);
        if (entityCanStep())
        {
            teleportY += 7;
        }
    }
}

if (phase == 0 && isFight && !teleporting)
{
    draw_sprite_ext(sprSakugarne, 1, round(teleportX), round(ystart),
        image_xscale, image_yscale, image_angle, c_white, 1);
}
