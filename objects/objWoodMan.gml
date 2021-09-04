#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();

healthpointsStart = 28;
healthpoints = healthpointsStart;
pose = sprWoodIntro;
poseImgSpeed = 7 / 60;
image_index = 6;
contactDamage = 4;
attackTimer = 0;
phase = 0;
phaseShieldTimer = 90;
shield = 0;
leafTimer = 0;
phaseShieldTimerStart = phaseShieldTimer;

_im = 0; // required for animationLoop()
stopOnFlash = true;
category = "nature";

// Health Bar
healthBarPrimaryColor[1] = 20;
healthBarSecondaryColor[1] = 46;

// Music
music = "Mega_Man_2.nsf";
musicType = "VGM";
musicTrackNumber = 17;

// Damage Table
enemyDamageValue(objBusterShot, 1);
enemyDamageValue(objBusterShotHalfCharged, 1);
enemyDamageValue(objBusterShotCharged, 3);

// MaGMML3
enemyDamageValue(objSparkChaser, 1);
enemyDamageValue(objLaserTrident, 2);
enemyDamageValue(objWaterShield, 0);
enemyDamageValue(objTornadoBlow, 7);
enemyDamageValue(objThunderBeam, 1);
enemyDamageValue(objBreakDash, 1);
enemyDamageValue(objMagneticShockwave, 0);
enemyDamageValue(objIceWall, 4);

// MaGMML2
enemyDamageValue(objHornetChaser, 1);
enemyDamageValue(objJewelSatellite, 2);
enemyDamageValue(objGrabBuster, 0);
enemyDamageValue(objTripleBlade, 6);
enemyDamageValue(objWheelCutter, 3);
enemyDamageValue(objSlashClaw, 3);
enemyDamageValue(objSakugarne, 3);
enemyDamageValue(objSuperArrow, 2);
enemyDamageValue(objWireAdapter, 2);

// MaGMML1
enemyDamageValue(objMetalBlade, 2);
enemyDamageValue(objGeminiLaser, 1);
enemyDamageValue(objSolarBlaze, 6);
enemyDamageValue(objTopSpin, 1);
enemyDamageValue(objThunderWool, 1);
enemyDamageValue(objPharaohShot, 2);
enemyDamageValue(objBlackHoleBomb, 2);
enemyDamageValue(objMagicCard, 1);

// MaG48HMML
enemyDamageValue(objFlameMixer, 6);
enemyDamageValue(objRainFlush, 2);
enemyDamageValue(objSparkShock, 1);
enemyDamageValue(objSearchSnake, 2);
enemyDamageValue(objTenguBlade, 3);
enemyDamageValue(objTenguDash, 3);
enemyDamageValue(objTenguDisk, 3);
enemyDamageValue(objSaltWater, 0);
enemyDamageValue(objConcreteShot, 2);
enemyDamageValue(objHomingSniper, 2);

// MaG24HMML
enemyDamageValue(objSuperArmBlockProjectile, 1);
enemyDamageValue(objSuperArmDebris, 1);
enemyDamageValue(objChillShot, 2);
enemyDamageValue(objChillSpikeLanded, 4);

// Misc.
enemyDamageValue(objPowerStone, 1);
enemyDamageValue(objPlantBarrier, 0);
enemyDamageValue(objBrickWeapon, 1);
enemyDamageValue(objIceSlasher, 4);
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
// leave this. this is needed, but don't use this as an example, this code is pretty weird.
event_inherited();
if (entityCanStep())
{
    if (isFight == true)
    {
        // phase code
        switch (phase)
        {
            case 0: // wait
                sprite_index = sprWoodMan;
                if (ground)
                {
                    image_index = 0;
                }
                else
                {
                    image_index = 6;
                }
                xspeed = 0;
                if (ground)
                {
                    phase = 1;
                }
                break;
            case 1: // shield
                phaseShieldTimer -= 1;
                if (phaseShieldTimer > 0)
                {
                    calibrateDirection();
                    leafTimer -= 1;
                    if (!shield)
                    {
                        var i;
                        for (i = 0; i < 8; i += 1)
                        {
                            shield = instance_create(x, y, objWoodLeafShield);
                            shield.image_xscale = image_xscale;
                            shield.direction = i * 45;
                            shield.despawnRange = -1;
                            with (shield)
                            {
                                if (direction / 90 != floor(direction / 90))
                                {
                                    visible = false;
                                }
                            }
                        }
                    }
                    animationLoop(1, 2, poseImgSpeed);
                    if (leafTimer <= 0)
                    {
                        instance_create(x, y - 16, objWoodRisingLeaves);
                        leafTimer = 30;
                    }
                }
                if (phaseShieldTimer <= 0)
                {
                    phaseShieldTimer = phaseShieldTimerStart;
                    phase = 2;
                    leafTimer = 15; // reusing this variable for the shield throw
                }
                break;
            case 2: // shield throw + leaves
                if (true)
                {
                    if (leafTimer > 0)
                    {
                        image_index = 3;
                        leafTimer -= 1;
                    }
                    else if (leafTimer <= 0)
                    {
                        image_index = 4;
                        if instance_exists(objWoodLeafShield)
                        {
                            objWoodLeafShield.xspeed = 3.5 * image_xscale;
                            objWoodLeafShield.yspeed = 0;
                            objWoodLeafShield.followWood = false;
                            objWoodLeafShield.despawnRange = 4;
                        }
                        for (i = 1; i < 5; i += 1)
                        {
                            if (image_xscale < 0)
                            {
                                instance_create(view_xview[0] + 48 * i, view_yview[0] + 16, objWoodFallingLeaves);
                            }
                            else
                            {
                                instance_create(view_xview[0] + view_wview[0] - 48 * i, view_yview[0] + 16, objWoodFallingLeaves);
                            }
                        }
                        phase = 3;
                        leafTimer = 15; // reusing this again
                        shield = 0;
                    }
                }
                break;
            case 3: // jump preparation
                if (image_index == 4)
                {
                    leafTimer -= 1;
                    if (leafTimer <= 0)
                    {
                        leafTimer = 8; // reusing this again
                        image_index = 0;
                    }
                }
                else if (image_index == 0)
                {
                    leafTimer -= 1;
                    if (leafTimer <= 0)
                    {
                        leafTimer = 8; // reusing this again
                        image_index = 5;
                    }
                }
                else if (image_index == 5)
                {
                    leafTimer -= 1;
                    if (leafTimer <= 0)
                    {
                        sprite_index = sprWoodMan; // not sure as to why but this needs to be here
                        image_index = 6;
                        yspeed = -5;
                        xspeed = 1 * image_xscale;
                        leafTimer = 0;
                    }
                }
                else if (image_index == 6)
                {
                    if (ground)
                    {
                        sprite_index = sprWoodMan;
                        image_index = 0;
                        xspeed = 0;
                        yspeed = 0;
                        phase = 4
                    }
                }
                break;
            // Wait for next phase
            case 4:
                if (image_index == 0)
                {
                    if (!instance_exists(objWoodFallingLeaves) && !instance_exists(objWoodLeafShield))
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
with (objWoodFallingLeaves)
{
    instance_create(x, y, objExplosion);
    instance_destroy();
}
with (objWoodRisingLeaves)
{
    instance_create(x, y, objExplosion);
    instance_destroy();
}
with (objWoodLeafShield)
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
