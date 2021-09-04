#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();
healthpointsStart = 28;
healthpoints = healthpointsStart;
pose = sprGutsIdle;
poseImgSpeed = 0.1;
contactDamage = 4;
grav = 0.15;

//@cc hadmode only
myTileDepth = 1000000;

//@cc
isHard = false;

stopOnFlash = true;
ground = false;
attackTimer = 0;
jumpTimer = 0;
jumpAmount = 0;
canInitShoot = true;
phase = 0; // 0 = nothing; 1 = running; 2 = jumping; 3 = shooting;
getLastXspeed = xspeed;
shakeTimer = 0;
prevDepth = depth;
choosePhase = 0;
lastPhase = phase;
block = noone;
timer = 0;

// Health Bar
healthBarPrimaryColor[1] = 18;
healthBarSecondaryColor[1] = 33;

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
enemyDamageValue(objTornadoBlow, 1);
enemyDamageValue(objBreakDash, 4);
enemyDamageValue(objMagneticShockwave, 1);
enemyDamageValue(objThunderBeam, 1);
enemyDamageValue(objIceWall, 1);

// MaGMML2
enemyDamageValue(objHornetChaser, 1);
enemyDamageValue(objJewelSatellite, 1);
enemyDamageValue(objGrabBuster, 1);
enemyDamageValue(objTripleBlade, 1);
enemyDamageValue(objWheelCutter, 1);
enemyDamageValue(objSlashClaw, 1);
enemyDamageValue(objSakugarne, 3);
enemyDamageValue(objSuperArrow, 2);
enemyDamageValue(objWireAdapter, 1);

// MaGMML1
enemyDamageValue(objMetalBlade, 1);
enemyDamageValue(objGeminiLaser, 3);
enemyDamageValue(objSolarBlaze, 1);
enemyDamageValue(objTopSpin, 1);
enemyDamageValue(objThunderWool, 1);
enemyDamageValue(objPharaohShot, 2);
enemyDamageValue(objBlackHoleBomb, 1);
enemyDamageValue(objMagicCard, 2);

// MaG48HMML
enemyDamageValue(objFlameMixer, 1);
enemyDamageValue(objRainFlush, 1);
enemyDamageValue(objSparkShock, 1);
enemyDamageValue(objSearchSnake, 1);
enemyDamageValue(objTenguBlade, 2);
enemyDamageValue(objTenguDash, 3);
enemyDamageValue(objTenguDisk, 2);
enemyDamageValue(objSaltWater, 2);
enemyDamageValue(objConcreteShot, 1);
enemyDamageValue(objHomingSniper, 4);

// MaG24HMML
enemyDamageValue(objSuperArmBlockProjectile, 1);
enemyDamageValue(objSuperArmDebris, 1);
enemyDamageValue(objChillShot, 1);
enemyDamageValue(objChillSpikeLanded, 2);

// Misc.
enemyDamageValue(objPowerStone, 1);
enemyDamageValue(objPlantBarrier, 3);
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
    if (isFight)
    {
        switch (phase)
        {
            case 0: // Idle
                xspeed = 0;
                sprite_index = sprGutsIdle;
                image_speed = 0.15;
                attackTimer -= 1;
                if (attackTimer <= 0)
                {
                    if (attackTimer == -1)
                        phase = 2;
                    else if (lastPhase == 2)
                        phase = 1;
                    else
                    {
                        if (!isHard)
                            phase = choose(1, 2);
                        else
                            phase = choose(1, 2, 3, 2, 3, 3, 3);
                    }
                    attackTimer = 50;
                    lastPhase = 0;
                }
                break;
            case 1: // Jumping
                if (ground)
                {
                    attackTimer -= 1;
                    sprite_index = sprGutsCrouch;
                }
                if (attackTimer == 10 && ground)
                {
                    if (x > view_xview + view_wview / 1.5)
                        xspeed = -1;
                    else if (x < view_xview + view_wview / 3)
                        xspeed = 1;
                    else
                        xspeed = choose(1, -1);
                    yspeed = -3.5;
                    sprite_index = sprGutsJump;
                }
                if (ground && attackTimer == 9)
                {
                    xspeed = 0;
                    if (global.difficulty != DIFF_EASY)
                    {
                        playSFX(sfxGutsQuake);
                        screenShake(38, 1, 1);
                    }
                }
                if (ground && attackTimer <= 0)
                {
                    lastPhase = phase;
                    phase = 0;
                    attackTimer = 30;
                }
                break;
            case 2: // Shooting
                if (ground)
                {
                    attackTimer -= 1;
                    if (attackTimer > 0)
                        sprite_index = sprGutsCrouch;
                    else
                        sprite_index = sprGutsGrab;
                    if (instance_exists(block))
                    {
                        if (block.timer < 30)
                        {
                            if (instance_place(x, y - 1, block))
                                image_index = 1;
                            else
                                image_index = 0;
                        }
                        else
                            image_index = 2;
                    }
                }
                if (attackTimer == 10 && ground)
                {
                    yspeed = -3.5;
                    sprite_index = sprGutsJump;
                }
                if (ground && attackTimer == 9)
                {
                    xspeed = 0;
                    if (global.difficulty != DIFF_EASY)
                    {
                        playSFX(sfxGutsQuake);
                        screenShake(38, 1, 1);
                    }
                }
                if (attackTimer == 0)
                {
                    block = instance_create(x, view_yview, objGutsBossBlock);
                }
                if (!instance_exists(block) && attackTimer < 0)
                {
                    lastPhase = phase;
                    phase = 0;
                    attackTimer = 30;
                }
                break;
            case 3:
                if (sprite_index != sprGutsIdle)
                {
                    sprite_index = sprGutsIdle;
                    image_index = 0;
                }
                if (ground && blockCollision)
                {
                    blockCollision = 0;
                    prevDepth = depth;
                    depth = myTileDepth + 1;
                    screenShake(30, 1, 1);
                    playSFX(sfxMM9Quake);
                    grav = 0;
                }
                else if (!blockCollision)
                {
                    timer += 1;
                    yspeed = 0.5;
                    if ((timer mod 4) == 0)
                        image_xscale *= -1;
                    if (timer > sprite_get_height(sprite_index) * 2)
                    {
                        phase = 4;
                        lastPhase = phase;
                        timer = 0;
                        yspeed = 0;
                        visible = 0;
                        canHit = false;
                        canDamage = false;
                    }
                }
                break;
            case 4:
                if (timer != -1 && !blockCollision && (!checkSolid(0, 0, 1, 1)) || yspeed > 0)
                {
                    blockCollision = true;
                    depth = prevDepth;
                    image_speed = 0;
                    var cy = bboxGetYCenter();

                    if (positionCollision(bbox_left, cy, 1, 1))
                    {
                        while (checkSolid(0, 0, 1, 1))
                            x += 1;
                    }
                    else if (positionCollision(bbox_right, cy, 1, 1))
                    {
                        while (checkSolid(0, 0, 1, 1))
                            x -= 1;
                    }
                    if (instance_exists(block))
                        block.depth = prevDepth;
                }
                if (timer != -1 && sprite_index == sprGutsIdle)
                    timer += 1;
                if (timer != -1 && sprite_index == sprGutsIdle && timer == 160)
                {
                    if (instance_exists(target))
                    {
                        newX = target.x;
                        with (target)
                        {
                            if (checkSolid(0, 0, 1, 1))
                                other.newX = other.x;
                        }
                    }
                    else
                        newX = x;
                }
                if (timer != -1 && sprite_index == sprGutsIdle && timer > 60 * 3)
                {
                    screenShake(10, 1, 1);

                    sprite_index = sprGutsGrab;
                    image_index = 1;
                    block = instance_create(newX, y, objGutsBossBlock);
                    block.phase = 1;
                    block.ignoreCollision = true;
                    block.blockCollision = 0;
                    block.depth = depth;
                    yspeed = -5;
                    grav = 0.15;
                    visible = 1;
                    canHit = true;
                    canDamage = true;
                    var _x = x;
                    x = newX;
                    if (!checkSolid(0, 0, 1, 1))
                    {
                        y += distanceToSolid(x, y, 0, 8, 0) * 8 + sprite_get_height(sprite_index) - 8;
                    }
                    calibrateDirection();
                    block.x = x;
                    block.y = y;
                    timer = 0;
                    var cy = bboxGetYCenter();
                    var safeToAdjust = !checkSolid(32 * sign(newX - _x), -64, 1, 1);
                    if (safeToAdjust)
                    {
                        y -= 64;
                        if (positionCollision(bbox_left, cy, 1, 1))
                        {
                            while (checkSolid(0, 0, 1, 1))
                                x += 1;
                        }
                        else if (positionCollision(bbox_right, cy, 1, 1))
                        {
                            while (checkSolid(0, 0, 1, 1))
                                x -= 1;
                        }
                        y += 64;
                    }
                }
                else if (sprite_index == sprGutsGrab || timer == -1)
                {
                    if (timer == 0)
                    {
                        if (positionCollision(bboxGetXCenter(), bbox_bottom))
                            yspeed = -5;
                        image_index = 1;
                        if (instance_exists(block))
                        {
                            block.x = x;
                            block.y = y - 28;
                            if (yspeed < 0)
                                block.timer = 0;
                            else if (block.timer < 29)
                            {
                                block.timer = 29;
                                block.ignoreCollision = false;
                                timer = 1;
                            }
                        }
                        else
                        {
                            timer = 1;
                        }
                    }
                    else
                    {
                        image_index = 2;
                        if (timer >= 0)
                            timer += 1;
                        if (timer > 10)
                        {
                            image_index = 0;
                            timer = -1;
                            sprite_index = sprGutsIdle;
                        }
                        if (timer == -1)
                        {
                            if (ground)
                            {
                                lastPhase = 2;
                                phase = 0;
                                attackTimer = 10;
                            }
                        }
                    }
                }
                break;
        }

        // Face the player
        if (phase < 3)
            calibrateDirection();

        // stun mega man if he's on the floor while the screen is shaking
        if (phase < 4 && global.shakeTimer > 0)
        {
            if (instance_exists(objMegaman))
                with (objMegaman)
                    if (!isShocked)
                        playerGetShocked(false, 0, true, 40);
        }

        // keep mega man bouncing while stunned
        if (instance_exists(objMegaman))
            with (objMegaman)
                if ((isShocked && ground) && !(isSlide && checkSolid(0, -3 * gravDir)))
                    yspeed = (-1.5 * gravDir) * (yspeed * gravDir <= 0);
    }
}
else
{
    image_speed = 0;
}

// FOR EXAMPLE GAME ONLY: Time Stopper drains Guts Man's health
if (instance_exists(objTimeStopper))
{
    healthpoints -= 1 / 30;
    if (healthpoints <= 0)
        event_user(EV_DEATH);
}
#define Other_20
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
with (objGutsBossBlock)
    instance_create(x, y, objExplosion);
instance_destroy();
with (objGutsBossBlockRubble)
    instance_create(x, y, objExplosion);
instance_destroy();
event_inherited();
#define Other_25
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();
if (spawned)
{
    if (isHard)
    {
        enemyDamageValue(objBusterShotCharged, 3);
    }
}
