#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
// This Hunter bounces off walls and spawns weaker, slower copies of itself.
event_inherited();

healthpointsStart = 28;
healthpoints = healthpointsStart;
pose = sprHunterA;
poseImgSpeed = 4 / 60;
contactDamage = 4;
ground = false;
attackTimer = 0;

introType = 2;

// grav = 0;
phase = 0;
spd = 2;
delay = 0;
hasFired = false;
getAngle = 0;
storeY = -1;

// Health Bar
healthBarPrimaryColor[1] = 18;
healthBarSecondaryColor[1] = 45;

// Music
music = "Mega_Man_4GB.gbs";
musicType = "VGM";
musicTrackNumber = 20;

// Damage Table
enemyDamageValue(objBusterShot, 1);
enemyDamageValue(objBusterShotHalfCharged, 1);
enemyDamageValue(objBusterShotCharged, 3);

// MaGMML3
enemyDamageValue(objSparkChaser, 2);
enemyDamageValue(objLaserTrident, 2);
enemyDamageValue(objWaterShield, 2);
enemyDamageValue(objTornadoBlow, 1);
enemyDamageValue(objThunderBeam, 4);
enemyDamageValue(objBreakDash, 1);
enemyDamageValue(objMagneticShockwave, 2);
enemyDamageValue(objIceWall, 1);

// MaGMML2
enemyDamageValue(objHornetChaser, 4);
enemyDamageValue(objJewelSatellite, 1);
enemyDamageValue(objGrabBuster, 2);
enemyDamageValue(objTripleBlade, 2);
enemyDamageValue(objWheelCutter, 1);
enemyDamageValue(objSlashClaw, 1);
enemyDamageValue(objSakugarne, 2);
enemyDamageValue(objSuperArrow, 2);
enemyDamageValue(objWireAdapter, 2);

// MaGMML1
enemyDamageValue(objMetalBlade, 2);
enemyDamageValue(objGeminiLaser, 2);
enemyDamageValue(objSolarBlaze, 1);
enemyDamageValue(objTopSpin, 5);
enemyDamageValue(objThunderWool, 1);
enemyDamageValue(objPharaohShot, 2);
enemyDamageValue(objBlackHoleBomb, 1);
enemyDamageValue(objMagicCard, 2);

// MaG48HMML
enemyDamageValue(objFlameMixer, 2);
enemyDamageValue(objRainFlush, 2);
enemyDamageValue(objSparkShock, 1);
enemyDamageValue(objSearchSnake, 1);
enemyDamageValue(objTenguBlade, 2);
enemyDamageValue(objTenguDash, 2);
enemyDamageValue(objTenguDisk, 2);
enemyDamageValue(objSaltWater, 1);
enemyDamageValue(objConcreteShot, 1);
enemyDamageValue(objHomingSniper, 4);

// MaG24HMML
enemyDamageValue(objSuperArmBlockProjectile, 1);
enemyDamageValue(objSuperArmDebris, 1);
enemyDamageValue(objChillShot, 1);
enemyDamageValue(objChillSpikeLanded, 4);

// Misc.
enemyDamageValue(objPowerStone, 4);
enemyDamageValue(objPlantBarrier, 1);
enemyDamageValue(objBrickWeapon, 2);
enemyDamageValue(objIceSlasher, 1);
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
// leave this. this is needed.
event_inherited();

// all of hunter's events trigger when the game isn't frozen. he isn't weak to flash stopper, so no need to check whether that is used or not!
if (entityCanStep())
{
    if (isIntro)
    {
        with (objHunterPlatform)
        {
            timerN = timerMax;
        }
    }
    if (isFight == true)
    {
        // this sets up hunter's movement variables.
        image_speed = 0;
        attackTimer += 1;
        grav = 0;

        // speed up as hunter looses health
        if ((28 - healthpoints) / 5.6 <= 1)
            spd = 2;
        else if ((28 - healthpoints) / 5.6 >= 3)
            spd = 3.6;
        else
            spd = (28 - healthpoints) / 5.6;
        switch (phase)
        {
            case 0: // start bouncing
                xspeed = spd * image_xscale;
                yspeed = spd * storeY;
                phase = 1;
                break;
            case 1: // whilst bouncing
                image_index = 0 + ((attackTimer / 4) mod 3);
                if (xcoll != 0)
                {
                    xspeed *= -1;
                    image_xscale *= -1;
                }
                if (checkSolid(0, yspeed, 0, 1))
                {
                    y -= yspeed;
                    yspeed *= -1;
                    storeY *= -1;
                }
                with (instance_place(x, y + yspeed, prtEntity))
                {
                    if (isSolid == 1)
                    {
                        with (other)
                        {
                            y -= yspeed;
                            yspeed *= -1;
                            storeY *= -1;
                        }
                    }
                }
                if (abs(xspeed) != spd)
                    xspeed = spd * image_xscale;
                if (abs(yspeed) != spd)
                    yspeed = spd * storeY;
                break;
            case 2: // spawn babies
                if (attackTimer < 24)
                {
                    with (objHunterBaby)
                    {
                        instance_create(x, y - 8, objExplosion);
                        dead = true;
                    }
                }
                xspeed = 0;
                yspeed = 0;
                if (attackTimer mod 4 == 0 && attackTimer < 24) // setup hunter's animation
                    image_index += 1;
                if (attackTimer == 24)
                {
                    if (instance_exists(target))
                        getAngle = point_direction(x, y, target.x, target.y); // find angle between mega man and hunter, fire babies in the opposite direction
                    var inst = instance_create(x, y, objHunterBaby);
                    inst.xspeed = cos(degtorad(getAngle - 180)) * 1.5;
                    inst.yspeed = -sin(degtorad(getAngle - 180)) * 1.5;
                    inst = instance_create(x, y, objHunterBaby);
                    inst.xspeed = cos(degtorad(getAngle - 135)) * 1.5;
                    inst.yspeed = -sin(degtorad(getAngle - 135)) * 1.5;
                    inst = instance_create(x, y, objHunterBaby);
                    inst.xspeed = cos(degtorad(getAngle - 225)) * 1.5;
                    inst.yspeed = -sin(degtorad(getAngle - 225)) * 1.5;
                    with (objHunterBaby)
                    {
                        image_xscale = sign(xspeed);
                        storeY = sign(yspeed);
                    }
                }
                if (attackTimer == 28)
                    image_index = 4;
                if (attackTimer == 32)
                    image_index = 3;
                if (attackTimer >= 36)
                    image_index = 0 + ((attackTimer / 4) mod 3);
                if (attackTimer == 64)
                {
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
with (objHunterBaby)
    instance_destroy();
event_inherited();
#define Other_21
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if (instance_number(objHunterBaby) < 2 && !phase != 2)
{
    attackTimer = 0;
    phase = 2;
}
#define Draw_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
var xsc = image_xscale;
image_xscale = abs(image_xscale);
event_inherited();
image_xscale = xsc;
