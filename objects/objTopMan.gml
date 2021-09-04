#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();

healthpointsStart = 28;
healthpoints = healthpointsStart;
pose = sprTopPose;
poseImgSpeed = 5 / 60;
contactDamage = 6;
ground = false;
phase = 0; // 0 = shooting; 1 = waiting; 2 = preparing to spin; 3 = spinning in place; 4 = spinning and moving
spinDir = 0;
didShoot = false;
timer = 0;
maxTimer = 40;

// Health Bar
healthBarPrimaryColor[1] = 32;
healthBarSecondaryColor[1] = 40;

// Music
music = "Mega_Man_3.nsf";
musicType = "VGM";
musicTrackNumber = 12;

// Damage Table
enemyDamageValue(objBusterShot, 2);
enemyDamageValue(objBusterShotHalfCharged, 2);
enemyDamageValue(objBusterShotCharged, 4);

// MaGMML3
enemyDamageValue(objSparkChaser, 1);
enemyDamageValue(objLaserTrident, 2);
enemyDamageValue(objWaterShield, 1);
enemyDamageValue(objTornadoBlow, 2);
enemyDamageValue(objThunderBeam, 1);
enemyDamageValue(objBreakDash, 4);
enemyDamageValue(objMagneticShockwave, 1);
enemyDamageValue(objIceWall, 5);

// MaGMML2
enemyDamageValue(objHornetChaser, 1);
enemyDamageValue(objJewelSatellite, 2);
enemyDamageValue(objGrabBuster, 2);
enemyDamageValue(objTripleBlade, 1);
enemyDamageValue(objWheelCutter, 1);
enemyDamageValue(objSlashClaw, 4);
enemyDamageValue(objSakugarne, 2);
enemyDamageValue(objSuperArrow, 2);
enemyDamageValue(objWireAdapter, 1);

// MaGMML1
enemyDamageValue(objMetalBlade, 2);
enemyDamageValue(objGeminiLaser, 0);
enemyDamageValue(objSolarBlaze, 1);
enemyDamageValue(objTopSpin, 4);
enemyDamageValue(objThunderWool, 2);
enemyDamageValue(objPharaohShot, 1);
enemyDamageValue(objBlackHoleBomb, 1);
enemyDamageValue(objMagicCard, 5);

// MaG48MML
enemyDamageValue(objFlameMixer, 1);
enemyDamageValue(objRainFlush, 1);
enemyDamageValue(objSparkShock, 1);
enemyDamageValue(objSearchSnake, 1);
enemyDamageValue(objTenguBlade, 2);
enemyDamageValue(objTenguDash, 4);
enemyDamageValue(objTenguDisk, 2);
enemyDamageValue(objSaltWater, 1);
enemyDamageValue(objConcreteShot, 5);
enemyDamageValue(objHomingSniper, 1);

// MaG48MML
enemyDamageValue(objSuperArmBlockProjectile, 2);
enemyDamageValue(objSuperArmDebris, 2);
enemyDamageValue(objChillShot, 2);
enemyDamageValue(objChillSpikeLanded, 5);

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
event_inherited();
if (entityCanStep())
{
    if (isFight == true)
    {
        switch (phase)
        {
            case 0: // Shooting
                sprite_index = sprTopShoot;
                image_speed = 0.1;
                if (floor(image_index) == 2 && didShoot == false)
                {
                    didShoot = true;
                    var ID;
                    ID = instance_create(x + image_xscale
                        * (-sprite_get_xoffset(sprite_index) + 10),
                        y - sprite_get_yoffset(sprite_index) + 8,
                        objTopmanTop);
                    ID.image_xscale = image_xscale;
                    ID.number = 0;
                    ID = instance_create(x + image_xscale
                        * (-sprite_get_xoffset(sprite_index) + 10),
                        y - sprite_get_yoffset(sprite_index) + 8,
                        objTopmanTop);
                    ID.image_xscale = image_xscale;
                    ID.number = 1;
                    ID = instance_create(x + image_xscale
                        * (-sprite_get_xoffset(sprite_index) + 10),
                        y - sprite_get_yoffset(sprite_index) + 8,
                        objTopmanTop);
                    ID.image_xscale = image_xscale;
                    ID.number = 2;
                }
                else if (image_index >= image_number - image_speed)
                {
                    image_index = 0;
                    sprite_index = sprTopStand;
                    phase = 1;
                    timer = 0;
                    didShoot = false;
                }
                break;
            case 1: // Waiting
                sprite_index = sprTopStand;
                timer += 1;
                if (timer >= 60)
                {
                    timer = 0;
                    phase = 2;
                }
                break;
            case 2: // Preparing to spin
                sprite_index = sprTopPrepareSpin;
                timer += 1;
                if (timer >= 10)
                {
                    timer = 0;

                    // randomize();
                    maxTimer = irandom_range(52, 74);
                    phase = 3;
                    image_index = 0;
                }
                break;
            case 3: // Spinning in place
                sprite_index = sprTopSpin;
                image_speed = 17 / 60;
                timer += 1;
                if (timer >= maxTimer)
                {
                    timer = 0;
                    phase = 4;
                }
                break;
            case 4: // Spinning and moving
                sprite_index = sprTopSpin;
                image_speed = 17 / 60;
                if (spinDir == 0)
                {
                    xspeed = image_xscale * 4.5;
                    spinDir = image_xscale;
                }
                else
                {
                    xspeed = spinDir * 4.5;
                }
                if ((bbox_left <= view_xview + 32 && /* image_xscale */ spinDir == -1)
                    || (bbox_right >= view_xview + view_wview - 32 && /* image_xscale */ spinDir == 1)
                    || (checkSolid(/* image_xscale */ spinDir * 16, 0) || (xcoll * spinDir > 0)))
                {
                    xspeed = 0;
                    x = round(x);

                    // image_xscale *= -1;
                    calibrateDirection();
                    spinDir *= -1;
                    sprite_index = sprTopStand;
                    phase = 0;
                }
                break;
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
with (objTopmanTop)
    instance_destroy();
event_inherited();
#define Other_21
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
// guard if spinning
if (sprite_index == sprTopSpin)
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
