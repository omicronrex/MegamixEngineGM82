#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();

healthParent=-1;//The parent gemini man acts normally, only its clones need to change this
healthpointsStart = 28;
healthpoints = healthpointsStart;
pose = sprGeminiIntro;
poseImgSpeed = 16 / 60;
contactDamage = 6;
ground = false;
attackTimer = 0;
jumpTimer = 0;
jumpAmount = 0;
canInitShoot = true;
phase = 0;
syncIFrames=true;
getLastXspeed = xspeed;
landTimer = 0;
clone = id;
makeClones = 1;
maxClones = 0;
cloneDelayOffset = 60;
cloneAddedDelay = 45;
cloneId = 0;
memYspeed = 0;
pauseY = 0;
delay = 0;
knockbackTimer = -1;
jumpToX = 0;
canIce = false;

isHard = false;

// Health Bar
healthBarPrimaryColor[1] = 27;
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
enemyDamageValue(objSparkChaser, 4);
enemyDamageValue(objLaserTrident, 2);
enemyDamageValue(objWaterShield, 1);
enemyDamageValue(objTornadoBlow, 1);
enemyDamageValue(objThunderBeam, 1);
enemyDamageValue(objBreakDash, 2);
enemyDamageValue(objMagneticShockwave, 2);
enemyDamageValue(objIceWall, 1);

// MaGMML2
enemyDamageValue(objHornetChaser, 4); //This is primarily for the Example Game
enemyDamageValue(objJewelSatellite, 2);
enemyDamageValue(objGrabBuster, 2);
enemyDamageValue(objTripleBlade, 1);
enemyDamageValue(objWheelCutter, 4);
enemyDamageValue(objSlashClaw, 2);
enemyDamageValue(objSakugarne, 3);
enemyDamageValue(objSuperArrow, 2);
enemyDamageValue(objWireAdapter, 1);

// MaGMML1
enemyDamageValue(objMetalBlade, 1);
enemyDamageValue(objGeminiLaser, 4);
enemyDamageValue(objSolarBlaze, 5);
enemyDamageValue(objTopSpin, 2);
enemyDamageValue(objThunderWool, 1);
enemyDamageValue(objPharaohShot, 1);
enemyDamageValue(objBlackHoleBomb, 1);
enemyDamageValue(objMagicCard, 2);

// MaG48MML
enemyDamageValue(objFlameMixer, 2);
enemyDamageValue(objRainFlush, 1);
enemyDamageValue(objSparkShock, 1);
enemyDamageValue(objSearchSnake, 5);
enemyDamageValue(objTenguBlade, 2);
enemyDamageValue(objTenguDash, 2);
enemyDamageValue(objTenguDisk, 2);
enemyDamageValue(objSaltWater, 1);
enemyDamageValue(objConcreteShot, 1);
enemyDamageValue(objHomingSniper, 1);

// MaG48MML
enemyDamageValue(objSuperArmBlockProjectile, 1);
enemyDamageValue(objSuperArmDebris, 1);
enemyDamageValue(objChillShot, 1);
enemyDamageValue(objChillSpikeLanded, 1);

// Misc.
enemyDamageValue(objPowerStone, 4);
enemyDamageValue(objPlantBarrier, 1);
enemyDamageValue(objBrickWeapon, 1);
enemyDamageValue(objIceSlasher, 1);
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();
if (entityCanStep())
{
    if (isFight == true)
    {
        if (delay > 0)
        {
            delay -= 1;
            exit;
        }

        if (makeClones)
        {
            for (var i = 0; i < maxClones; i++)
            {
                var c = instance_create(x, y, objGemineighbour);
                c.clone = id;
                c.healthParent=id;
                c.sprite_index = sprGeminiStand;
                c.maxClones = maxClones;
                c.xstart = xstart;
                c.ystart = ystart;
                c.image_xscale = image_xscale;
                c.phase = phase;
                c.attackTimer = attackTimer;
                c.healthpoints=healthpoints;
                c.healthParent=id;//Sync damage and healthbars
                c.makeClones = 0;
                c.delay = cloneDelayOffset + i * cloneAddedDelay;
                c.cloneId = i + 1;
                c.itemDrop = -1;
                c.useEndStageBehavior = false;
                c.syncIFrames=syncIFrames;
            }
            makeClones = false;
        }

        switch (phase)
        {
            case 0: // RunJumping
                if (healthpoints < (healthpointsStart / 2) && ground)
                {
                    if (cloneId == 0)
                    {
                        phase = 2;
                        xspeed = 0;
                        yspeed = 0;
                        attackTimer = 0;
                    }
                }

                // determine coordinates to jump to
                if (jumpToX == 0)
                {
                    jumpToX = abs(x - (view_xview + view_wview));
                }
                if (ground && xspeed < 0)
                {
                    xspeed = 0;
                }
                if (x >= xstart && ground)
                {
                    if (delay <= 0)
                    {
                        sprite_index = sprGeminiJump;
                        yspeed = -7;
                        xspeed = arcCalcXspeed(yspeed, 0.25, x, y,
                            view_xview + jumpToX - 8, y);
                        attackTimer = 0;
                        image_xscale = -1;
                    }
                }
                else if (ground)
                {
                    attackTimer += 1;
                    if (attackTimer > 5)
                    {
                        xspeed = 3;
                        image_xscale = 1;
                        sprite_index = sprGeminiWalk;
                        image_speed = 0.2;
                    }
                    else
                    {
                        sprite_index = sprGeminiStand;
                    }

                    // if the target is pressing the shoot button, shoot back
                    if (instance_exists(target))
                    {
                        if (global.keyShootPressed[target.playerID])
                        {
                            phase = 1;

                            // only stop if you're on lower than hard mode
                            xspeed = 0;

                            image_index = 0;
                            image_speed = 0;
                            attackTimer = 0;
                        }
                    }
                }
                else
                {
                    sprite_index = sprGeminiJump;
                }
                if (checkSolid(xspeed, 0)) // stuck prevention
                {
                    sprite_index = sprGeminiJump;
                    if (ground)
                    {
                        yspeed = -4;
                    }
                    xspeed = sign(xspeed);
                }
                var isPhaseDifferent = false;
                var i = 0;
                with (objGeminiMan)
                {
                    if (id != other && phase < 2 && clone.id == other.clone.id)
                    {
                        i++;
                        if (phase != other.phase)
                        {
                            isPhaseDifferent = true;
                            break;
                        }
                    }
                }

                // pause if the clone is not on the same phase and we're in the air
                if (i > 0 && !place_meeting(x - xspeed * 4, y, objGeminiMan) && !ground)
                {
                    if (isPhaseDifferent)
                    {
                        if (pauseY != 0)
                            y = pauseY;
                        else
                        {
                            pauseY = y;
                            y -= yspeed;
                        }
                        x -= xspeed;
                        if (memYspeed == 0)
                            memYspeed = yspeed;
                        yspeed = 0;
                    }
                    else if (memYspeed != 0)
                    {
                        yspeed = memYspeed;
                        memYspeed = 0;
                        pauseY = 0;
                    }
                }
                break;
            case 1: // shooting
                calibrateDirection();
                attackTimer += 1;
                sprite_index = sprGeminiShoot;
                if (attackTimer <= 5)
                    image_index = 0;
                if (attackTimer == 5)
                {
                    image_index = 1;
                    bull = instance_create(x, y + 2, objGeminiBullet);
                    bull.xspeed = image_xscale * 4;
                }
                if (attackTimer >= 10)
                    phase = 0;
                break;
            case 2:
                if (checkSolid(image_xscale * 8, 0))
                {
                    image_xscale = -image_xscale;
                }
                if (attackTimer < 120)
                {
                    if (ground)
                    {
                        if (landTimer <= 5)
                        {
                            xspeed = 0;
                            sprite_index = sprGeminiStand;
                            landTimer += 1;
                        }
                        else
                        {
                            xspeed = image_xscale * 1.5;
                            sprite_index = sprGeminiWalk;
                            image_speed = 0.15;
                        }
                        if (instance_exists(target))
                        {
                            if (global.keyShootPressed[target.playerID])
                            {
                                xspeed = image_xscale * 1.5;
                                yspeed = -5;
                                landTimer = 0;
                            }
                        }
                    }
                    else if (!ground)
                        sprite_index = sprGeminiJump;
                }
                if (canInitShoot && ground && !instance_exists(objGeminiManLaser)
                    || attackTimer >= 120)
                    attackTimer += 1;
                if (attackTimer >= 120)
                {
                    canInitShoot = false;
                    xspeed = 0;
                    sprite_index = sprGeminiShoot;
                    if (attackTimer < 125)
                        image_index = 0;
                    else
                        image_index = 1;
                    if (attackTimer >= 120)
                    {
                        xspeed = 0;
                        sprite_index = sprGeminiShoot;
                        if (attackTimer < 125)
                            image_index = 0;
                        else
                            image_index = 1;
                        if (attackTimer == 125)
                        {
                            for (i = -1; i <= 1; i += 1)
                            {
                                laser = instance_create((round(x / 2) * 2) + i * 7,
                                    y + 2, objGeminiManLaser);
                                laser.xspeed = image_xscale * 2;
                                if (i == -1)
                                    laser.x += 1; // for some reason the first one seperates
                            }
                        }
                        if (attackTimer >= 130)
                            attackTimer = 60;
                    }
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
event_inherited();

// get rid of clones and projectiles
with (objGemineighbour)
{
    instance_destroy();
}

with (objGeminiManLaser)
{
    instance_destroy();
}

with (objGeminiBullet)
{
    instance_destroy();
}
#define Other_25
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();
if (spawned)
{
    if (maxClones == 0)
    {
        if (isHard)
        {
            maxClones = 2;
        }
        else
        {
            maxClones = 1;
        }
    }
}
#define Draw_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();
