#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
// Creation code (all optional):
// col = <number> (0 = orange (default); 1 = red; 2 = green ; 3 = game gear colouration)

event_inherited();

respawn = true;

healthpointsStart = 2;
healthpoints = healthpointsStart;
contactDamage = 5;
category = "cannons, shielded";
doesTransition = false;
isSolid = 0;

facePlayerOnSpawn = true;

// Enemy specific code
mySolid = instance_create(x, y, objTatepakkanPlatform);

// Image variables
cooldownImageTimer = 0;
cooldownImageMax = 120;
imageOffset = 0;

platformOffset = 7;
platformCalc = 7;
currentPlatformOffset = 7;

col = 0;
image_speed = 0;
#define Destroy_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
// destroy leftover solid if it's still there
instance_activate_object(mySolid);
with (mySolid)
    instance_destroy();
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();

if (entityCanStep())
{
    // setup defences
    if (imageOffset == 0)
    {
        calibrateDirection();
    }

    cooldownImageTimer += 1;

    if (imageOffset == 2 && cooldownImageTimer == cooldownImageMax / 2)
    {
        var ID;
        ID = instance_create(x + image_xscale * 9, spriteGetYCenter() + 5,
            objEnemyBullet);
        {
            ID.xspeed = image_xscale * 2;
            ID.contactDamage = 4;
        }
        playSFX(sfxEnemyShootClassic);
    }
}

if (!dead)
{
    // animation timer setup;
    switch (imageOffset)
    {
        case 0:
            cooldownImageMax = 120;
            break;
        case 1:
            cooldownImageMax = 9;
            break;
        case 2:
            cooldownImageMax = 36;
            break;
        case 3:
            cooldownImageMax = 9;
            break;
    }

    if (cooldownImageTimer == cooldownImageMax && imageOffset < 3)
    {
        cooldownImageTimer = 0;
        imageOffset += 1;
    }
    if (cooldownImageTimer == cooldownImageMax && imageOffset == 3)
    {
        cooldownImageTimer = 0;
        imageOffset = 0;
    }
    image_index = (4 * col) + imageOffset;

    // create standable block:
    if (instance_exists(mySolid))
    {
        if (!visible)
        {
            with (mySolid)
                instance_destroy();
        }
        else
        {
            mySolid.x = x;
            mySolid.yspeed = ((y - currentPlatformOffset) - mySolid.y);
            if (currentPlatformOffset < platformCalc)
                currentPlatformOffset += 1;
            else if (currentPlatformOffset > platformCalc)
                currentPlatformOffset -= 1;

            if (imageOffset < 3)
                platformCalc = (platformOffset + (imageOffset * 3));
            else
                platformCalc = (platformOffset + (imageOffset * 3) - 6);
        }
    }
    else if (visible)
    {
        mySolid = instance_create(x, y, objTatepakkanPlatform);
    }
}
else if (dead)
{
    if (instance_exists(mySolid))
    {
        with (mySolid)
        {
            instance_destroy();
        }
    }
}
#define Other_21
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if (imageOffset == 0)
{
    if (sign(bboxGetXCenterObject(other.id) - bboxGetXCenter()) == image_xscale)
    {
        other.guardCancel = 1;
    }
}
#define Other_23
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
/// Damage tables
specialDamageValue(objHornetChaser, 2);
specialDamageValue(objJewelSatellite, 1);
specialDamageValue(objGrabBuster, 2);
specialDamageValue(objTripleBlade, 1);
specialDamageValue(objWheelCutter, 2);
specialDamageValue(objSlashClaw, 2);
specialDamageValue(objSakugarne, 2);
specialDamageValue(objSuperArrow, 2);
specialDamageValue(objWireAdapter, 2);
#define Other_25
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();

image_index = 0;
imageOffset = 0;
cooldownImageTimer = 0;
cooldownImageMax = 130;
