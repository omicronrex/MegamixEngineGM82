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
contactDamage = 5;
customPose = true;

ground = false;

attackTimer = 0;
hasTriggeredFall = false;
spreadYspeed = -2;

introType = 0;

bossTriggered = true;
phase = 0;
hasFired = false;
grav = 0.15;

child[0] = noone;
child[1] = noone;
child[2] = noone;
child[3] = noone;

myHat = noone;

hatOffset = 40;
eyeOffset = 0;
eyeTimer = 0;
freeMegaman = 0;
hatFrame = 3;
directX = 1;

// met falling patterns
met1[0] = 48;
met2[0] = 112;
met3[0] = 144;
met4[0] = 208;
met1[1] = 56;
met2[1] = 104;
met3[1] = 152;
met4[1] = 200;
met1[2] = 80;
met2[2] = 112;
met3[2] = 144;
met4[2] = 176;

// Health Bar
healthBarPrimaryColor[1] = 33;
healthBarSecondaryColor[1] = 40;

// Music
music = "Mega_Man_4.nsf";
musicType = "VGM";
musicTrackNumber = 17;

// Damage Table
enemyDamageValue(objBusterShot, 1);
enemyDamageValue(objBusterShotHalfCharged, 1);
enemyDamageValue(objBusterShotCharged, 3);

// MaGMML3
enemyDamageValue(objSparkChaser, 2);
enemyDamageValue(objLaserTrident, 4);
enemyDamageValue(objWaterShield, 1);
enemyDamageValue(objTornadoBlow, 1);
enemyDamageValue(objThunderBeam, 1);
enemyDamageValue(objBreakDash, 2);
enemyDamageValue(objMagneticShockwave, 0);
enemyDamageValue(objIceWall, 2);

// MaGMML2
enemyDamageValue(objHornetChaser, 2);
enemyDamageValue(objJewelSatellite, 2);
enemyDamageValue(objGrabBuster, 1);
enemyDamageValue(objTripleBlade, 2);
enemyDamageValue(objWheelCutter, 1);
enemyDamageValue(objSlashClaw, 4);
enemyDamageValue(objSakugarne, 0);
enemyDamageValue(objSuperArrow, 1);
enemyDamageValue(objWireAdapter, 1);

// MaGMML1
enemyDamageValue(objMetalBlade, 1);
enemyDamageValue(objGeminiLaser, 2);
enemyDamageValue(objSolarBlaze, 2);
enemyDamageValue(objTopSpin, 0);
enemyDamageValue(objThunderWool, 1);
enemyDamageValue(objPharaohShot, 1);
enemyDamageValue(objBlackHoleBomb, 1);
enemyDamageValue(objMagicCard, 4);

// MaG48HMML
enemyDamageValue(objFlameMixer, 2);
enemyDamageValue(objRainFlush, 1);
enemyDamageValue(objSparkShock, 1);
enemyDamageValue(objSearchSnake, 2);
enemyDamageValue(objTenguBlade, 1);
enemyDamageValue(objTenguDash, 2);
enemyDamageValue(objTenguDisk, 1);
enemyDamageValue(objSaltWater, 4);
enemyDamageValue(objConcreteShot, 1);
enemyDamageValue(objHomingSniper, 1);

// MaG24HMML
enemyDamageValue(objSuperArmBlockProjectile, 1);
enemyDamageValue(objSuperArmDebris, 1);
enemyDamageValue(objChillShot, 2);
enemyDamageValue(objChillSpikeLanded, 5);

// Misc.
enemyDamageValue(objPowerStone, 1);
enemyDamageValue(objPlantBarrier, 1);
enemyDamageValue(objBrickWeapon, 0);
enemyDamageValue(objIceSlasher, 1);
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
// leave this. this is needed.
event_inherited();

// all of metall daddy's events trigger when the game isn't frozen.
if (entityCanStep())
{
    // metall daddy's custom intro
    if (startIntro)
    {
        canFillHealthBar = false;
        image_index = 1;
        startIntro = false;
        isIntro = true;
        visible = true;
        y=ystart;
        calibrateDirection();
        yspeed=0;
        grav=0;
    }
    else if (isIntro)
    {
        // custom intro:
        if(y>=ystart)
        {
            image_speed = 0;
            attackTimer += 1;
            if (attackTimer mod 8 == 7 && hatFrame < 6)
                hatFrame+=1;
            if (attackTimer == 50)
            {
                myHat = instance_create(x, y + hatOffset, objMetallDaddyHelmet);
                myHat.parent = id;
                canFillHealthBar = true;
                isIntro = false;
                attackTimer = 0;
                hasFired = false;
                storeDirection = image_xscale;
                grav = gravStart;
                blockCollision = blockCollisionStart;
                with (objMegaman)
                {
                    stunLock = noone;
                }
            }
        }
    }
}
if (entityCanStep())
{
    if (isFight == true)
    {
        myHat.x = x;
        myHat.y = y + hatOffset;

        // eye shake animation
        if (eyeTimer > 0)
        {
            eyeTimer-=1;
        }

        switch (eyeTimer)
        {
            case 0:
            case 16:
            case 12:
            case 8:
            case 6:
                eyeOffset = 0;
                break;
            case 40:
            case 32:
            case 24:
                eyeOffset = 4;
                break;
            case 36:
            case 28:
            case 20:
                eyeOffset = -4;
                break;
            case 14:
                eyeOffset = -2;
                break;
            case 15:
            case 13:
            case 7:
                eyeOffset = -1;
                break;
            case 10:
                eyeOffset = 2;
                break;
            case 11:
            case 9:
            case 5:
                eyeOffset = 1;
                break;
        }

        attackTimer+=1;
        switch (phase)
        {
            case 0: // prepare phase!
                xspeed = 0;
                if (attackTimer == 4 && hatOffset > 0)
                {
                    hatOffset -= 8;
                    attackTimer = 0;
                }
                if (attackTimer == 80 - ((global.difficulty == DIFF_HARD) * 40))
                {
                    var inst; inst = instance_create(x, y + 32, objExplosion);
                    inst.sprite_index = sprMetallDaddyJump;
                    yspeed = -3.5 - choose(0, 1, 1.5);
                    if (instance_exists(target))
                    {
                        xspeed = xSpeedAim(x, y, target.x, y, yspeed, grav);
                    }
                    if (abs(xspeed) > 1.5)
                    {
                        xspeed = sign(xspeed) * 1.5;
                    }
                    phase = 1;
                    attackTimer = 0;
                }
                break;
            case 1: // jump
                if (!ground)
                {
                    attackTimer = 0;
                }
                else
                {
                    xspeed = 0;
                    if (!hasFired)
                    {
                        with (objMegaman)
                        {
                            if (ground)
                            {
                                xspeed = 0;
                                yspeed = 0;
                                stunLockP = lockPoolLock(localPlayerLock[PL_LOCK_MOVE],
                                    localPlayerLock[PL_LOCK_TURN],
                                    localPlayerLock[PL_LOCK_SLIDE],
                                    localPlayerLock[PL_LOCK_SHOOT],
                                    localPlayerLock[PL_LOCK_CLIMB],
                                    localPlayerLock[PL_LOCK_SPRITECHANGE],
                                    localPlayerLock[PL_LOCK_GRAVITY],
                                    localPlayerLock[PL_LOCK_JUMP]);
                                stunLock = stunLockP;
                            }
                        }
                        screenShake(72, 2, 2);
                        playSFX(sfxGutsQuake);
                        eyeTimer = 41;
                        hasFired = true;
                    }
                }
                if (attackTimer == 72)
                {
                    var i; for ( i = 0; i < 4; i+=1)
                    {
                        var offsetMet; offsetMet = 0;
                        var xDirt; xDirt = -1;
                        var rnd; rnd = choose(0, 1, 2);
                        var storeMetVal; storeMetVal = 0;
                        switch (i)
                        {
                            case 0:
                                storeMetVal = met1[rnd];
                                break;
                            case 1:
                                storeMetVal = met2[rnd];
                                offsetMet = -32;
                                break;
                            case 2:
                                storeMetVal = met3[rnd];
                                offsetMet = -32;
                                xDirt = 1;
                                break;
                            case 3:
                                storeMetVal = met4[rnd];
                                xDirt = 1;
                                break;
                        }
                        var inst; inst = instance_create(view_xview + storeMetVal, view_yview - 16 + offsetMet, objMetallDaddyChild);
                        inst.parent = id;
                        child[i] = inst.id;
                        inst.image_xscale = xDirt;
                        inst.itemDrop = -1;
                    }
                }

                // release player after a certain point
                with (objMegaman)
                {
                    if (other.attackTimer == 88 || isHit)
                    {
                        stunLock = lockPoolRelease(stunLock);
                    }
                }

                // hat goes down
                if (attackTimer > 128 && attackTimer mod 4 == 0 && hatOffset < 40)
                {
                    hatOffset += 8;
                }
                if (attackTimer >= 164 && !instance_exists(child[0]) && !instance_exists(child[1]) && !instance_exists(child[2]) && !instance_exists(child[3]))
                {
                    attackTimer = 0;
                    phase = ((global.difficulty == DIFF_HARD) * 2);
                    hasFired = false;
                }
                break;
            case 2: // Hard Mode exclusive bullet spread
                if (attackTimer == 54 && hatOffset > 0)
                {
                    hatOffset -= 8;
                    attackTimer = 50;
                }
                if (attackTimer == 75 && spreadYspeed < 2)
                {
                    playSFX(sfxEnemyShoot);

                    with (instance_create(x, y + 20, objEnemyBullet))
                    {
                        sprite_index = sprMetallCannonBall;
                        depth = other.depth - 1;

                        if (instance_exists(target))
                        {
                            if (target.x < x)
                            {
                                xspeed = -2;
                            }
                            else
                            {
                                xspeed = 2;
                            }
                        }

                        yspeed = other.spreadYspeed;
                    }

                    spreadYspeed += 0.6;
                    attackTimer = 67;
                }
                if (attackTimer == 95)
                {
                    spreadYspeed = -2;
                    attackTimer = 39;
                    phase = 0;
                }
                break;
        }
    }
}
else
{ }
#define Other_12
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
/// animation code
draw_sprite_part(sprite_index, 1, 0, 40 + hatOffset, 80, 80, round(x - 40), round(y + hatOffset * 2 - 40 + 32 - hatOffset));
draw_sprite_ext(sprite_index, 2, round(x), round(y + eyeOffset), 1, image_yscale, image_angle, image_blend, image_alpha);
draw_sprite_ext(sprite_index, hatFrame, round(x), round(y + hatOffset), 1, image_yscale, image_angle, image_blend, image_alpha);
#define Other_20
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
with (myHat)
    instance_destroy();
with (objMetallDaddyChild)
{
    instance_create(x, y, objExplosion);
    instance_destroy();
}
with (objMegaman)
    stunLock = lockPoolRelease(stunLock);
event_inherited();
#define Other_21
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if (collision_rectangle(x - 40, y + hatOffset,
    x + 40, y - 8, other.id, false, false))
{
    other.guardCancel = 3;
}
#define Draw_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if (!dead)
{
    if (drawBoss) // actually draw itself
    {
        if ((iFrames mod 4) < 2 || !iFrames)
        {
            event_user(2);
        }
        else // Hitspark
        {
            d3d_set_fog(true, c_white, 0, 0);
            event_user(2);
            d3d_set_fog(false, 0, 0, 0);
        }
    }
}
