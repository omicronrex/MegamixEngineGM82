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
blockCollision = true;

attackTimer = 0;
hasTriggeredFall = false;
introType = 0;
bossTriggered = true;
delayUse = false;
phase = 0;
attackRandomiser = -1;
oldAttack = -1;
jumpY = -7.5;
findWall = 0;
jumpToWall = false;
onWall = false;
oilSlider = false;
animStore = 0;
delay = 0;
storeSpeed = 0;
hasFired = false;
shotsFired = 0;
grav = 0.25;

// Health Bar
healthBarPrimaryColor[1] = 12;
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
enemyDamageValue(objSparkChaser, 1);
enemyDamageValue(objLaserTrident, 2);
enemyDamageValue(objWaterShield, 4);
enemyDamageValue(objTornadoBlow, 1);
enemyDamageValue(objThunderBeam, 1);
enemyDamageValue(objBreakDash, 1);
enemyDamageValue(objMagneticShockwave, 2);
enemyDamageValue(objIceWall, 1);

// MaGMML2
enemyDamageValue(objHornetChaser, 2);
enemyDamageValue(objJewelSatellite, 1);
enemyDamageValue(objGrabBuster, 2);
enemyDamageValue(objTripleBlade, 1);
enemyDamageValue(objWheelCutter, 2);
enemyDamageValue(objSlashClaw, 2);
enemyDamageValue(objSakugarne, 3);
enemyDamageValue(objSuperArrow, 2);
enemyDamageValue(objWireAdapter, 1);

// MaGMML1
enemyDamageValue(objMetalBlade, 1);
enemyDamageValue(objGeminiLaser, 2);
enemyDamageValue(objSolarBlaze, 5);
enemyDamageValue(objTopSpin, 1);
enemyDamageValue(objThunderWool, 1);
enemyDamageValue(objPharaohShot, 2);
enemyDamageValue(objBlackHoleBomb, 1);
enemyDamageValue(objMagicCard, 2);

// MaG48MML
enemyDamageValue(objFlameMixer, 5);
enemyDamageValue(objRainFlush, 1);
enemyDamageValue(objSparkShock, 1);
enemyDamageValue(objSearchSnake, 1);
enemyDamageValue(objTenguBlade, 1);
enemyDamageValue(objTenguDash, 2);
enemyDamageValue(objTenguDisk, 2);
enemyDamageValue(objSaltWater, 2);
enemyDamageValue(objConcreteShot, 1);
enemyDamageValue(objHomingSniper, 2);

// MaG24HMML
enemyDamageValue(objSuperArmBlockProjectile, 1);
enemyDamageValue(objSuperArmDebris, 1);
enemyDamageValue(objChillShot, 1);
enemyDamageValue(objChillSpikeLanded, 4);

// Misc.
enemyDamageValue(objPowerStone, 1);
enemyDamageValue(objPlantBarrier, 1);
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

// all of bomb man's events trigger when the game isn't frozen.
if (entityCanStep())
{
    // bomb man's custom intro
    if (startIntro)
    {
        y -= view_hview;
        canFillHealthBar = false;
        image_index = 22;
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
            yspeed += 0.25;
        if (y + yspeed >= ystart || hasTriggeredFall)
        {
            if (!hasTriggeredFall)
            {
                y = ystart;
                hasTriggeredFall = true;
                playSFX(sfxSplash);
                yspeed = -6;
                image_index = 5;
                attackTimer = -1000;
                var i; for ( i = 0; i < 12; i += 1) // create oil splash
                {
                    var inst; inst = instance_create((x - 3) + irandom(6), y, objOilManParticle);
                    var inst; inst = instance_create((x - 3) + irandom(6), y, objOilManParticle);
                    var inst; inst = instance_create((x - 3) + irandom(6), y, objOilManParticle);
                    inst.sprite_index = sprOilManShot;
                }
            }
            blockCollision = 1;
            image_speed = 0;
            attackTimer += 1;
            if (yspeed < 0)
                image_index = 5;
            else if (yspeed >= 0 && yspeed < 3 && !ground)
                image_index = 6;
            else if (!ground)
            {
                image_index = 7;
            }
            if (ground && attackTimer < 0)
            {
                attackTimer = 0;
                image_index = 0;
            }

            // intro animation
            if (attackTimer == 10)
                image_index = 23;
            if (attackTimer == 18 || attackTimer == 34)
                image_index = 24;
            if (attackTimer == 26)
                image_index = 25;
            if (attackTimer == 42)
                image_index = 0;
            if (attackTimer == 58)
            {
                canFillHealthBar = true;
                isIntro = false;
                attackTimer = 0;
                grav = gravStart;
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
        if (jumpToWall)
        {
            jumpToWall = false;
            var i; for ( i = 0; i < 256; i += 1)
            {
                if (checkSolid(i * image_xscale, 0, 1, 1))
                {
                    break;
                }
                else
                {
                    findWall += 1;
                }
            }

            if (instance_exists(target))
            {
                xspeed = xSpeedAim(x, y, x + findWall * image_xscale, y, yspeed, grav);
            }
        }

        // setup jump animation
        if (yspeed < 0 && !oilSlider)
            image_index = 5;
        else if (yspeed >= 0 && yspeed < 3 && !onWall && !ground && !oilSlider)
            image_index = 6;
        else if (!ground && !onWall && !oilSlider)
        {
            image_index = 7;
            attackTimer = 0;
        }
        switch (phase)
        {
            case 0: // choose attack
                if (ground)
                {
                    image_index = 0;
                    xspeed = 0;
                }
                else
                    attackTimer = 0;
                if (attackRandomiser == oldAttack)
                    attackRandomiser = choose(1, 2, 3);
                calibrateDirection();
                if (attackTimer >= 10)
                {
                    attackTimer = 0;
                    oldAttack = attackRandomiser;
                    phase = attackRandomiser;
                }
                break;
            case 1: // jump across room
            // animation setup
                if (ground)
                {
                    image_index = 0;
                    xspeed = 0;
                }
                if (shotsFired == 0) // on first jump, jump towards mega man
                {
                    shotsFired = 1;
                    yspeed = jumpY;
                    if (instance_exists(target))
                        xspeed = xSpeedAim(x, y, target.x, target.y, yspeed, grav);
                    else
                        xspeed = 4 * image_xscale;
                    findWall = 0;
                }
                if (shotsFired == 1 && attackTimer == 10) // on second jump, jump towards wall
                {
                    yspeed = jumpY;
                    findWall = 0;
                    jumpToWall = true;
                    shotsFired = 2;
                }
                if (ground && shotsFired == 2 && yspeed >= 0) // change phase!
                {
                    shotsFired = 0;
                    attackTimer = 0;
                    phase = 6;
                }
                break;
            case 2: // walk across arena and jump when near mega man
                if (ground && shotsFired == 0)
                {
                    xspeed = 2 * image_xscale;
                    image_index = 1 + ((attackTimer / 6) mod 4);
                    if (instance_exists(target))
                    {
                        if (abs(x - target.x) < 32)
                        {
                            findWall = 0;
                            yspeed = jumpY;
                            jumpToWall = true;
                            shotsFired = 1;
                        }
                    }
                }
                if (ground && shotsFired == 1 && yspeed >= 0) // change phase!
                {
                    shotsFired = 0;
                    attackTimer = 0;
                    phase = 6;
                }
                break;
            case 3: // oil slider start
                if (shotsFired == 0)
                {
                    animStore = 0;
                    findWall = 0;
                    yspeed = jumpY / 2;
                    grav = 0.25;
                    shotsFired = 1;
                }
                if (shotsFired == 1 && yspeed >= 0)
                {
                    oilSlider = true;
                    image_index = 12;
                    var sd;
                    var i; for ( i = 0; i < 224; i += 1)
                    {
                        if (checkSolid(0, i, 1, 1) || place_meeting(x, y + i, objTopSolid))
                            break;
                        else
                            findWall += 1;
                    }
                    sd = instance_create(x, y + (findWall / 2), objOilManParticle);
                    sd.contactDamage = 0;
                    sd.reflectable = false;
                    animStore = sd.y;
                    with (sd)
                        instance_destroy();
                    shotsFired = 2;
                }
                if (shotsFired == 2 && y >= animStore && y < animStore + 8 && !ground)
                    image_index = 13;
                if (shotsFired == 2 && y >= animStore + 8 && !ground)
                {
                    image_index = 14;
                    attackTimer = 0;
                }
                if (ground && image_index < 15)
                    image_index = 15;
                if (ground && oilSlider)
                {
                    if (attackTimer mod 3 == 1)
                        image_index += 1;
                    if (attackTimer mod 3 == 1 && image_index == 16)
                    {
                        playSFX(sfxOil);
                        var i; for ( i = 0; i < 8; i += 1) // create oil splash
                        {
                            var inst; inst = instance_create((x - 3) + irandom(6), y, objOilManParticle);
                            var inst; inst = instance_create((x - 3) + irandom(6), y, objOilManParticle);
                        }
                    }
                    if (image_index == 18)
                    {
                        attackTimer = 0;
                        shotsFired = 0;
                        phase = 4;
                        grav = 0.25;
                    }
                }
                break;
            case 4: // oil slider
                image_index = 18 + ((attackTimer / 4) mod 4);
                if (abs(xspeed) < 6)
                    xspeed += 0.5 * image_xscale;
                if (xcoll != 0)
                {
                    oilSlider = false;
                    yspeed = jumpY / 1.5;
                    playSFX(sfxWaveManPipe);
                    phase = 5;
                }
                break;
            case 5: // change phases after oil slider
                if (!ground)
                    attackTimer = 0;
                if (ground && yspeed >= 0)
                {
                    image_index = 0;
                    calibrateDirection();
                }
                if (attackTimer == 5)
                {
                    attackTimer = 0;
                    phase = choose(0, 3);
                }
                break;
            case 6: // oil buster
                if (ground)
                    image_index = 0;
                if (attackTimer == 10 && ground)
                    yspeed = jumpY * 0.9;
                if (!ground && grav != 0) // reset attack timer. since attack timer only moves forward when on the ground, an additional event is needed here.
                    attackTimer = 0;
                else if (grav == 0)
                    attackTimer += 1;
                if (!ground && yspeed >= 0 && grav != 0) // when oilman's yspeed is greater than 0, attach him to the wall.
                {
                    onWall = true;
                    grav = 0;
                    yspeed = 0;
                    calibrateDirection();
                    image_index = 8;
                }
                if (attackTimer mod 48 == 16) // shoot oil shot
                {
                    image_index = 9;
                    instance_create(x + 12 * image_xscale, y + 2, objExplosion);
                    instance_create(x + 8 * image_xscale, y - 2, objOilManOilShot);
                    playSFX(sfxEnemyShootClassic);
                    shotsFired += 1;
                }

                // setup oil man's animation during shooting
                if (attackTimer mod 48 == 24)
                    image_index = 10;
                if (attackTimer mod 48 == 32)
                    image_index = 11;
                if (attackTimer mod 48 == 40)
                    image_index = 8;
                if (shotsFired == 3 && image_index == 8) // if oil man has fired three shots, make him fall.
                {
                    onWall = false;
                    grav = 0.25;
                    shotsFired = 0;
                    attackTimer = 0;
                    phase = 0;
                }
                break;
        }
        if (!instance_exists(target))
        {
            xspeed = 0;
            grav = 0.25;
            image_index = 0;
        }
    }
}
#define Other_20
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
with (objOilManParticle)
    instance_destroy();
with (objOilManOilShot)
    instance_create(x, y, objExplosion);
instance_destroy();
with (objOilManPuddle)
    instance_create(x, y, objExplosion);
instance_destroy();
event_inherited();
#define Other_21
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();

// guard if on oil slider
if (image_index >= 16)
{
    other.guardCancel = 1;
}
