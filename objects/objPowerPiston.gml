#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();

healthpointsStart = 28;
healthpoints = healthpointsStart;
imageOffset = 0;
contactDamage = 8;
customPose = true;
ground = false;
grav = 0;
phase = 0;
shotsFired = 0;
attackTimer = 0;
healthBarPrimaryColor[1] = 16;
healthBarSecondaryColor[1] = 30;


image_index = 4;

yMax = ystart + 32;
yMin = -1;
animTimer = 0;
delayRock = 24;
bodyFrame = 0;
lightFrame = 0;
turnTimer = 0;
delayMove = 8;
cTurn = -1;
turnCheck[0] = 24;
turnCheck[1] = 24;
turnCheck[2] = 32;
turnCheck[3] = 24;
turnCheck[4] = 600;
startCheck = false;
child = noone;
shootAngle = 35;

// Music
music = "Mega_Man_6.nsf";
musicType = "VGM";
musicTrackNumber = 12;

// Damage Table
enemyDamageValue(objBusterShot, 1);
enemyDamageValue(objBusterShotHalfCharged, 1);
enemyDamageValue(objBusterShotCharged, 3);

// MaGMML3
enemyDamageValue(objSparkChaser, 4);
enemyDamageValue(objLaserTrident, 1);
enemyDamageValue(objWaterShield, 2);
enemyDamageValue(objTornadoBlow, 1);
enemyDamageValue(objThunderBeam, 4);
enemyDamageValue(objBreakDash, 1);
enemyDamageValue(objMagneticShockwave, 2);
enemyDamageValue(objIceWall, 1);

// MaGMML2
enemyDamageValue(objHornetChaser, 4);
enemyDamageValue(objJewelSatellite, 2);
enemyDamageValue(objGrabBuster, 1);
enemyDamageValue(objTripleBlade, 2);
enemyDamageValue(objWheelCutter, 2);
enemyDamageValue(objSlashClaw, 1);
enemyDamageValue(objSakugarne, 1);
enemyDamageValue(objSuperArrow, 1);
enemyDamageValue(objWireAdapter, 8);

// MaGMML1
enemyDamageValue(objMetalBlade, 4);
enemyDamageValue(objGeminiLaser, 1);
enemyDamageValue(objSolarBlaze, 2);
enemyDamageValue(objTopSpin, 8);
enemyDamageValue(objThunderWool, 2);
enemyDamageValue(objPharaohShot, 2);
enemyDamageValue(objBlackHoleBomb, 1);
enemyDamageValue(objMagicCard, 2);

// MaG48HMML
enemyDamageValue(objFlameMixer, 3);
enemyDamageValue(objRainFlush, 1);
enemyDamageValue(objSparkShock, 1);
enemyDamageValue(objSearchSnake, 2);
enemyDamageValue(objTenguBlade, 1);
enemyDamageValue(objTenguDash, 1);
enemyDamageValue(objTenguDisk, 2);
enemyDamageValue(objSaltWater, 2);
enemyDamageValue(objConcreteShot, 1);
enemyDamageValue(objHomingSniper, 4);

// MaG24HMML
enemyDamageValue(objSuperArmBlockProjectile, 4);
enemyDamageValue(objSuperArmDebris, 4);
enemyDamageValue(objChillShot, 1);
enemyDamageValue(objChillSpikeLanded, 1);

// Misc.
enemyDamageValue(objPowerStone, 4);
enemyDamageValue(objPlantBarrier, 1);
enemyDamageValue(objBrickWeapon, 4);
enemyDamageValue(objIceSlasher, 1);
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
// leave this. this is needed.
event_inherited();

if (cTurn == -1)
{
    cTurn = choose(0, 1);
}

if (!startCheck)
{
    startCheck = true;


    var i; for ( i = 0; i < view_wview; i+=1)
    {
        if (checkSolid(i, 0))
        {
            image_xscale = -1;
            x += i - 1;
            break;
        }
        if (checkSolid(-i, 0))
        {
            image_xscale = 1;
            x -= i - 1;
            break;
        }
    }
    var i; for ( i = 0; i < view_hview; i+=1)
    {
        if (checkSolid(0, -i))
        {
            yMin = y;
            break;
        }
    }
}

// all of power piston's events trigger when the game isn't frozen.
if (!global.frozen)
{
    // power piston's custom intro
    if (startIntro)
    {
        canFillHealthBar = false;
        startIntro = false;
        isIntro = true;
        visible = true;
    }
    else if (isIntro)
    {
        // custom intro:
        attackTimer+=1;

        if (attackTimer == 10 && image_index > 0)
        {
            image_index-=1;
            attackTimer = 0;
        }
        if (attackTimer == 40)
        {
            canFillHealthBar = true;
            isIntro = false;
            grav = gravStart;
            blockCollision = blockCollisionStart;
            attackTimer = 0;
            storeDirection = image_xscale;
        }
    }
}
if (entityCanStep())
{
    if (isFight)
    {
        attackTimer+=1;
        animTimer+=1;
        delayRock-=1;
        turnTimer+=1;
        delayMove-=1;




        // animation setup
        image_index = 5 + bodyFrame;
        if (animTimer mod 8 == 0)
        {
            bodyFrame = !bodyFrame;
        }

        if (animTimer mod 5 == 0)
        {
            lightFrame+=1;
            if (lightFrame == 3)
            {
                lightFrame = 0;
            }
        }

        switch (phase)
        {
            case 0: // move and shoot
                if (yspeed == 0 && delayMove <= 0) // if not moving, move.
                {
                    yspeed = choose(1, -1);
                }
                if (yspeed > 0 && y >= yMax || yspeed < 0 && y <= yMin || ycoll != 0 || turnTimer >= turnCheck[cTurn mod 5]) // turn around, bright eyes
                {
                    yspeed *= -1;
                    if (turnTimer >= turnCheck[cTurn mod 4]) // spaz about
                    {
                        turnTimer = 0;
                        cTurn+=1;
                    }
                    delayMove = choose(0, 0, 32);
                    if (delayMove > 0)
                    {
                        yspeed = 0;
                    }
                }
                if (delayRock <= 0 && !instance_exists(child)) // if no rocks or explosions exist, and there is no deleay, create rock
                {
                    var inst; inst = instance_create(view_xview + 24 + irandom(view_wview - 48), view_yview - 16, objPowerPistonRock);
                    inst.parent = id;
                    inst.itemDrop = -1;
                    child = inst.id;
                }
                if (instance_exists(child))
                {
                    delayRock = 16;
                }
                if (attackTimer >= 64) // fire projectiles
                {
                    var getAngle;

                    // If megaman exists, grab his angle, otherwise grab some random different angle.
                    if (instance_exists(target))
                        getAngle = point_direction(x, y, target.x, target.y);
                    else
                        getAngle = point_direction(x, y, x + (45 * (image_xscale)),
                            45 * (image_xscale));

                    var ID;
                    if (shotsFired == 0) // power piston only fires three bullets on its first barrage.
                    {
                        ID = instance_create(x + image_xscale * 8, spriteGetYCenter(),
                            objMM5AimedBullet);

                        ID.dir = getAngle;
                        ID.xscale = image_xscale;
                    }

                    ID = instance_create(x + image_xscale * 8, spriteGetYCenter(),
                        objMM5AimedBullet);
                    ID.dir = getAngle + shootAngle;
                    ID.xscale = image_xscale;
                    ID = instance_create(x + image_xscale * 8, spriteGetYCenter(),
                        objMM5AimedBullet);
                    ID.dir = getAngle - shootAngle;
                    ID.xscale = image_xscale;
                    playSFX(sfxEnemyShoot);
                    shotsFired+=1;

                    if (shotsFired >= 2)
                    {
                        shotsFired = 0;
                    }
                    attackTimer = 0;
                }
                break;
        }
    }
}
#define Other_12
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
/// draw code
drawSelf();
if (!dead)
{
    if (lightFrame < 2)
    {
        draw_sprite_ext(sprite_index, min(lightFrame + 7, 8), round(x), round(y), image_xscale, image_yscale, image_angle, image_blend, image_alpha);
    }
}
#define Other_20
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
with (objPowerPistonRock)
{
    instance_create(x, y, objExplosion);
    instance_destroy();
}
with (objNewShotmanBullet)
    instance_destroy();
with (objHarmfulExplosion)
    instance_destroy();
with (objMM5AimedBullet)
    instance_destroy();
event_inherited();
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
