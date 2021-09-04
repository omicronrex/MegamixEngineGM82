#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();

healthpointsStart = 28;
contactDamage = 5;

customPose = sprIcePose;
hasTriggeredFall = false;
introType = 0;

phase = 0;

grav = 0.25;
ground = false;
attackTimer = 0;

imgIndex = 0;
yCount = 0; // How far to go before shooting
dir = 1;
shooting = false;
origY = 0;
shotLimit = 0;
scaleWall = false;

// Health Bar
healthBarPrimaryColor[1] = 27;
healthBarSecondaryColor[1] = 40;

// Music
music = "Mega_Man_1.nsf";
musicType = "VGM";
musicTrackNumber = 8;

// Damage Table
enemyDamageValue(objBusterShot, 1);
enemyDamageValue(objBusterShotHalfCharged, 1);
enemyDamageValue(objBusterShotCharged, 3);

// MaGMML3
enemyDamageValue(objSparkChaser, 2);
enemyDamageValue(objLaserTrident, 1);
enemyDamageValue(objWaterShield, 1);
enemyDamageValue(objTornadoBlow, 1);
enemyDamageValue(objThunderBeam, 5);
enemyDamageValue(objBreakDash, 1);
enemyDamageValue(objMagneticShockwave, 2);
enemyDamageValue(objIceWall, 0);

// MaGMML2
enemyDamageValue(objHornetChaser, 1);
enemyDamageValue(objJewelSatellite, 1);
enemyDamageValue(objGrabBuster, 1);
enemyDamageValue(objTripleBlade, 2);
enemyDamageValue(objSlashClaw, 2);
enemyDamageValue(objWheelCutter, 2);
enemyDamageValue(objSakugarne, 4);
enemyDamageValue(objWireAdapter, 2);

// MaGMML1
enemyDamageValue(objMetalBlade, 2);
enemyDamageValue(objGeminiLaser, 1);
enemyDamageValue(objSolarBlaze, 1);
enemyDamageValue(objTopSpin, 1);
enemyDamageValue(objThunderWool, 4);
enemyDamageValue(objPharaohShot, 1);
enemyDamageValue(objBlackHoleBomb, 1);
enemyDamageValue(objMagicCard, 2);

// MaG48MML
enemyDamageValue(objFlameMixer, 1);
enemyDamageValue(objRainFlush, 1);
enemyDamageValue(objSparkShock, 4);
enemyDamageValue(objSearchSnake, 1);
enemyDamageValue(objTenguBlade, 1);
enemyDamageValue(objTenguDash, 1);
enemyDamageValue(objTenguDisk, 2);
enemyDamageValue(objSaltWater, 1);
enemyDamageValue(objConcreteShot, 1);
enemyDamageValue(objHomingSniper, 2);

// MaG24HMML
enemyDamageValue(objSuperArmBlockProjectile, 1);
enemyDamageValue(objSuperArmDebris, 1);
enemyDamageValue(objChillShot, 0);
enemyDamageValue(objChillSpikeLanded, 0);

// Misc.
enemyDamageValue(objPowerStone, 1);
enemyDamageValue(objPlantBarrier, 1);
enemyDamageValue(objBrickWeapon, 1);
enemyDamageValue(objIceSlasher, 0);
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();

if (entityCanStep())
{
    // Ice Man's custom intro
    if (startIntro)
    {
        y -= view_hview;
        canFillHealthBar = false;
        sprite_index = sprIcePose;
        image_index = 0;
        startIntro = false;
        isIntro = true;
        visible = true;
        grav = gravStart;
        calibrateDirection();
    }
    else if (isIntro)
    {
        // custom intro:
        /* if (y <= ystart && !hasTriggeredFall)
            y += 4 ;*/
        if (y >= ystart || hasTriggeredFall)
        {
            // since bosses do not have gravity during intros, we need to reuse this here.
            hasTriggeredFall = true;
            y = ystart;
            image_speed = 0;
            attackTimer++;
            if (attackTimer < 8)
                image_index = 1;
            if (attackTimer == 10)
                image_index = 2;
            if (attackTimer == 18)
            {
                image_index = 3;
                canFillHealthBar = true;
                isIntro = false;
                attackTimer = 0;
                blockCollision = blockCollisionStart;
            }
        }
    }

    // Fight Data
    if (isFight)
    {
        image_xscale = dir;
        switch (phase)
        {
            // Skate
            case 0:
                if (ground)
                {
                    sprite_index = sprIceSkate;
                    image_speed = 0.1;

                    // Fall if going off ledge
                    if (!positionCollision(x, bbox_bottom + 2))
                    {
                        xspeed = 0;
                    }
                }
                grav = 0.25;
                xspeed = dir;

                // Reset animation frames
                if ((image_index == 2) && (xspeed != 0))
                {
                    image_index = 0;
                }

                // Turn around
                if (xcoll != 0)
                {
                    dir *= -1;
                    x += dir;
                }

                // Stop in these spots
                if ((x == (view_xview + view_wview) - 48) ||
                    (x == view_xview + 88) ||
                    (x == view_xview + 148))
                {
                    image_index = 2;
                    image_speed = 0;
                    xspeed = 0;
                    attackTimer++;
                    if (attackTimer == 16)
                    {
                        phase = 1;
                        y--;
                        origY = y + 1;
                        attackTimer = 0;
                        sprite_index = sprIceMan;
                        grav = 0;
                    }
                }
                break;
            case 1: // Turn around to face Mega Man
                calibrateDirection();

                // Jump into the air
                if (attackTimer == 0)
                {
                    if ((y > origY - 64) && (shooting == false))
                    {
                        y -= 4;
                    } // Start shooting at apex
                    else
                    {
                        shooting = true;

                        if (y != origY)
                        {
                            y++;
                            yCount++;
                        }
                        else
                        {
                            attackTimer++;
                        }
                    }
                }
                else
                {
                    attackTimer++;
                    if (attackTimer >= 35)
                    {
                        y--;
                        yCount++;
                        if (y <= origY - 64)
                        {
                            shooting = false;
                            phase = 2;
                        }
                    }
                    else
                    {
                        yCount = 20;
                        image_index = 0;
                    }
                }

                // Fire Ice Slasher
                if (shooting)
                {
                    // Only shoot at certain times and don't fire more times than six
                    if ((yCount == 21) && (shotLimit < 6))
                    {
                        image_index = 1;
                        yCount = 0;

                        var i = instance_create(x + 12 * image_xscale, y + 2, objIceManSlasher);
                        i.image_xscale = image_xscale;
                        i.xspeed = 2 * image_xscale;
                        i.parent = id;
                        playSFX(sfxIceSlasher);
                        shotLimit++;
                    }
                    else
                    {
                        if (yCount > 8)
                        {
                            image_index = 0;
                        }
                    }
                }
                break;
            // Fall back down
            case 2:
                calibrateDirection();
                if (y != origY)
                {
                    y += 4;
                }
                else
                {
                    yCount = 0;
                    shotLimit = 0;
                    phase = 0;
                    attackTimer = 1;
                    if (x == view_xview + 88)
                    {
                        dir = 1;
                    }

                    if (x == (view_xview + view_wview) - 48)
                    {
                        dir = -1;
                    }
                    x += dir;
                }
                break;
        }
    }
}
#define Other_20
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
with (objIceManSlasher)
{
    instance_destroy();
}
event_inherited();
