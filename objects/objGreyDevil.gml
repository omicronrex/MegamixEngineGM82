#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();

healthpointsStart = 28;
healthpoints = healthpointsStart;
pose = sprGreyDevilIntro;
poseImgSpeed = 8 / 60;
contactDamage = 4;
ground = false;

// rather than using game maker's image offset features, this time round we're building a more accurate animation system.
imageTimer = 0;
imageTimerMax = 99;

// this is the minmum image_indexs of crash man for any given animation. imageNoMin is what the image_index is set to when plant man has finished an animation.
imageNoMin = 0;

// boss variables
phase = 0;
delay = 0;
lookFired = 0;
hasFired = false;
shotsFired = 0;
introType = 2;

// health bar variables
healthBarPrimaryColor[1] = 25;
healthBarSecondaryColor[1] = 0;

// Music
music = "RnFBossNES.ogg";
musicType = "OGG";
musicLoopSecondsStart = 55.70;
musicLoopSecondsEnd = 79.70;
musicVolume = 0.8;

// Damage Table
enemyDamageValue(objBusterShot, 1);
enemyDamageValue(objBusterShotHalfCharged, 1);
enemyDamageValue(objBusterShotCharged, 3);

// MaGMML3
enemyDamageValue(objSparkChaser, 3);
enemyDamageValue(objLaserTrident, 2);
enemyDamageValue(objWaterShield, 1);
enemyDamageValue(objTornadoBlow, 2);
enemyDamageValue(objThunderBeam, 4);
enemyDamageValue(objMagneticShockwave, 2);
enemyDamageValue(objIceWall, 1);
enemyDamageValue(objBreakDash, 0);

// MaGMML2
enemyDamageValue(objHornetChaser, 1);
enemyDamageValue(objJewelSatellite, 1);
enemyDamageValue(objGrabBuster, 2);
enemyDamageValue(objTripleBlade, 4);
enemyDamageValue(objWheelCutter, 2);
enemyDamageValue(objSlashClaw, 2);
enemyDamageValue(objSakugarne, 3);
enemyDamageValue(objSuperArrow, 2);
enemyDamageValue(objWireAdapter, 2);

// MaGMML1
enemyDamageValue(objMetalBlade, 2);
enemyDamageValue(objGeminiLaser, 2);
enemyDamageValue(objSolarBlaze, 1);
enemyDamageValue(objTopSpin, 0);
enemyDamageValue(objThunderWool, 2);
enemyDamageValue(objPharaohShot, 1);
enemyDamageValue(objBlackHoleBomb, 4);
enemyDamageValue(objMagicCard, 2);

// MaG48HMML
enemyDamageValue(objFlameMixer, 2);
enemyDamageValue(objRainFlush, 1);
enemyDamageValue(objSparkShock, 4);
enemyDamageValue(objSearchSnake, 1);
enemyDamageValue(objTenguBlade, 2);
enemyDamageValue(objTenguDash, 1);
enemyDamageValue(objTenguDisk, 2);
enemyDamageValue(objSaltWater, 1);
enemyDamageValue(objConcreteShot, 2);
enemyDamageValue(objHomingSniper, 2);

// MaG24HMML
enemyDamageValue(objSuperArmBlockProjectile, 2);
enemyDamageValue(objSuperArmDebris, 2);
enemyDamageValue(objChillShot, 0);
enemyDamageValue(objChillSpikeLanded, 0);

// Misc.
enemyDamageValue(objPowerStone, 2);
enemyDamageValue(objPlantBarrier, 1);
enemyDamageValue(objBrickWeapon, 1);
enemyDamageValue(objIceSlasher, 1);
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
// leave this. this is needed.
event_inherited();

// all of devils's events trigger when the game isn't frozen. he isn't weak to flash stopper, so no need to check whether that is used or not!
if (entityCanStep())
{
    if (isFight == true)
    {
        // this sets up crash man's movement variables.
        image_speed = 0;

        // resets the image timer if grey devil ever changes poses
        if (pose != sprite_index)
        {
            pose = sprite_index;
            imageTimer = 0;
        }

        // this is the animation system. don't touch this.
        imageTimer += 1;
        if (imageTimer >= imageTimerMax && image_index < image_number - 1)
        {
            imageTimer = 0;
            image_index += 1;
        }
        if (imageTimer >= imageTimerMax && image_index == image_number - 1)
        {
            imageTimer = 0;
            image_index = imageNoMin;
        }

        // this is grey devil's AI -
        // 0: blink twice - this is the only time you can damage grey devil
        // 1: move across room - this increases the hitbox horzitionally but shrinks its vertically
        // 2: when he reaches the edge of the room, reform and fire projectiles, reset to phase 0. every 3rd shot he fires a slightly altered pattern of projectiles.
        switch (phase)
        {
            case 0: // stand
            // this sets up the animation system. crash man changes animation frames every 30 ticks, and resets to the first frame of his animation.
                sprite_index = sprGreyDevilIdle;
                if (image_index != 2) // if grey devil is on any frame other than 2, he is immune to damage.
                {
                    canHit = false;
                    imageTimerMax = 15;
                }
                else
                {
                    // if alarm 9 is set to -1 that means the boss is not in a iFrames state. this is when he should be open to damage, otherwise GD would have not hit invunerability.
                    if (alarm[9] == -1)
                        canHit = true;
                    imageTimerMax = 30; // he stays on this frame longer than the other frames.
                }
                imageNoMin = 0;
                if (image_index == 3 && !hasFired)
                {
                    lookFired += 1; // grey devil will look twice before crossing the room.
                    hasFired = true;
                }
                else if (image_index != 3)
                    hasFired = false;

                // change direction of grey devil depending on which side of the room he's on.
                if (x > view_xview + view_wview / 2)
                    image_xscale = -1;
                else
                    image_xscale = 1;

                // change to phase 2 and reset other variables
                if (lookFired == 2 && image_index == 0)
                {
                    phase = 1;
                    lookFired = 0;
                    hasFired = false;
                }
                break;
            case 1: // slide
                canHit = false;
                sprite_index = sprGreyDevilMove;

                // this increases grey devil's hitbox. we make this an ellipse rather than a square because otherwise mega man would be hit by a lot of empty space.
                with (collision_ellipse(x - 32, y + 8, x + 32, y + 32, objMegaman, false, true))
                {
                    if (iFrames == 0 && canHit)
                    {
                        with other
                        {
                            entityEntityCollision(4);
                        }
                    }
                }

                // the boss otherwise deals no combat damage, this is to stop mega man from being hit by dead air as he jumps over him.
                contactDamage = 0;

                // during this phase, if any gloop is on the floor (not mega man), destroy it.
                if (image_index >= 2)
                {
                    with (objGreyDevilGloop)
                    {
                        instance_create(x, y, objExplosion);
                        instance_destroy();
                    }

                    // move grey devil.
                    xspeed = 2 * image_xscale;
                }

                // grey devil will only repeat the last two frames of his animation.
                imageNoMin = 2;
                imageTimerMax = 14;

                // if grey devil reaches edge of room or wall, he turns round and changes to phase 2.
                if ((x <= view_xview + 26 && image_xscale == -1) || (x >= view_xview + view_wview - 26 && image_xscale == 1)
                    || (checkSolid(-2, - 1) && image_xscale == -1) || (checkSolid(2, - 1) && image_xscale == 1))
                {
                    xspeed = 0;
                    image_index = 1;
                    phase = 2;
                    image_xscale *= -1;
                }
                break;
            case 2: // fire gloop balls
                imageNoMin = 0;
                contactDamage = 4;
                sprite_index = sprGreyDevilReform;
                imageTimerMax = 16;
                if (image_index == 2) // grey devil fires three globules
                {
                    var i; for ( i = 0; i < 3; i += 1)
                    {
                        var inst;
                        inst = instance_create(x, y - 24, objGreyDevilGloop);
                        if (shotsFired mod 3 == 0 || shotsFired mod 3 == 1)
                            inst.xspeed = (1.24 + (1 * i)) * image_xscale;
                        else
                            inst.xspeed = (2.24 + (1 * i)) * image_xscale;
                    }
                    phase = 0; // reset grey devil.
                    shotsFired += 1;
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
with (objGloop)
    instance_destroy();
with (objGreyDevilGloop)
    instance_destroy();
event_inherited();
#define Draw_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();
