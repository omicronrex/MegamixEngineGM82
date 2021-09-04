#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
// Creation code (all optional):
event_inherited();

healthpointsStart = 28;
healthpoints = healthpointsStart;

pose = sprChillIntro;
poseImgSpeed = 6 / 60;
contactDamage = 4;
ground = false;
attackTimer = 0;

// rather than using game maker's image offset features, this time round we're building a more accurate animation system.
imageTimer = 0;
imageTimerMax = 99;

// this is the minmum image_indexs of chill man for any given animation. imageNoMin is what the image_index is set to when plant man has finished an animation.
imageNoMin = 0;
attackTimerMax = 145;
phase = 0;
oldPhase = 2;
jumpY = -7;
walkX = 1.5;
delay = 0;
hasFired = false;
slide = false;
pauseGravity = false;
shotsFired = 0;
frostTimer = 0;

// chill man has a bit of randomised shenangians going on. this variable sets it.
randomiser = -1;

//@cc use this if you want to disable Chill Man's spread jump attack.
spreadAttack = false;

shotsToFire = 2; //@cc use this if you want to determine how many chill spikes chill man fires. more than 3 is excessive, as he alternates between firing at the floor and wall.
if (global.difficulty == DIFF_HARD)
{
    spreadAttack = true;
    shotsToFire = 3;
}
else
{
    spreadAttack = false;
    if (global.difficulty == DIFF_EASY)
        shotsToFire = 1;
    else
        shotsToFire = 2;
}

// Health Bar
healthBarPrimaryColor[1] = 27;
healthBarSecondaryColor[1] = 40;

// Music
music = "Mega_Man_10.nsf";
musicType = "VGM";
musicTrackNumber = 18;

// Damage Table
enemyDamageValue(objBusterShot, 1);
enemyDamageValue(objBusterShotHalfCharged, 1);
enemyDamageValue(objBusterShotCharged, 3);

// MaGMML3
enemyDamageValue(objSparkChaser, 1);
enemyDamageValue(objLaserTrident, 2);
enemyDamageValue(objWaterShield, 1);
enemyDamageValue(objTornadoBlow, 1);
enemyDamageValue(objThunderBeam, 2);
enemyDamageValue(objBreakDash, 5);
enemyDamageValue(objMagneticShockwave, 2);
enemyDamageValue(objIceWall, 1);

// MaGMML2
enemyDamageValue(objHornetChaser, 1);
enemyDamageValue(objJewelSatellite, 5);
enemyDamageValue(objGrabBuster, 1);
enemyDamageValue(objTripleBlade, 1);
enemyDamageValue(objWheelCutter, 2);
enemyDamageValue(objSlashClaw, 2);
enemyDamageValue(objSakugarne, 3);
enemyDamageValue(objSuperArrow, 4);
enemyDamageValue(objWireAdapter, 12);

// MaGMML1
enemyDamageValue(objMetalBlade, 2);
enemyDamageValue(objGeminiLaser, 1);
enemyDamageValue(objSolarBlaze, 4);
enemyDamageValue(objTopSpin, 1);
enemyDamageValue(objThunderWool, 1);
enemyDamageValue(objPharaohShot, 2);
enemyDamageValue(objBlackHoleBomb, 1);
enemyDamageValue(objMagicCard, 1);

// MaG48HMML
enemyDamageValue(objFlameMixer, 5);
enemyDamageValue(objRainFlush, 2);
enemyDamageValue(objSparkShock, 1);
enemyDamageValue(objSearchSnake, 1);
enemyDamageValue(objTenguBlade, 2);
enemyDamageValue(objTenguDash, 3);
enemyDamageValue(objTenguDisk, 2);
enemyDamageValue(objSaltWater, 1);
enemyDamageValue(objConcreteShot, 1);
enemyDamageValue(objHomingSniper, 1);

// MaG24HMML
enemyDamageValue(objSuperArmBlockProjectile, 1);
enemyDamageValue(objSuperArmDebris, 1);
enemyDamageValue(objChillShot, 1);
enemyDamageValue(objChillSpikeLanded, 1);

// Misc.
enemyDamageValue(objPowerStone, 2);
enemyDamageValue(objPlantBarrier, 0);
enemyDamageValue(objBrickWeapon, 2);
enemyDamageValue(objIceSlasher, 1);
#define Alarm_7
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
cS = instance_create(x + (24 * image_xscale), y + 3, objChillSpike);
cS.image_xscale = image_xscale;
cS.yspeed = -3;
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=605
invert=0
arg0=fire chill spike at mega man
*/
#define Alarm_8
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
cS = instance_create(x + (24 * image_xscale), y + 3, objChillSpike);
cS.image_xscale = image_xscale;
cS.toWall = true;
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=605
invert=0
arg0=fire chill spike at wall
*/
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();
if (randomiser == -1)
{
    randomiser = choose(1, 2);
}
if (entityCanStep())
{
    if (isFight)
    {
        // this sets up chill man's movement variables.
        image_speed = 0;
        if (pauseGravity)
        {
            grav = 0;
            yspeed = 0;
        }
        else
        {
            grav = gravAccel;
        }

        // resets the image timer if chill man ever changes poses
        if (pose != sprite_index)
        {
            pose = sprite_index;
            imageTimer = 0;
        }

        // these control various timers crash man uses - attackTimer and delay.
        // attackTimer can trigger an attack to occur after a certain amount of ticks. (around 145)
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

        // this prevents chill man from randomly choosing the same attack twice in a row
        if (randomiser == oldPhase)
        {
            randomiser = choose(1, 2, 2, 3, 4);
        }
        if (phase > 0 && phase != oldPhase)
        {
            oldPhase = phase;
        }

        // slow down chill man if he's in this phase and still moving.
        if (ground)
        {
            if (xspeed > 0)
                xspeed -= 0.05;
            else if (xspeed < 0)
                xspeed += 0.05;
            if (abs(xspeed) <= 0.25)
                xspeed = 0;
        }
        switch (phase)
        {
            case 0: // idle
                calibrateDirection();
                sprite_index = sprChillIdle;
                imageNoMin = 0;
                imageTimerMax = 9999;
                if (attackTimer >= 45)
                {
                    phase = randomiser;
                    attackTimer = 0;
                }
                break;
            case 1: // walk
            // if chill man isn't near mega man, he walks at a very brisk pace... otherwise he slows down and prepares for the next phase.
                sprite_index = sprChillWalk;
                imageNoMin = 0;
                imageTimerMax = 6;
                xspeed = 2.5 * image_xscale;
                if (instance_exists(target))
                {
                    if ((image_xscale == 1 && x >= target.x
                        && hasFired == false) || (image_xscale == -1
                        && x <= target.x && hasFired == false))
                    {
                        attackTimer = 0;
                        slide = true;
                        phase = 0;
                    }
                }
                else if (attackTimer >= 10)
                {
                    attackTimer = 0;
                    slide = true;
                    phase = 0;
                }
                break;
            case 2: // fire chill spike
                calibrateDirection();
                if (attackTimer == 10)
                    sprite_index = sprChillShoot;

                // create chill spike detector
                if (attackTimer == 20 && shotsFired mod 2 == 0)
                {
                    playSFX(sfxChillShoot);
                    if (delay == 0)
                    {
                        cD = instance_create(x, y, objChillSpikeDetector);
                        cD.image_xscale = image_xscale;
                        cD.aimAtMegaman = true;
                        cD.target = target;
                        alarm[7] = 2;
                    }
                }
                else if (attackTimer == 20 && shotsFired mod 2 == 1)
                {
                    playSFX(sfxChillShoot);
                    cD = instance_create(x, y, objChillSpikeDetector);
                    cD.image_xscale = image_xscale;
                    cD.aimAtMegaman = false;
                    alarm[8] = 2;
                }
                if (attackTimer == 45)
                {
                    sprite_index = sprChillIdle;
                    attackTimer = 0;
                    shotsFired += 1;
                    with (objChillSpikeDetector)
                    {
                        instance_destroy();
                    }
                }
                if (shotsFired == shotsToFire)
                {
                    shotsFired = 0;
                    phase = 0;
                }
                break;
            case 3: // jump!
                if (attackTimer < 15)
                {
                    sprite_index = sprChillPrepareJump;
                }
                if (attackTimer == 15)
                {
                    sprite_index = sprChillJump;
                    delay = 3;
                    yspeed = -4.75;
                    if (instance_exists(target))
                    {
                        xspeed = floor(abs(target.x - x) / 32) * image_xscale;
                        if (xspeed >= 2)
                        {
                            xspeed += xspeed / 5;
                        }
                        if (xspeed <= -2)
                        {
                            xspeed -= xspeed / 5;
                        }
                    }
                    else
                    {
                        cD = instance_create(x, y, objChillSpikeDetector);
                        cD.aimAtMegaman = true;
                        xspeed = xSpeedAim(x, y, objChillSpikeDetector.x, objChillSpikeDetector.y, yspeed, grav);
                    }
                }
                if (ground && delay == 0 && attackTimer > 15)
                {
                    attackTimer = 0;
                    phase = 0;
                    if (abs(xspeed) > 2.5)
                    {
                        xspeed = 2.5 * image_xscale;
                    }
                }
                break;
            case 4: // spread attack start
                if (!spreadAttack)
                {
                    phase = 0;
                }
                else
                {
                    if (x < view_xview + (view_wview / 2))
                    {
                        image_xscale = 1;
                    }
                    else
                    {
                        image_xscale = -1;
                    }
                    if (attackTimer < 10)
                    {
                        sprite_index = sprChillPrepareJump;
                    }
                    if (attackTimer == 10)
                    {
                        sprite_index = sprChillJump;
                        delay = 3;
                        cD = instance_create(view_xview + (view_wview / 2),
                            view_yview + (view_hview / 2),
                            objChillSpikeDetector);
                        cD.center = true;
                        yspeed = -6.75;
                        xspeed = ((view_xview + view_wview * 0.5) - x)
                            / abs(yspeed * 4);
                        phase = 5;
                    }
                }
                break;
            case 5: // jump to middle
                if (yspeed >= 0)
                {
                    yspeed = 0;
                    xspeed = 0;
                    pauseGravity = true;
                    sprite_index = sprChillJump2;
                    image_xscale = 1;
                    imageTimerMax = 99999;
                }
                if (pauseGravity && xspeed == 0)
                {
                    with (objChillSpikeDetector)
                    {
                        instance_destroy();
                    }
                    phase = 6;
                    attackTimer = 0;
                    shotsFired = 0;
                }
                break;
            case 6: // spread attack
                if (attackTimer < 15)
                {
                    sprite_index = sprChillJump2;
                    d = 0;
                }
                else
                {
                    sprite_index = sprChillSpread;
                    imageTimerMax = 8;
                    imageNoMin = 2;
                    if (attackTimer > 15 && attackTimer mod 4 == 0
                        && shotsFired < 5)
                    {
                        playSFX(sfxChillShoot);
                        cG = instance_create(x, y, objChillSpikeGenerator);
                        cG.cooldownTimer = 16 * (shotsFired + 1);
                        cG.spike = 4 - shotsFired;
                        cG.x += 24 * cos(d / 57);
                        cG.y += 22 * sin((d + 180) / 57);
                        d -= 45;
                        shotsFired += 1;
                    }
                    if (shotsFired > 0
                        && !instance_exists(objChillSpikeGenerator)
                        && delay == 0)
                    {
                        if (shotsFired == 6)
                        {
                            sprite_index = sprChillJump;
                            pauseGravity = false;
                            shotsFired = 6;
                        }
                        else
                        {
                            delay = 10;
                            shotsFired = 6;
                        }
                    }
                    if (ground)
                    {
                        phase = 0;
                        attackTimer = 0;
                        shotsFired = 0;
                    }
                }
                break;
        }
        x = round(x);
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
with (objChillSpike)
    instance_destroy();
with (objChillSpikeSpike)
    instance_destroy();
with (objChillDebry)
    instance_destroy();
with (objChillSpikeGenerator)
    instance_destroy();
with (objChillSpikeDetector)
    instance_destroy();
event_inherited();
#define Other_21
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if (other.object_index == objPharaohShot)
{
    with (objPharaohShot)
    {
        if (sprite_index = sprPharaohShotCharged)
        {
            extraDamage = 4;
        }
    }
}
