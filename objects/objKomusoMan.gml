#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();

//@cc use this if you want the shadow clones to cross the entire screen rather than halfway.
deadlyShadowClones = false;

healthpointsStart = 28;
healthpoints = healthpointsStart;

// Health Bar
healthBarPrimaryColor[1] = 16;
healthBarSecondaryColor[1] = 33;

pose = sprKomusoIntro;
poseImgSpeed = 12 / 60;
contactDamage = 4;
ground = false;
attackTimer = 0;

// rather than using game maker's image offset features, this time round we're building a more accurate animation system.
imageTimer = 0;
imageTimerMax = 99;

// this is the minmum image_indexs of komuso man for any given animation. imageNoMin is what the image_index is set to when komuso man has finished an animation.
imageNoMin = 0;
phase = 0;
walkX = 2.5;
resetY = y;
delay = 0;
hasFired = false;
moveToLocation = 0;
locationX = 0;
locationY = view_yview + 64;
timesMoved = 0;
guard = 0;
shadowClones = ds_list_create();
shadowClones[0] = 0;
shadowClones[1] = 1;
shadowClones[2] = 2;

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
enemyDamageValue(objWaterShield, 5);
enemyDamageValue(objTornadoBlow, 3);
enemyDamageValue(objThunderBeam, 2);
enemyDamageValue(objMagneticShockwave, 2);
enemyDamageValue(objIceWall, 2);
enemyDamageValue(objBreakDash, 2);

// MaGMML2
enemyDamageValue(objHornetChaser, 0);
enemyDamageValue(objJewelSatellite, 0);
enemyDamageValue(objGrabBuster, 4);
enemyDamageValue(objTripleBlade, 1);
enemyDamageValue(objWheelCutter, 4);
enemyDamageValue(objSlashClaw, 2);
enemyDamageValue(objSakugarne, 3);
enemyDamageValue(objSuperArrow, 2);
enemyDamageValue(objWireAdapter, 6);

// MaGMML1
enemyDamageValue(objMetalBlade, 2);
enemyDamageValue(objGeminiLaser, 2);
enemyDamageValue(objSolarBlaze, 1);
enemyDamageValue(objTopSpin, 5);
enemyDamageValue(objThunderWool, 2);
enemyDamageValue(objPharaohShot, 1);
enemyDamageValue(objBlackHoleBomb, 1);
enemyDamageValue(objMagicCard, 2);

// MaG48HMML
enemyDamageValue(objFlameMixer, 2);
enemyDamageValue(objRainFlush, 5);
enemyDamageValue(objSparkShock, 1);
enemyDamageValue(objSearchSnake, 2);
enemyDamageValue(objTenguBlade, 3);
enemyDamageValue(objTenguDash, 3);
enemyDamageValue(objTenguDisk, 3);
enemyDamageValue(objSaltWater, 2);
enemyDamageValue(objConcreteShot, 1);
enemyDamageValue(objHomingSniper, 2);

// MaG24HMML
enemyDamageValue(objSuperArmBlockProjectile, 1);
enemyDamageValue(objSuperArmDebris, 1);
enemyDamageValue(objChillShot, 0);
enemyDamageValue(objChillSpikeLanded, 0);

// Misc.
enemyDamageValue(objPowerStone, 1);
enemyDamageValue(objPlantBarrier, 6);
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
        blockCollision = 0;
        grav = 0;
        locationY = view_yview + 64;
        image_speed = 0;

        // setup locations to transport to
        switch (moveToLocation)
        {
            case 0:
                locationX = view_xview + 48;
                break;
            case 1:
                locationX = view_xview + (view_wview / 2);
                break;
            case 2:
                locationX = view_xview + view_wview - 48;
                break;
        }

        // resets the image timer if kumuso man ever changes poses
        if (pose != sprite_index)
        {
            pose = sprite_index;
            imageTimer = 0;
        }
        attackTimer += 1;
        if (delay > 0)
            delay -= 1;
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
        switch (phase)
        {
            case 0: // idle
                sprite_index = sprKomusoFlute;
                imageTimerMax = 9999;
                if (attackTimer >= 35)
                {
                    phase = 1;
                    attackTimer = 0;
                }
            case 1: // summon doppler gangers
                imageTimerMax = 7;
                imageNoMin = 0;
                if (image_xscale == 1)
                    moveToLocation = 2 - instance_number(objKomusoDoppler);
                else
                    moveToLocation = instance_number(objKomusoDoppler);
                if (attackTimer == 35 && instance_number(objKomusoDoppler) < 2)
                {
                    delay = 4;
                    playSFX(sfxKomusoDoppler);
                    instance_create(x, y, objKomusoSmoke);
                    kD = instance_create(x, y, objKomusoDoppler);
                    kD.image_xscale = image_xscale;
                    kD.moveToLocation = moveToLocation;
                    kD.deadlyShadowClones = deadlyShadowClones;
                }
                if (attackTimer == 35 && instance_number(objKomusoDoppler)
                    >= 2 && delay == 0)
                {
                    playSFX(sfxKomusoDoppler);
                    instance_create(x, y, objKomusoSmoke);
                    phase = 2;
                }
                break;
            case 2: // dash to location
                guard = true;
                sprite_index = sprKomusoDoppler2;
                imageTimerMax = 4;
                imageNoMin = 2;
                if (xspeed == 0)
                {
                    xspeed = (2.5 + deadlyShadowClones) * image_xscale;
                }
                if ((image_xscale == 1 && x >= view_xview + (view_wview / 2)
                    && deadlyShadowClones == false) || (image_xscale == -1
                    && x <= view_xview + (view_wview / 2)
                    && deadlyShadowClones == false) || (image_xscale == 1
                    && x >= view_xview + (view_wview - 32)
                    && deadlyShadowClones == true) || (image_xscale == -1
                    && x <= view_xview + 32 && deadlyShadowClones == true))
                    phase = 3;
                break;
            case 3: // fly to upper location
                xspeed = 0;
                yspeed = 0;
                sprite_index = sprKomusoDoppler1;
                mp_linear_step(locationX, locationY, 3.5, false);
                if (abs(x - locationX) <= 2 && abs(y - locationY) <= 2)
                {
                    x = locationX;
                    y = locationY;
                    phase = 4;
                    with (objKomusoDoppler)
                        phase = 3;
                }
                break;
            case 4: // fire shots
                if (hasFired == false)
                    delay = 25;
                imageTimerMax = 5;
                imageNoMin = image_number - 1;
                sprite_index = sprKomusoDoppler3;
                grav = 0;
                if (image_index >= 3 && hasFired == false)
                {
                    hasFired = true;
                    var ID;
                    imageTimerMax = 15;
                    ID = instance_create(x, y, objKomusoBullet);
                    ID.angle = 90 + 180;
                    ID.xscale = image_xscale;
                    ID = instance_create(x, y, objKomusoBullet);
                    ID.angle = 135 + 180;
                    ID.xscale = image_xscale;
                    ID = instance_create(x, y, objKomusoBullet);
                    ID.angle = 45 + 180;
                    ID.xscale = image_xscale;
                    playSFX(sfxKomusoShot);
                }
                if (image_index > 3)
                    imageTimerMax = 6;
                if (image_index > 3 && instance_number(objKomusoBullet)
                    < 2 && delay == 0)
                {
                    phase = 5;
                    timesMoved += 1;
                    with (objKomusoDoppler)
                        phase = 4;
                }
                break;
            case 5: // move to middle
                moveToLocation = 1;
                locationY = resetY;
                image_index = 3;
                mp_linear_step(locationX, locationY, 2, false);
                if (abs(x - locationX) <= 2 && abs(y - locationY) <= 2)
                {
                    x = locationX;
                    y = resetY;
                    guard = false;
                    playSFX(sfxKomusoDoppler);
                    instance_create(x, y, objKomusoSmoke);
                    if (timesMoved == 1)
                        phase = 6;
                    else
                        phase = 8;
                    sprite_index = sprKomusoFlute;
                    imageTimerMax = 9999;
                    delay = 4;
                }
                break;
            case 6: // move to other side of the screen.
                xspeed = 2.5 * image_xscale;
                sprite_index = sprKomusoDash;
                imageTimerMax = 4;
                imageNoMin = 2;
                blockCollision = 1;
                grav = gravAccel;
                if (xcoll != 0 && delay == 0 && timesMoved < 10)
                {
                    image_xscale = image_xscale * -1;
                    hasFired = false;
                    phase = 0;
                    attackTimer = 0;
                    locationY = view_yview + 64;
                    xspeed = 0;
                    blockCollision = 0;
                    grav = 0;
                }
                if (xcoll != 0 && delay == 0 && timesMoved >= 10)
                {
                    phase = 10;
                    xspeed = 0;
                    blockCollision = 0;
                    grav = 0;
                }
                break;
            // phase 7 - no phase here - waiting for new phase!
            case 8: // summon fire pillars
                timesMoved = 10;
                calibrateDirection();
                sprite_index = sprKomusoFlute;
                imageTimerMax = 12;
                imageNoMin = 0;
                if (!instance_exists(objKomusoFire))
                {
                    playSFX(sfxKomusoFireTower);
                    kF = instance_create(view_xview + (view_wview / 4),
                        view_yview + view_hview, objKomusoFire);
                    kF.cDir = 1;
                    kF = instance_create(view_xview + (view_wview / 4),
                        view_yview + view_hview, objKomusoFire);
                    kF.cAngle = degtorad(270);
                    kF = instance_create(view_xview + view_wview
                        - (view_wview / 4), view_yview + view_hview,
                        objKomusoFire);
                    kF.cDir = 1;
                    kF.cAngle = degtorad(270);
                    kF = instance_create(view_xview + view_wview
                        - (view_wview / 4), view_yview + view_hview,
                        objKomusoFire);
                }
                phase = 9;
                break;
            // phase 9 - no phase here - waiting for new phase!
            case 10: // teleport
                image_xscale = 1;
                sprite_index = sprKomusoTeleport1;
                imageTimerMax = 3;
                imageNoMin = image_number - 1;
                if (image_index >= 8)
                    canHit = false;
                contactDamage = 0;
                if (image_index >= imageNoMin)
                    if (instance_exists(target))
                    {
                        x = target.x;
                        delay = 8;
                        sprite_index = sprKomusoTeleport2;
                        image_index = 0;
                        phase = 11;
                        timesMoved += 1;
                        playSFX(sfxKomusoDoppler);
                    }
                    else
                    {
                        x = x;
                        delay = 8;
                        sprite_index = sprKomusoTeleport2;
                        image_index = 0;
                        phase = 11;
                        timesMoved += 1;
                        playSFX(sfxKomusoDoppler);
                    }
                break;
            case 11: // teleport in
                imageNoMin = image_number - 1;
                if (timesMoved > 11)
                    timesMoved = 0;
                if (image_index > 10 && delay == 0)
                {
                    calibrateDirection();
                    canHit = true;
                    contactDamage = 4;
                }
                if (image_index >= imageNoMin && delay == 0)
                    phase = 6;
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
with (objKomusoBullet)
    instance_destroy();
with (objKomusoFire)
    instance_destroy();
with (objKomusoDoppler)
    instance_destroy();
with (objKomusoSmoke)
    instance_destroy();
event_inherited();
#define Other_21
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
// guard if guarding (!!)
if (guard)
{
    other.guardCancel = 1;
}
