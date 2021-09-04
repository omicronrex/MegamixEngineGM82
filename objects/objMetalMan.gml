#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();

healthpointsStart = 28;
healthpoints = healthpointsStart;

pose = sprMetalIntro;
poseImgSpeed = 0.2;
contactDamage = 6; // 3 blades

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

// Health Bar
healthBarPrimaryColor[1] = 18;
healthBarSecondaryColor[1] = 34;

// Music
music = "Mega_Man_2.nsf";
musicType = "VGM";
musicTrackNumber = 17;

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
enemyDamageValue(objBreakDash, 0);
enemyDamageValue(objMagneticShockwave, 6);
enemyDamageValue(objIceWall, 1);

// MaGMML2
enemyDamageValue(objHornetChaser, 1);
enemyDamageValue(objJewelSatellite, 1);
enemyDamageValue(objGrabBuster, 1);
enemyDamageValue(objTripleBlade, 2);
enemyDamageValue(objWheelCutter, 8);
enemyDamageValue(objSlashClaw, 1);
enemyDamageValue(objSakugarne, 3);
enemyDamageValue(objSuperArrow, 2);
enemyDamageValue(objWireAdapter, 2);

// MaGMML1
enemyDamageValue(objMetalBlade, 28);
enemyDamageValue(objGeminiLaser, 1);
enemyDamageValue(objSolarBlaze, 1);
enemyDamageValue(objTopSpin, 0);
enemyDamageValue(objThunderWool, 2);
enemyDamageValue(objPharaohShot, 1);
enemyDamageValue(objBlackHoleBomb, 1);
enemyDamageValue(objMagicCard, 4);

// MaG48HMML
enemyDamageValue(objFlameMixer, 1);
enemyDamageValue(objRainFlush, 2);
enemyDamageValue(objSparkShock, 2);
enemyDamageValue(objSearchSnake, 0);
enemyDamageValue(objTenguBlade, 0);
enemyDamageValue(objTenguDash, 0);
enemyDamageValue(objTenguDisk, 0);
enemyDamageValue(objSaltWater, 4);
enemyDamageValue(objConcreteShot, 1);
enemyDamageValue(objHomingSniper, 0);

// MaG24HMML
enemyDamageValue(objSuperArmBlockProjectile, 1);
enemyDamageValue(objSuperArmDebris, 1);
enemyDamageValue(objChillShot, 1);
enemyDamageValue(objChillSpikeLanded, 1);

// Misc.
enemyDamageValue(objPowerStone, 1);
enemyDamageValue(objPlantBarrier, 0);
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
        flashTimer += 1;
        if (flashTimer == (60 * 7) + 1)
        {
            if (instance_exists(objMM2Conveyor))
                with (objMM2Conveyor)
                    dir = -dir;
            flashTimer = 0;
            playSFX(sfxGravityFlip);
        }

        switch (phase)
        {
            case 0: // Idle (running in place)
                attackTimer += 1;
                xspeed = 0;
                if (getX == 0)
                    getX = abs(x - (view_xview + view_wview / 2));
                sprite_index = sprMetalRun;
                image_speed = 0.15;

                if (instance_exists(target))
                {
                    if (global.keyShootPressed[target.playerID]
                        || attackTimer >= 60 * 3)
                    {
                        // randomize();
                        yspeed = -choose(3, 5, 7);
                        phase = 1;
                        ground = false;
                        attackTimer = 0;
                    }

                    if ((target.x > view_xview + view_wview / 2
                        && x > view_xview + view_wview / 2)
                        || (target.x < view_xview + view_wview / 2
                        && x < view_xview + view_wview / 2))
                    {
                        var dx, initYspeed;
                        if (x > view_xview + view_wview / 2)
                            dx = (view_xview + view_wview / 2)
                                - getX - spriteGetXCenter();
                        else
                            dx = (view_xview + view_wview / 2)
                                + getX - spriteGetXCenter();
                        initYspeed = -7;

                        var time, yy,
                            yyspeed; // time: How much time (in frames) it would take to land on Mega Man's location
                        yy = bbox_bottom;
                        yyspeed = initYspeed;
                        time = 0;

                        while (yy < bbox_bottom || yyspeed < 0)
                        {
                            yyspeed += 0.25;
                            yy += yyspeed;
                            time += 1;
                        }

                        xspeed = dx / time;
                        yspeed = initYspeed;
                        ground = false;
                        phase = 1;
                        attackTimer = 0;
                    }
                }
                break;



            case 1: // Jumping/Shooting
                sprite_index = sprMetalJump;
                if ((attackTimer == floor(attackTimer / 20) * 20 && yspeed >= 0
                    && throwTimer == 0 && xspeed == 0) || (attackTimer == 0
                    && yspeed > 0 && xspeed != 0 && throwTimer == 0))
                {
                    if (attackTimer == 0)
                        attackTimer += 1;
                    getLastXspeed = xspeed;
                    getLastYspeed = yspeed;
                    throwTimer += 1;
                }
                else if (throwTimer > 0)
                {
                    throwTimer += 1;
                    if (xspeed == 0)
                        yspeed = min(0.5, yspeed);
                    sprite_index = sprMetalJumpThrow;
                    image_index = 0 + min(floor(throwTimer / bladeThrow), 1);
                    if (throwTimer == bladeThrow)
                    {
                        playSFX(sfxMetalBlade);
                        instance_create(x + image_xscale * 8, y,
                            objMetalManBlade);
                    }
                    if (throwTimer >= bladeThrow * 2)
                    {
                        throwTimer = 0;

                        //                        xspeed = getLastXspeed;
                        //                        yspeed = getLastYspeed;
                    }
                }

                //                if throwTimer == 0
                if (xspeed == 0)
                    attackTimer += 1;
                if (ground)
                {
                    phase = 0;
                    throwTimer = 0;
                    attackTimer = 0;
                }
                break;
        }

        // Face the player
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
with (objMetalManBlade)
    instance_create(x, y, objExplosion);
instance_destroy();

event_inherited();
#define Other_21
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();

// if it looks like a metal blade, and smells like a metal blade, and feels like a metal blade...
if (other.sprite_index == sprMetalBlade)
{
    global.damage = 6969;
}
#define Draw_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();
if (flashTimer == floor(flashTimer / (60 * 7)) * (60 * 7) && flashTimer > 0)
{
    draw_set_color(c_white);
    draw_rectangle(view_xview - 1, view_yview - 1, view_xview + view_wview + 1,
        view_yview + view_hview + 1, false);
}
