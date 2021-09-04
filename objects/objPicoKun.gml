#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
// Creation code (all optional):
event_inherited();

respawnRange = -1; // set to -1 to make infinite
despawnRange = -1; // set to -1 to make infinite

grav = 0;
blockCollision = false;

healthpointsStart = 3;
healthpoints = healthpointsStart;
contactDamage = 8;
itemDrop = -1;

phase = -1;
phaseTimer = 0;
decrementedCount = false;

// super arm interaction
category = "superArmTarget";
superArmFlashTimer = 0;
superArmFlashOwner = noone;
superArmFlashInterval = 1;
superArmHoldOwner = noone;
superArmDeathOnDrop = false;
superArmThrown = false;
superArmSquirmTimer = 0;

// Damage Tables
enemyDamageValue(objBusterShot, 1);
enemyDamageValue(objBusterShotHalfCharged, 1);
enemyDamageValue(objBusterShotCharged, 3);

// MaGMML3
enemyDamageValue(objSparkChaser, 1);
enemyDamageValue(objLaserTrident, 2);
enemyDamageValue(objWaterShield, 3);
enemyDamageValue(objTornadoBlow, 2);
enemyDamageValue(objThunderBeam, 2);
enemyDamageValue(objBreakDash, 2);
enemyDamageValue(objMagneticShockwave, 3);
enemyDamageValue(objIceWall, 2);

// MaGMML2
enemyDamageValue(objHornetChaser, 3);
enemyDamageValue(objJewelSatellite, 2);
enemyDamageValue(objGrabBuster, 1);
enemyDamageValue(objTripleBlade, 1);
enemyDamageValue(objSlashClaw, 2);
enemyDamageValue(objWheelCutter, 2);
enemyDamageValue(objSakugarne, 2);
enemyDamageValue(objSuperArrow, 1);
enemyDamageValue(objWireAdapter, 1);

// MaGMML1
enemyDamageValue(objMetalBlade, 1);
enemyDamageValue(objGeminiLaser, 3);
enemyDamageValue(objSolarBlaze, 2);
enemyDamageValue(objTopSpin, 3);
enemyDamageValue(objThunderWool, 2);
enemyDamageValue(objPharaohShot, 2);
enemyDamageValue(objBlackHoleBomb, 1);
enemyDamageValue(objMagicCard, 2);

// MaG48HMML
enemyDamageValue(objFlameMixer, 1);
enemyDamageValue(objRainFlush, 1);
enemyDamageValue(objSparkShock, 2);
enemyDamageValue(objSearchSnake, 3);
enemyDamageValue(objTenguBlade, 2);
enemyDamageValue(objTenguDash, 3);
enemyDamageValue(objTenguDisk, 2);
enemyDamageValue(objSaltWater, 3);
enemyDamageValue(objConcreteShot, 2);
enemyDamageValue(objHomingSniper, 1);

// MaG24HMML
enemyDamageValue(objSuperArmBlockProjectile, 3);
enemyDamageValue(objSuperArmDebris, 3);
enemyDamageValue(objChillShot, 0);
enemyDamageValue(objChillSpikeLanded, 1);

// Misc.
enemyDamageValue(objPowerStone, 3);
enemyDamageValue(objPlantBarrier, 1);
enemyDamageValue(objBrickWeapon, 1);
enemyDamageValue(objIceSlasher, 1);
#define Destroy_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if (!decrementedCount)
{
    decrementedCount = true;
    with (objPicoControl)
        puyoBrickIndex += 2;
}
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();

if (entityCanStep())
{
    // super arm interaction
    if (superArmThrown || superArmHoldOwner != noone)
    {
        contactDamage = 0;

        // happily fall off bottom of screen :)
        despawnRange = 4;
        grav = 0.25;
        exit;
    }
    phaseTimer += 1;
    if (phase == -1)
    {
        image_index = phaseTimer div 4;
        if (image_index >= 4)
        {
            phase = 0;
            phaseTimer = 0;
        }
    }
    else if (phase == 0)
    {
        image_index = 4 - (phaseTimer div 4) mod 2;
        if (phaseTimer == 1)
        {
            if (instance_exists(target))
            {
                var dx = target.x - x;
                var dy = target.y - y;
                var dist = sqrt(dx * dx + dy * dy);
                xspeed = dx * spd / dist;
                yspeed = dy * spd / dist;
            }
        }
        if (phaseTimer >= 30)
        {
            phase = 1;
            phaseTimer = 0;
        }
    }
    else if (phase == 1)
    {
        image_index = 4 - (phaseTimer div 4) mod 2;
        xspeed = 0;
        yspeed = 0;
        if (phaseTimer >= 50)
        {
            phase = 0;
            phaseTimer = 0;
        }
    }
}
#define Other_23
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
specialDamageValue(objBusterShot, 1);
specialDamageValue(objBusterShotHalfCharged, 1);
specialDamageValue(objBusterShotCharged, 2);

// idk what this is for. CODE HOARDING
#define Other_25
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();

if (!spawned)
{
    if (!decrementedCount)
    {
        decrementedCount = true;
        with (objPicoControl)
        {
            puyoBrickIndex += 2;
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

// super arm flash
if (superArmFlashTimer mod (2 * superArmFlashInterval) >= superArmFlashInterval || superArmThrown || superArmHoldOwner != noone)
{
    draw_set_blend_mode(bm_add);
    drawSelf();
    draw_set_blend_mode(bm_normal);
    draw_set_alpha(1);
}
