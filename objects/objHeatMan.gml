#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();
healthpointsStart = 28;
healthpoints = healthpointsStart;

customPose = true;
hasTriggeredFall = false;
introType = 0;
contactDamage = 8;

ground = false;
attackTimer = 0;

phase = 0;
phaseTimer = 0;
targetX = 0;

// Health Bar
healthBarPrimaryColor[1] = 18;
healthBarSecondaryColor[1] = 34;

// Music
music = "Mega_Man_2.nsf";
musicType = "VGM";
musicTrackNumber = 17;

// Damage Table
enemyDamageValue(objBusterShot, 2);
enemyDamageValue(objBusterShotHalfCharged, 2);
enemyDamageValue(objBusterShotCharged, 4);
enemyDamageValue(objSparkChaser, 1);
enemyDamageValue(objLaserTrident, 2);
enemyDamageValue(objWaterShield, 5);
enemyDamageValue(objTornadoBlow, 4);
enemyDamageValue(objThunderBeam, 1);
enemyDamageValue(objMagneticShockwave, 1);
enemyDamageValue(objIceWall, 5);
enemyDamageValue(objBreakDash, 2);

// MaG48HMML
// Flame Mixer heals Heat Man
enemyDamageValue(objSaltWater, 2);
enemyDamageValue(objRainFlush, 6);
enemyDamageValue(objSparkShock, 1);
enemyDamageValue(objSearchSnake, 1);
enemyDamageValue(objTenguBlade, 2);
enemyDamageValue(objTenguDash, 2);
enemyDamageValue(objTenguDisk, 2);
enemyDamageValue(objConcreteShot, 2);
enemyDamageValue(objHomingSniper, 0);

// MaGMML2
enemyDamageValue(objHornetChaser, 1);
enemyDamageValue(objJewelSatellite, 1);
enemyDamageValue(objGrabBuster, 2);
enemyDamageValue(objTripleBlade, 1);
enemyDamageValue(objSlashClaw, 2);
enemyDamageValue(objWheelCutter, 1);
enemyDamageValue(objSakugarne, 4);
enemyDamageValue(objSuperArrow, 2);
enemyDamageValue(objWireAdapter, 2);

// MaGMML1
enemyDamageValue(objMetalBlade, 1);
enemyDamageValue(objGeminiLaser, 1);

// Solar Blaze heals Heat Man
enemyDamageValue(objTopSpin, 5);
enemyDamageValue(objThunderWool, 1);

// Pharaoh Shot heals Heat Man
enemyDamageValue(objBlackHoleBomb, 2);
enemyDamageValue(objMagicCard, 2);

// MaG24HMML
enemyDamageValue(objSuperArmBlockProjectile, 2);
enemyDamageValue(objSuperArmDebris, 2);
enemyDamageValue(objChillShot, 2);
enemyDamageValue(objChillSpikeLanded, 4);

// Misc.
enemyDamageValue(objPowerStone, 2);
enemyDamageValue(objPlantBarrier, 0);
enemyDamageValue(objBrickWeapon, 2);
enemyDamageValue(objIceSlasher, 4);
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
var xscl; xscl = image_xscale;
image_xscale=1;
event_inherited();
image_xscale=xscl;

if (entityCanStep())
{
    // Heat Man's custom intro
    if (startIntro)
    {
        y -= view_hview;
        canFillHealthBar = false;
        sprite_index = sprHeatmanPose;
        image_index = 0;
        startIntro = false;
        isIntro = true;
        visible = true;
        calibrateDirection();
        grav = gravStart;
    }
    else if (isIntro)
    {
        if (y >= ystart || hasTriggeredFall)
        {
            // Since bosses do not have gravity during intros, we need to reuse this here.
            hasTriggeredFall = true;
            y = ystart;
            attackTimer+=1;
            if (attackTimer < 8)
                image_index = 1;
            if (attackTimer == 8)
                image_speed = 0.3; // 12 / 60;
            if (image_index > 12)
            {
                image_speed = 0;
                canFillHealthBar = true;
                isIntro = false;
                ground = true;
                attackTimer = 0;
                blockCollision = blockCollisionStart;
            }
        }
    }

    // Fight Data
    if (isFight == true)
    {
        sprite_index = sprHeatman;

        var prevPhase; prevPhase = phase;

        if (!ground && phase != 2)
            image_index = 13;
        else
            switch (phase)
            {
                // shooting
                case 0:
                    xspeed = 0;
                    image_index = 5;
                    if (phaseTimer >= 8) // 16
                    {
                        image_index = 6;
                        if (phaseTimer >= 16) // 32
                            image_index = 0;
                    }
                    if (phaseTimer == 8) // 16
                    {
                        // shoot
                        calibrateDirection();
                        var offset;
                        offset[0] = 0;
                        offset[1] = 32;
                        offset[2] = -20;
                        if (!instance_exists(target))
                            break;
                        var i; for ( i = 0; i < 3; i+=1)
                        {
                            with (instance_create(x + 8 * image_xscale, y, objHeatManFire))
                            {
                                var offs; offs = other.image_xscale * (other.target.x - x) + offset[i];
                                var destX; destX = x + offs * other.image_xscale;
                                var time; time = 50;
                                xspeed = (destX - x) / time;
                                yspeed = -(grav * time) / 2;
                            }
                        }
                    }

                    // if time runs out, reset phase
                    if (phaseTimer >= 120)
                    {
                        phaseTimer = 0;
                    }

                    // if hit, switch phase
                    if (iFrames > 0)
                    {
                        phase = 1;
                    }
                    break;
                // flame
                case 1:
                    xspeed = 0;
                    if (phaseTimer <= 22)
                        image_index = 1;
                    else
                    {
                        image_index = 3 + (phaseTimer div 3) mod 2;
                        if (phaseTimer == 23)
                        {
                            playSFX(sfxHeatManTackle);
                        }
                    }
                    if (phaseTimer >= 120)
                    {
                        phase = 2;
                    }
                    break;
                // atomic dash
                case 2:
                    if (phaseTimer == 0)
                    {
                        y -= 8;
                        grav = 0;

                        if (instance_exists(target))
                            targetX = target.x;
                        else
                        {
                            // random destination
                            targetX = view_xview[0] + random(view_wview[0]);
                        }

                        // no available space; pick target at random.
                        var i; i = 32;
                        while (checkSolid(targetX - x, 0) && i > 0)
                        {
                            targetX = view_xview[0] + random(view_wview[0]);
                            i-=1;
                        }
                        image_xscale = 1;
                        if (targetX < x)
                            image_xscale = -1;
                        deTimer = 0;

                        // give up
                        if (i == 0)
                            phase = 0;
                    }
                    image_index = 7 + (phaseTimer div 5);

                    // Play tackle sound
                    if ((image_index == 7) && (!audio_is_playing(sfxHeatManTackle)))
                    {
                        playSFX(sfxHeatManTackle);
                    }

                    if (image_index >= 10)
                    {
                        image_index = 10 + (phaseTimer div 4) mod 3;
                        xspeed = 5 * image_xscale;
                        grav = 0;
                    }
                    if (((x - targetX) * image_xscale >= 0) || xcoll!=0)
                    {
                        // reached destination; stop
                        xspeed = 0;

                        // grav = 0.25;
                        deTimer += 1;
                        image_index = 9 - (deTimer div 5); // 9 - (phaseTimer div 5);
                        if (image_index < 7)
                        {
                            image_index = 13;
                            grav = 0.25;
                            y += 8;
                            calibrateDirection();
                            phase = 3;
                            yspeed = 8;
                        }
                    }
                    break;
                // Animation for turning back
                case 3:
                    if (ground)
                    {

                        attackTimer+=1;
                        if (attackTimer == 4)
                        {
                            image_index = 1;
                            image_speed = 0.2;
                        }
                        if (image_index == 3)
                        {
                            image_index = 0;
                            image_speed = 0;
                        }
                        if (attackTimer >= 20)
                        {
                            phase = 0;
                            attackTimer = 0;
                        }

                        // if hit, switch phase
                        if (iFrames > 0)
                        {
                            phase = 1;
                        }
                    }
                    break;
            }

        phaseTimer+=1;

        // new phase -=1 reset timer
        if (prevPhase != phase)
        {
            phaseTimer = 0;
        }
    }
}
#define Other_20
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();

// Destroy Atomic Fire on death
with (objHeatManFire)
{
    instance_create(x, y, objExplosion);
    instance_destroy();
}
#define Other_21
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();

// guard if on fire etc
if (phase == 2)
{
    other.guardCancel = 2;
}
if (phase == 1)
{
    other.guardCancel = 1;
}

if ((other.object_index == objFlameMixer) || (other.object_index == objSolarBlaze)
    || (other.object_index == objPharaohShot))
{
    iFrames = 0;
    with (other)
    {
        event_user(EV_DEATH);
    }
    other.guardCancel = 2;
    healthpoints += 28;
}
