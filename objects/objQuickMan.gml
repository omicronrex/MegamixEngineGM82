#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();

healthpointsStart = 28;
healthpoints = healthpointsStart;

blockCollision = 1;

stopOnFlash = true;
ground = false;

pose = sprQuickManPose;
poseImgSpeed = 12 / 60;
image_index = 13;

contactDamage = 4;

phase = 0;
phaseTimer = 0;
xDistanceTravelled = 0;
has_fired = false;
jump_count = 0;
bugActive = false;

// tailor these variables at your leisure:

run_speed = 3;
run_time = 60;

// sometimes doesn't jump a full 3 times
aiBug = false;

// how high Quick Man jumps:
jumpHeightFor[0] = 32;
jumpHeightFor[1] = 96;
jumpHeightFor[2] = 128;

// affects where Quick Man tries to land next to Mega Man
jump_x_offset[0] = -32;
jump_x_offset[1] = 0;
jump_x_offset[2] = 32;

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

// MaGMML3
enemyDamageValue(objSparkChaser, 4);
enemyDamageValue(objLaserTrident, 3);
enemyDamageValue(objWaterShield, 2);
enemyDamageValue(objTornadoBlow, 2);
enemyDamageValue(objThunderBeam, 1);
enemyDamageValue(objBreakDash, 2);
enemyDamageValue(objMagneticShockwave, 2);
enemyDamageValue(objIceWall, 2);

// MaGMML2
enemyDamageValue(objHornetChaser, 2);
enemyDamageValue(objJewelSatellite, 0);
enemyDamageValue(objGrabBuster, 2);
enemyDamageValue(objTripleBlade, 0);
enemyDamageValue(objWheelCutter, 0);
enemyDamageValue(objSlashClaw, 2);
enemyDamageValue(objSakugarne, 1);
enemyDamageValue(objSuperArrow, 0);
enemyDamageValue(objWireAdapter, 4);

// MaGMML1
enemyDamageValue(objMetalBlade, 0);
enemyDamageValue(objGeminiLaser, 4);
enemyDamageValue(objSolarBlaze, 2);
enemyDamageValue(objTopSpin, 1);
enemyDamageValue(objThunderWool, 2);
enemyDamageValue(objPharaohShot, 2);
enemyDamageValue(objBlackHoleBomb, 4);
enemyDamageValue(objMagicCard, 0);

// MaG48HMML
enemyDamageValue(objFlameMixer, 2);
enemyDamageValue(objRainFlush, 2);
enemyDamageValue(objSparkShock, 2);
enemyDamageValue(objSearchSnake, 4);
enemyDamageValue(objTenguBlade, 3);
enemyDamageValue(objTenguDash, 3);
enemyDamageValue(objTenguDisk, 4);
enemyDamageValue(objSaltWater, 0);
enemyDamageValue(objConcreteShot, 2);
enemyDamageValue(objHomingSniper, 6);

// MaG24HMML
enemyDamageValue(objSuperArmBlockProjectile, 2);
enemyDamageValue(objSuperArmDebris, 2);
enemyDamageValue(objChillShot, 2);
enemyDamageValue(objChillSpikeLanded, 4);

// Misc.
enemyDamageValue(objPowerStone, 2);
enemyDamageValue(objPlantBarrier, 0);
enemyDamageValue(objBrickWeapon, 2);
enemyDamageValue(objIceSlasher, 1);
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();

if (entityCanStep())
{
    if (isFight)
    {
        image_speed = 0;
        sprite_index = sprQuickMan;

        startPhase = phase;

        switch (phase)
        {
            case 0: // jump at Mega Man
            // AI bug:
                if (bugActive)
                {
                    image_index = 13;
                    if (checkSolid(0, 0, 1, 1))
                    {
                        y -= 16; // simulate getting out depends on height of jump selected
                        if (irandom(2) == 2)
                        {
                            // simulate random jump height select
                            jump_count += 1;
                            has_fired = false;
                        }
                        jump_count += 1;
                    }
                    else
                        bugActive = false;

                    // abort if jumping too many times -- don't want to jump out of arena!
                    if (jump_count > 3)
                    {
                        bugActive = false;
                        phase = 1;
                    }

                    if (bugActive)
                        break;
                }

                // normal:
                if (phaseTimer == 0)
                {
                    jump_count += 1;
                    image_index = 13;

                    // turn to face Mega Man:
                    calibrateDirection();

                    jump_type = irandom(2); // 0: small, 1: medium, 2: high

                    // doesn't perform small jump if Mega Man is too far away:
                    if (instance_exists(target))
                        if (abs(target.x - x) > 120 && jump_type == 0)
                            jump_type = 1;

                    var jumpHeight, x_start, x_end, x_displacement;

                    // calculate yspeed:
                    jumpHeight = jumpHeightFor[jump_type];

                    // velocity required to reach jump height derived with kinematics equations:
                    yspeed = -sqrt(abs(2 * gravAccel * jumpHeight));
                    airTime = abs(2 * yspeed / gravAccel);

                    // calculate xspeed:
                    x_start = x;
                    if (instance_exists(target))
                        x_end = target.x + jump_x_offset[jump_type]
                            * image_xscale;
                    else
                        x_end = x;

                    x_displacement = x_end - x_start;
                    pref_xspeed = x_displacement / airTime;
                }
                else if (ground)
                {
                    // landed; restart jump (or next phase after three jumps)
                    if (jump_count >= 3)
                    {
                        // next phase (running)
                        jump_count = 0;
                        phase = 1;
                        has_fired = false;
                    }
                    else
                    {
                        // restart jump
                        startPhase = -1;
                    }
                }

                // fire bullets at Mega Man:
                if (jump_count == 2 && !has_fired && yspeed >= 0
                    && instance_exists(target))
                {
                    has_fired = true;

                    // set shooting sprite:
                    image_index = 14;

                    // fire bullet:
                    var i;
                    for (i = 0; i < 3; i += 1)
                    {
                        with (instance_create(x, y, objQuickManBoomerang))
                        {
                            faction = other.faction;
                            target = other.target;
                            var dir = point_direction(x, y, target.x, target.y);
                            xspeed = cos(degtorad(dir)) * _speed * (0.5 + i / 2);
                            yspeed = -sin(degtorad(dir)) * _speed;
                            dist = point_distance(x, y, x + (target.x - x) * (0.5 + i / 2), target.y) + 48;
                        }
                    }
                }

                xspeed = pref_xspeed;

                break;
            case 1: // Run for 1 second:
                if (phaseTimer == 0)
                {
                    // turn to face Mega Man:
                    calibrateDirection();
                }
                xspeed = run_speed * image_xscale;

                // hop over small obstacle:
                if (checkSolid(xspeed, yspeed, 0, 1)
                    && !checkSolid(0, yspeed, 0, 1)
                    && !checkSolid(xspeed, yspeed - 6, 0, 1)
                    && !checkSolid(0, -6, 0, 1))
                {
                    // adjust position slightly:
                    y -= 6;
                }

                xDistanceTravelled += abs(xspeed);
                image_index = 8 + (xDistanceTravelled div 10) mod 4;
                if (phaseTimer > run_time)
                {
                    phase = 0;

                    // trigger AI bug:
                    if (aiBug) // sometimes jumps fewer times
                    // must be next to a tall wall to trigger:
                        if (place_meeting(x + xspeed * 1.5, y - 20, objSolid))
                        {
                            bugActive = true;
                            y += 16; // sink into floor
                        }
                }
                break;
        }

        if (bugActive)
        {
            blockCollision = 0;
            x -= xspeed;
            y -= yspeed;
        }
        else
        {
            blockCollision = 1;
        }

        phaseTimer += 1;

        // check if phase has changed and reset some variables
        if (phase != startPhase)
        {
            phaseTimer = 0;
        }
    }
}

// flash stopper drains Quick Man's health:
if (global.timeStopped)
{
    healthpoints -= 1 / 30;
    if (healthpoints <= 0)
        event_user(EV_DEATH);

    // flash stopper drains extra fast:
    with (objFlashStopper)
        phase -= 3;
}
#define Other_20
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
with (objQuickManBoomerang)
{
    instance_create(x, y, objExplosion);
    instance_destroy();
}

event_inherited();
#define Other_22
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
// weaponSetup("QUICK MAN", make_color_rgb(231, 0, 90), make_color_rgb(255, 189, 0), sprWeaponIconsMetalBlade);
#define Other_24
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if (global.keyShootPressed[playerID] && !playerIsLocked(PL_LOCK_SHOOT))
{
    i = fireWeapon(24, 1, objQuickMan, 3, 2, 2, 1);
    if (instance_exists(i))
    {
        // instance_create(i.x, i.y, objExplosion);
        i.isFight = 1;
        i.startIntro = 0;
        i.faction = 2;
        i.pierces = 2;
        i.grav = 0.25;
        i.phase = 1;
        i.drawBoss = 1;
    }
}
