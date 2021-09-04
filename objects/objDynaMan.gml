#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();

healthpointsStart = 28;
healthpoints = healthpointsStart;

healthBarPrimaryColor[1] = 22;
healthBarSecondaryColor[1] = 52;

customPose = true;
introType = 0;
hasTriggeredFall = false;
bossTriggered = true;
starterBomb = true;
starterBombX = 12;
starterBombY = -26;

image_speed = 0;
contactDamage = 6;

bombX = 13;
bombY = 1;
smallJumpHeight = 24;
bigJumpHeight = 96;

ground = false;
attackTimer = 0;

fallTime = false;
smallJumps = 3;
jumpCounter = 0;
bombToThrow = true;

// Music
music = "Mega_Man_5GB.gbs";
musicType = "VGM";
musicTrackNumber = 5;

// Damage Table
enemyDamageValue(objBusterShot, 1);
enemyDamageValue(objBusterShotHalfCharged, 1);
enemyDamageValue(objBusterShotCharged, 3);

// MaGMML3
enemyDamageValue(objSparkChaser, 1);
enemyDamageValue(objLaserTrident, 2);
enemyDamageValue(objWaterShield, 4);
enemyDamageValue(objTornadoBlow, 1);
enemyDamageValue(objThunderBeam, 1);
enemyDamageValue(objMagneticShockwave, 4);
enemyDamageValue(objIceWall, 1);
enemyDamageValue(objBreakDash, 1);

// MaGMML2
enemyDamageValue(objHornetChaser, 1);
enemyDamageValue(objJewelSatellite, 2);
enemyDamageValue(objGrabBuster, 2);
enemyDamageValue(objTripleBlade, 1);
enemyDamageValue(objWheelCutter, 3);
enemyDamageValue(objSlashClaw, 4);
enemyDamageValue(objSakugarne, 2);
enemyDamageValue(objSuperArrow, 2);
enemyDamageValue(objWireAdapter, 3);

// MaGMML1
enemyDamageValue(objMetalBlade, 1);
enemyDamageValue(objGeminiLaser, 1);
enemyDamageValue(objSolarBlaze, 4);
enemyDamageValue(objTopSpin, 1);
enemyDamageValue(objThunderWool, 2);
enemyDamageValue(objPharaohShot, 2);
enemyDamageValue(objBlackHoleBomb, 1);
enemyDamageValue(objMagicCard, 2);

// MaG48HMML
enemyDamageValue(objFlameMixer, 4);
enemyDamageValue(objRainFlush, 2);
enemyDamageValue(objSparkShock, 2);
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
enemyDamageValue(objChillShot, 0);
enemyDamageValue(objChillSpikeLanded, 0);

// Misc.
enemyDamageValue(objPowerStone, 1);
enemyDamageValue(objPlantBarrier, 2);
enemyDamageValue(objBrickWeapon, 1);
enemyDamageValue(objIceSlasher, 1);
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
// leave this. this is needed.
event_inherited();

// all of dyna man's events trigger when the game isn't frozen.
if (!global.frozen)
{
    if (startIntro)
    {
        y -= view_hview;
        canFillHealthBar = false;
        image_index = 2;
        startIntro = false;
        isIntro = true;
        visible = true;
        calibrateDirection();
    }
    else if (isIntro)
    {
        if (y <= ystart && !hasTriggeredFall)
            y += 4;
        if (y >= ystart || hasTriggeredFall)
        {
            sprite_index = sprDynaManIntro;
            if (!hasTriggeredFall)
            {
                hasTriggeredFall = true;
                starterBomb = true;
            }
            y = ystart;
            image_speed = 0;
            if (!instance_exists(objDynaDynamite))
            {
                attackTimer += 1;
            }
            if (attackTimer < 10)
                image_index = 0;
            if (attackTimer == 10)
                image_index = 1;
            if (attackTimer == 15)
            {
                image_index = 2;
            }
            if (attackTimer == 20)
            {
                image_index = 3;
                with (instance_create(x + starterBombX * image_xscale,
                    y + starterBombY * image_yscale, objDynaDynamite))
                {
                    xspeed = 0;
                    grav = 0.25;
                    yspeed = -6;
                    collectMe = true;
                }
                starterBomb = false;
                attackTimer = 21;
            }
            if (attackTimer == 22)
                image_index = 2;
            if (attackTimer == 27)
                image_index = 1;
            if (attackTimer == 32)
            {
                image_index = 0;
                canFillHealthBar = true;
                isIntro = false;
                grav = gravStart;
                blockCollision = blockCollisionStart;
                attackTimer = 0;
            }
        }
    }
}
if (entityCanStep())
{
    if (isFight)
    {
        image_speed = 0;
        sprite_index = sprDynaMan;
        calibrateDirection();
        if (ground)
        {
            image_index = 0;
            if (attackTimer > 0)
            {
                xspeed = 0;
                attackTimer--;
            }
            else
            {
                if (fallTime)
                {
                    fallTime = false;
                    bombToThrow = true;
                    if (smallJumps > jumpCounter)
                    {
                        attackTimer = 10;
                        jumpCounter++;
                    }
                    else
                    {
                        attackTimer = 45;
                        smallJumps = 3 + irandom(4);
                        jumpCounter = 0;
                    }
                }
                else
                {
                    fallTime = true;
                    var x_start, x_end, x_displacement;
                    x_start = x;
                    if (instance_exists(target))
                    {
                        x_end = target.x;
                    }
                    else
                    {
                        x_end = x;
                    }
                    x_displacement = x_end - x_start;
                    if (abs(x_displacement) > 64)
                    {
                        x_displacement = sign(x_displacement) * 64;
                    }
                    if (smallJumps > jumpCounter)
                    {
                        image_index = (jumpCounter mod 2) + 1;
                        yspeed = -sqrt(abs(2 * gravAccel * smallJumpHeight));
                        airTime = abs(2 * yspeed / gravAccel);
                        xspeed = x_displacement / airTime;
                    }
                    else
                    {
                        image_index = 3;
                        yspeed = -sqrt(abs(2 * gravAccel * bigJumpHeight));
                        airTime = abs(2 * yspeed / gravAccel);
                        xspeed = x_displacement * 2 / airTime;
                    }
                }
            }
        }
        else
        {
            if (smallJumps <= jumpCounter && yspeed >= 0 && bombToThrow)
            {
                bombToThrow = false;
                image_index = 4;
                attackTimer = 6;
                if (instance_exists(target))
                {
                    with (instance_create(x + bombX * image_xscale,
                        y + bombY * image_yscale, objDynaDynamite))
                    {
                        image_xscale = other.image_xscale;
                        aimAtTarget(6);
                    }
                }
                else
                {
                    with (instance_create(x + bombX * image_xscale,
                        y + bombY * image_yscale, objDynaDynamite))
                    {
                        image_xscale = other.image_xscale;
                        xspeed = 0;
                        yspeed = 6;
                    }
                }
                playSFX(sfxEnemyDrop);
            }
            else if (smallJumps <= jumpCounter && yspeed >= 0)
            {
                if (attackTimer > 0)
                {
                    attackTimer--;
                }
                else
                {
                    image_index = 5;
                }
            }
        }
    }
}
#define Other_20
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
with (objDynaDynamite)
{
    instance_create(x, y, objExplosion);
    instance_destroy();
}
with (objHarmfulExplosion)
{
    instance_destroy();
}
event_inherited();
#define Other_25
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();

smallJumps = 3 + irandom(4);
