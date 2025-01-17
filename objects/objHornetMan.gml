#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
// Creation code (all optional):
// character = 0 / 1 - (0: Honey Woman Sprite (default), 1: Hornet Man Sprite)
event_inherited();

healthpointsStart = 28;
healthpoints = healthpointsStart;

pose = sprHornetManIntro;
poseImgSpeed = 0.11;
contactDamage = 4;

phase = 0;
timer = 0;
counter = 0;

imgIndex = 0;
imgIndex2 = 0;
imgSpd = 0.12;

image_index = 8; // falling sprite for intro

// Healthbar color
healthBarPrimaryColor[1] = 20;
healthBarSecondaryColor[1] = 34;

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
enemyDamageValue(objChillSpikeLanded, 3);

// Misc.
enemyDamageValue(objPowerStone, 3);
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
        sprite_index = sprHornetMan;
        switch (phase)
        {
            // windup before flying
            case 0:
                timer += 1;

                if (timer >= 10)
                {
                    imgIndex = 6;
                }

                if (timer >= 21)
                {
                    timer = -2; // travel up a bit farther before shooting bees
                    imgIndex = 7;
                    phase+=1;
                }

                break;

            // fly up and shoot bees
            case 1: // animation
                imgIndex += imgSpd * 3;
                if (imgIndex >= 9 + imgIndex2 * 2)
                {
                    imgIndex = 7 + imgIndex2 * 2;
                }

                // movement
                grav = 0;
                yspeed = -2;

                timer += 1;
                if (timer > 13)
                {
                    timer = 0;

                    bee = instance_create(x + 10 * image_xscale, y - 6, objBeeChaser);
                    bee.sprite_index = sprBossHornetChaser;
                    bee.image_xscale = image_xscale;
                    bee.timer += (26 - counter * 13); // make sure they all start moving at the same time
                    bee.contactDamage = 4;
                    playSFX(sfxHornetChaser);

                    counter+=1;
                    imgIndex2+=1;
                    imgIndex += 2;

                    if (counter >= 3)
                    {
                        timer = 0;
                        counter = 0;
                        yspeed = 0;
                        imgIndex2 = 0;
                        phase+=1;
                    }
                }

                break;

            // wait a bit then fly back down
            case 2: // animation
                imgIndex += imgSpd * 3;
                if (timer < 30 && imgIndex >= 15)
                {
                    imgIndex = 13;
                }

                if (timer >= 30 && imgIndex >= 9)
                {
                    imgIndex = 7;
                }

                // movement
                timer += 1.3;
                if (timer >= 30)
                {
                    if (imgIndex >= 14)
                    {
                        // close honeycomb compartments
                        imgIndex -= 6;
                    }

                    yspeed = 1;

                    if (ground)
                    {
                        yspeed = 0;
                        timer = 0;
                        grav = gravAccel;
                        imgIndex = 4;
                        phase+=1;
                    }
                }

                break;

            // walk to the other side of the screen
            case 3: // animation
                if (ground)
                {
                    imgIndex += imgSpd;
                    if (imgIndex >= 5)
                    {
                        imgIndex -= 4;
                    }
                }
                else
                {
                    imgIndex = 5;
                }

                // move
                xspeed = 1.7 * image_xscale;

                // jump
                if (ground)
                {
                    stop = false;

                    if (checkSolid(10 * image_xscale, 0,1,1) || !positionCollision(x+10 * image_xscale,y+20,1,1))
                    {
                        if (!checkSolid(10 * image_xscale,- 16,1,1))
                        {
                            // no wall preventing a jump
                            timer = 0;
                            yspeed = -3.5;
                            imgIndex = 5;
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
                            phase = 0;
                        }
                    }
                }
                else
                {
                    timer = 0;
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
event_inherited();

if (instance_exists(objBeeChaser))
{
    with (objBeeChaser)
    {
        healthpoints = 0;
        event_user(EV_DEATH);
    }
}
#define Other_23
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();

// Set Damage
specialDamageValue(objPharaohShot, max(2, floor(global.damage / 3)));
