#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
// Using Giant Suzy:
/*
Since it can spend quite some time on the ceiling, Giant Suzy works best in smaller rooms, almost boss corridor-like in size.
*/

event_inherited();

healthpointsStart = 28;
healthpoints = healthpointsStart;

healthBarPrimaryColor[1] = 18;
healthBarSecondaryColor[1] = 45;

imageOffset = 0;
contactDamage = 4;
customPose = true;

ground = false;

attackTimer = 0;
hasTriggeredFall = false;
hasTriggeredQuake = false;

introType = 0;
shakeTimer = 0;

init = 0;
col = 0; //SET IN CREATION CODE: use this to set Giant Suzy's colours.

spd = 0;
phase = 0;
jumpY = -4.5;
yMoveDir = -1;
hasFired = false;
grav = 0;

// Music
music = "Mega_Man_3GB.gbs";
musicType = "VGM";
musicTrackNumber = 9;

// Damage Table
enemyDamageValue(objBusterShot, 1);
enemyDamageValue(objBusterShotHalfCharged, 1);
enemyDamageValue(objBusterShotCharged, 3);

// MaGMML3
enemyDamageValue(objSparkChaser, 2);
enemyDamageValue(objLaserTrident, 2);
enemyDamageValue(objWaterShield, 1);
enemyDamageValue(objTornadoBlow, 1);
enemyDamageValue(objThunderBeam, 4);
enemyDamageValue(objBreakDash, 2);
enemyDamageValue(objMagneticShockwave, 2);
enemyDamageValue(objIceWall, 2);

// MaGMML2
enemyDamageValue(objHornetChaser, 1);
enemyDamageValue(objJewelSatellite, 1);
enemyDamageValue(objGrabBuster, 4);
enemyDamageValue(objTripleBlade, 1);
enemyDamageValue(objWheelCutter, 2);
enemyDamageValue(objSlashClaw, 2);
enemyDamageValue(objSakugarne, 1);
enemyDamageValue(objSuperArrow, 1);
enemyDamageValue(objWireAdapter, 2);

// MaGMML1
enemyDamageValue(objMetalBlade, 1);
enemyDamageValue(objGeminiLaser, 2);
enemyDamageValue(objSolarBlaze, 2);
enemyDamageValue(objTopSpin, 1);
enemyDamageValue(objThunderWool, 4);
enemyDamageValue(objPharaohShot, 1);
enemyDamageValue(objBlackHoleBomb, 1);
enemyDamageValue(objMagicCard, 2);

// MaG48HMML
enemyDamageValue(objFlameMixer, 2);
enemyDamageValue(objRainFlush, 1);
enemyDamageValue(objSparkShock, 4);
enemyDamageValue(objSearchSnake, 2);
enemyDamageValue(objTenguBlade, 1);
enemyDamageValue(objTenguDash, 3);
enemyDamageValue(objTenguDisk, 1);
enemyDamageValue(objSaltWater, 2);
enemyDamageValue(objConcreteShot, 1);
enemyDamageValue(objHomingSniper, 1);

// MaG24HMML
enemyDamageValue(objSuperArmBlockProjectile, 1);
enemyDamageValue(objSuperArmDebris, 1);
enemyDamageValue(objChillShot, 1);
enemyDamageValue(objChillSpikeLanded, 1);

// Misc.
enemyDamageValue(objPowerStone, 2);
enemyDamageValue(objPlantBarrier, 1);
enemyDamageValue(objBrickWeapon, 2);
enemyDamageValue(objIceSlasher, 1);
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
// leave this. this is needed.
event_inherited();

if (!init)
{
    switch (col)
    {
        // Red colours (default)
        case 0:
            sprite_index = sprGiantSuzy;
            healthBarPrimaryColor[1] = 18;
            healthBarSecondaryColor[1] = 45;
        // Official art colours
        case 1:
            sprite_index = sprGiantSuzyArtColours;
            healthBarPrimaryColor[1] = 28;
            healthBarSecondaryColor[1] = 42;
    }
    init+=1;
}

// all of giant suzy's events trigger when the game isn't frozen.
if (!global.frozen)
{
    // giant suzy can shake the screen even outside the fight (for his intro), so this is stored outside of the other events.
    if (shakeTimer > 0)
    {
        if (shakeTimer mod 25 == 24)
        {
            image_index = (imageOffset * 3) + 1;
        }
        if (shakeTimer mod 25 == 20)
        {
            image_index = (imageOffset * 3) + 2;
        }
        if (shakeTimer mod 25 == 15)
        {
            image_index = (imageOffset * 3) + 3;
        }
        if (shakeTimer mod 25 == 10)
        {
            image_index = (imageOffset * 3) + 2;
        }
        if (shakeTimer mod 25 == 5)
        {
            image_index = (imageOffset * 3) + 1;
        }
        if (shakeTimer == 0)
        {
            image_index = (imageOffset * 3) + 1;
        }
        shakeTimer -= 1;
        screenShake(2, 1, 1);
        if (imageOffset != 0 && shakeTimer > 15) // giant suzy only shakes mega man if it hits the floor or cieling.
        {
            with (objMegaman)
            {
                if (ground) // shunt mega man off the floor to prevent sliding and break dash
                {
                    y -= 1.5 * (irandom(3) + 1);
                }
            }
        }
    }

    // giant suzy's custom intro
    if (startIntro)
    {
        calibrateDirection();
        y -= view_hview;
        canFillHealthBar = false;
        image_index = 0;
        startIntro = false;
        isIntro = true;
        visible = true;
    }
    else if (isIntro)
    {
        // custom intro:
        if (y <= ystart && !hasTriggeredFall)
        {
            hasTriggeredQuake = true;
            y += 4;
        }
        if (y >= ystart || hasTriggeredFall)
        {
            if (!hasTriggeredFall)
            {
                hasTriggeredQuake = false;
                shakeTimer = 50;
                hasTriggeredFall = true;
                imageOffset = 2;
            }
            if (shakeTimer == 50)
            {
                playSFX(sfxBikkyLand);
            }
            if (shakeTimer == 1)
            {
                imageOffset = 0;
                canFillHealthBar = true;
                attackTimer = 0;
                isIntro = false;
                grav = gravStart;
                blockCollision = blockCollisionStart;
                image_index = (imageOffset * 3) + 1;
            }
        }
    }
}
if (entityCanStep())
{
    // if giant suzy lands for any reason, shake screen.
    if ((xcoll != 0 || ycoll != 0) && !hasTriggeredQuake)
    {
        // initate shake timer
        shakeTimer = 25;
        hasTriggeredQuake = true;
        playSFX(sfxBikkyLand);

        // if in phase 5, only return to phase 1 if horzitional wall has been hit.
        if (phase == 5
            && ((checkSolid(1, 0, 1) && image_xscale == 1)
            || (checkSolid(-1, 0, 1) && image_xscale == -1)))
        {
            imageOffset = 0;
            phase = 1;
            attackTimer = 0;
            grav = 0;
        }
        xspeed = 0;
        yspeed = 0;
        xcoll = 0;
        ycoll = 0;
    }

    // determine speed up of boss based on hitpoints. he has a minimum and a maximum speed.
    if ((32 - healthpoints) / 5.6 <= 1.5)
    {
        spd = 1.5;
    }
    else if ((32 - healthpoints) / 5.6 >= 3.5)
    {
        spd = 3.5;
    }
    else
    {
        spd = (32 - healthpoints) / 5.6;
    }
    if (isFight)
    {
        attackTimer += 1;
        switch (phase)
        {
            case 0: // choose pattern
                hasTriggeredQuake = false;
                if (attackTimer == 30)
                {
                    attackTimer = 0;
                    phase = choose(2, 3, 4, 4); // giant suzy's attack pattern is completely random according to the GB game!
                }
                break;
            case 1: // middle of moving, return to original pattern.
                grav = 0;
                if (hasTriggeredQuake && shakeTimer == 0)
                {
                    hasTriggeredQuake = false;

                    // depending on what wall it is touching, change the xscale or yscale of giant suzy.
                    if (checkSolid(1, 0, 1) && image_xscale == 1 || checkSolid(-1, 0, 1) && image_xscale == -1)
                    {
                        image_xscale *= -1;
                    }
                    if (checkSolid(0, -1) && yMoveDir == -1 || checkSolid(0, 1) && yMoveDir == 1)
                    {
                        yMoveDir *= -1;
                    }
                    attackTimer = 0;
                    phase = 0;
                }
                break;
            case 2: // move left or right
                imageOffset = 0;
                image_index = (imageOffset * 3) + 1;
                xspeed = spd * image_xscale;
                grav = 0;
                phase = 1;
                break;
            case 3: // move up or down
                if (yMoveDir == -1)
                {
                    imageOffset = 1;
                }
                else
                {
                    imageOffset = 2;
                }
                image_index = (imageOffset * 3) + 1;
                yspeed = spd * yMoveDir;
                grav = 0;
                phase = 1;
                break;
            case 4: // move up or down if going to jump across screen
            // if already in correct position, immediately move onto phase 5.
                if ((checkSolid(0, 1) && yMoveDir == -1
                    || checkSolid(0, -1) && yMoveDir == 1)
                    && yspeed == 0 && !hasFired)
                {
                    phase = 5;
                }
                else if (!hasFired) // otherwise move up or down screen.
                {
                    hasFired = true;
                    if (yMoveDir == -1)
                    {
                        imageOffset = 1;
                    }
                    else
                    {
                        imageOffset = 2;
                    }
                    image_index = (imageOffset * 3) + 1;
                    yspeed = spd * yMoveDir;
                }

                // then if out of shake, goto phase 5.
                if (shakeTimer == 0 && hasTriggeredQuake)
                {
                    yMoveDir *= -1;
                    phase = 5;
                }
                break;
            case 5: // jump across boundary
                if (shakeTimer == 0 && xspeed == 0)
                {
                    // if not shaking screen, jump
                    hasFired = false;
                    hasTriggeredQuake = false;

                    // whilst jumping, should look horizitionally
                    imageOffset = 0;
                    image_index = (imageOffset * 3) + 1;
                    xspeed = spd * image_xscale;
                    yspeed = jumpY * (yMoveDir * -1);
                    grav = 0.325 * (yMoveDir * -1);
                }
                if (ground) // correct image offset as it moves.
                {
                    if (yMoveDir == -1)
                    {
                        imageOffset = 2;
                    }
                    else
                    {
                        imageOffset = 1;
                    }
                }
                break;
        }
    }
}
