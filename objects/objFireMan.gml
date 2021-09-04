#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();


healthpointsStart = 28;
healthpoints = healthpointsStart;

customPose = true;
hasTriggeredFall = false;
introType = 1;
contactDamage = 4;

ground = false;
attackTimer = 0;
phase = 0; // 0 = running; 1 = shooting;

spriteRun = sprFireManRun;
spriteShoot = sprFireManShoot;

moveTimer = 30;

// Health Bar
healthBarPrimaryColor[1] = 18;
healthBarSecondaryColor[1] = 40;

// Music
music = "Mega_Man_1.nsf";
musicType = "VGM";
musicTrackNumber = 8;

// Damage Table
enemyDamageValue(objBusterShot, 2);
enemyDamageValue(objBusterShotHalfCharged, 2);
enemyDamageValue(objBusterShotCharged, 4);

// MaGMML3
enemyDamageValue(objSparkChaser, 1);
enemyDamageValue(objLaserTrident, 2);
enemyDamageValue(objWaterShield, 2);
enemyDamageValue(objTornadoBlow, 2);
enemyDamageValue(objThunderBeam, 1);
enemyDamageValue(objBreakDash, 1);
enemyDamageValue(objMagneticShockwave, 2);
enemyDamageValue(objIceWall, 4);

// MaGMML2
enemyDamageValue(objHornetChaser, 1);
enemyDamageValue(objJewelSatellite, 6);
enemyDamageValue(objGrabBuster, 1);
enemyDamageValue(objTripleBlade, 2);
enemyDamageValue(objSlashClaw, 2);
enemyDamageValue(objWheelCutter, 2);
enemyDamageValue(objSakugarne, 1);
enemyDamageValue(objSuperArrow, 2);
enemyDamageValue(objWireAdapter, 1);

// MaGMML1
enemyDamageValue(objMetalBlade, 2);
enemyDamageValue(objGeminiLaser, 1);
enemyDamageValue(objSolarBlaze, 1);
enemyDamageValue(objTopSpin, 4);
enemyDamageValue(objThunderWool, 1);
enemyDamageValue(objPharaohShot, 1);
enemyDamageValue(objBlackHoleBomb, 2);
enemyDamageValue(objMagicCard, 2);

// MaG48HMML
enemyDamageValue(objFlameMixer, 1);
enemyDamageValue(objRainFlush, 4);
enemyDamageValue(objSparkShock, 1);
enemyDamageValue(objSearchSnake, 1);
enemyDamageValue(objTenguBlade, 2);
enemyDamageValue(objTenguDash, 2);
enemyDamageValue(objTenguDisk, 2);
enemyDamageValue(objSaltWater, 2);
enemyDamageValue(objConcreteShot, 4);
enemyDamageValue(objHomingSniper, 1);

// MaG24HMML
enemyDamageValue(objSuperArmBlockProjectile, 1);
enemyDamageValue(objSuperArmDebris, 1);
enemyDamageValue(objChillShot, 2);
enemyDamageValue(objChillSpikeLanded, 4);

// Misc
enemyDamageValue(objPowerStone, 2);
enemyDamageValue(objPlantBarrier, 1);
enemyDamageValue(objBrickWeapon, 2);
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
    // Fire Man's custom intro
    if (startIntro)
    {
        y -= view_hview;
        canFillHealthBar = false;
        startIntro = false;
        isIntro = true;
        visible = true;
        grav = gravStart;
        calibrateDirection();
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
            // since bosses do not have gravity during intros, we need to reuse this here.
            hasTriggeredFall = true;
            y = ystart;
            attackTimer+=1;
            if (attackTimer < 8)
            {
                image_index = 0;
            }
            if (attackTimer == 8)
            {
                image_index = 2;
                image_speed = 6 / 60;
            }
            if (image_index == 12)
            {
                image_speed = 0;
                canFillHealthBar = true;
                isIntro = false;
                attackTimer = 0;
                blockCollision = blockCollisionStart;
            }
        }
    }

    // Actual fight
    if (isFight == true)
    {
        switch (phase)
        {
            // Walking
            case 0:
                xspeed = 1 * image_xscale;
                image_speed = 0.15;
                if (ground)
                {
                    if ((instance_exists(target)) && (abs(round(target.x) - x) == 95))
                    {
                        // Face the player
                        calibrateDirection();
                        xspeed = 0;
                        sprite_index = spriteShoot;
                        phase = 1;
                    }
                    else
                    {
                        sprite_index = spriteRun;

                        if (xcoll != 0)
                        {
                            image_xscale *= -1;
                        }
                    }
                }
                break;
            case 1:
                moveTimer-=1;
                if (moveTimer == 29)
                {
                    var i; i = instance_create(x, y, objFireManStorm);
                    i.image_xscale = image_xscale;
                }
                if (moveTimer <= 0)
                {
                    moveTimer = 40;
                    phase = 0;
                    image_xscale *= -1;
                }
                break;
        }
    }
}
else
{
    image_speed = 0;
}
#define Other_20
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
with (objFireManStorm)
{
    instance_destroy();
}
with (objFireFlame)
{
    instance_destroy();
}
event_inherited();
#define Other_21
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
// Face the player
calibrateDirection();
xspeed = 0;
sprite_index = spriteShoot;
phase = 1;
