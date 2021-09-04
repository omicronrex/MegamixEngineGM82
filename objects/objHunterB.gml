#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
// This Hunter sticks to walls and floors while creating a partner that does the same.
event_inherited();

healthpointsStart = 28;
healthpoints = healthpointsStart;
pose = sprHunterB;
poseImgSpeed = 4 / 60;
contactDamage = 4;
introType = 2;

ground = false;
attackTimer = 0;
onOrOff = false;
clone = noone;
phase = 0;
spd = 2;
delay = 0;
hasFired = false;
getAngle = 0;
storeY = -1;
horVer = "h";
partnerItemDrop = -1; //this can be set to anything in creation code but -1 makes sure that it doesn't drop any items by default

// Health Bar
healthBarPrimaryColor[1] = 35;
healthBarSecondaryColor[1] = 22;

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
enemyDamageValue(objLaserTrident, 2);
enemyDamageValue(objWaterShield, 2);
enemyDamageValue(objTornadoBlow, 1);
enemyDamageValue(objThunderBeam, 1);
enemyDamageValue(objBreakDash, 4);
enemyDamageValue(objMagneticShockwave, 6);
enemyDamageValue(objIceWall, 2);

// MaGMML2
enemyDamageValue(objHornetChaser, 4);
enemyDamageValue(objJewelSatellite, 2);
enemyDamageValue(objGrabBuster, 2);
enemyDamageValue(objTripleBlade, 1);
enemyDamageValue(objWheelCutter, 2);
enemyDamageValue(objSlashClaw, 1);
enemyDamageValue(objSakugarne, 2);
enemyDamageValue(objSuperArrow, 2);
enemyDamageValue(objWireAdapter, 1);

// MaGMML1
enemyDamageValue(objMetalBlade, 2);
enemyDamageValue(objGeminiLaser, 4);
enemyDamageValue(objSolarBlaze, 1);
enemyDamageValue(objTopSpin, 1);
enemyDamageValue(objThunderWool, 1);
enemyDamageValue(objPharaohShot, 2);
enemyDamageValue(objBlackHoleBomb, 1);
enemyDamageValue(objMagicCard, 1);

// MaG48HMML
enemyDamageValue(objFlameMixer, 2);
enemyDamageValue(objRainFlush, 2);
enemyDamageValue(objSparkShock, 1);
enemyDamageValue(objSearchSnake, 5);
enemyDamageValue(objTenguBlade, 1);
enemyDamageValue(objTenguDash, 4);
enemyDamageValue(objTenguDisk, 1);
enemyDamageValue(objSaltWater, 2);
enemyDamageValue(objConcreteShot, 1);
enemyDamageValue(objHomingSniper, 1);

// MaG24HMML
enemyDamageValue(objSuperArmBlockProjectile, 1);
enemyDamageValue(objSuperArmDebris, 1);
enemyDamageValue(objChillShot, 1);
enemyDamageValue(objChillSpikeLanded, 4);

// Misc.
enemyDamageValue(objPowerStone, 4);
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

// all of hunter's events trigger when the game isn't frozen. he isn't weak to flash stopper, so no need to check whether that is used or not!
if (entityCanStep())
{
    if (isIntro)
    {
        with (objHunterPlatform)
        {
            timerMax = 9999;
            timerN = timerMax;
        }
    }
    if (isFight == true)
    {
        // this sets up hunter's movement variables.
        image_speed = 0;
        attackTimer += 1;
        grav = 0;
        if (delay > 0)
            delay -= 1;

        // animation hunter
        if (!onOrOff && image_index > 3 && attackTimer mod 5 == 4)
            image_index -= 1;
        else if (!onOrOff)
            image_index = 0 + ((attackTimer / 4) mod 3);
        if (onOrOff && image_index < 5 && attackTimer mod 5 == 4)
            image_index += 1;


        // if meeting up with clone, move platforms in arena.
        if (place_meeting(x, y, clone) && !hasFired)
        {
            with (objHunterPlatform)
            {
                forceMove = true;
            }
            hasFired = true;
        }
        if (!place_meeting(x, y, clone) && hasFired)
        {
            hasFired = false;
            delay = 32;
        }
        if (attackTimer == 128) // alternate between which eye is open
        {
            onOrOff = !onOrOff;
            attackTimer = 0;
        }
        with (objHunterPlatform) // hunter platforms only move when the clones connect with each other, so otherwise stop them from moving.
        {
            if (timerN != 0)
                timerN = timerMax;
        }
        switch (phase)
        {
            case 0: // config
                with (objHunterPlatform)
                    forceMove = true;
                if (object_index != objHunterBPartner && xspeed == 0)
                {
                    xspeed = -2;
                    horVer = "h";
                    phase = 1;
                    onOrOff = false;
                    if (!instance_exists(clone))
                        clone = instance_create(x, y, objHunterBPartner);
                    clone.clone = id;
                    clone.itemDrop = partnerItemDrop;
                    clone.healthParent = id;//Share health bars
                }
                else if (object_index == objHunterBPartner && xspeed == 0)
                {
                    xspeed = 2;
                    horVer = "h";
                    phase = 3;
                    onOrOff = true;
                }
                break;
            case 1: // move left && lower platform
                if (!checkSolid(0, 2, 1, 1) && horVer == "h")
                {
                    xspeed = 0;
                    yspeed = 2;
                    horVer = "v";
                }
                if (checkSolid(-2, 0, 1, 1) && horVer == "h")
                {
                    xspeed = 0;
                    yspeed = -2;
                    horVer = "v";
                }
                if ((checkSolid(0, 2, 1, 1) && horVer == "v" && yspeed > 0)
                    || ((!checkSolid(-2, 0, 1, 1) && horVer == "v" && yspeed < 0)))
                {
                    xspeed = -2;
                    yspeed = 0;
                    horVer = "h";
                }
                if (checkSolid(0, -2, 1, 1) && horVer == "v")
                {
                    phase = 2;
                    xspeed = 2;
                    yspeed = 0;
                    horVer = "h";
                }
                if (xspeed == 0 && yspeed == 0) // sometimes platforms can leave hunter stranded,  if this happens, flip its movement variable, and continue moving.
                {
                    if (horVer == "h")
                    {
                        yspeed = 2;
                        horVer = "v";
                    }
                    else
                    {
                        xspeed = -2;
                        horVer = "h";
                    }
                }
                break;
            case 2: // move right && upper platform
                if (!checkSolid(0, -2, 1, 1) && horVer == "h")
                {
                    xspeed = 0;
                    yspeed = -2;
                    horVer = "v";
                }
                if (checkSolid(2, 0, 1, 1) && horVer == "h")
                {
                    xspeed = 0;
                    yspeed = 2;
                    horVer = "v";
                }
                if ((checkSolid(0, -2, 1, 1) && horVer == "v" && yspeed < 0)
                    || (!checkSolid(2, 0, 1, 1) && horVer == "v" && yspeed > 0))
                {
                    xspeed = 2;
                    yspeed = 0;
                    horVer = "h";
                }
                if (checkSolid(0, 2, 1, 1) && horVer == "v")
                {
                    phase = 1;
                    xspeed = -2;
                    yspeed = 0;
                    horVer = "h";
                }
                if (xspeed == 0 && yspeed == 0)
                {
                    if (horVer == "h")
                    {
                        yspeed = -2;
                        horVer = "v";
                    }
                    else
                    {
                        xspeed = 2;
                        horVer = "h";
                    }
                }
                break;
            case 3: // move right && lower platform
                if (!checkSolid(0, 2, 1, 1) && horVer == "h")
                {
                    xspeed = 0;
                    yspeed = 2;
                    horVer = "v";
                }
                if (checkSolid(2, 0, 1, 1) && horVer == "h")
                {
                    xspeed = 0;
                    yspeed = -2;
                    horVer = "v";
                }
                if ((checkSolid(0, 2, 1, 1) && horVer == "v" && yspeed > 0)
                    || ((!checkSolid(2, 0, 1, 1) && horVer == "v" && yspeed < 0)))
                {
                    xspeed = 2;
                    yspeed = 0;
                    horVer = "h";
                }
                if (checkSolid(0, -2, 1, 1) && horVer == "v")
                {
                    phase = 4;
                    xspeed = -2;
                    yspeed = 0;
                    horVer = "h";
                }
                if (xspeed == 0 && yspeed == 0)
                {
                    if (horVer == "h")
                    {
                        yspeed = -2;
                        horVer = "v";
                    }
                    else
                    {
                        xspeed = 2;
                        horVer = "h";
                    }
                }
                break;
            case 4: // move left && upper platform
                if (!checkSolid(0, -2, 1, 1) && horVer == "h")
                {
                    xspeed = 0;
                    yspeed = -2;
                    horVer = "v";
                }
                if (checkSolid(-2, 0, 1, 1) && horVer == "h")
                {
                    xspeed = 0;
                    yspeed = 2;
                    horVer = "v";
                }
                if ((checkSolid(0, -2, 1, 1) && horVer == "v" && yspeed < 0)
                    || ((!checkSolid(-2, 0, 1, 1) && horVer == "v" && yspeed > 0)))
                {
                    xspeed = -2;
                    yspeed = 0;
                    horVer = "h";
                }
                if (checkSolid(0, 2, 1, 1) && horVer == "v")
                {
                    phase = 3;
                    xspeed = 2;
                    yspeed = 0;
                    horVer = "h";
                }
                if (xspeed == 0 && yspeed == 0)
                {
                    if (horVer == "h")
                    {
                        yspeed = 2;
                        horVer = "v";
                    }
                    else
                    {
                        xspeed = -2;
                        horVer = "h";
                    }
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
with (clone)
    instance_destroy();
with (objHunterBullet)
    instance_destroy();
with (objHunterPlatform)
{
    timerMax = 999999;
    timerN = timerMax;
}
event_inherited();
#define Other_21
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if (image_index == 5)
{
    with (instance_create(x, y - 8, objHunterBullet))
        image_index = 1;
}
#define Draw_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
var xsc; xsc = image_xscale;
image_xscale = abs(image_xscale);
event_inherited();
image_xscale = xsc;
