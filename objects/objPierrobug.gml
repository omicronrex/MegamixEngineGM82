#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
// Creation code (all optional):
// col = <number> (0 = grey ball(default); 1 = teal ball; )

event_inherited();

healthpointsStart = 6;
healthpoints = healthpointsStart;
contactDamage = 6;

category = "nature, shielded";

facePlayer = true;

// Enemy specific code
hasFired = false;
imageOffset = 0;
imageTimer = 0;
imageTimerMax = 12;
timerAdd = 1;
beginShoot = 0;
objectThrown = objPierrobugBall;
col = 0;
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();
image_index = imageOffset;
if (entityCanStep())
{
    // animation timer setup;
    switch (imageOffset)
    {
        case 0:
            imageTimerMax = 10;
            timerAdd = 1;
            break;
        case 1:
            imageTimerMax = 10;
            break;
        case 2:
            imageTimerMax = 10;
            timerAdd = -1;
            break;
        case 3:
            imageTimerMax = 12;
            break;
        case 6:
            imageTimerMax = 24;
            break;
    }
    imageTimer += 1;
    if (imageTimer == imageTimerMax && imageOffset < 3 && beginShoot < 3)
    {
        imageOffset += timerAdd;
        imageTimer = 0;
        if (imageOffset == 2)
            beginShoot += 1;
    }
    if (imageTimer == imageTimerMax && imageOffset < 3 && beginShoot == 3)
    {
        imageOffset = 3;
        imageTimer = 0;
    }
    else if (imageTimer == imageTimerMax && imageOffset >= 3)
    {
        imageOffset += 1;
        imageTimer = 0;
    }
    var ID;
    if (imageOffset == 6 && !hasFired)
    {
        hasFired = true;
        playSFX(sfxFallNoise);
        var ID;
        ID = instance_create(x + (image_xscale * 7), y - 15, objectThrown);
        {
            ID.xscale = image_xscale;
            ID.xspeed = 3 * image_xscale;
            ID.yspeed = -4;
        }
        ID = instance_create(x + (image_xscale * 7), y - 15, objectThrown);
        {
            ID.xscale = image_xscale;
            ID.xspeed = 4 * image_xscale;
            ID.yspeed = -3;
        }
        ID = instance_create(x + (image_xscale * 7), y - 15, objectThrown);
        {
            ID.xscale = image_xscale;
            ID.xspeed = 2 * image_xscale;
            ID.yspeed = -5;
        }
    }
    if (imageOffset == 7)
    {
        imageOffset = 0;
        timerAdd = 1;
        beginShoot = 0;
        hasFired = false;
    }
}
image_index = imageOffset;
#define Other_21
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if (imageOffset < 3)
{
    other.guardCancel = 1;
}
#define Other_23
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
/// Damage tables
specialDamageValue(objLaserTrident, 4);

specialDamageValue(objHornetChaser, 3);
specialDamageValue(objJewelSatellite, 6);
specialDamageValue(objGrabBuster, 2);
specialDamageValue(objTripleBlade, 1);
specialDamageValue(objWheelCutter, 3);
specialDamageValue(objSlashClaw, 6);
specialDamageValue(objSakugarne, 3);
specialDamageValue(objSuperArrow, 6);
specialDamageValue(objWireAdapter, 3);
#define Other_25
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();
if(spawned)
{
    image_index = 0;
    hasFired = false;
    timerAdd = 1;
    beginShoot = 0;
    imageOffset = 0;
    imageTimer = 0;
}
