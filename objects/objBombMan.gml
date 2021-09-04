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
attackRandomiser = 3;
jumpY = -5.5;
setX = 0;
delay = 0;
storeSpeed = 0;
hasFired = false;
shotsFired = 0;
hasBomb = false;

// store bomb location per frame
bombX[0] = 9;
bombY[0] = -9;
bombX[1] = 7;
bombY[1] = -15;
bombX[2] = 9;
bombY[2] = -8;
bombX[3] = -999;
bombY[3] = -999;
bombX[4] = 13;
bombY[4] = -19;
bombX[5] = 7;
bombY[5] = -20;
bombX[6] = 3;
bombY[6] = -20;
grav = 0.25;

// Health Bars
healthBarPrimaryColor[1] = 18;
healthBarSecondaryColor[1] = 33;

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
enemyDamageValue(objTornadoBlow, 1);
enemyDamageValue(objThunderBeam, 2);
enemyDamageValue(objBreakDash, 2);
enemyDamageValue(objMagneticShockwave, 6);
enemyDamageValue(objIceWall, 2);

// MaGMML2
enemyDamageValue(objHornetChaser, 1);
enemyDamageValue(objJewelSatellite, 1);
enemyDamageValue(objGrabBuster, 2);
enemyDamageValue(objTripleBlade, 4);
enemyDamageValue(objWheelCutter, 2);
enemyDamageValue(objSlashClaw, 2);
enemyDamageValue(objSakugarne, 1);
enemyDamageValue(objSuperArrow, 2);
enemyDamageValue(objWireAdapter, 2);

// MaGMML1
enemyDamageValue(objMetalBlade, 2);
enemyDamageValue(objGeminiLaser, 1);
enemyDamageValue(objSolarBlaze, 5);
enemyDamageValue(objTopSpin, 1);
enemyDamageValue(objThunderWool, 1);
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
enemyDamageValue(objConcreteShot, 2);
enemyDamageValue(objHomingSniper, 2);

// MaG24HMML
enemyDamageValue(objSuperArmBlockProjectile, 0);
enemyDamageValue(objSuperArmDebris, 0);
enemyDamageValue(objChillShot, 2);
enemyDamageValue(objChillSpikeLanded, 2);

// Misc.
enemyDamageValue(objPowerStone, 2);
enemyDamageValue(objPlantBarrier, 2);
enemyDamageValue(objBrickWeapon, 2);
enemyDamageValue(objIceSlasher, 0);
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
// leave this. this is needed.
event_inherited();

// all of bomb man's events trigger when the game isn't frozen.
if (!global.frozen)
{
    // bomb man's custom intro
    if (startIntro)
    {
        y -= view_hview;
        canFillHealthBar = false;
        image_index = 5;
        startIntro = false;
        isIntro = true;
        visible = true;
        grav = gravStart;
        calibrateDirection();
    }
    else if (isIntro)
    {
        // custom intro:
        if (y <= ystart && !hasTriggeredFall)
            y += 4;
        if (y >= ystart || hasTriggeredFall)
        {
            if (!hasTriggeredFall)
            {
                hasTriggeredFall = true;
                hasBomb = true;
            }
            y = ystart;
            image_speed = 0;
            if (!instance_exists(objBombManBomb))
            {
                attackTimer += 1;
                hasBomb = true;
            }
            if (attackTimer < 10)
                image_index = 0;
            if (attackTimer == 10)
                image_index = 2;
            if (attackTimer == 15)
            {
                image_index = 1;
                with (instance_create(round(x + bombX[image_index] * image_xscale), round(y + bombY[image_index] * image_yscale), objBombManBomb))
                {
                    xspeed = 0;
                    grav = 0.25;
                    yspeed = -4;
                    collectMe = true;
                }
                hasBomb = false;
                attackTimer = 16;
            }
            if (attackTimer == 17)
                image_index = 0;
            if (attackTimer == 30)
                image_index = 0;
            if (attackTimer == 58)
            {
                canFillHealthBar = true;
                isIntro = false;
                attackTimer = 0;
                blockCollision = blockCollisionStart;
            }
        }
    }
}
if (entityCanStep())
{
    if (isFight == true)
    {
        image_speed = 0;
        if (ground)
            attackTimer += 1;
        calibrateDirection();
        switch (phase)
        {
            case 0: // choose attack
                if (ground)
                {
                    image_index = 0;
                    xspeed = 0;
                }
                hasBomb = true;
                if (attackTimer == 2)
                {
                    attackTimer = 0;
                    if (attackRandomiser == 2)
                    {
                        attackRandomiser += irandom(2);
                    }
                    phase = attackRandomiser;
                }
                break;
            case 1: // throw bomb
                if (attackRandomiser == 1)
                    attackRandomiser = choose(3, 3, 2);
                if (attackTimer == 1)
                    image_index = 2;
                if (attackTimer == 9)
                {
                    image_index = 3;
                    hasBomb = false;
                    with (instance_create(round(x + bombX[2] * image_xscale), round(y + bombY[2] * image_yscale), objBombManBomb))
                    {
                        if (instance_exists(target))
                        {
                            xSpeedAim(x, y, target.x, target.y, yspeed, grav);
                        }
                    }
                }
                if (!instance_exists(objBombManBomb) && attackTimer >= 10)
                {
                    shotsFired += 1;
                    attackTimer = 0;
                    hasBomb = true;
                    image_index = 2;
                    if (shotsFired == attackRandomiser)
                    {
                        shotsFired = 0;
                        phase = 0;
                        attackRandomiser = 2;
                    }
                }
                break;
            case 2: // jump backwards
                if (ground)
                {
                    yspeed = -6;
                    xspeed = -1.5 * image_xscale;
                    image_index = 6;
                    phase = 0;
                    attackRandomiser = 1 + choose(0, 0, 1);
                }
                break;
            case 3: // jump forwards large
                if (ground)
                {
                    yspeed = -7;
                    xspeed = 2.5 * image_xscale;
                    image_index = 4;
                    phase = 0;
                    attackRandomiser = 1 + choose(0, 0, 1);
                }
                break;
            case 4: // jump forwards small
                if (ground)
                {
                    yspeed = -5;
                    xspeed = 1.5 * image_xscale;
                    image_index = 5;
                    phase = 0;
                    attackRandomiser = 1 + choose(0, 0, 1);
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
with (objBombManBomb)
{
    instance_create(x, y, objExplosion);
    instance_destroy();
}
with (objBombManBlast)
{
    instance_destroy();
}
event_inherited();
#define Draw_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if ((iFrames mod 4) < 2 || !iFrames)
{
    if (hasBomb)
    {
        draw_sprite_ext(sprBombManBomb, 0, round(x + bombX[image_index] * image_xscale), round(y + bombY[image_index] * image_yscale),
            image_xscale, image_yscale, image_angle, image_blend, image_alpha);
    }
}
event_inherited();
