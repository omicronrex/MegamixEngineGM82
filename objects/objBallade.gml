#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();

healthpointsStart = 28;
healthpoints = healthpointsStart;
contactDamage = 4;
customPose = true;
ground = false;
attackTimer = 0;
hasTriggeredFall = false;
sd = noone;
introType = 0;
bossTriggered = true;
phase = 0;
attackRandomiser = 1;
oldAttack = -1;
initialAttack = false; // ballade always starts the fight by jumping towards mega man.
jumpY = -5;
findWall = 0;
jumpToWall = false;
delay = 0;
hasFired = false;
shotsFired = 0;
grav = 0.25;
manualColors = true;
form = 0; //SET IN CREATION CODE: Use this to set Ballade's sprites.

// Health Bar
healthBarPrimaryColor[1] = make_color_rgb(128, 0, 240);
healthBarSecondaryColor[1] = make_color_rgb(240, 184, 56);

// Music
music = "Mega_Man_4GB.gbs";
musicType = "VGM";
musicTrackNumber = 20;

// Damage Table
enemyDamageValue(objBusterShot, 1);
enemyDamageValue(objBusterShotHalfCharged, 1);
enemyDamageValue(objBusterShotCharged, 3);

// MaGMML3
enemyDamageValue(objSparkChaser, 2);
enemyDamageValue(objLaserTrident, 1);
enemyDamageValue(objWaterShield, 0);
enemyDamageValue(objTornadoBlow, 1);
enemyDamageValue(objThunderBeam, 2);
enemyDamageValue(objBreakDash, 5);
enemyDamageValue(objMagneticShockwave, 2);
enemyDamageValue(objIceWall, 2);

// MaGMML2
enemyDamageValue(objHornetChaser, 2);
enemyDamageValue(objJewelSatellite, 5);
enemyDamageValue(objGrabBuster, 1);
enemyDamageValue(objTripleBlade, 0);
enemyDamageValue(objWheelCutter, 0);
enemyDamageValue(objSlashClaw, 1);
enemyDamageValue(objSakugarne, 2);
enemyDamageValue(objSuperArrow, 3);
enemyDamageValue(objWireAdapter, 1);

// MaGMML1
enemyDamageValue(objMetalBlade, 4);
enemyDamageValue(objGeminiLaser, 2);
enemyDamageValue(objSolarBlaze, 2);
enemyDamageValue(objTopSpin, 1);
enemyDamageValue(objThunderWool, 0);
enemyDamageValue(objPharaohShot, 1);
enemyDamageValue(objBlackHoleBomb, 1);
enemyDamageValue(objMagicCard, 1);

// MaG48HMML
enemyDamageValue(objFlameMixer, 2);
enemyDamageValue(objRainFlush, 1);
enemyDamageValue(objSparkShock, 1);
enemyDamageValue(objSearchSnake, 2);
enemyDamageValue(objTenguBlade, 1);
enemyDamageValue(objTenguDash, 3);
enemyDamageValue(objTenguDisk, 2);
enemyDamageValue(objSaltWater, 1);
enemyDamageValue(objConcreteShot, 1);
enemyDamageValue(objHomingSniper, 4);

// MaG24HMML
enemyDamageValue(objSuperArmBlockProjectile, 0);
enemyDamageValue(objSuperArmDebris, 0);
enemyDamageValue(objChillShot, 0);
enemyDamageValue(objChillSpikeLanded, 0);

// Misc.
enemyDamageValue(objPowerStone, 2);
enemyDamageValue(objPlantBarrier, 0);
enemyDamageValue(objBrickWeapon, 2);
enemyDamageValue(objIceSlasher, 0);
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
// leave this. this is needed.
event_inherited();

// all of ballade's events trigger when the game isn't frozen.
if (entityCanStep())
{
    // ballade's custom intro
    if (startIntro)
    {
        y += view_yview - bbox_bottom;
        canFillHealthBar = false;
        image_index = 4;
        startIntro = false;
        isIntro = true;
        visible=1;
        calibrateDirection();
    }
    if (isIntro)
    {
        // custom intro:
        if (y <= ystart && !hasTriggeredFall)
            y += 4;
        if (y >= ystart || hasTriggeredFall)
        {
            if (!hasTriggeredFall)
            {
                y = ystart;
                hasTriggeredFall = true;
                image_index = 2;
            }
            image_speed = 0;
            attackTimer += 1;

            // intro animation
            if (attackTimer == 8) // 15
                image_index = 3;
            if (attackTimer == 58)
            {
                canFillHealthBar = true;
                isIntro = false;
                attackTimer = 0;
                blockCollision = blockCollisionStart;
                grav = gravStart;
                ground=true;
            }
        }
    }
}
if (entityCanStep())
{
    if (isFight)
    {
        if (instance_exists(target))
        {
            strMMX = target.x;
            strMMY = target.y;
        }
        image_speed = 0;
        attackTimer += 1;
        if (delay > 0)
            delay -= 1;

        // setup jump animation
        if (yspeed < 0)
            image_index = 4;

        // if (checkSolid(24*image_xscale,-2)) // ballade cannot touch the sides of the arena, for what-ever reason.
        // xspeed = 0;
        switch (phase)
        {
            case 0: // choose attack
                if (ground)
                {
                    if (image_index == 4)
                        image_index = 2;
                    xspeed = 0;
                }
                else
                    attackTimer = 0;
                if (floor(attackRandomiser) == oldAttack)
                    attackRandomiser = choose(1, 1.5, 2, 2, 3, 3);
                calibrateDirection();
                if (attackTimer >= 15)
                {
                    attackTimer = 0;
                    oldAttack = floor(attackRandomiser);
                    phase = attackRandomiser;
                    initialAttack = true;
                }
                break;
            case 1:
            case 1.5: // jump to mega man
            // phase 1 = ballade jumps twice
            // phase 2 = ballade jumps once.
            // ballade jumps twice, on the first jump he creates a mine.
                if (attackTimer < 10 || ground && shotsFired > 0 && yspeed >= 0) // ballade events on the ground
                {
                    calibrateDirection();
                    image_index = 2;
                    xspeed = 0;
                    if (shotsFired == 1 && attackTimer > 11 && phase == 1)
                        attackTimer = 0;
                    if (shotsFired == 2 && attackTimer > 11 || shotsFired >= 1 && attackTimer > 11 && phase == 1.5)
                    {
                        shotsFired = 0;
                        attackTimer = 0;
                        phase = 0;
                    }
                }
                if (attackTimer == 10)
                {
                    image_index = 4;
                    if (abs(strMMX - x) > 32 && shotsFired == 0) // if ballade is next to mega man at the time of creating the mine, create the mine on mega man.
                    {
                        instance_create(x, y + 4, objBalladeBalladeMine);
                        playSFX(sfxBalladeMine);
                    }
                    else if (shotsFired == 0)
                    {
                        instance_create(x + 16 * image_xscale, y + 4, objBalladeBalladeMine);
                        playSFX(sfxBalladeMine);
                    }
                    yspeed = jumpY;
                }
                if (attackTimer == 11) // jump across room
                {
                    sd = instance_create(strMMX, strMMY, objCannonjoeBullet);
                    with (sd)
                    {
                        contactDamage = 0;
                        reflectable = false;
                        var i; for ( i = 0; i < 24; i += 1) // ballade cannot jump next to the wall, so offset the target object slightly away from the wall.
                        {
                            if (checkSolid(-24, 0))
                            {
                                x += 1;
                            }
                            if (checkSolid(24, 0))
                            {
                                x -= 1;
                            }
                        }
                    }
                    xspeed = xSpeedAim(x, y, sd.x, sd.y, yspeed, grav); // jump towards target object and remove it.
                    shotsFired += 1;
                    with (sd)
                    {
                        instance_destroy();
                    }
                }
                break;
            case 2: // walk to mega man
                if (attackTimer < 10 || xspeed == 0)
                {
                    image_index = 0;
                    calibrateDirection();
                }
                if (attackTimer == 10 && shotsFired == 0)
                {
                    xspeed = 3 * image_xscale;
                    delay = 24; // ballade has a slight delay before he stops dead in his tracks
                    shotsFired = 1;
                }
                if (xspeed != 0)
                    image_index = 5 + ((attackTimer / 6) mod 4); // animate walk
                if (checkSolid(24 * image_xscale, 0))
                    xspeed = 0;
                if (attackTimer >= 15 && delay == 0 && (x >= strMMX && image_xscale == 1 || x <= strMMX && image_xscale == -1 || xspeed == 0)) // if ballade has reached mega man or a wall, stop dead.
                {
                    xspeed = 0;
                    image_index = 0;
                    attackTimer = 0;
                    shotsFired = 0;
                    phase = 0;
                }
                break;
            case 3: // fire ballade cracker
                if (attackTimer < 10)
                {
                    image_index = 0;
                    calibrateDirection();
                }
                if (attackTimer == 10)
                {
                    image_index = 3;
                    calibrateDirection();
                }
                if (attackTimer == 25 && shotsFired == 0)
                {
                    shotsFired = 1;
                    image_index = 1;
                    with (instance_create(x + 2 * image_xscale, y + 3, objBalladeBalladeCracker))
                    {
                        image_xscale = other.image_xscale;
                        xspeed = 3 * image_xscale;
                        instance_create(x, y, objExplosion);
                    }
                }
                if (attackTimer == 40)
                    image_index = 0;
                if (attackTimer == 70)
                {
                    attackTimer = 0;
                    shotsFired = 0;
                    phase = 0;
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
with (objBalladeBalladeMine)
    instance_create(x, y, objExplosion);
instance_destroy();
with (objBalladeBalladeCracker)
    instance_create(x, y, objExplosion);
instance_destroy();
with (objCannonjoeBullet)
    instance_destroy();
with (objHarmfulExplosion)
    instance_destroy();
event_inherited();
#define Draw_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();
// Draw Ballade's sprite index based on creation code
if (form != 0)
{
    sprite_index = sprBallade2;
}
else
{
    sprite_index = sprBallade1;
}
