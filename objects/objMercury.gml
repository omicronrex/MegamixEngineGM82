#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();

healthpointsStart = 28;
healthpoints = healthpointsStart;
contactDamage = 4;

customPose = true;
hasTriggeredFall = false;
introType = 0;
ground = false;
delay = 0;

child[0] = noone;
child[1] = noone;

attackTimer = 0;
phase = 0;
shotsFired = 0;
blobMove = 0; // 0 = slide, 1 = bounce
blobTimer = 0; // Time until small blobs are dropped

// Health Bar
healthBarPrimaryColor[1] = 22;
healthBarSecondaryColor[1] = 31;

// Music
music = "Mega_Man_5GB.gbs";
musicType = "VGM";
musicTrackNumber = 6;

// Damage Table
enemyDamageValue(objBusterShot, 2);
enemyDamageValue(objBusterShotHalfCharged, 2);
enemyDamageValue(objBusterShotCharged, 4);

// MaGMML3
enemyDamageValue(objSparkChaser, 1);
enemyDamageValue(objLaserTrident, 2);
enemyDamageValue(objWaterShield, 1);
enemyDamageValue(objTornadoBlow, 7);
enemyDamageValue(objThunderBeam, 2);
enemyDamageValue(objMagneticShockwave, 2);
enemyDamageValue(objIceWall, 2);
enemyDamageValue(objBreakDash, 1);

// MaGMML2
enemyDamageValue(objHornetChaser, 1);
enemyDamageValue(objJewelSatellite, 1);
enemyDamageValue(objGrabBuster, 0);
enemyDamageValue(objTripleBlade, 3);
enemyDamageValue(objWheelCutter, 3);
enemyDamageValue(objSlashClaw, 7);
enemyDamageValue(objSakugarne, 1);
enemyDamageValue(objSuperArrow, 2);
enemyDamageValue(objWireAdapter, 1);

// MaGMML1
enemyDamageValue(objMetalBlade, 3);
enemyDamageValue(objGeminiLaser, 1);
enemyDamageValue(objSolarBlaze, 3);
enemyDamageValue(objTopSpin, 1);
enemyDamageValue(objThunderWool, 1);
enemyDamageValue(objPharaohShot, 2);
enemyDamageValue(objBlackHoleBomb, 7);
enemyDamageValue(objMagicCard, 2);

// MaG48HMML
enemyDamageValue(objFlameMixer, 2);
enemyDamageValue(objRainFlush, 1);
enemyDamageValue(objSparkShock, 1);
enemyDamageValue(objSearchSnake, 2);
enemyDamageValue(objTenguBlade, 7);
enemyDamageValue(objTenguDash, 7);
enemyDamageValue(objTenguDisk, 7);
enemyDamageValue(objSaltWater, 2);
enemyDamageValue(objConcreteShot, 3);
enemyDamageValue(objHomingSniper, 1);

// MaG24HMML
enemyDamageValue(objSuperArmBlockProjectile, 2);
enemyDamageValue(objSuperArmDebris, 2);
enemyDamageValue(objChillShot, 0);
enemyDamageValue(objChillSpikeLanded, 0);

// Misc.
enemyDamageValue(objPowerStone, 1);
enemyDamageValue(objPlantBarrier, 1);
enemyDamageValue(objBrickWeapon, 1);
enemyDamageValue(objIceSlasher, 2);
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();

if (entityCanStep())
{
    // Setup
    if (startIntro)
    {
        y += view_yview - bbox_bottom;
        canFillHealthBar = false;
        image_index = 1;
        startIntro = false;
        isIntro = true;
        visible = true;
        grav = gravAccel;
        calibrateDirection();
    }
    else if (isIntro)
    {
        if (!hasTriggeredFall)
        {
            image_index = 9;
        }

        if (y >= ystart || hasTriggeredFall)
        {
            hasTriggeredFall = true;
            y = ystart;
            attackTimer+=1;

            // Intro animation
            if (attackTimer < 10)
            {
                image_index = 0;
            }
            if (attackTimer == 10)
            {
                image_speed = 0.25;
            }
            if (image_index >= 8)
            {
                image_index = 8;
                image_speed = 0;
            }

            if ((image_index == 8) && (attackTimer < 50))
            {
                image_index = 7;
                image_speed = -0.25;
            }
            if (image_index < 0)
            {
                image_index = 8;
            }
            if (attackTimer > 70)
            {
                image_speed = 0;
                if (attackTimer == 105)
                {
                    image_index = 0;
                    attackTimer = 0;
                    isIntro = false;
                    canFillHealthBar = true;
                    blockCollision = blockCollisionStart;
                    grav = gravStart;
                }
            }
        }
    }

    // Battle Data
    if (isFight)
    {
        delay-=1;

        switch (phase)
        {
            // Fire Grab Buster
            case 0:
                attackTimer+=1;
                if ((attackTimer > 15) && (attackTimer mod 30 == 0) && (shotsFired < 9))
                {
                    image_index = 8;
                    playSFX(sfxGrabBuster);
                    with (instance_create(x + 24 * image_xscale, y, objMercuryGrabBuster))
                    {
                        // Fire straight ahead
                        if ((other.shotsFired == 0) || (other.shotsFired == 4) || (other.shotsFired == 8))
                        {
                            dir = 0;
                        } // Fire high
                        else if ((other.shotsFired == 2) || (other.shotsFired == 6))
                        {
                            dir = 45;
                        } // Fire middle
                        else
                        {
                            dir = 22.5;
                        }
                        dir = dir mod 360;
                        image_xscale = other.image_xscale;
                        parent = other.id;
                    }
                    other.shotsFired+=1;
                } // If maximum Grab Buster shots have been fired
                else if (shotsFired == 9)
                {
                    attackTimer = 0;
                    phase = 1;
                    image_index = 0;
                }
                break;

            // Form blob
            case 1:
                attackTimer+=1;
                if (attackTimer > 30)
                {
                    image_speed = 0.25;
                    if ((sprite_index == sprMercury) && (image_index == 5))
                    {
                        sprite_index = sprMercuryBigBlob;
                        mask_index = sprMercuryBigBlob;
                        image_index = 0;
                    }
                }
                if (attackTimer >= 90)
                {
                    // Slide
                    if (blobMove == 0)
                    {
                        xspeed = 4 * image_xscale;
                        blobTimer+=1;

                        if ((blobTimer == 17) && (instance_number(objMercurySmallBlob) < 2)) //( round(x) == view_xview + 85) || (round(x) == view_xview + 170)
                        {
                            var i; i = instance_create(x, y, objMercurySmallBlob);
                            i.blobMove = blobMove;
                            i.image_xscale = image_xscale;
                            blobTimer = 0;
                        }
                    } // Bounce
                    else
                    {
                        // Create first blob
                        if (attackTimer == 90)
                        {
                            child[0] = instance_create(x, y, objMercurySmallBlob);
                            child[0].blobMove = blobMove;
                            child[0].yspeed = -4;
                            child[0].xspeed = 1.5 * image_xscale;
                            child[0].image_xscale = image_xscale;
                            child[0].blobID = 1;
                            delay = 16;
                        }

                        // Create second blob
                        if (instance_exists(objMercurySmallBlob))
                        {
                            if (child[0].trigBlob)
                            {
                                child[1] = instance_create(x, y, objMercurySmallBlob);
                                child[1].blobMove = blobMove;
                                child[1].yspeed = -4;
                                child[1].xspeed = 1.5 * image_xscale;
                                child[1].image_xscale = image_xscale;

                                sprite_index = sprMercuryBlob;
                                mask_index = sprMercuryBlob;
                                phase = 2;
                                delay = 16;
                            }
                        }
                    }

                    // Change sprite if two small blobs are onscreen
                    if (instance_number(objMercurySmallBlob) == 2)
                    {
                        sprite_index = sprMercuryBlob;
                        mask_index = sprMercuryBlob;
                    }

                    if (xcoll != 0)
                    {
                        xspeed = 0;
                        phase = 2;
                        image_xscale *= -1;
                        blobTimer = 0;
                    }
                }
                break;

            // Reform/Bounce across room
            case 2: // Slide pattern
                if (blobMove == 0)
                {
                    if (instance_number(objMercurySmallBlob) < 2)
                    {
                        sprite_index = sprMercuryBigBlob;
                        mask_index = sprMercuryBigBlob;
                    }
                } // Bounce pattern
                else
                {
                    if ((instance_exists(child[1]) && child[1].trigBlob || !instance_exists(child[1])) && !place_meeting(x, y, objMercurySmallBlob))
                    {
                        if (ground)
                        {
                            yspeed = -4;
                            xspeed = 1.5 * image_xscale;
                            playSFX(sfxNumetallShoot);
                        }
                    }

                    if (place_meeting(x, y, objMercurySmallBlob) && xspeed == 0 && delay <= 0)
                    {
                        with (objMercurySmallBlob)
                        {
                            instance_destroy();
                        }

                        image_xscale *= -1;
                        sprite_index = sprMercuryBigBlob;
                        playSFX(sfxNumetallShoot);

                        phase = 3;
                        attackTimer = 0;
                    }
                }
                if (!instance_exists(objMercurySmallBlob))
                {
                    phase = 3;
                    attackTimer = 0;
                }
                break;

            // Pop back up
            case 3:
                attackTimer+=1;
                if (attackTimer >= 30)
                {
                    if (attackTimer == 30)
                    {
                        sprite_index = sprMercury;
                        mask_index = mskMercury;
                        image_index = 5;
                        image_speed = -0.25;
                    }

                    // Begin shooting Grab Buster again
                    if (image_index == 0)
                    {
                        attackTimer = 0;
                        image_index = 8;
                        image_speed = 0;
                        phase = 0;
                        shotsFired = 0;
                    }
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
event_inherited();

// Destroy projectiles on death
with (objMercuryGrabBuster)
{
    instance_create(x, y, objExplosion);
    instance_destroy();
}
with (objMercuryGrabBusterPickup)
{
    instance_create(x, y, objExplosion);
    instance_destroy();
}
with (objMercurySmallBlob)
{
    instance_create(x, y + (sprite_height / 2), objExplosion);
    instance_destroy();
}
#define Other_21
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if (phase == 0)
{
    shotsFired = 9;
    if (blobMove == 0)
    {
        blobMove = 1;
    }
    else
    {
        blobMove = 0;
    }
}
else if ((sprite_index != sprMercury) || (image_index < 8))
{
    if ((other.object_index != objTenguBlade) && (other.object_index != objTenguDash)
        && (other.object_index != objSlashClaw) && (other.object_index != objBreakDash)
        && (other.object_index != objBlackHoleBomb))
    {
        iFrames = 0;
        with (other)
        {
            if ((penetrate < 2) && (pierces < 2))
            {
                event_user(EV_DEATH);
            }
        }
        other.guardCancel = 2;
    }
}
