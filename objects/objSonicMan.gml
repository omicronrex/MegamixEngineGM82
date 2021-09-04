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
contactDamage = 3;
customPose = true;
ground = false;
attackTimer = 0;
hasTriggeredFall = false;
introType = 0;
bossTriggered = true;
phase = 0;
hasFired = false;
grav = 0.24;
cAngle = 90;
cDistance = 4;
bobAround = false;

skewerPhase = 1;

// Health Bar
healthBarPrimaryColor[1] = 22;
healthBarSecondaryColor[1] = 17;

// Music
music = "Mega_Man_5GB.gbs";
musicType = "VGM";
musicTrackNumber = 5;

// Damage Table
enemyDamageValue(objBusterShot, 1);
enemyDamageValue(objBusterShotHalfCharged, 1);
enemyDamageValue(objBusterShotCharged, 3);

// MaGMML3
enemyDamageValue(objSparkChaser, 4);
enemyDamageValue(objLaserTrident, 2);
enemyDamageValue(objWaterShield, 0);
enemyDamageValue(objTornadoBlow, 1);
enemyDamageValue(objThunderBeam, 2);
enemyDamageValue(objMagneticShockwave, 2);
enemyDamageValue(objIceWall, 1);
enemyDamageValue(objBreakDash, 1);

// MaGMML2
enemyDamageValue(objHornetChaser, 2);
enemyDamageValue(objJewelSatellite, 1);
enemyDamageValue(objGrabBuster, 2);
enemyDamageValue(objTripleBlade, 4);
enemyDamageValue(objWheelCutter, 1);
enemyDamageValue(objSlashClaw, 2);
enemyDamageValue(objSakugarne, 2);
enemyDamageValue(objSuperArrow, 2);
enemyDamageValue(objWireAdapter, 3);

// MaGMML1
enemyDamageValue(objMetalBlade, 4);
enemyDamageValue(objGeminiLaser, 2);
enemyDamageValue(objSolarBlaze, 0);
enemyDamageValue(objTopSpin, 2);
enemyDamageValue(objThunderWool, 4);
enemyDamageValue(objPharaohShot, 0);
enemyDamageValue(objBlackHoleBomb, 1);
enemyDamageValue(objMagicCard, 2);

// MaG48HMML
enemyDamageValue(objFlameMixer, 0);
enemyDamageValue(objRainFlush, 1);
enemyDamageValue(objSparkShock, 2);
enemyDamageValue(objSearchSnake, 4);
enemyDamageValue(objTenguBlade, 4);
enemyDamageValue(objTenguDash, 3);
enemyDamageValue(objTenguDisk, 4);
enemyDamageValue(objSaltWater, 0);
enemyDamageValue(objConcreteShot, 2);
enemyDamageValue(objHomingSniper, 2);

// MaG24HMML
enemyDamageValue(objSuperArmBlockProjectile, 1);
enemyDamageValue(objSuperArmDebris, 1);
enemyDamageValue(objChillShot, 2);
enemyDamageValue(objChillSpikeLanded, 2);

// Misc.
enemyDamageValue(objPowerStone, 1);
enemyDamageValue(objPlantBarrier, 3);
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

// all of sonic man's events trigger when the game isn't frozen.
if (!global.frozen)
{
    // sonic man's custom intro
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
            y = ystart + 1;
            cAngle += 4;
            bobAround = true;
            image_speed = 0;
            attackTimer+=1;
            if (attackTimer < 8)
                image_index = 0;
            if (attackTimer == 8)
                image_index = 1;
            if (attackTimer == 12)
                image_index = 2;
            if (attackTimer == 16)
                image_index = 3;
            if (attackTimer == 20)
                image_index = 4;
            if (attackTimer == 50)
            {
                image_index = 0;
                canFillHealthBar = true;
                isIntro = false;
                attackTimer = 0;
                hasFired = true;
                grav = gravStart;
                blockCollision = blockCollisionStart;
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
        attackTimer+=1;
        cAngle += 4;
        if (cAngle >= 360)
        {
            cAngle -= 360;
        }
        if (xspeed == 0)
        {
            calibrateDirection();
        }
        switch (phase)
        {
            case 0: // prepare phase!
                xspeed = 0;
                if (attackTimer < 20)
                {
                    bobAround = true;
                    image_index = 0;
                }
                if (attackTimer == 20) // move up
                {
                    yspeed = -1.5;
                    bobAround = false;
                    grav = 0;
                }
                if (attackTimer >= 20)
                {
                    image_index = 5 + (attackTimer / 8 mod 2);
                }
                if (attackTimer == 34) // fire sonic mine
                {
                    hasFired = false;
                    phase = 1;
                }
                break;
            case 1: // fire sonic mine
                image_index = 8 + (attackTimer / 8 mod 2);
                if (!hasFired)
                {
                    hasFired = true;
                    playSFX(sfxSonicManSonicMine);
                    var inst; inst = instance_create(x, y, objSonicMine);
                    inst.xspeed = 4 * image_xscale;
                    inst = instance_create(x, y, objSonicMine);
                    inst.xspeed = 2.5 * image_xscale;
                    inst = instance_create(x, y, objSonicMine);
                    inst.xspeed = 1 * image_xscale;
                }
                if (attackTimer == 56) // fire sonic mine
                {
                    yspeed = 0;
                    hasFired = false;
                    attackTimer = 0;
                    phase = choose(2, 3);
                    image_index = 7;
                    bobAround = true;
                }
                break;
            case 2: // divebomb
                if (attackTimer == 16)
                {
                    image_index = 10;
                }
                if (attackTimer == 56)
                {
                    image_index = 11;
                    grav = 0.45;
                    yspeed = -2;

                    if (instance_exists(target))
                    {
                        xspeed = xSpeedAim(x, y, target.x, target.y, yspeed, grav, 5.2);
                    }
                    else
                    {
                        xspeed = 2 * image_xscale;
                    }
                    yspeed = 0;
                }
                if (ground)
                {
                    xspeed = 0;
                    attackTimer = 0;
                    phase = 0;
                }
                break;
            case 3: // move
                image_index = 7;
                if (!hasFired && attackTimer >= 24)
                {
                    xspeed = choose(1.5, 1.75, 2) * image_xscale;
                    yspeed = 1;
                    hasFired = true;
                }
                if (attackTimer == 72 || xcoll != 0)
                {
                    xspeed = 0;
                }
                if (ground)
                {
                    xspeed = 0;
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
with (objSonicMine)
    instance_destroy();
event_inherited();
#define Draw_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if (!dead)
{
    if (drawBoss) // actually draw itself
    {
        if ((iFrames mod 4) < 2 || !iFrames)
        {
            if (!bobAround)
            {
                drawSelf();
            }
            else
            {
                draw_sprite_ext(sprite_index, image_index, round(x), round(y + cos(+degtorad(cAngle)) * cDistance),
                    image_xscale, image_yscale, image_angle, image_blend, image_alpha);
            }
        }
        else // Hitspark
        {
            draw_sprite_ext(sprHitspark, 0, spriteGetXCenter(), spriteGetYCenter(), 1, 1, 0, c_white, 1);
        }
    }
}
