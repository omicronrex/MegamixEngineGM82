#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();

respawn = false;
healthpointsStart = 4;
healthpoints = healthpointsStart;
contactDamage = 4;

killOverride = false;

// Enemy specific code
xspeed = 0;
yspeed = 0;
grav = 0;
blockCollision = 0;
attackTimer = 0;
image_speed = 0;
image_index = 0;
calibrateDirection();
spd = 2;
shell = false;

// Damage Table
enemyDamageValue(objBusterShot, 1);
enemyDamageValue(objBusterShotHalfCharged, 1);
enemyDamageValue(objBusterShotCharged, 3);

// MaGMML3
enemyDamageValue(objSparkChaser, 3);
enemyDamageValue(objLaserTrident, 2);
enemyDamageValue(objWaterShield, 1);
enemyDamageValue(objTornadoBlow, 3);
enemyDamageValue(objThunderBeam, 2);
enemyDamageValue(objBreakDash, 3);
enemyDamageValue(objMagneticShockwave, 1);
enemyDamageValue(objIceWall, 1);

// MaGMML2
enemyDamageValue(objHornetChaser, 1);
enemyDamageValue(objJewelSatellite, 2);
enemyDamageValue(objGrabBuster, 1);
enemyDamageValue(objTripleBlade, 3);
enemyDamageValue(objWheelCutter, 2);
enemyDamageValue(objSlashClaw, 2);
enemyDamageValue(objSakugarne, 1);
enemyDamageValue(objSuperArrow, 2);
enemyDamageValue(objWireAdapter, 1);

// MaGMML1
enemyDamageValue(objMetalBlade, 1);
enemyDamageValue(objGeminiLaser, 1);
enemyDamageValue(objSolarBlaze, 1);
enemyDamageValue(objTopSpin, 3);
enemyDamageValue(objThunderWool, 2);
enemyDamageValue(objPharaohShot, 1);
enemyDamageValue(objBlackHoleBomb, 2);
enemyDamageValue(objMagicCard, 2);

// MaG48MML
enemyDamageValue(objFlameMixer, 1);
enemyDamageValue(objRainFlush, 1);
enemyDamageValue(objSparkShock, 0);
enemyDamageValue(objSearchSnake, 3);
enemyDamageValue(objTenguBlade, 2);
enemyDamageValue(objTenguDash, 3);
enemyDamageValue(objTenguDisk, 2);
enemyDamageValue(objSaltWater, 1);
enemyDamageValue(objConcreteShot, 3);
enemyDamageValue(objHomingSniper, 1);

// MaG48MML
enemyDamageValue(objSuperArmBlockProjectile, 2);
enemyDamageValue(objSuperArmDebris, 2);
enemyDamageValue(objChillShot, 1);
enemyDamageValue(objChillSpikeLanded, 1);

// Misc.
enemyDamageValue(objPowerStone, 1);
enemyDamageValue(objPlantBarrier, 1);
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
    if (attackTimer < 48)
        attackTimer += 1;
    if (attackTimer == 48)
    {
        attackTimer = 49;
        with (instance_create(x, y, objKamegoroShell))
            image_xscale = other.image_xscale;
        shell = true;
    }
    if (xspeed == 0 && yspeed == 0)
    {
        xspeed = spd * image_xscale;
        yspeed = spd * 0.5;
    }
    if (yspeed > 0)
        image_index = 0 + (shell * 2);
    else
        image_index = 1 + (shell * 2);
    if (place_meeting(x + xspeed, y, objSolid))
    {
        xspeed *= -1;
        image_xscale = sign(xspeed);
        x += xspeed;
    }
    if (place_meeting(x, y + yspeed, objSolid))
    {
        yspeed *= -1;
        y += yspeed;
    }
    if (y <= view_yview - 8 && yspeed < 0)
        y = view_yview - 8;
    if (!place_meeting(x, y - 8, objWater))
        grav = 0.45;
    else if (yspeed > 0)
    {
        grav = 0;
        yspeed = spd * 0.5;
    }
}
else if (dead)
{
    calibrateDirection();
    xspeed = 0;
    yspeed = 0;
    image_index = 0;
}
#define Other_20
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
instance_create(x, y, objExplosion);
with (objKamegoroMaker)
    healthpoints -= (shotsFired * 2);
instance_destroy();
