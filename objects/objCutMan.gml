#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
// Creation code (all optional):
event_inherited();

healthpointsStart = 28;
healthpoints = healthpointsStart;

//@cc use this if you want to enable cut man's knockback
hasKnockback = false;

pose = sprCutIntro;
poseImgSpeed = 6 / 60;
contactDamage = 4;
ground = false;
attackTimer = 0;
jumpTimer = 0;
jumpAmount = 0;
canInitShoot = true;
phase = 0; // 0 = nothing; 1 = running; 2 = jumping; 3 = shooting;
getLastXspeed = xspeed;
delay = 0;

knockbackTimer = -1;

// Sprites 0 = no cutter, 1 = cutter
cutter = 1;

spriteStand[0] = sprCutStandShame;
spriteRun[0] = sprCutRunShame;
spriteJump[0] = sprCutJumpShame;
spriteStand[1] = sprCutStand;
spriteRun[1] = sprCutRun;
spriteJump[1] = sprCutJump;

// Healthbar colours
healthBarPrimaryColor[1] = 18;
healthBarSecondaryColor[1] = 40;

// Music
music = "Mega_Man_1.nsf";
musicType = "VGM";
musicTrackNumber = 8;

// Damage Table
enemyDamageValue(objBusterShot, 2);
enemyDamageValue(objBusterShotHalfCharged, 2);
enemyDamageValue(objBusterShotCharged, 4);

// MaGMML3
enemyDamageValue(objSparkChaser, 1);
enemyDamageValue(objLaserTrident, 2);
enemyDamageValue(objWaterShield, 1);
enemyDamageValue(objTornadoBlow, 0);
enemyDamageValue(objThunderBeam, 1);
enemyDamageValue(objMagneticShockwave, 1);
enemyDamageValue(objIceWall, 2);
enemyDamageValue(objBreakDash, 4);

// MaGMML2
enemyDamageValue(objHornetChaser, 2);
enemyDamageValue(objJewelSatellite, 1);
enemyDamageValue(objGrabBuster, 5);
enemyDamageValue(objTripleBlade, 2);
enemyDamageValue(objWheelCutter, 2);
enemyDamageValue(objSlashClaw, 1);
enemyDamageValue(objSakugarne, 3);
enemyDamageValue(objSuperArrow, 2);
enemyDamageValue(objWireAdapter, 1);

// MaGMML1
enemyDamageValue(objMetalBlade, 1);
enemyDamageValue(objGeminiLaser, 2);
enemyDamageValue(objSolarBlaze, 4);
enemyDamageValue(objTopSpin, 1);
enemyDamageValue(objThunderWool, 1);
enemyDamageValue(objPharaohShot, 2); //Charge shot = 6
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
enemyDamageValue(objConcreteShot, 4);
enemyDamageValue(objHomingSniper, 1);

// MaG24HMML
enemyDamageValue(objSuperArmBlockProjectile, 14);
enemyDamageValue(objSuperArmDebris, 2);
enemyDamageValue(objChillShot, 1);
enemyDamageValue(objChillSpikeLanded, 2);

// Misc.
enemyDamageValue(objPowerStone, 4);
enemyDamageValue(objPlantBarrier, 0);
enemyDamageValue(objBrickWeapon, 4);
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
        if (!(((xspeed > 0 && !checkSolid(xspeed + 2, 0, 0, 1))
            || (xspeed < 0 && !checkSolid(xspeed - 2, 0, 0, 1)))))
        {
            x -= xspeed;
        }
        if (delay > 0)
            delay -= 1;
        switch (phase)
        {
            case 0: // Idle (standing still)
                if (attackTimer == 60)
                {
                    playSFX(sfxCutManSnip);
                }
                xspeed = 0;
                sprite_index = spriteStand[cutter];
                image_speed = 0.15;
                attackTimer -= 1;
                if (attackTimer <= 0)
                {
                    // randomize();
                    if (attackTimer == -1)
                        phase = 1;
                    else
                        phase = 2;
                    attackTimer = 60;
                }
                break;
            case 1: // Walking/Jumping
                image_speed = 0.15;
                if (ground)
                {
                    sprite_index = spriteRun[cutter];
                    xspeed = image_xscale * 1.5;
                    getLastXspeed = xspeed;
                }
                else
                {
                    sprite_index = spriteJump[cutter];
                    xspeed = getLastXspeed;
                }
                if (xspeed == 0 && ground)
                    yspeed = -6;
                if (instance_exists(target))
                    if (distance_to_point(target.x, y) < 48 && ground)
                    {
                        // randomize();
                        if (cutter == 0)
                            phase = 3;
                        else
                            phase = choose(0, 2);
                        attackTimer = 60;
                    }
                break;
            case 2: // Shooting
                if (attackTimer == 60)
                    attackTimer = 30;
                attackTimer -= 1;
                xspeed = 0;
                sprite_index = sprCutThrow;
                if (attackTimer > 10)
                {
                    if (cutter == 0)
                    {
                        phase = 3;
                        attackTimer = 60;
                    }
                    image_single = 0;
                }
                else if (attackTimer == 10)
                {
                    image_single = 1;
                    instance_create(x, y, objCutBullet);
                }
                if (attackTimer <= 0)
                {
                    if (instance_exists(target))
                        if (distance_to_point(target.x, y) > 48)
                            phase = 1;
                        else
                            phase = 3;
                    attackTimer = 60;
                }
                break;
            case 3: // Jumping
                if (ground && attackTimer == 60 && delay == 0)
                {
                    attackTimer -= 1;
                    xspeed = image_xscale * 1.5;
                    getLastXspeed = xspeed;
                    yspeed = -6;
                }
                sprite_index = spriteJump[cutter];
                xspeed = getLastXspeed;
                if (ground)
                {
                    delay = 5;

                    // randomize();
                    phase = 1;
                    attackTimer = 60;
                }
                break;
        }

        // optional knockback
        if (hasKnockback == true && knockbackTimer > -1)
        {
            if (knockbackTimer > 0)
            {
                if (yspeed < 0)
                    yspeed = 0;
                knockbackTimer -= 1;
                phase = 4;
                sprite_index = spriteRun[cutter];
                image_index = 1;
                xspeed = -0.75 * image_xscale;
            }
            else if (phase == 4)
            {
                if (ground == true)
                    sprite_index = spriteStand[cutter];
                else
                    sprite_index = spriteJump[cutter];
                phase = 0;
                attackTimer = 0;
                knockbackTimer = -2;
            }
        }

        // Face the player
        if (instance_exists(target) && ((hasKnockback == false)
            || (hasKnockback == true && knockbackTimer <= -1)))
        {
            if (x > target.x)
                image_xscale = -1;
            else
                image_xscale = 1;
        }
    }
    if (instance_exists(objCutBullet))
        cutter = 0;
    else
        cutter = 1;
}
else
{
    image_speed = 0;
}
#define Other_19
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();

if (hasKnockback)
{
    knockbackTimer = min(hitInvun, 30);
}
#define Other_20
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
with (objCutBullet)
{
    instance_create(x, y, objExplosion);
    instance_destroy();
}

event_inherited();
#define Other_21
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
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