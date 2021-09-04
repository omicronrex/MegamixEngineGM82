#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();
healthpointsStart = 28;
healthpoints = healthpointsStart;
blockCollision = 0;
grav = 0;
pose = sprite_index;
contactDamage = 4;
ground = false;
attackTimer = 0;
jumpTimer = 0;
jumpAmount = 0;
canInitShoot = true;
phase = 0;
image_speed = 0.15;
introType = 0;

// Music
music = "Mega_Man_2.nsf";
musicType = "VGM";
musicTrackNumber = 17;

// Damage Tables
enemyDamageValue(objBusterShot, 1);
enemyDamageValue(objBusterShotHalfCharged, 1);
enemyDamageValue(objBusterShotCharged, 3);

// MaGMML3
enemyDamageValue(objSparkChaser, 2);
enemyDamageValue(objLaserTrident, 2);
enemyDamageValue(objWaterShield, 0);
enemyDamageValue(objTornadoBlow, 0);
enemyDamageValue(objThunderBeam, 4);
enemyDamageValue(objBreakDash, 0);
enemyDamageValue(objMagneticShockwave, 2);
enemyDamageValue(objIceWall, 8);

// MaGMML2
enemyDamageValue(objHornetChaser, 2);
enemyDamageValue(objJewelSatellite, 4);
enemyDamageValue(objGrabBuster, 1);
enemyDamageValue(objTripleBlade, 2);
enemyDamageValue(objSlashClaw, 1);
enemyDamageValue(objWheelCutter, 0);
enemyDamageValue(objSakugarne, 0);
enemyDamageValue(objSuperArrow, 6);
enemyDamageValue(objWireAdapter, 1);

// MaGMML1
enemyDamageValue(objMetalBlade, 0);
enemyDamageValue(objGeminiLaser, 2);
enemyDamageValue(objSolarBlaze, 4);
enemyDamageValue(objTopSpin, 0);
enemyDamageValue(objThunderWool, 2);
enemyDamageValue(objPharaohShot, 2);
enemyDamageValue(objBlackHoleBomb, 1);
enemyDamageValue(objMagicCard, 2);

// MaG48HMML
enemyDamageValue(objFlameMixer, 4);
enemyDamageValue(objRainFlush, 0);
enemyDamageValue(objSparkShock, 2);
enemyDamageValue(objSearchSnake, 0);
enemyDamageValue(objTenguBlade, 2);
enemyDamageValue(objTenguDash, 0);
enemyDamageValue(objTenguDisk, 2);
enemyDamageValue(objSaltWater, 0);
enemyDamageValue(objConcreteShot, 1);
enemyDamageValue(objHomingSniper, 2);

// MaG24HMML
enemyDamageValue(objSuperArmBlockProjectile, 1);
enemyDamageValue(objSuperArmDebris, 1);
enemyDamageValue(objChillShot, 4);
enemyDamageValue(objChillSpikeLanded, 0);

// Misc.
enemyDamageValue(objPowerStone, 0);
enemyDamageValue(objPlantBarrier, 0);
enemyDamageValue(objBrickWeapon, 0);
enemyDamageValue(objIceSlasher, 4);
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();

// Handle Intro
if (!global.frozen)
{
    image_speed = 0.15;

    // Starting the intro animation
    if (startIntro)
    {
        if (image_xscale == -1)
        {
            x = view_xview[0] + view_wview[0];
        }
        else
        {
            x = view_xview[0] - sprite_xoffset;
        }
        startIntro = false;
        isIntro = true;
        drawBoss = true;
        visible = true;
    }
    else if (isIntro)
    {
        if (((x < xstart) && image_xscale == 1) || ((x > xstart) && image_xscale == -1))
        {
            x += image_xscale;
        }
        else
        {
            isIntro = false;
            playSFX(sfxMechaDragon);
            grav = gravStart;
            blockCollision = blockCollisionStart;
        }
    }
}
if (entityCanStep())
{
    if (isFight)
    {
        switch (phase)
        {
            case 0: // Mecha Dragon only has 1 real attack, however you can do different attack patterns, see pharoh mans step event code for an example
                if (yspeed == 0)
                {
                    yspeed = -0.5;
                    xspeed = yspeed;
                }
                if (x < xstart - 16)
                {
                    yspeed = -yspeed;
                    xspeed = 0.5;
                }
                if (x > xstart + 16)
                    xspeed = -0.5;
                attackTimer -= 1;
                if (attackTimer == 50)
                    sprite_index = sprMechaDragon;
                if (attackTimer <= 0)
                {
                    attackTimer = 60;
                    fire = instance_create(x + 48 * image_xscale, y - 32,
                        objMechaDragonFire);
                    sprite_index = sprMechaDragonFire;
                    fire.image_xscale = image_xscale;
                }
                break;
        }
    }
}
#define Other_20
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
with (objMechaDragonFire)
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
#define Draw_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();
