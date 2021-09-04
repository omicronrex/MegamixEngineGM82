#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
// Creation code (all optional):
// suckSpeed = <number> // how fast you want Dust Man to pull you. Make negative to make him push you away.
// suckTimer = <number> // how long dust man suck/blows for. Remember he's immune during this attack!

event_inherited();

healthpointsStart = 28;
healthpoints = healthpointsStart;
xOff = 0;
contactDamage = 6;
customPose = true;
ground = false;
attackTimer = 0;
hasTriggeredFall = false;
introType = 0;
bossTriggered = true;
phase = 0;
hasFired = false;
grav = 0.24;
child = noone;

nextPhase = -1;
skewerPhase = 3;

// creation code
suckSpeed = 1;
suckTimer = 224;

// Health Bar
healthBarPrimaryColor[1] = 27;
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
enemyDamageValue(objSparkChaser, 1);
enemyDamageValue(objLaserTrident, 3);
enemyDamageValue(objWaterShield, 1);
enemyDamageValue(objTornadoBlow, 7);
enemyDamageValue(objThunderBeam, 1);
enemyDamageValue(objBreakDash, 2);
enemyDamageValue(objMagneticShockwave, 1);
enemyDamageValue(objIceWall, 2);

// MaGMML2
enemyDamageValue(objHornetChaser, 1);
enemyDamageValue(objJewelSatellite, 2);
enemyDamageValue(objGrabBuster, 1);
enemyDamageValue(objTripleBlade, 4);
enemyDamageValue(objWheelCutter, 1);
enemyDamageValue(objSlashClaw, 2);
enemyDamageValue(objSakugarne, 3);
enemyDamageValue(objSuperArrow, 1);
enemyDamageValue(objWireAdapter, 1);

// MaGMML1
enemyDamageValue(objMetalBlade, 3);
enemyDamageValue(objGeminiLaser, 1);
enemyDamageValue(objSolarBlaze, 2);
enemyDamageValue(objTopSpin, 1);
enemyDamageValue(objThunderWool, 1);
enemyDamageValue(objPharaohShot, 1);
enemyDamageValue(objBlackHoleBomb, 4);
enemyDamageValue(objMagicCard, 2);

// MaG48MML
enemyDamageValue(objFlameMixer, 2);
enemyDamageValue(objRainFlush, 1);
enemyDamageValue(objSparkShock, 1);
enemyDamageValue(objSearchSnake, 2);
enemyDamageValue(objTenguBlade, 1);
enemyDamageValue(objTenguDash, 2);
enemyDamageValue(objTenguDisk, 1);
enemyDamageValue(objSaltWater, 1);
enemyDamageValue(objConcreteShot, 4);
enemyDamageValue(objHomingSniper, 1);

// MaG48MML
enemyDamageValue(objSuperArmBlockProjectile, 4);
enemyDamageValue(objSuperArmDebris, 4);
enemyDamageValue(objChillShot, 1);
enemyDamageValue(objChillSpikeLanded, 1);

// Misc.
enemyDamageValue(objPowerStone, 1);
enemyDamageValue(objPlantBarrier, 4);
enemyDamageValue(objBrickWeapon, 3);
enemyDamageValue(objIceSlasher, 1);
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
// leave this. this is needed.
event_inherited();

// all of yamato man's events trigger when the game isn't frozen.
if (!global.frozen)
{
    // yamato man's custom intro
    if (startIntro)
    {
        y -= view_hview;
        canFillHealthBar = false;
        image_index = 8;
        startIntro = false;
        isIntro = true;
        visible = true;
        calibrateDirection();
    }
    else if (isIntro)
    {
        // custom intro:
        if (y <= ystart && !hasTriggeredFall)
            y += 4;
        if (y >= ystart || hasTriggeredFall)
        {
            // since bosses do not have gravity during intros, we need to reuse this here.
            hasTriggeredFall = true;
            y = ystart + 1;
            image_speed = 0;
            attackTimer += 1;
            if (attackTimer < 8)
                image_index = 0;
            if (attackTimer == 8)
                image_index = 1;
            if (attackTimer >= 14 && attackTimer < 32)
                image_index = 2;
            if (attackTimer == 32)
            {
                canFillHealthBar = true;
                isIntro = false;
                attackTimer = 0;
                hasFired = true;
                storeDirection = image_xscale;
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
        attackTimer+=1;
        switch (phase)
        {
            case 0: // prepare phase!
                xspeed = 0;
                if (attackTimer < 16)
                {
                    if (attackTimer > 6)
                    {
                        calibrateDirection();
                    }
                    image_index = 0;
                }
                if (attackTimer == 16) // choose tell
                {
                    nextPhase = choose(1, 2, skewerPhase);

                    switch (nextPhase)
                    {
                        case 1:
                            image_index = 4;
                            break;
                        case 2:
                            image_index = 3;
                            break;
                        case 3:
                            image_index = 1;
                            break;
                    }
                }
                if (attackTimer >= 24)
                {
                    attackTimer = 0;
                    hasFired = false;
                    phase = nextPhase;
                }
                break;
            case 1: // jump!
                if (ground && !hasFired)
                {
                    image_index = 8;
                    yspeed = -7.2;
                    xspeed = image_xscale * 1.3;
                    hasFired = true;
                }
                if (!ground)
                {
                    attackTimer = 0;
                }
                if (ground && yspeed >= 0 && hasFired)
                {
                    image_index = 4;
                    xspeed = 0;
                }
                if (attackTimer >= 8)
                {
                    attackTimer = 0;
                    skewerPhase = 3;
                    phase = 0;
                }
                break;
            case 2: // dust crusher
                calibrateDirection();
                switch (attackTimer) // setup animation
                {
                    case 1:
                    case 11:
                        image_index = 3;
                        break;
                    case 6:
                    case 16:
                        image_index = 4;
                        break;
                    case 21:
                        image_index = 5;
                        break;
                    case 26:
                        image_index = 6;
                        break;
                    case 36:
                        image_index = 7;
                        break;
                    case 46: // fire dust crusher
                        image_index = 3;
                        var inst; inst = instance_create(x, y - 8, objDustManCrusher);
                        inst.xspeed = image_xscale * 4;
                        inst.image_xscale = image_xscale;
                        playSFX(sfxEnemyShoot);
                        break;
                    case 64: // reset pattern
                        attackTimer = 0;
                        skewerPhase = 3;
                        phase = 0;
                        break;
                }
                break;
            case 3: // dust man sucks
                if (attackTimer > 8)
                {
                    if (sign(suckSpeed) == 1)
                    {
                        image_index = min(9 + ((attackTimer / 3) mod 4), 12);
                    }
                    if (sign(suckSpeed) == -1)
                    {
                        image_index = max(12 - ((attackTimer / 3) mod 4), 9);
                    }
                    with (objMegaman)
                    {
                        if (id == other.id)
                            continue;
                        if (!dead)
                        {
                            if (climbing)
                            {
                                continue;
                            }


                            with (other)
                            {
                                if (collision_rectangle(x, view_yview, x + image_xscale * view_wview, view_yview + view_hview, other.id, false, false))
                                {
                                    with (other)
                                    {
                                        shiftObject(-other.suckSpeed * other.image_xscale, 0, 1);
                                    }
                                }
                            }
                        }
                    }

                    // disable suck if timer runs out, or he collides with mega man
                    if (attackTimer >= suckTimer || place_meeting(x - 4 * image_xscale, y, objMegaman))
                    {
                        image_index = 1;
                        attackTimer = 0;
                        skewerPhase = choose(1, 2);
                        phase = 0;
                    }
                }
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
with (objDustManCrusher)
{
    instance_create(x, y, objExplosion);
    instance_destroy();
}
with (objDustManDebris)
{
    instance_create(x, y, objExplosion);
    instance_destroy();
}
event_inherited();
#define Other_21
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if (image_index >= 9)
{
    other.guardCancel = 1;
}
#define Draw_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();
