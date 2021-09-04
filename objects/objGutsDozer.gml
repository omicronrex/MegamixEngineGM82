#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();

healthpointsStart = 28;
healthpoints = healthpointsStart;
despawnRange = -1;

pose = sprite_index;
poseImgSpeed = 1;
contactDamage = 4;

moveSpeed = 1 / 3;
dstX = 0;

introType = 2;
shootTimer = 0;
waitTime = 0;
mySolid = noone;
child = noone;
playerOnTank = false;

animTimerTreads = 0;
animTimerMouth = 0;

// Health Bar
healthBarPrimaryColor[1] = 33;
healthBarSecondaryColor[1] = 47;

// Music
music = "Mega_Man_2.nsf";
musicType = "VGM";
musicTrackNumber = 17;

// Damage Tables
enemyDamageValue(objBusterShot, 1);
enemyDamageValue(objBusterShotHalfCharged, 1);
enemyDamageValue(objBusterShotCharged, 3);

// MaGMML3
enemyDamageValue(objSparkChaser, 1);
enemyDamageValue(objLaserTrident, 4);
enemyDamageValue(objWaterShield, 1);
enemyDamageValue(objTornadoBlow, 0);
enemyDamageValue(objThunderBeam, 2);
enemyDamageValue(objBreakDash, 0);
enemyDamageValue(objMagneticShockwave, 2);
enemyDamageValue(objIceWall, 0);

// MaGMML2
enemyDamageValue(objHornetChaser, 1);
enemyDamageValue(objJewelSatellite, 0);
enemyDamageValue(objGrabBuster, 2);
enemyDamageValue(objTripleBlade, 0);
enemyDamageValue(objSlashClaw, 4);
enemyDamageValue(objWheelCutter, 0);
enemyDamageValue(objSakugarne, 0);
enemyDamageValue(objSuperArrow, 2);
enemyDamageValue(objWireAdapter, 0);

// MaGMML1
enemyDamageValue(objMetalBlade, 0);
enemyDamageValue(objGeminiLaser, 2);
enemyDamageValue(objSolarBlaze, 4);
enemyDamageValue(objTopSpin, 0);
enemyDamageValue(objThunderWool, 1);
enemyDamageValue(objPharaohShot, 2);
enemyDamageValue(objBlackHoleBomb, 1);
enemyDamageValue(objMagicCard, 0);

// MaG48HMML
enemyDamageValue(objFlameMixer, 2);
enemyDamageValue(objRainFlush, 1);
enemyDamageValue(objSparkShock, 0);
enemyDamageValue(objSearchSnake, 0);
enemyDamageValue(objTenguBlade, 2);
enemyDamageValue(objTenguDash, 0);
enemyDamageValue(objTenguDisk, 0);
enemyDamageValue(objSaltWater, 2);
enemyDamageValue(objConcreteShot, 1);
enemyDamageValue(objHomingSniper, 4);

// MaG24HMML
enemyDamageValue(objSuperArmBlockProjectile, 1);
enemyDamageValue(objSuperArmDebris, 1);
enemyDamageValue(objChillShot, 0);
enemyDamageValue(objChillSpikeLanded, 0);

// Misc.
enemyDamageValue(objPowerStone, 2);
enemyDamageValue(objPlantBarrier, 5);
enemyDamageValue(objBrickWeapon, 0);
enemyDamageValue(objIceSlasher, 0);
#define Destroy_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
with (mySolid)
    instance_destroy();
with (objMet)
    event_user(EV_DEATH);
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();

var arenaCentre; arenaCentre = view_xview[0] + view_wview[0] / 2;
var stopDist; stopDist = (view_wview[0] / 2 - 48);

if (entityCanStep())
{
    if (isFight)
    {
        // animate (the boss is assembled animation wise in user event 2)
        animTimerTreads = (animTimerTreads + 1) mod 10;
        animTimerMouth-=1;

        if (!instance_exists(child))
        {
            child = instance_create(x - 51 * image_xscale, y - 16, objGutsDozerHand);
            child.image_xscale = image_xscale;
            child.parent = id;
        }

        // movement planning:
        if (waitTime <= 0)
        {
            // not waiting; move toward target.
            if (x > dstX)
                xspeed = -moveSpeed;
            else
                xspeed = moveSpeed;
            if (abs(x - dstX) <= moveSpeed)
            {
                // pause, then turn around:
                waitTime = 80;
                if (dstX == arenaCentre)
                {
                    dstX = arenaCentre + image_xscale * stopDist;
                }
                else
                {
                    dstX = arenaCentre;
                }
            }
        }
        else
        {
            // just stay put
            xspeed = 0;
            waitTime-=1;
        }

        // shooting (only when not far offscreen)
        if (abs(x - image_xscale * 80 - arenaCentre) <= (view_wview[0] / 2 - 46))
        {
            // fix physics
            grav = 0.25;
            blockCollision = 1;

            // determine if anybody is aboard:
            playerOnTank = false;
            with (objMegaman)
            {
                if (y + 12 < other.y && (x - other.x) * other.image_xscale < 12)
                    other.playerOnTank = true;
            }

            shootTimer-=1
            if ((shootTimer) <= -1 && instance_exists(target))
            {
                shootTimer = 60;
                if (playerOnTank)
                {
                    animTimerMouth = 12;
                    with (instance_create(x - 64 * image_xscale, y - 48, objEnemyBullet))
                    {
                        playSFX(sfxEnemyShootClassic);
                        yspeed = -5;
                        grav = 0.25;
                        xspeed = other.image_xscale;
                    }
                }
                else
                {
                    with (instance_create(x - 64 * image_xscale, y - 14, objMet))
                    {
                        respawn = false;
                        yspeed = -2;
                        itemDrop = -1;
                    }
                }
            }


            if (playerOnTank)
            {
                with (child)
                {
                    if (yOffset > 0)
                    {
                        yOffset-=1;
                    }
                }
            }
            else
            {
                with (child)
                {
                    if (yOffset < 24)
                    {
                        yOffset+=1;
                    }
                }
            }
        }
    }
    else
    {
        // set starting position
        if (insideView())
        {
            calibrateDirection();
            grav = 0;
            blockCollision = 0;
            if (image_xscale == 1)
            {
                x = view_xview[0] + 1;
                dstX = arenaCentre + stopDist;
            }
            else
            {
                x = view_xview[0] + view_wview[0] - 1;
                dstX = arenaCentre - stopDist;
            }
        }
    }
}

// customize mets
with (objMet)
{
    cooldownTimer = 59;
    image_xscale = other.image_xscale;
    canShoot = false;
    animTimer = clamp(animTimer, 0, 6);
    image_index = clamp(image_index, 1, 3);

    // bounce
    if (place_meeting(x, y + 4, other.mySolid))
        yspeed = -4;
}

// solid object for treads
if (isFight && !dead)
{
    if (!instance_exists(mySolid))
    {
        mySolid = instance_create(x, y, objSolidEntity);
    }
    mySolid.image_yscale = 0.1;
    mySolid.image_xscale = 164 / 16;
    var dstXSolid; dstXSolid = x;
    if (image_xscale == 1)
    {
        dstXSolid -= 166;
    }
    else
    {
        dstXSolid += 2;
    }
    var dstYSolid; dstYSolid = y - 1;
    mySolid.xspeed = dstXSolid - mySolid.x;
    mySolid.yspeed = dstYSolid - mySolid.y;
    mySolid.isSolid = 2;
    mySolid.visible = false;
}
else
    with (mySolid)
        instance_destroy();
#define Other_12
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
/// draw code

draw_sprite_ext(sprite_index, 1, round(x), round(y), image_xscale, image_yscale, image_angle, image_blend, image_alpha);
draw_sprite_ext(sprite_index, 2 + animTimerTreads div 5, round(x), round(y), image_xscale, image_yscale, image_angle, image_blend, image_alpha);
if (animTimerMouth > 0)
    draw_sprite_ext(sprite_index, 5, round(x), round(y), image_xscale, image_yscale, image_angle, image_blend, image_alpha);
else
    draw_sprite_ext(sprite_index, 4, round(x), round(y), image_xscale, image_yscale, image_angle, image_blend, image_alpha);

if ((floor(shootTimer / 8) mod 2) == 0)
{
    draw_sprite_ext(sprite_index, 6, round(x), round(y), image_xscale, image_yscale, image_angle, image_blend, image_alpha);
}
if (instance_exists(child))
    draw_sprite_ext(sprGutsDozerHand, 0, round(x - 58 * image_xscale), round(y - 16 - child.yOffset), image_xscale, image_yscale, image_angle, image_blend, image_alpha);
#define Other_21
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();
other.guardCancel = 1;

// pass through treads
if (other.y >= y - 5)
{
    other.guardCancel = 2;
}

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

// pass through front:
if ((other.x - x) * image_xscale > -60)
    other.guardCancel = 2; // hit head:
else if ((other.x - x) * image_xscale > -90 && other.y < y - 40)
    other.guardCancel = 0;
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
