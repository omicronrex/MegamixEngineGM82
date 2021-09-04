#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();

healthpointsStart = 28;
healthpoints = healthpointsStart;
pose = sprBlizzardManPose;
poseImgSpeed = 0.5;
contactDamage = 3;
ground = false;
phase = 0; // 0 = nothing; 1 = skiing; 2 = Blizzard Attack; 3 = snowball
phasetime = 0;
skitime = -1;
charging = 0;

// Health Bar
healthBarPrimaryColor[1] = 38;
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
enemyDamageValue(objSparkChaser, 1);
enemyDamageValue(objLaserTrident, 4);
enemyDamageValue(objWaterShield, 1);
enemyDamageValue(objTornadoBlow, 1);
enemyDamageValue(objThunderBeam, 2);
enemyDamageValue(objBreakDash, 2);
enemyDamageValue(objMagneticShockwave, 1);
enemyDamageValue(objIceWall, 0);

// MaGMML2
enemyDamageValue(objHornetChaser, 1);
enemyDamageValue(objJewelSatellite, 2);
enemyDamageValue(objGrabBuster, 4);
enemyDamageValue(objTripleBlade, 2);
enemyDamageValue(objSlashClaw, 2);
enemyDamageValue(objWheelCutter, 1);
enemyDamageValue(objSakugarne, 2);
enemyDamageValue(objSuperArrow, 1);
enemyDamageValue(objWireAdapter, 1);

// MaGMML1
enemyDamageValue(objMetalBlade, 1);
enemyDamageValue(objGeminiLaser, 2);
enemyDamageValue(objSolarBlaze, 4);
enemyDamageValue(objTopSpin, 1);
enemyDamageValue(objThunderWool, 1);
enemyDamageValue(objPharaohShot, 3);
enemyDamageValue(objBlackHoleBomb, 2);
enemyDamageValue(objMagicCard, 1);

// MaG48HMML
enemyDamageValue(objFlameMixer, 5);
enemyDamageValue(objRainFlush, 3);
enemyDamageValue(objSparkShock, 1);
enemyDamageValue(objSearchSnake, 2);
enemyDamageValue(objTenguBlade, 1);
enemyDamageValue(objTenguDash, 2);
enemyDamageValue(objTenguDisk, 1);
enemyDamageValue(objSaltWater, 3);
enemyDamageValue(objConcreteShot, 2);
enemyDamageValue(objHomingSniper, 1);

// MaG24HMML
enemyDamageValue(objSuperArmBlockProjectile, 1);
enemyDamageValue(objSuperArmDebris, 1);
enemyDamageValue(objChillShot, 0);
enemyDamageValue(objChillSpikeLanded, 0);

// Misc.
enemyDamageValue(objPowerStone, 1);
enemyDamageValue(objPlantBarrier, 1);
enemyDamageValue(objBrickWeapon, 1);
enemyDamageValue(objIceSlasher, 0);
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
        sprite_index = sprBlizzardMan;
        phasetime += 1;
        switch (phase)
        {
            case 0: // Nothing
            // Face the player
                calibrateDirection();
                image_index = 0;
                xspeed = 0;
                charging = 0;
                reflectProjectiles = false;
                if (phasetime >= 12)
                {
                    phasetime = 0;
                    var r;
                    r = irandom_range(0, 6);
                    if (r == 6)
                    {
                        phase = 1;
                    }
                    else if (r > 2)
                    {
                        phase = 2;
                    }
                    else
                    {
                        phase = 3;
                    }
                }
                break;
            case 1: // Ski forward
                if (phasetime == 1)
                {
                    phasetime = irandom_range(1, 33);
                }
                skitime += 1;
                if (skitime <= 10)
                {
                    image_index = 1;
                }
                else if (skitime > 10 && skitime < 28)
                {
                    image_index = 2;
                    xspeed = 1.5 * image_xscale;
                    if (skitime == 12)
                    {
                        ID = instance_create(x - (24 * image_xscale), y + 13,
                            objSlideDust);
                        ID.image_xscale = image_xscale;
                    }
                }
                else if (skitime >= 28)
                {
                    skitime = 0;
                }
                if (phasetime >= 56)
                {
                    skitime = 0;
                    phasetime = 0;
                    phase = 0;
                    xspeed = 0;
                }
                break;
            case 2: // Blizzard Attack
                if (phasetime <= 5)
                    image_index = 1;
                else if (phasetime == 6)
                    image_index = 2;
                else if (phasetime == 22)
                    image_index = 1;
                else if (phasetime == 26)
                    image_index = 3;
                else if (phasetime == 30)
                {
                    image_xscale *= -1;
                    image_index = 1;
                    phasetime = 2;
                }
                if (phasetime == 1)
                {
                    playSFX(sfxBlizzardAttack);
                    var r;
                    r = irandom(2);
                    switch (r)
                    {
                        case 0:
                            instance_create(view_xview[0] + 39,
                                view_yview[0] + 121, objBlizzardAttack);
                            instance_create(view_xview[0] + 151,
                                view_yview[0] + 137, objBlizzardAttack);
                            instance_create(view_xview[0] + 87,
                                view_yview[0] + 57, objBlizzardAttack);
                            instance_create(view_xview[0] + 199,
                                view_yview[0] + 73, objBlizzardAttack);
                            break;
                        case 1:
                            instance_create(view_xview[0] + 119,
                                view_yview[0] + 141, objBlizzardAttack);
                            instance_create(view_xview[0] + 151,
                                view_yview[0] + 117, objBlizzardAttack);
                            instance_create(view_xview[0] + 93,
                                view_yview[0] + 85, objBlizzardAttack);
                            instance_create(view_xview[0] + 45,
                                view_yview[0] + 67, objBlizzardAttack);
                            break;
                        case 2:
                            instance_create(view_xview[0] + 216,
                                view_yview[0] + 145, objBlizzardAttack);
                            instance_create(view_xview[0] + 63,
                                view_yview[0] + 137, objBlizzardAttack);
                            instance_create(view_xview[0] + 127,
                                view_yview[0] + 121, objBlizzardAttack);
                            instance_create(view_xview[0] + 119,
                                view_yview[0] + 49, objBlizzardAttack);
                            break;
                    }
                }
                else if (!instance_exists(objBlizzardAttack))
                {
                    phasetime = 0;
                    phase = 0;
                }
                break;
            case 3: // Snowball
                if (phasetime <= 10)
                {
                    image_index = 1;
                }
                else
                {
                    if (!ground)
                    {
                        yspeed -= 0.075;
                    }
                    reflectProjectiles = true;
                    image_index += 0.5;
                    if (phasetime == 11)
                    {
                        image_index = 5;
                        yspeed = -2.875;
                        ground = false;
                    }
                    if (ground && phasetime > 11)
                    {
                        switch (charging)
                        {
                            case 0:
                                xspeed = image_xscale * 4;
                                playSFX(sfxBlizzardCharge);
                                break;
                            case 2:
                                xspeed = 0;
                                yspeed = -2.875;
                                break;
                            case 3:
                                phase = 0;
                                phasetime = 0;
                                break;
                        }
                        if (charging != 1)
                        {
                            charging += 1;
                        }
                    }
                    if (checkSolid(xspeed * 2, 0, 0, 1)
                        && charging == 1)
                    {
                        ground = false;
                        charging = 2;
                        image_xscale *= -1;
                        xspeed *= -0.4;
                        yspeed = -3.25;
                        audio_stop_sound(sfxBlizzardCharge);
                        playSFX(sfxBlizzardSlam);
                    }
                    if (image_index >= 9)
                    {
                        image_index -= 4;
                    }
                }
                break;
        }
    }
}
else
{
    image_speed = 0;
    if (charging == 1)
        sound_stop(sfxBlizzardCharge);
}
#define Other_20
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
with (objBlizzardAttack)
    instance_destroy();
event_inherited();
#define Other_21
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();

// guard if rolling in a ball and making that cool BWOODAWOODAWOODAWOODA sound
if (image_index >= 5)
{
    other.guardCancel = 1;
}

if (other.object_index == objPharaohShot)
{
    with (objPharaohShot)
    {
        if (sprite_index = sprPharaohShotCharged)
        {
            extraDamage = 3;
        }
    }
}
