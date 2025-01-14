#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
//Health sharing in Room Start
event_inherited();
event_perform_object(prtRail, ev_create, 0);

numberOfRounder = 1;
hitInvun = 1;
introType = 2;

totalHealth = 28;
healthpointsStart = 28
healthpoints = 28;
pose = sprRounderV2;
poseImgSpeed = 4 / 60;
contactDamage = 4;
attackTimer = 0;
attackTimerMax = 110;
shotsFired = 0;
phase = 0;
delay = 0;
hasFired = false;
startingDirection = -1;
mySpeed = 0.5;
grav = 0;
blockCollision = 0;
init = 1;
dir = "none"; // left, up, down, right
startDir = dir;

// distance from the x and y position to check by
xOffset = 0;
yOffset = -8;
fallMomentum = 0.25;

// Health Bar
healthBarPrimaryColor[1] = 29;
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
enemyDamageValue(objTornadoBlow, 1);
enemyDamageValue(objThunderBeam, 2);
enemyDamageValue(objBreakDash, 1);
enemyDamageValue(objMagneticShockwave, 2);
enemyDamageValue(objIceWall, 3);

// MaGMML2
enemyDamageValue(objHornetChaser, 2);
enemyDamageValue(objJewelSatellite, 4);
enemyDamageValue(objGrabBuster, 1);
enemyDamageValue(objTripleBlade, 2);
enemyDamageValue(objWheelCutter, 1);
enemyDamageValue(objSlashClaw, 1);
enemyDamageValue(objSakugarne, 2);
enemyDamageValue(objSuperArrow, 1);
enemyDamageValue(objWireAdapter, 2);

// MaGMML1
enemyDamageValue(objMetalBlade, 2);
enemyDamageValue(objGeminiLaser, 1);
enemyDamageValue(objSolarBlaze, 4);
enemyDamageValue(objTopSpin, 1);
enemyDamageValue(objThunderWool, 2);
enemyDamageValue(objPharaohShot, 2);
enemyDamageValue(objBlackHoleBomb, 1);
enemyDamageValue(objMagicCard, 2);

// MaG48HMML
enemyDamageValue(objFlameMixer, 4);
enemyDamageValue(objRainFlush, 1);
enemyDamageValue(objSparkShock, 1);
enemyDamageValue(objSearchSnake, 1);
enemyDamageValue(objTenguBlade, 1);
enemyDamageValue(objTenguDash, 2);
enemyDamageValue(objTenguDisk, 2);
enemyDamageValue(objSaltWater, 1);
enemyDamageValue(objConcreteShot, 2);
enemyDamageValue(objHomingSniper, 2);

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
        // this sets up crash man's movement variables.
        image_speed = 0;
        event_perform_object(prtRailPlatform, ev_step, 0);
        attackTimer += 1;

        // rounder has no different patterns other than to move around the rail. here are all of its events!
        if (attackTimer mod attackTimerMax < attackTimerMax - 15)
            image_index = 0 + ((attackTimer / 5) mod 2);
        if (attackTimer mod attackTimerMax == attackTimerMax - 15 || attackTimer mod attackTimerMax == attackTimerMax - 5)
            image_index = 2;
        if (attackTimer mod attackTimerMax == attackTimerMax - 10)
        {
            image_index = 3;

            // alternating behavior on difficulty modes
            if (global.difficulty == DIFF_HARD)
            {
                instance_create(x, y, choose(objFireTellyShot, objRounderV2Bomb));

                if (shotsFired mod 3 == 0 && shotsFired != 0) // every fourth shot after switching directions
                {
                    i = instance_create(x, y, objDachoneBullet);
                    with (i)
                    {
                        contactDamage = 2;
                        image_index = 2;
                        xspeed = 2;
                        yspeed = 2;
                    }
                    i = instance_create(x, y, objDachoneBullet);
                    with (i)
                    {
                        contactDamage = 2;
                        image_xscale = -1;
                        image_index = 2;
                        xspeed = 2;
                        yspeed = -2;
                    }
                    i = instance_create(x, y, objDachoneBullet);
                    with (i)
                    {
                        contactDamage = 2;
                        image_index = 2;
                        xspeed = -2;
                        yspeed = -2;
                    }
                    i = instance_create(x, y, objDachoneBullet);
                    with (i)
                    {
                        contactDamage = 2;
                        image_xscale = -1;
                        image_index = 2;
                        xspeed = -2;
                        yspeed = 2;
                    }

                    playSFX(sfxDachoneLaser);
                }
            }
            else
            {
                instance_create(x, y, objRounderV2Bomb);
            }

            shotsFired += 1;
        }
        if (shotsFired == 6) // after 6 shots turn around.
        {
            shotsFired = 0;
            if (dir == "left")
            {
                dir = "right";
            }
            if (dir == "right")
            {
                dir = "left";
            }
            if (dir == "up")
            {
                dir = "down";
            }
            if (dir == "down")
            {
                dir = "up";
            }
        }
    }
}
else
{ }
#define Other_4
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if(healthParent!=-1)
    exit;
var parent; parent = instance_find(objRounderV2, 0);
with (objRounderV2)
{
    healthParent = parent.id;
    numberOfRounder = instance_number(objRounderV2);
    healthpoints = ceil(totalHealth / numberOfRounder);
    healthpointsStart = healthpoints;
    shareMode=1;
    var i;
    for (i = 0; i < instance_number(objRounderV2); i += 1)
    {
        rounder[i] = instance_find(objRounderV2, i);
    }
}
parent.healthParent=-1;
#define Other_10
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_perform_object(prtRailPlatform, ev_other, ev_user0);
#define Other_20
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
with (objHarmfulExplosion)
    instance_destroy();
with (objRounderV2Bomb)
    instance_destroy();
event_inherited();
#define Other_21
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();

// if not hitting in the center, reflect
if (!collision_rectangle(x - 16, y - 12,
    x + 16, y - 8, other.id, false, false))
{
    other.guardCancel = 3;
}
#define Draw_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
var hl; hl = healthpoints;
healthpoints = totalHealth;
event_inherited();
healthpoints = hl;
