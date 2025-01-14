#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();

healthpointsStart = 28;
healthpoints = healthpointsStart;
pose = sprDanganIntro;
poseImgSpeed = 6 / 60;
contactDamage = 4;
ground = false;
attackTimer = 0;
beginAttackTimer = false;

// rather than using game maker's image offset features, this time round we're building a more accurate animation system.
imageTimer = 0;
imageTimerMax = 99;

// this is the minmum image_indexs of crash man for any given animation. imageNoMin is what the image_index is set to when plant man has finished an animation.
imageNoMin = 0;
attackTimerMax = 145;
phase = 0;
grav = 0.125;
delay = 0;
hasFired = false;
setY = 0;
setX = 0;
introType = 2;

// health bar variables
healthBarPrimaryColor[1] = 16;
healthBarSecondaryColor[1] = 27;

// Music
music = "RnFBossNES.ogg";
musicType = "OGG";
musicLoopSecondsStart = 55.70;
musicLoopSecondsEnd = 79.70;
musicVolume = 0.8;

// Damage Table
enemyDamageValue(objBusterShot, 1);
enemyDamageValue(objBusterShotHalfCharged, 1);
enemyDamageValue(objBusterShotCharged, 3);

// MaGMML3
enemyDamageValue(objSparkChaser, 1);
enemyDamageValue(objLaserTrident, 2);
enemyDamageValue(objWaterShield, 4);
enemyDamageValue(objTornadoBlow, 1);
enemyDamageValue(objThunderBeam, 2);
enemyDamageValue(objMagneticShockwave, 2);
enemyDamageValue(objIceWall, 4);
enemyDamageValue(objBreakDash, 1);

// MaGMML2
enemyDamageValue(objHornetChaser, 1);
enemyDamageValue(objJewelSatellite, 6);
enemyDamageValue(objGrabBuster, 1);
enemyDamageValue(objTripleBlade, 1);
enemyDamageValue(objWheelCutter, 2);
enemyDamageValue(objSlashClaw, 2);
enemyDamageValue(objSakugarne, 1);
enemyDamageValue(objSuperArrow, 2);
enemyDamageValue(objWireAdapter, 1);

// MaGMML1
enemyDamageValue(objMetalBlade, 0);
enemyDamageValue(objGeminiLaser, 4);
enemyDamageValue(objSolarBlaze, 2);
enemyDamageValue(objTopSpin, 2);
enemyDamageValue(objThunderWool, 1);
enemyDamageValue(objPharaohShot, 1);
enemyDamageValue(objBlackHoleBomb, 1);
enemyDamageValue(objMagicCard, 2);

// MaG48HMML
enemyDamageValue(objFlameMixer, 2);
enemyDamageValue(objRainFlush, 1);
enemyDamageValue(objSparkShock, 1);
enemyDamageValue(objSearchSnake, 1);
enemyDamageValue(objTenguBlade, 2);
enemyDamageValue(objTenguDash, 2);
enemyDamageValue(objTenguDisk, 1);
enemyDamageValue(objSaltWater, 2);
enemyDamageValue(objConcreteShot, 4);
enemyDamageValue(objHomingSniper, 1);

// MaG24HMML
enemyDamageValue(objSuperArmBlockProjectile, 1);
enemyDamageValue(objSuperArmDebris, 1);
enemyDamageValue(objChillShot, 1);
enemyDamageValue(objChillSpikeLanded, 2);

// Misc.
enemyDamageValue(objPowerStone, 1);
enemyDamageValue(objPlantBarrier, 6);
enemyDamageValue(objBrickWeapon, 2);
enemyDamageValue(objIceSlasher, 1);
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
// leave this. this is needed.
event_inherited();

// all of dangan man's events trigger when the game isn't frozen.
if (entityCanStep())
{
    if (isFight == true)
    {
        image_speed = 0;

        // if dangan man is rocketing, he turns around when he hits a wall, otherwise he doesn't.
        if (sprite_index == sprDanganRocket)
        {
            xSpeedTurnaround();
            if (checkSolid(16 * sign(xspeed), 0,1,1))
            {
                if (!checkSolid(- 16 * sign(xspeed), 0,1,1))
                {
                    if (!hasFired)
                    {
                        xspeed *= -1;
                        image_xscale *= -1;
                        hasFired = true;
                    }
                    else
                    {
                        grav = 0.125;
                        xspeed = 0;
                        image_xscale *= -1;
                    }
                }
            }
        }

        // resets the image timer if crash man ever changes poses
        if (pose != sprite_index)
        {
            pose = sprite_index;
            imageTimer = 0;
        }

        // these control various timers crash man uses - attackTimer and delay.
        // attackTimer can trigger an attack to occur after a certain amount of ticks.
        // Delay - Delay is useful to use to stop code from firing too quickly.
        attackTimer += 1;
        if (delay > 0)
        {
            delay -= 1;
        }

        // this is the animation system. don't touch this.
        imageTimer += 1;
        if (imageTimer >= imageTimerMax && image_index < image_number - 1)
        {
            imageTimer = 0;
            image_index += 1;
        }
        if (imageTimer >= imageTimerMax && image_index == image_number - 1)
        {
            imageTimer = 0;
            image_index = imageNoMin;
        }

        // this is dangan man's AI -
        // 0: jump over to other side of the screen
        // 1: jumping
        // 2: throw rock'n vulcan
        // 3: begin/end rocket
        // 4: rocket across screen, rebound off wall when he hits it.
        // repeat
        switch (phase)
        {
            // jump
            case 0:
                if (attackTimer == 20)
                {
                    sprite_index = sprDanganJump;
                    imageTimerMax = 10;
                    imageNoMin = 2;
                    setY = 8;
                    setX = 32;
                }
                if (sprite_index == sprDanganJump && image_index == 2)
                {
                    var i; for ( i = 8; i < 224; i += 1)
                    {
                        if (place_meeting(x, (y - i) - 8, objSolid))
                        {
                            break;
                        }
                        else
                        {
                            setY += 1;
                        }
                    }
                    yspeed = ySpeedAim(y, y - setY, grav);
                    var i; for ( i = 32; i < 256; i += 1)
                    {
                        if (place_meeting(x + i * image_xscale, y, objSolid))
                        {
                            break;
                        }
                        else
                        {
                            setX += 1;
                        }
                    }
                    xspeed = xSpeedAim(x, y, x + setX * image_xscale, y, yspeed, grav);
                    phase = 1;
                }
                break;
            // jumping
            case 1:
                if (yspeed < 0)
                {
                    sprite_index = sprDanganJump;
                    image_index = 2;
                }
                else
                {
                    sprite_index = sprDanganFall;
                }
                if (ground && sprite_index == sprDanganFall)
                {
                    xspeed = 0;
                    attackTimer = 0;
                    image_xscale *= -1;
                    sprite_index = sprDanganIdle;
                    phase = 2;
                    image_index = 0;
                    imageNoMin = 0;
                }
                break;
            // fire rockn vulcan
            case 2:
                if (attackTimer == 20)
                {
                    sprite_index = sprDanganThrow;
                    imageTimerMax = 15;
                    imageNoMin = 2;
                }
                if (sprite_index == sprDanganThrow && image_index == 1 && !hasFired)
                {
                    var i; for ( i = 0; i < 3; i += 1)
                    {
                        var inst;
                        inst = instance_create(x + 4 * image_xscale, y + 2, objDanganBullet);
                        inst.xspeed = (1.5 + i * 1.5) * image_xscale;
                        inst.storeX = abs(xspeed);
                        inst.image_xscale = image_xscale;
                        inst.yspeed = -6;
                    }
                    hasFired = true;
                    playSFX(sfxEnemyDrop);
                }
                if (hasFired && attackTimer >= 100)
                {
                    attackTimer = 0;
                    phase = 3;
                    sprite_index = sprDanganTransform1;
                    hasFired = false;
                    setY = y;
                    setX = x;
                }
                break;
            // rocket across screen
            case 3:
                if (sprite_index == sprDanganTransform1 || sprite_index == sprDanganTransform2)
                {
                    imageTimerMax = 2;
                    imageNoMin = 8;
                    if (image_index == 9)
                    {
                        if (sprite_index == sprDanganTransform1)
                        {
                            sprite_index = sprDanganRocket;
                            grav = 0;
                        }
                        else
                        {
                            attackTimer = 0;
                            hasFired = false;
                            sprite_index = sprDanganIdle;
                            phase = 0;
                        }
                    }
                }
                else
                {
                    imageTimerMax = 3;
                    imageNoMin = 0;
                }
                if (sprite_index == sprDanganRocket && y > setY - 8)
                {
                    yspeed = -1;
                }
                else if (sprite_index == sprDanganRocket)
                {
                    xspeed = 4 * image_xscale;
                    x += 4 * image_xscale;
                    yspeed = 0;
                    phase = 4;
                }
                break;
            // rocket
            case 4:
                contactDamage = 0;
                with (collision_ellipse(x - 12, y + 18, x + 12, y + 30, objMegaman, false, true))
                {
                    // manual damage to player
                    if (iFrames == 0 && canHit)
                    {
                        with (other)
                        {
                            entityEntityCollision(4);
                        }
                    }
                }
                if (ground)
                {
                    xspeed = 0;
                    sprite_index = sprDanganTransform2;
                    phase = 3;
                    contactDamage = 4;
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
with (objDanganBullet)
    instance_destroy();
with (objHarmfulExplosion)
    instance_destroy();
event_inherited();
#define Other_21
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
// if he's in a rocket, guard
if (sprite_index == sprDanganRocket)
{
    if (collision_ellipse(x - 12, y + 18, x + 12, y + 30, other.id, false, true))
    {
        other.guardCancel = 1;
    }
    else
    {
        other.guardCancel = 2;
    }
}
