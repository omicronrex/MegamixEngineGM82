#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();

healthpointsStart = 28;
healthpoints = healthpointsStart;

pose = sprGravityIntro;
poseImgSpeed = 0.25;
contactDamage = 5; // 4 shots

ground = false;
attackTimer = 0;
fireTimer = 0;
canInitShoot = true;
phase = 0; // 0 = nothing; 1 = running; 2 = jumping; 3 = flipping;
myGrav = 1;

// Health Bar
healthBarPrimaryColor[1] = 18;
healthBarSecondaryColor[1] = 40;

// Music
music = "Mega_Man_5.nsf";
musicType = "VGM";
musicTrackNumber = 10;

// Damage Table
enemyDamageValue(objBusterShot, 1);
enemyDamageValue(objBusterShotHalfCharged, 1);
enemyDamageValue(objBusterShotCharged, 3);

// MaGMML3
enemyDamageValue(objSparkChaser, 2);
enemyDamageValue(objLaserTrident, 2);
enemyDamageValue(objWaterShield, 1);
enemyDamageValue(objTornadoBlow, 1);
enemyDamageValue(objThunderBeam, 2);
enemyDamageValue(objBreakDash, 1);
enemyDamageValue(objMagneticShockwave, 6);
enemyDamageValue(objIceWall, 1);

// MaGMML2
enemyDamageValue(objHornetChaser, 2);
enemyDamageValue(objJewelSatellite, 4);
enemyDamageValue(objGrabBuster, 1);
enemyDamageValue(objTripleBlade, 2);
enemyDamageValue(objWheelCutter, 1);
enemyDamageValue(objSlashClaw, 1);
enemyDamageValue(objSakugarne, 3);
enemyDamageValue(objSuperArrow, 2);
enemyDamageValue(objWireAdapter, 1);

// MaGMML1
enemyDamageValue(objMetalBlade, 2);
enemyDamageValue(objGeminiLaser, 1);
enemyDamageValue(objSolarBlaze, 1);
enemyDamageValue(objTopSpin, 1);
enemyDamageValue(objThunderWool, 1);
enemyDamageValue(objPharaohShot, 1);
enemyDamageValue(objBlackHoleBomb, 4);
enemyDamageValue(objMagicCard, 2);

// MaG48MML
enemyDamageValue(objFlameMixer, 2);
enemyDamageValue(objRainFlush, 1);
enemyDamageValue(objSparkShock, 2);
enemyDamageValue(objSearchSnake, 1);
enemyDamageValue(objTenguBlade, 1);
enemyDamageValue(objTenguDash, 1);
enemyDamageValue(objTenguDisk, 2);
enemyDamageValue(objSaltWater, 1);
enemyDamageValue(objConcreteShot, 1);
enemyDamageValue(objHomingSniper, 4);

// MaG48MML
enemyDamageValue(objSuperArmBlockProjectile, 1);
enemyDamageValue(objSuperArmDebris, 1);
enemyDamageValue(objChillShot, 1);
enemyDamageValue(objChillSpikeLanded, 4);

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
if (startIntro)
{
    with (objMegaman)
    {
        if (gravDir > 0)
        {
            i = instance_create(x - 8, y - 8, objGravityFlipUp);
            with (i)
            {
                event_perform(ev_step, ev_step_normal);
                instance_destroy();
            }
        }
    }
}

event_inherited();

if (entityCanStep())
{
    if (isFight)
    {
        grav = 0.25 * myGrav;

        switch (phase)
        {
            case 0: // GravityFlip
                if (y < view_yview + view_hview / 2)
                {
                    image_yscale = -1;
                }
                else
                {
                    image_yscale = 1;
                }

                image_speed = 0;
                if (attackTimer == 0)
                    image_index = 0;
                if (ground)
                {
                    attackTimer += 1;
                    sprite_index = sprGravityReadyingJump;
                }
                if (attackTimer == 15)
                    image_index = 1;
                if (attackTimer == 30)
                {
                    sprite_index = sprGravityJump;
                    with (objMegaman)
                    {
                        if (gravDir != other.myGrav)
                        {
                            yspeed = yspeed / 2;
                            image_yscale = other.myGrav;
                            y += sprite_get_yoffset(mask_index) * -other.myGrav;
                            other.getX = x;
                            gravDir = other.myGrav;
                        }
                    }
                    myGrav = -myGrav;
                    y += myGrav * 2;
                    ground = false;
                    attackTimer = 31;
                }
                if (attackTimer == 32)
                {
                    image_index = 1;
                }
                if (attackTimer >= 37)
                {
                    attackTimer = 0;

                    // randomize();
                    phase = choose(1, 2);
                }
                break;
            case 1: // Jump and shoot
                image_speed = 0;
                if (attackTimer == 0)
                    image_index = 0;
                if (ground)
                {
                    attackTimer += 1;
                    sprite_index = sprGravityReadyingJump;
                }
                if (attackTimer == 15)
                    image_index = 1;
                if (attackTimer == 30)
                {
                    var dx, initYspeed;
                    dx = getX - x;
                    initYspeed = -5 * myGrav;

                    var time, yy,
                        yyspeed; // time: How much time (in frames) it would take to land on Mega Man's location
                    if (myGrav == 1)
                        yy = bbox_bottom;
                    else
                        yy = bbox_top;
                    yyspeed = initYspeed;
                    time = 0;

                    while (((yy < bbox_bottom && myGrav == 1)
                        || (yyspeed < 0 && myGrav == 1))
                        || ((yy > bbox_top && myGrav == -1)
                        || (yyspeed > 0 && myGrav == -1)))
                    {
                        yyspeed += 0.25 * myGrav;
                        yy += yyspeed;
                        time += 1;
                    }
                    if (x > view_xview + view_wview / 2)
                        xspeed = -max(abs(dx / time), 1);
                    else
                        xspeed = max(abs(dx / time), 1);
                    yspeed = initYspeed;
                    sprite_index = sprGravityJump;
                    attackTimer = 31;
                }
                if (attackTimer == 32)
                {
                    image_index = 1;
                    xspeed = 0;
                }
                if (attackTimer == 37)
                {
                    attackTimer = 0;
                    phase = 0;
                }
                break;
            case 2: // Run
                image_speed = 0.2;
                sprite_index = sprGravityWalk;
                xspeed = image_xscale * 1.5;
                attackTimer += 1;
                if (attackTimer >= 60)
                {
                    attackTimer = 0;
                    phase = 0;
                    xspeed = 0;
                }
                break;
        }
        if (sprite_index == sprGravityJump)
        {
            if (fireTimer < 45)
                fireTimer += 1;
            else
            {
                fireTimer = 0;
                instance_create(x + 8 * image_xscale, y - 8 * myGrav,
                    objGravityShot);
                sprite_index = sprGravityJumpShoot;
            }
        }

        // Face the player
        if (sprite_index != sprGravityWalk)
            calibrateDirection();
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
event_inherited();

if (instance_exists(objMegaman))
{
    i = instance_create(objMegaman.x - 8, objMegaman.y - 8, objGravityFlipDown);
    with (i)
    {
        event_perform(ev_step, ev_step_normal);
        instance_destroy();
    }
}

with (objGravityShot)
    instance_destroy();
