#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
// Creation code (all optional):
// col = <number> (0 = grey ball(default); 1 = teal ball; )

event_inherited();

respawn = true;

healthpointsStart = 3;
healthpoints = healthpointsStart;
contactDamage = 5;
category = "grounded";

facePlayer = true;

// Enemy specific code
hasFired = false;
imageOffset = 0;
imageTimer = 0;
imageTimerMax = 12;

objectThrown = objTosserRock;
col = 0;
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();

if (entityCanStep())
{
    // animation timer setup
    switch (imageOffset)
    {
        case 0:
            imageTimerMax = 56;
            break;
        case 1:
            imageTimerMax = 6;
            break;
        case 3:
            imageTimerMax = 15;
            break;
        case 4:
            imageTimerMax = 6;
            break;
    }

    imageTimer += 1;
    if (imageTimer == imageTimerMax && imageOffset < 6)
    {
        imageOffset += 1;
        imageTimer = 0;
    }
    else if (imageTimer == imageTimerMax && imageOffset == 6)
    {
        imageOffset = 0;
        imageTimer = 0;
        hasFired = false;
    }

    if (imageOffset == 4 && !hasFired)
    {
        hasFired = true;
        var ID;
        ID = instance_create(x - (image_xscale * 10), y - 5, objectThrown);
        ID.xscale = image_xscale;
        ID.col = col;
    }
}

image_index = (7 * col) + imageOffset;
#define Other_23
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
specialDamageValue(objHornetChaser, 3);
specialDamageValue(objJewelSatellite, 3);
specialDamageValue(objGrabBuster, 2);
specialDamageValue(objTripleBlade, 1);
specialDamageValue(objWheelCutter, 3);
specialDamageValue(objSlashClaw, 3);
specialDamageValue(objSakugarne, 3);
specialDamageValue(objSuperArrow, 3);
specialDamageValue(objWireAdapter, 3);
#define Other_25
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();

imageOffset = 0;
imageTimer = 0;
hasFired = false;
