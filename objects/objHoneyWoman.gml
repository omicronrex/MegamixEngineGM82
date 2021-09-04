#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();

healthpointsStart = 28;
healthpoints = healthpointsStart;

pose = sprHoneyWomanIntro;
poseImgSpeed = 0.11;

contactDamage = 4;

phase = 0;
dropHoney = false;
timer = 0;
counter = 0;

xspeedSave = 0;

imgIndex = 0;
imgIndex2 = 0;
imgSpd = 0.4;
image_index = 14; // falling sprite from intro

// healthbar
healthBarPrimaryColor[1] = 34;
healthBarSecondaryColor[1] = 40;

// Music
music = "Mega_Man_9.nsf";
musicType = "VGM";
musicTrackNumber = 16;

// Damage Table
enemyDamageValue(objBusterShot, 1);
enemyDamageValue(objBusterShotHalfCharged, 1);
enemyDamageValue(objBusterShotCharged, 3);

// MaGMML3
enemyDamageValue(objSparkChaser, 1);
enemyDamageValue(objLaserTrident, 1);
enemyDamageValue(objWaterShield, 1);
enemyDamageValue(objTornadoBlow, 2);
enemyDamageValue(objThunderBeam, 2);
enemyDamageValue(objBreakDash, 2);
enemyDamageValue(objMagneticShockwave, 1);
enemyDamageValue(objIceWall, 4);

// MaGMML2
enemyDamageValue(objHornetChaser, 1);
enemyDamageValue(objJewelSatellite, 2);
enemyDamageValue(objGrabBuster, 2);
enemyDamageValue(objTripleBlade, 4);
enemyDamageValue(objSlashClaw, 1);
enemyDamageValue(objWheelCutter, 2);
enemyDamageValue(objSakugarne, 1);
enemyDamageValue(objSuperArrow, 1);
enemyDamageValue(objWireAdapter, 1);

// MaGMML1
enemyDamageValue(objMetalBlade, 2);
enemyDamageValue(objGeminiLaser, 1);
enemyDamageValue(objSolarBlaze, 4);
enemyDamageValue(objTopSpin, 2);
enemyDamageValue(objThunderWool, 1);
enemyDamageValue(objPharaohShot, 2);
enemyDamageValue(objBlackHoleBomb, 1);
enemyDamageValue(objMagicCard, 1);

// MaG48HMML
enemyDamageValue(objFlameMixer, 5);
enemyDamageValue(objRainFlush, 3);
enemyDamageValue(objSparkShock, 1);
enemyDamageValue(objSearchSnake, 2);
enemyDamageValue(objTenguBlade, 2);
enemyDamageValue(objTenguDash, 2);
enemyDamageValue(objTenguDisk, 2);
enemyDamageValue(objSaltWater, 1);
enemyDamageValue(objConcreteShot, 1);
enemyDamageValue(objHomingSniper, 2);

// MaG24HMML
enemyDamageValue(objSuperArmBlockProjectile, 1);
enemyDamageValue(objSuperArmDebris, 1);
enemyDamageValue(objChillShot, 3);
enemyDamageValue(objChillSpikeLanded, 6);

// Misc.
enemyDamageValue(objPowerStone, 4);
enemyDamageValue(objPlantBarrier, 1);
enemyDamageValue(objBrickWeapon, 4);
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
    if (isIntro)
    {
        // starting direction
        calibrateDirection();
    }
    if (isFight == true)
    {
        // set normal sprite
        sprite_index = sprHoneyWoman;
        switch (phase)
        {
            // windup before flying
            case 0:
                timer += 1;
                if (timer >= 10)
                {
                    imgIndex = 8;
                }
                if (timer >= 21)
                {
                    timer = -2; // travel up a bit farther before shooting bees
                    imgIndex = 10;
                    phase+=1;
                }
                break;
            // fly up and shoot bees
            case 1: // animation
                if (timer < 0)
                {
                    // normal flying
                    imgIndex2 = 0;
                }
                else
                {
                    // raised arm
                    imgIndex2 = 1;
                    if (imgIndex < 14)
                    {
                        imgIndex += 4;
                    }
                }
                imgIndex += imgSpd;
                if (imgIndex2 == 0 && imgIndex >= 14)
                {
                    imgIndex = 10;
                }
                if (imgIndex2 == 1 && imgIndex >= 18)
                {
                    imgIndex = 14;
                }

                // movement
                grav = 0;
                yspeed = -2;
                timer += 1;
                if (timer > 13 - ((global.difficulty == DIFF_HARD) * 4))
                {
                    timer = 0;
                    bee = instance_create(x + 10 * image_xscale, y, objBeeChaser);
                    bee.image_xscale = image_xscale;
                    bee.timer += (26 - counter * 13); // make sure they all start moving at the same time
                    playSFX(sfxHornetChaser);
                    counter+=1;
                    if (counter >= 3 + (global.difficulty == DIFF_HARD))
                    {
                        timer = 0 - ((global.difficulty == DIFF_HARD) * 15);
                        counter = 0;
                        yspeed = 0;
                        imgIndex2 = 0;
                        phase+=1;
                    }
                }
                break;
            // wait a bit then fly back down
            case 2: // animation
                imgIndex += imgSpd;
                if (timer < 30 && imgIndex >= 18)
                {
                    imgIndex = 14;
                }
                if (timer >= 30 && imgIndex >= 14)
                {
                    imgIndex = 10;
                }

                // movement
                timer += 1;
                if (timer >= 30)
                {
                    if (imgIndex >= 14)
                    {
                        // put arm down
                        imgIndex -= 4;
                    }
                    yspeed = 1.3;
                    if (ground)
                    {
                        yspeed = 0;
                        timer = 0;
                        grav = gravAccel;
                        walk = false;
                        if (instance_exists(target))
                        {
                            if ((image_xscale > 0 && target.x > x) || (image_xscale < 0 && target.x < x))
                            {
                                // jump if the player is in front of her
                                imgIndex = 8;
                                phase+=1;
                            }
                            else
                            {
                                // if not than just walk
                                walk = true;
                            }
                        }
                        else
                        {
                            walk = true;
                        }
                        if (walk)
                        {
                            imgIndex = 4;
                            phase += 2;
                        }
                    }
                }
                break;
            // Jump at the player
            case 3:
                if (timer >= 10)
                {
                    if (timer == 10)
                    {
                        imgIndex = 9;
                        yspeed -= 6;
                        if (instance_exists(target))
                        {
                            xspeed = xSpeedAim(x, y, target.x, target.y, yspeed, grav);
                        }
                        else
                        {
                            xspeed = 0;
                        }
                        xspeedSave = xspeed;
                        timer+=1;
                    }
                    else
                    {
                        xspeed = xspeedSave;
                        if (ground)
                        {
                            timer = 0;
                            imgIndex = 4;
                            xspeed = 1.7 * image_xscale;
                            phase+=1;
                        }
                    }
                }
                else
                {
                    timer+=1;
                }
                break;
            // walk to the other side of the screen
            case 4: // animation
                if (ground)
                {
                    imgIndex += imgSpd;
                    if (imgIndex >= 8)
                    {
                        imgIndex -= 4;
                    }
                }
                else
                {
                    imgIndex = 9;
                }

                // move
                xspeed = 1.7 * image_xscale;
                if (ground)
                {
                    // jump
                    stop = false;
                    if (checkSolid(10 * image_xscale, 0,1,1) || !positionCollision(x+10 * image_xscale,y+20,1,1))
                    {
                        if (!checkSolid(10 * image_xscale,- 16,1,1))
                        {
                            // no wall preventing a jump
                            timer = 0;
                            yspeed = -3.5;
                            imgIndex = 9;
                        }
                        else
                        {
                            // can't jump
                            stop = true;
                        }
                    }


                    // going off screen
                    if ((image_xscale < 0 && x + 16 * image_xscale < view_xview[0])
                        || (image_xscale > 0 && x + 16 * image_xscale > view_xview[0] + view_wview[0]))
                    {
                        stop = true;
                    }
                    if (stop)
                    {
                        image_xscale = -image_xscale;

                        // only shoot more bees if there's no more bees, otherwise just turn around and run the other way
                        if (!instance_exists(objBeeChaser))
                        {
                            xspeed = 0;
                            timer = 0;
                            imgIndex = 0;
                            if (!dropHoney)
                            {
                                phase = 0;
                            }
                            else
                            {
                                imgIndex = 18;
                                phase+=1;
                            }
                            dropHoney = !dropHoney;
                        }
                        else
                        {
                            if (instance_exists(target))
                            {
                                if ((image_xscale > 0 && target.x > x) || (image_xscale < 0 && target.x < x))
                                {
                                    // jump if the player is in front of her
                                    imgIndex = 8;
                                    phase-=1;
                                }
                            }
                        }
                    }
                }
                else
                {
                    timer = 0;
                }
                break;
            // drop honey
            case 5:
                if (timer >= 10) // <-=1 time until swiping arm
                {
                    if (imgIndex == 28) // <-=1 play sfx once
                    {
                        playSFX(sfxSlashClaw);
                    }
                    imgIndex += poseImgSpeed;
                    if (imgIndex >= 20) // <-=1 done swiping arm
                    {
                        imgIndex = 20;
                        if (timer == 10 || (timer == 25 && global.difficulty == DIFF_HARD)) // Only summon bee once, unless on hard mode
                        {
                            bee = instance_create(view_xview[0] + view_wview[0] * (image_xscale == -1), view_yview[0] + 64, objBeeDropper);
                            bee.image_xscale = image_xscale;
                            bee.respawn = false;
                            bee.itemDrop = -1;
                        }
                        timer+=1;
                        if (timer >= 50)
                        {
                            timer = 0;
                            imgIndex = 0;
                            phase = 0;
                        }
                    }
                }
                else
                {
                    timer+=1;
                }
                break;
        }
        image_index = floor(imgIndex);
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
/// EV_DEATH
event_inherited();

if (instance_exists(objBeeChaser))
{
    with (objBeeChaser)
    {
        healthpoints = 0;
        event_user(EV_DEATH);
    }
}

if (instance_exists(objBeeDropper))
{
    with (objBeeDropper)
    {
        healthpoints = 0;
        event_user(EV_DEATH);
    }
}

if (instance_exists(objHoneycombBomb))
{
    with (objHoneycombBomb)
    {
        instance_create(x, y, objExplosion);
        instance_destroy();
    }
}

if (instance_exists(objHoneyPuddle))
{
    with (objHoneyPuddle)
    {
        instance_create(x, y, objExplosion);
        instance_destroy();
    }
}
#define Other_23
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
/// Set damage
event_inherited();
specialDamageValue(objPharaohShot, max(2, floor(global.damage / 3)));
