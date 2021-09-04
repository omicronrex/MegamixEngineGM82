#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();

healthpointsStart = 28;
healthpoints = healthpointsStart;
inWater = -1;
pose = sprSplashIntro;
poseImgSpeed = 10 / 60;
contactDamage = 4;
ground = false;
attackTimer = 10;
attackTimerMax = 20;
canInitShoot = true;
phase = 0;

// setup initial animation direction. this direction overrights the image_xscale in certain circumstances.
detectAnimation = 1;

if (instance_exists(target))
{
    if (x > target.x)
        detectAnimation = -1;
    else
        detectAnimation = 1;
}
xspeed = 0;
hitWall = false;
redetectWall = 0;
detectRoof = 0;
shotsFired = 0;
starty = y;

// sin x movement variables:
// resetX=x;
// cDistanceX=0;
// cAngleX=degtorad(90);
// addAngleX=0;
// readableXAngle=0;
// cos y movement variables:
cDistanceY = 4;
cAngleY = 0;
addAngleY = 0;

// fish spawner
distanceYToFish = 32;
fishCreated = 0;
fishYDistance = 20;
fishDirection = image_xscale;
fishToggle = false;
fishSpawnX = 0;
fishSpawnY = 0;

// Health Bar
healthBarPrimaryColor[1] = 14;
healthBarSecondaryColor[1] = 40;

// Music
music = "Mega_Man_9.nsf";
musicType = "VGM";
musicTrackNumber = 16;

// Damage Table
enemyDamageValue(objBusterShot, 2);
enemyDamageValue(objBusterShotHalfCharged, 2);
enemyDamageValue(objBusterShotCharged, 4);

// MaGMML3
enemyDamageValue(objSparkChaser, 5);
enemyDamageValue(objLaserTrident, 2);
enemyDamageValue(objWaterShield, 0);
enemyDamageValue(objTornadoBlow, 1);
enemyDamageValue(objThunderBeam, 4);
enemyDamageValue(objBreakDash, 1);
enemyDamageValue(objMagneticShockwave, 1);
enemyDamageValue(objIceWall, 1);

// MaGMML2
enemyDamageValue(objHornetChaser, 4);
enemyDamageValue(objJewelSatellite, 1);
enemyDamageValue(objGrabBuster, 2);
enemyDamageValue(objTripleBlade, 2);
enemyDamageValue(objWheelCutter, 1);
enemyDamageValue(objSlashClaw, 1);
enemyDamageValue(objSakugarne, 3);
enemyDamageValue(objSuperArrow, 2);
enemyDamageValue(objWireAdapter, 3);

// MaGMML1
enemyDamageValue(objMetalBlade, 2);
enemyDamageValue(objGeminiLaser, 2);
enemyDamageValue(objSolarBlaze, 0);
enemyDamageValue(objTopSpin, 1);
enemyDamageValue(objThunderWool, 4);
enemyDamageValue(objPharaohShot, 1);
enemyDamageValue(objBlackHoleBomb, 1);
enemyDamageValue(objMagicCard, 2);

// MaG48HMML
enemyDamageValue(objFlameMixer, 0);
enemyDamageValue(objRainFlush, 1);
enemyDamageValue(objSparkShock, 2);
enemyDamageValue(objSearchSnake, 1);
enemyDamageValue(objTenguBlade, 2);
enemyDamageValue(objTenguDash, 2);
enemyDamageValue(objTenguDisk, 2);
enemyDamageValue(objSaltWater, 0);
enemyDamageValue(objConcreteShot, 1);
enemyDamageValue(objHomingSniper, 4);

// MaG24HMML
enemyDamageValue(objSuperArmBlockProjectile, 1);
enemyDamageValue(objSuperArmDebris, 1);
enemyDamageValue(objChillShot, 1);
enemyDamageValue(objChillSpikeLanded, 1);

// Misc.
enemyDamageValue(objPowerStone, 1);
enemyDamageValue(objPlantBarrier, 4);
enemyDamageValue(objBrickWeapon, 1);
enemyDamageValue(objIceSlasher, 1);
#define Alarm_7
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
phase = 3;
playSFX(sfxSplashSing);
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=605
invert=0
arg0=gives a delay for when splash woman starts moving.
*/
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();
if (entityCanStep())
{
    cAngleY += addAngleY;

    // on certain animations, splash woman bobs up and down.
    if (sprite_index == sprSplashIntro || sprite_index == sprSplashLaserTrident
        || sprite_index == sprSplashIdle)
        addAngleY = 0.05;
    if (!sprite_index == sprSplashLaserTrident && cDistanceY > 4)
        cDistanceY -= 0.25;
    if (sprite_index == sprSplashLaserTrident && cDistanceY < 8)
        cDistanceY += 0.25;
    if (instance_exists(target) && isFight == false)
    {
        if (x > target.x)
            detectAnimation = -1;
        else
            detectAnimation = 1;
    }
    if (isFight == true)
    {
        grav = 0;
        attackTimer += 1;

        // this value is used to override the image_xscale occasionally.
        if (xspeed > 0)
            detectAnimation = 1;
        else if (xspeed < 0)
            detectAnimation = -1;
        else
            detectAnimation = image_xscale;
        switch (phase)
        {
            case 0: // Idle (standing still)
                if (y < starty)
                {
                    grav = 0.35;
                }
                else
                {
                    yspeed = 0;
                    grav = 0;
                }
                attackTimerMax = 35;
                xspeed = 0;
                sprite_index = sprSplashIdle;
                image_index += 0.15;
                if (attackTimer == attackTimerMax)
                    phase = 1;
                break;
            case 1: // determine move distnace for next phase and generate the first detector
                SWD = instance_create(x, y, objSplashWallDetector);
                SWD.image_xscale = image_xscale;
                alarm[7] = 12;
                phase = 2;
                break;
            // phase 2 is basically skipped to allow the alarm to happen. the alarm also triggers splashwoman's sing effect.
            case 3: // begin sing / go up
                image_index += 0.10;
                sprite_index = sprSplashSing;

                // this generates the splash wall dectector, a detector that allows slash woman to turn around when near walls, rather than when actually hitting them.
                if (instance_exists(objSplashWallDetector))
                {
                    objSplashWallDetector.y = y;
                    redetectWall += 1;

                    // occasionally we destroy the detector and remake it. we do this if she's either in a different direction to the detector or the counter has reset.
                    if (objSplashWallDetector.image_xscale != image_xscale
                        || redetectWall >= 3)
                    {
                        with (objSplashWallDetector)
                            instance_destroy();
                        SWD = instance_create(x, y, objSplashWallDetector);
                        SWD.image_xscale = image_xscale;
                        redetectWall = 0;
                    }

                    // if speed is lower than 3, and splash is not against wall, speed up.
                    if (abs(xspeed) < 3 && hitWall == false)
                        xspeed += image_xscale / 3;

                    // if any of the following are true, splash woman is near to, or has hit a wall and needs to turn around.
                    if ((xspeed > 0 && objSplashWallDetector.x
                        > view_xview + (view_wview * 0.5)
                        && x >= objSplashWallDetector
                        && objSplashWallDetector.hitWall == true)
                        || (xspeed < 0 && objSplashWallDetector.x
                        <= view_xview + (view_wview * 0.5)
                        && x <= objSplashWallDetector
                        && objSplashWallDetector.hitWall == true)
                        || (place_meeting(x, y, objSplashWallDetector)
                        && objSplashWallDetector.hitWall == true
                        && image_xscale
                        == objSplashWallDetector.image_xscale))
                    {
                        hitWall = true;
                    }

                    // if the above is true, splash woman slows down and eventually turns around.
                    if (hitWall == true)
                        xspeed -= image_xscale / 4;

                    // deactivating the above when she's no longer near a wall.
                    if (!place_meeting(x + (8 * image_xscale), y,
                        objSplashWallDetector))
                        hitWall = false;
                }

                // if splash woman has turned around, then she ... well, turns around.
                if (image_xscale == -1 && xspeed > 0 && hitWall == false)
                    image_xscale = 1;
                else if (image_xscale == 1 && xspeed < 0 && hitWall == false)
                    image_xscale = -1;
                yspeed = -0.45;

                // generate fishies
                if (y <= (view_yview + (view_hview))
                    - ((distanceYToFish * fishCreated)) - 64
                    && fishCreated < 3 && hitWall == true)
                {
                    var i;
                    for (i = 0; i < 3; i += 1)
                    {
                        if (fishDirection == -1)
                            fishSpawnX = view_xview + view_wview
                                + (view_wview / 4) + (32 * (i));
                        else
                            fishSpawnX = view_xview - (view_wview / 4)
                                - (32 * (i));
                        fishSpawnY = (view_yview + view_hview) - 32
                            - ((distanceYToFish * (fishCreated + 1))
                            + (fishYDistance * (i - 1)));

                        // this long line of code does the following: it finds the edge of the x screen.. and the bottom of the y screen, and modifies where the fish are created occordingly.
                        fish = instance_create(fishSpawnX, fishSpawnY,
                            objSplashFlounder);
                        fish.image_xscale = fishDirection;
                        fish.respawn = false;
                    }
                    fishCreated += 1;
                    fishDirection = fishDirection * -1;
                }
                if (ycoll != 0)
                    detectRoof += 1;

                // else
                //    detectRoof = 0;
                attackTimer = 0;
                if (detectRoof >= 16)
                {
                    attackTimer = 0;
                    attackTimerMax = 30;
                    sprite_index = sprSplashIdle;
                    phase = 4;
                }
                break;
            case 4: // begin laser trident
                detectRoof = 0;
                image_index += 0.15;
                attackTimerMax = 30;
                if (xspeed > 0)
                    xspeed -= 0.10;
                if (xspeed < 0)
                    xspeed += 0.10;
                if (attackTimer >= attackTimerMax)
                {
                    sprite_index = sprSplashLaserTrident;
                    image_index = 0;
                    phase = 5;
                }
                break;
            case 5: // laser trident
                image_index += 0.25;

                // follow mega man
                if (instance_exists(target))
                {
                    if (x > target.x)
                        xspeed -= 0.15;
                    else if (x < target.x)
                        xspeed += 0.15;
                }
                if (xspeed > 3)
                    xspeed = 3;
                if (xspeed < -3)
                    xspeed = -3;

                // turn around
                if (xspeed > 0)
                    image_xscale = 1;
                else
                    image_xscale = -1;

                // fire laser trident
                if (image_index == 6)
                {
                    lT = instance_create(x + (4 * image_xscale), y + 10,
                        objSplashTrident);
                    playSFX(sfxLaserTrident);
                    shotsFired += 1;
                }

                // reset animation to original position + 1
                if (image_index >= 9 && shotsFired < 6)
                    image_index = 2;

                // divebomb!
                if (image_index >= 9 && shotsFired >= 6)
                {
                    sprite_index = sprSplashDiveBomb;
                    image_index = 0;
                    phase = 6;
                }
                break;
            case 6: // divebomb
                xspeed = 0;
                if (image_index < 6)
                    image_index += 0.20;
                if (image_index >= 4 && ground == false)
                    yspeed = 4;
                if (ground == true)
                {
                    yspeed = -2;
                    attackTimer = 0;
                    sprite_index = sprSplashRebound;
                    image_index = 0;
                    phase = 7;
                }
                break;
            case 7: // divebomb finish
                attackTimerMax = 8;
                grav = 0.35;
                if (attackTimer == attackTimerMax)
                {
                    attackTimer = 0;
                    sprite_index = sprSplashIdle;
                    image_index = 0;
                    phase = 0;
                    fishCreated = 0;
                    shotsFired = 0;
                    grav = 0;
                }
                break;
        }

        // if splash is singing, create note for her to sing.
        if (sprite_index == sprSplashSing && !instance_exists(objSplashNote))
            instance_create(x + (16 * image_xscale), y - 23, objSplashNote);

        // change postion of note depending on what frame its on.
        if (instance_exists(objSplashNote))
        {
            objSplashNote.image_index += 0.10;
            if (objSplashNote.image_index > 4)
                objSplashNote.image_index = 0;
            if (objSplashNote.image_index < 2)
            {
                objSplashNote.x = x + (16 * detectAnimation);
                objSplashNote.y = y - 23;
            }
            else
            {
                objSplashNote.x = x + (24 * detectAnimation);
                objSplashNote.y = y - 16;
            }
        }

        // Face the player if not doing anything.
        if ((instance_exists(target) && phase == 0)
            || (instance_exists(target) && phase == 4))
        {
            if (x > target.x)
            {
                image_xscale = -1;
                fishDirection = detectAnimation;
            }
            else
            {
                image_xscale = 1;
                fishDirection = detectAnimation;
            }
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
with (objSplashFlounder)
    instance_destroy();
with (objSplashTrident)
    instance_destroy();
with (objSplashNote)
    instance_destroy();
with (objSplashWallDetector)
    instance_destroy();
event_inherited();
#define Draw_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
var bx; bx = image_xscale;
var by; by = y;
y = round(y + sin(cAngleY) * cDistanceY);
if (detectAnimation != image_xscale)
{
    image_xscale *= -1;
}
event_inherited();
image_xscale = bx;
y = by;
