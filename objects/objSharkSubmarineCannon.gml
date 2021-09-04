#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();

healthpointsStart = 28;
healthpoints = healthpointsStart;
contactDamage = 5;
killOverride = false;
grav = 0;
blockCollision = 0;
canHit = true;
stopOnFlash = false;
hitInvun = 45;
canIce = false;
respawnRange = -1;
despawnRange = -1;
itemDrop = -1;
lockTransition = false;

phaseMultiple = 7; // 8;

headShark = noone; // The shark that made this.
leftShark = noone;

timer = 0;
cannonIndex = 0;

// Damage Table
enemyDamageValue(objBusterShot, 2);
enemyDamageValue(objBusterShotHalfCharged, 2);
enemyDamageValue(objBusterShotCharged, 4);

// MaGMML3
enemyDamageValue(objSparkChaser, 2);
enemyDamageValue(objLaserTrident, 4);
enemyDamageValue(objWaterShield, 1);
enemyDamageValue(objTornadoBlow, 4);
enemyDamageValue(objThunderBeam, 3);
enemyDamageValue(objBreakDash, 1);
enemyDamageValue(objMagneticShockwave, 3);
enemyDamageValue(objIceWall, 0);

// MaGMML2
enemyDamageValue(objHornetChaser, 2);
enemyDamageValue(objJewelSatellite, 1);
enemyDamageValue(objGrabBuster, 2);
enemyDamageValue(objTripleBlade, 5);
enemyDamageValue(objSlashClaw, 1);
enemyDamageValue(objWheelCutter, 1);
enemyDamageValue(objSakugarne, 1);
enemyDamageValue(objSuperArrow, 2);
enemyDamageValue(objWireAdapter, 3);

// MaGMML1
enemyDamageValue(objMetalBlade, 2);
enemyDamageValue(objGeminiLaser, 4);
enemyDamageValue(objSolarBlaze, 2);
enemyDamageValue(objTopSpin, 1);
enemyDamageValue(objThunderWool, 2);
enemyDamageValue(objPharaohShot, 1);
enemyDamageValue(objBlackHoleBomb, 1);
enemyDamageValue(objMagicCard, 3);

// MaG48HMML
enemyDamageValue(objFlameMixer, 2);
enemyDamageValue(objRainFlush, 4);
enemyDamageValue(objSparkShock, 5);
enemyDamageValue(objSearchSnake, 1);
enemyDamageValue(objTenguBlade, 1);
enemyDamageValue(objTenguDash, 1);
enemyDamageValue(objTenguDisk, 2);
enemyDamageValue(objSaltWater, 1);
enemyDamageValue(objConcreteShot, 1);
enemyDamageValue(objHomingSniper, 3);

// MaG24HMML
enemyDamageValue(objSuperArmBlockProjectile, 1);
enemyDamageValue(objSuperArmDebris, 1);
enemyDamageValue(objChillShot, 0);
enemyDamageValue(objChillSpikeLanded, 0);

// Misc.
enemyDamageValue(objPowerStone, 2);
enemyDamageValue(objPlantBarrier, 1);
enemyDamageValue(objBrickWeapon, 2);
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
    if (instance_exists(headShark))
    {
        xspeed = headShark.xspeed;
        yspeed = headShark.yspeed;
        image_xscale = headShark.image_xscale;
        image_yscale = headShark.image_yscale;

        if (headShark.startFiring)
        {
            timer++;
        }

        // Opening.
        if (timer == phaseMultiple * 20
            || timer == phaseMultiple * 37)
        {
            cannonIndex = 1;
        }

        // Fully opened and no recoil.
        if (timer == phaseMultiple * 21
            || timer == phaseMultiple * 24
            || timer == phaseMultiple * 27
            || timer == phaseMultiple * 30
            || timer == phaseMultiple * 33)
        {
            cannonIndex = 2;
        }

        // Shooting fricking laser beams.
        if (timer == phaseMultiple * 23
            || timer == phaseMultiple * 26
            || timer == phaseMultiple * 29
            || timer == phaseMultiple * 32)
        {
            cannonIndex = 3;
            var newShot = instance_create(x - 20 * image_xscale,
                y + 14 * image_yscale, objSharkSubmarineLaser);
            newShot.image_xscale = -image_xscale;
        }

        // Closing the cannon.
        if (timer >= phaseMultiple * 38)
        {
            cannonIndex = 0;
            timer = phaseMultiple * 10;
        }
    }
    else
    {
        instance_destroy();
    }
}
#define Other_19
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();
iFrames = max(1, hitInvun);
#define Other_20
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();
if (instance_exists(parent))
{
    with (parent)
        event_user(EV_DEATH);
}
#define Other_21
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();
if (cannonIndex > 1)
{
    other.guardCancel = 0;
    if (instance_exists(headShark))
    {
        headShark.blinkTimer = 0;
    }
}
else
{
    other.guardCancel = 2;
}
#define Draw_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if (instance_exists(parent))
{
    if (parent.introTimer <= 0)
    {
        if ((ceil(iFrames / 2) mod 4) || !iFrames)
        {
            var iceBlinkTime = 42;
            if ((ceil(iFrames / 2) mod 2) || (iceTimer > 0 && (iceTimer > iceBlinkTime || (iceTimer <= iceBlinkTime && iceTimer mod 4 == 0))))
            {
                var flashcol = c_white;
                if (iceTimer > 0 && (iceTimer > iceBlinkTime || (iceTimer <= iceBlinkTime && iceTimer mod 4 == 0)))
                {
                    switch (iceGraphicStyle)
                    {
                        case 1:
                            flashcol = 0;
                            break;
                        default:
                            flashcol = make_color_rgb(0, 120, 255);
                            break;
                    }
                }

                d3d_set_fog(true, flashcol, 0, 0);
                draw_sprite_ext(sprSharkSubmarineCannon, cannonIndex, x, round(y),
                    headShark.image_xscale, headShark.image_yscale,
                    image_angle, image_blend, image_alpha);
                d3d_set_fog(false, 0, 0, 0);

                if (iceTimer > 0 && (iceTimer > iceBlinkTime || (iceTimer <= iceBlinkTime && iceTimer mod 4 == 0)))
                {
                    draw_set_blend_mode(bm_add);
                    draw_sprite_ext(sprSharkSubmarineCannon, cannonIndex, x, round(y),
                        headShark.image_xscale, headShark.image_yscale,
                        image_angle, image_blend, image_alpha);
                    draw_set_blend_mode(bm_normal);
                }
            }
            else
            {
                draw_sprite_ext(sprSharkSubmarineCannon, cannonIndex, x, round(y),
                    headShark.image_xscale, headShark.image_yscale,
                    image_angle, image_blend, image_alpha);
            }
        }
    }
    else
    {
        draw_sprite_ext(sprSharkSubmarineCannon, cannonIndex, x, round(y),
            headShark.image_xscale, headShark.image_yscale, image_angle, image_blend,
            1 - ((floor(parent.introTimer / (30 / 2)) * (30 / 2)) / 30) / 2);
    }
}
