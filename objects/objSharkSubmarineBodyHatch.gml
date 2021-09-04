#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();

healthpointsStart = 14;
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

phaseMultiple = 8; // Multiply in if arguments involving the timer.

bodyShark = noone; // The shark part that made this.
leftShark = noone; // Copied from the shark part that made this.

/* xOffset = 0;
yOffset = 0 ;*/

timer = phaseMultiple * 7; // Timer for making a dolphin.
hatchIndex = 0;
image_speed = 0;

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
    if (instance_exists(bodyShark))
    {
        xspeed = bodyShark.xspeed;
        yspeed = bodyShark.yspeed;
        image_xscale = bodyShark.image_xscale;
        image_yscale = bodyShark.image_yscale;

        // Opening (0) or closing (60) hatch.
        if (timer <= 0 || timer == phaseMultiple * 6)
        {
            hatchIndex = 1;
        }
        if (timer == phaseMultiple) // Hatch fully opened.
        {
            hatchIndex = 2;
        }
        if (timer == phaseMultiple * 3) // DOLPHIN, LAUNCH!
        {
            with (instance_create(x, y + 13 * image_yscale,
                objSharkSubmarineDolphin))
            {
                image_yscale = other.image_yscale;
                grav *= image_yscale;
                if (instance_exists(other.target))
                {
                    calibrateDirection(other.target);
                }
            }
        }
        if (timer >= phaseMultiple * 7) // Hatch fully closed.
        {
            hatchIndex = 0;
        }
        timer+=1;
        image_index = hatchIndex; // Making sure the hitbox changes when opened.
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
visible = false;

// dead = 1;

// instance_create(bboxGetXCenter(), bboxGetYCenter(), objHarmfulExplosion);
// playSFX(sfxMM3Explode);
#define Draw_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
/* event_inherited ();*/

if (instance_exists(bodyShark))
{
    if (bodyShark.introTimer <= 0)
    {
        if ((ceil(iFrames / 2) mod 4) || !iFrames)
        {
            var iceBlinkTime; iceBlinkTime = 42;
            if ((ceil(iFrames / 2) mod 2) || (iceTimer > 0 && (iceTimer > iceBlinkTime || (iceTimer <= iceBlinkTime && iceTimer mod 4 == 0))))
            {
                var flashcol; flashcol = c_white;
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
                draw_sprite_ext(sprSharkSubmarineBodyHatch, hatchIndex, x, round(y),
                    bodyShark.image_xscale, bodyShark.image_yscale,
                    image_angle, image_blend, image_alpha);
                d3d_set_fog(false, 0, 0, 0);

                if (iceTimer > 0 && (iceTimer > iceBlinkTime || (iceTimer <= iceBlinkTime && iceTimer mod 4 == 0)))
                {
                    draw_set_blend_mode(bm_add);
                    draw_sprite_ext(sprSharkSubmarineBodyHatch, hatchIndex, x, round(y),
                        bodyShark.image_xscale, bodyShark.image_yscale,
                        image_angle, image_blend, image_alpha);
                    draw_set_blend_mode(bm_normal);
                }
            }
            else
            {
                draw_sprite_ext(sprSharkSubmarineBodyHatch, hatchIndex, x, round(y),
                    bodyShark.image_xscale, bodyShark.image_yscale,
                    image_angle, image_blend, image_alpha);
            }
        }
    }
    else
    {
        draw_sprite_ext(sprSharkSubmarineBodyHatch, hatchIndex, x, round(y),
            bodyShark.image_xscale, bodyShark.image_yscale, image_angle, image_blend,
            1 - ((floor(bodyShark.introTimer / (30 / 2)) * (30 / 2)) / 30) / 2);
    }
}
