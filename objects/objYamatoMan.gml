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
contactDamage = 4;
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

skewerPhase = 1;
strMMX = -1;

// Health Bar
healthBarPrimaryColor[1] = 16;
healthBarSecondaryColor[1] = 40;

// Music
music = "Mega_Man_6.nsf";
musicType = "VGM";
musicTrackNumber = 12;

// Damage Table
enemyDamageValue(objBusterShot, 1);
enemyDamageValue(objBusterShotHalfCharged, 1);
enemyDamageValue(objBusterShotCharged, 3);

// MaGMML3
enemyDamageValue(objSparkChaser, 2);
enemyDamageValue(objLaserTrident, 4);
enemyDamageValue(objWaterShield, 1);
enemyDamageValue(objTornadoBlow, 2);
enemyDamageValue(objThunderBeam, 1);
enemyDamageValue(objBreakDash, 1);
enemyDamageValue(objMagneticShockwave, 2);
enemyDamageValue(objIceWall, 1);

// MaGMML2
enemyDamageValue(objHornetChaser, 2);
enemyDamageValue(objJewelSatellite, 1);
enemyDamageValue(objGrabBuster, 1);
enemyDamageValue(objTripleBlade, 2);
enemyDamageValue(objWheelCutter, 1);
enemyDamageValue(objSlashClaw, 1);
enemyDamageValue(objSakugarne, 1);
enemyDamageValue(objSuperArrow, 4);
enemyDamageValue(objWireAdapter, 2);

// MaGMML1
enemyDamageValue(objMetalBlade, 1);
enemyDamageValue(objGeminiLaser, 2);
enemyDamageValue(objSolarBlaze, 2);
enemyDamageValue(objTopSpin, 1);
enemyDamageValue(objThunderWool, 1);
enemyDamageValue(objPharaohShot, 1);
enemyDamageValue(objBlackHoleBomb, 1);
enemyDamageValue(objMagicCard, 4);

// MaG48HMML
enemyDamageValue(objFlameMixer, 2);
enemyDamageValue(objRainFlush, 2);
enemyDamageValue(objSparkShock, 0);
enemyDamageValue(objSearchSnake, 1);
enemyDamageValue(objTenguBlade, 4);
enemyDamageValue(objTenguDash, 4);
enemyDamageValue(objTenguDisk, 4);
enemyDamageValue(objSaltWater, 1);
enemyDamageValue(objConcreteShot, 1);
enemyDamageValue(objHomingSniper, 2);

// MaG24HMML
enemyDamageValue(objSuperArmBlockProjectile, 1);
enemyDamageValue(objSuperArmDebris, 1);
enemyDamageValue(objChillShot, 1);
enemyDamageValue(objChillSpikeLanded, 2);

// Misc.
enemyDamageValue(objPowerStone, 1);
enemyDamageValue(objPlantBarrier, 0);
enemyDamageValue(objBrickWeapon, 1);
enemyDamageValue(objIceSlasher, 1);
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
// leave this. this is needed.
event_inherited();
if (xcoll != 0)
    xspeed = xcoll;

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
            if (attackTimer >= 12 && attackTimer < 50)
                image_index = 2 + ((attackTimer / 3) mod 2);
            if (attackTimer == 50)
            {
                image_index = 0;
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

        if (instance_exists(target))
        {
            strMMX = target.x;
        }
        switch (phase)
        {
            case 0: // prepare phase!
                xspeed = 0;
                if (attackTimer < 30)
                {
                    if (attackTimer > 15)
                    {
                        calibrateDirection();
                    }
                    image_index = 0;
                }
                if (attackTimer == 32)
                {
                    image_index = 1;
                }
                if (attackTimer == 40)
                {
                    hasFired = false;
                    phase = choose(1, 2, skewerPhase);
                }
                break;
            case 1: // jump
                skewerPhase = 2;
                if (image_index > 8)
                {
                    image_index = 9 + ((attackTimer / 3) mod 2);
                }
                if (ground && !hasFired && image_index < 8)
                {
                    hasFired = true;
                    image_index = 8;
                    yspeed = -8;
                    var modi; modi = choose(0.95, 0.75, 0.5);
                    var ty; ty = 0;
                    if (instance_exists(target))
                    {
                        ty = target.y;
                    }
                    xspeed = xSpeedAim(x, y, strMMX + 16 * image_xscale, ty, yspeed, grav);
                    xspeed = xspeed * modi;
                }
                if (yspeed >= 1 && hasFired)
                {
                    hasFired = false;
                    image_index = 9;
                    playSFX(sfxEnemyShoot);
                    if (image_xscale == 1 && x + 8 < strMMX || image_xscale == -1 && x - 8 > strMMX) // how yamato man shoots depends on mega man's position.
                    {
                        var i; i = instance_create(x, y, objCentaurSecondaryBullet);
                        i.sprite_index = sprYamatoManSpearhead;
                        i.image_speed = 0;
                        i.image_index = 0;
                        i.dir = 0;
                        i.image_xscale = image_xscale;
                        i.xscale = i.image_xscale;
                        i.contactDamage = 4;
                        i.spd = 2.5;
                        var i; i = instance_create(x, y, objCentaurSecondaryBullet);
                        i.sprite_index = sprYamatoManSpearhead;
                        i.image_speed = 0;
                        i.image_index = 1;
                        i.dir = 315;
                        i.image_xscale = image_xscale;
                        i.xscale = i.image_xscale;
                        i.contactDamage = 4;
                        i.spd = 2.5;
                        var i; i = instance_create(x, y, objCentaurSecondaryBullet);
                        i.sprite_index = sprYamatoManSpearhead;
                        i.image_speed = 0;
                        i.image_index = 2;
                        i.dir = 285;
                        i.image_xscale = image_xscale;
                        i.xscale = i.image_xscale;
                        i.contactDamage = 4;
                        i.spd = 2.5;
                    }
                    else
                    {
                        var i; i = instance_create(x, y, objCentaurSecondaryBullet);
                        i.sprite_index = sprYamatoManSpearhead;
                        i.image_speed = 0;
                        i.image_index = 1;
                        i.dir = 295;
                        i.image_xscale = image_xscale;
                        i.xscale = i.image_xscale;
                        i.contactDamage = 4;
                        i.spd = 2.5;
                        var i; i = instance_create(x, y, objCentaurSecondaryBullet);
                        i.sprite_index = sprYamatoManSpearhead;
                        i.image_speed = 0;
                        i.image_index = 1;
                        i.dir = 295;
                        i.image_xscale = -image_xscale;
                        i.xscale = i.image_xscale;
                        i.contactDamage = 4;
                        i.spd = 2.5;
                        var i; i = instance_create(x, y, objCentaurSecondaryBullet);
                        i.sprite_index = sprYamatoManSpearhead;
                        i.image_speed = 0;
                        i.image_index = 2;
                        i.dir = 270;
                        i.image_xscale = image_xscale;
                        i.xscale = i.image_xscale;
                        i.contactDamage = 4;
                        i.spd = 2.5;
                    }
                }
                if (ground && image_index >= 9)
                {
                    image_index = 0;
                    attackTimer = 0;
                    phase = 0;
                }
                break;
            case 2: // fire spear
                skewerPhase = 1;
                image_index = 2 + ((attackTimer / 3) mod 2);
                if (!hasFired)
                {
                    playSFX(sfxEnemyShoot);
                    hasFired = true;
                    child = instance_create(x, y, objYamatoSpearhead);
                    child.xspeed = 4 * image_xscale;
                    child.image_xscale = image_xscale;
                    child.parent = id;
                }
                break;
            case 3: // collect spearhead
                image_index = 4 + ((attackTimer / 6) mod 4); // animate walk
                if (ycoll != 0 && xcoll != 0)
                    image_xscale *= -1;
                xspeed = 2.75 * image_xscale;
                if (yspeed == 0 && checkSolid(xspeed, 0, 0, 1))
                    yspeed = -4.35;
                if (instance_exists(child))
                {
                    if (place_meeting(x + xspeed * 2, y, child))
                    {
                        with (child)
                        {
                            instance_destroy();
                        }
                    }
                }
                if (!instance_exists(child))
                {
                    image_index = 0;
                    attackTimer = 0;
                    phase = 0;
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
with (objCentaurSecondaryBullet)
{
    instance_create(x, y, objExplosion);
    instance_destroy();
}
with (objYamatoSpearhead)
{
    instance_create(x, y, objExplosion);
    instance_destroy();
}
event_inherited();
#define Draw_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();
