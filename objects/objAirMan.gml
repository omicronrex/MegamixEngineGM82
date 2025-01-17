#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();

healthpointsStart = 28;
healthpoints = healthpointsStart;
contactDamage = 6;

pose = sprAirIntro;
poseImgSpeed = 15/60; //0.5;
sprite_index = sprAirJump;

grav = 0.25;

ground = false;
attackTimer = 0;
throwTimer = 0;
jumpTimer = 0;
jumpAmount = 0;
canInitShoot = true;
phase = 0; // 0 = nothing; 1 = running; 2 = jumping; 3 = shooting;
getLastXspeed = xspeed;
getLastYspeed = yspeed;
getX = 0;
flashTimer = 0;
bladeThrow = 5;
timesFired = 0;

maxBlowSpeed = 4;

// Health Bar
healthBarPrimaryColor[1] = 15;
healthBarSecondaryColor[1] = 34;

// Music
music = "Mega_Man_2.nsf";
musicType = "VGM";
musicTrackNumber = 17;

// Damage Table
enemyDamageValue(objBusterShot, 2);
enemyDamageValue(objBusterShotHalfCharged, 2);
enemyDamageValue(objBusterShotCharged, 4);

// MaGMML3
enemyDamageValue(objSparkChaser, 4);
enemyDamageValue(objLaserTrident, 2);
enemyDamageValue(objWaterShield, 0);
enemyDamageValue(objTornadoBlow, 0);
enemyDamageValue(objThunderBeam, 2);
enemyDamageValue(objBreakDash, 1);
enemyDamageValue(objMagneticShockwave, 2);
enemyDamageValue(objIceWall, 1);

// MaGMML2
enemyDamageValue(objHornetChaser, 0);
enemyDamageValue(objJewelSatellite, 5);
enemyDamageValue(objGrabBuster, 2);
enemyDamageValue(objTripleBlade, 0);
enemyDamageValue(objWheelCutter, 0);
enemyDamageValue(objSlashClaw, 0);
enemyDamageValue(objSakugarne, 2);
enemyDamageValue(objSuperArrow, 0);
enemyDamageValue(objWireAdapter, 2);

// MaGMML1
enemyDamageValue(objMetalBlade, 0);
enemyDamageValue(objGeminiLaser, 2);
enemyDamageValue(objSolarBlaze, 2);
enemyDamageValue(objTopSpin, 1);
enemyDamageValue(objThunderWool, 4);
enemyDamageValue(objPharaohShot, 1);
enemyDamageValue(objBlackHoleBomb, 2);
enemyDamageValue(objMagicCard, 0);

// MaG48MML
enemyDamageValue(objFlameMixer, 2);
enemyDamageValue(objRainFlush, 1);
enemyDamageValue(objSparkShock, 4);
enemyDamageValue(objSearchSnake, 2);
enemyDamageValue(objTenguBlade, 0);
enemyDamageValue(objTenguDash, 2);
enemyDamageValue(objTenguDisk, 0);
enemyDamageValue(objSaltWater, 2);
enemyDamageValue(objConcreteShot, 2);
enemyDamageValue(objHomingSniper, 0);

// MaG24HMML
enemyDamageValue(objSuperArmBlockProjectile, 4);
enemyDamageValue(objSuperArmDebris, 4);
enemyDamageValue(objChillShot, 1);
enemyDamageValue(objChillSpikeLanded, 2);

// Misc.
enemyDamageValue(objPowerStone, 2);
enemyDamageValue(objPlantBarrier, 6);
enemyDamageValue(objBrickWeapon, 4);
enemyDamageValue(objIceSlasher, 2);

// AirShooter Patterns
lastShot0 = -1;
lastShot1 = -1;
airShoot[0] = ds_grid_create(18, 16);
airShoot[1] = ds_grid_create(18, 16);
airShoot[2] = ds_grid_create(18, 16);
airShoot[3] = ds_grid_create(18, 16);

ds_grid_add(airShoot[0], (2.5) * 2, (2) * 2, 1);
ds_grid_add(airShoot[0], (5.5) * 2, (3.5) * 2, 1);
ds_grid_add(airShoot[0], (2) * 2, (5) * 2, 1);
ds_grid_add(airShoot[0], (6.5) * 2, (5.5) * 2, 1);
ds_grid_add(airShoot[0], (3.5) * 2, (7) * 2, 1);
ds_grid_add(airShoot[0], (8.5) * 2, (7) * 2, 1);

ds_grid_add(airShoot[1], (5) * 2, (0.5) * 2, 1);
ds_grid_add(airShoot[1], (1) * 2, (2.5) * 2, 1);
ds_grid_add(airShoot[1], (7.5) * 2, (3) * 2, 1);
ds_grid_add(airShoot[1], (0) * 2, (5) * 2, 1);
ds_grid_add(airShoot[1], (2.5) * 2, (5.5) * 2, 1);
ds_grid_add(airShoot[1], (5.5) * 2, (7.5) * 2, 1);

ds_grid_add(airShoot[2], (2) * 2, (1) * 2, 1);
ds_grid_add(airShoot[2], (8.5) * 2, (2) * 2, 1);
ds_grid_add(airShoot[2], (6) * 2, (3) * 2, 1);
ds_grid_add(airShoot[2], (1) * 2, (4.5) * 2, 1);
ds_grid_add(airShoot[2], (6.5) * 2, (5.5) * 2, 1);
ds_grid_add(airShoot[2], (3) * 2, (7.5) * 2, 1);


ds_grid_add(airShoot[3], (6.5) * 2, (3.5) * 2, 1);
ds_grid_add(airShoot[3], (1) * 2, (5) * 2, 1);
ds_grid_add(airShoot[3], (1.5) * 2, (6) * 2, 1);
ds_grid_add(airShoot[3], (4.5) * 2, (5.5) * 2, 1);
ds_grid_add(airShoot[3], (8) * 2, (6) * 2, 1);
ds_grid_add(airShoot[3], (5.5) * 2, (8) * 2, 1);
#define Destroy_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
ds_grid_destroy(airShoot[0]);
ds_grid_destroy(airShoot[1]);
ds_grid_destroy(airShoot[2]);
ds_grid_destroy(airShoot[3]);
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
            case 0: // Idle
                if (getX == 0)
                    getX = abs(x - (view_xview + view_wview / 2));
                attackTimer += 1;
                xspeed = 0;
                if (attackTimer >= 120)
                    attackTimer = 0;
                if (attackTimer == 1)
                {
                    if (timesFired < 3)
                    {
                        playSFX(sfxAirShooter);
                        timesFired += 1;
                        var shootPattern;
                        do
                        {
                            shootPattern = choose(0, 1, 2);
                        }
                            until (shootPattern != lastShot0 && shootPattern != lastShot1)
                        if (lastShot0 == -1)
                            lastShot0 = shootPattern;
                        else if (lastShot1 == -1)
                            lastShot1 = shootPattern;
                        for (i = 0; i < ds_grid_width(airShoot[shootPattern]); i += 1)
                            for (j = 0; j < ds_grid_height(airShoot[shootPattern]); j += 1)
                                if (ds_grid_get(airShoot[shootPattern], i, j) == 1)
                                {
                                    ID = instance_create((round(x / 16) * 16) + 8 + ((i / 2) * 16 * image_xscale), ((round(y / 16) * 16) + 8) - (8 * 16) + (j / 2) * 16, objAirManGust);
                                    ID.image_xscale = image_xscale;
                                }
                    }
                    else
                    {
                        yspeed = -6;
                        xspeed = arcCalcXspeed(yspeed, grav, x, y, view_xview + view_wview / 2, y);
                        phase = 1;
                        lastShot1 = -1;
                        lastShot2 = -1;
                    }
                }

                // blowing
                if (attackTimer < 60)
                    sprite_index = sprAirShoot;
                else
                {
                    with (objMegaman)
                        playerBlow((min(other.attackTimer - 60, other.maxBlowSpeed*20) * other.image_xscale)/15);
                    sprite_index = sprAirBlow;
                    image_index += 0.3;
                }
                break;



            case 1: // Jumping
                sprite_index = sprAirJump;
                if (ground)
                {
                    if (x >= (view_xview + view_wview / 2) - 16
                        && x <= (view_xview + view_wview / 2) + 16)
                    {
                        yspeed = -7;
                        xspeed = arcCalcXspeed(yspeed, grav, x, y, (view_xview + view_wview / 2) + getX * image_xscale, y);
                        phase = 1;
                    }
                    else
                    {
                        timesFired = 0;
                        phase = 0;
                        attackTimer = 0;
                    }
                }
                break;
        }

        // Face the player
        if (ground)
        {
            if (x >= (view_xview + view_wview / 2) + 16)
                image_xscale = -1;
            else if (x <= (view_xview + view_wview / 2) - 16)
                image_xscale = 1;
        }
    }
}
else
{
    image_speed = 0;
}
#define Other_5
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
ds_grid_destroy(airShoot[0]);
ds_grid_destroy(airShoot[1]);
ds_grid_destroy(airShoot[2]);
ds_grid_destroy(airShoot[3]);
#define Other_23
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();
specialDamageValue(objPharaohShot, max(2, floor(global.damage / 3)));
