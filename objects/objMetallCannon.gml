#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
// Creation code (all optional):
// col = <number> (0 = green (default); 1 = game gear colouration;)

event_inherited();

healthpointsStart = 4;
healthpoints = healthpointsStart;
contactDamage = 4;

category = "cannons, mets";

facePlayerOnSpawn = true;

// Enemy specific code
radius = 80;
activated = false;

// Image variables
cooldownImageTimer = 0;
cooldownImageMax = 7;
popUporDown = false;
turnAroundBrightEyes = false;
turnAroundOffset = 0;
imageOffset = 0;

col = 0;
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();

image_index = (7 * col) + imageOffset;

if (entityCanStep())
{
    if (turnAroundBrightEyes)
    {
        activated = false;
        cooldownImageTimer += 1;
        if (cooldownImageTimer >= 7)
        {
            cooldownImageTimer = 0;
            turnAroundOffset += 1;
        }
        switch (turnAroundOffset)
        {
            case 0:
                imageOffset = 2;
                break;
            case 1:
                imageOffset = 3;
                break;
            case 2:
                imageOffset = 5;
                break;
            case 3:
                imageOffset = 6;
                break;
            case 4:
                image_xscale = image_xscale * -1;
                imageOffset = 2;
                turnAroundOffset = 0;
                cooldownImageTimer = 0;
                turnAroundBrightEyes = false;
                break;
        }
    }

    // Basic AI, if Mega Man is within range, activate gun. if mega man goes behind cannon, turn around.
    if (instance_exists(target))
    {
        if ((sign(target.x - x) == -image_xscale)
            && imageOffset == 2 && !turnAroundBrightEyes)
        {
            turnAroundBrightEyes = true;
            cooldownImageTimer = 0;
        }
        if (!activated && abs(target.x - x) <= radius && !turnAroundBrightEyes)
        {
            activated = true;
        }
    }

    // rest of events follow whilst gun is activated.
    if (activated)
    {
        cooldownImageTimer += 1;

        // animation timer setup;
        switch (imageOffset)
        {
            case 0:
                cooldownImageMax = 56;
                mask_index = sprMetallCannon;
                break;
            case 1:
                cooldownImageMax = 10;
                mask_index = sprMetallCannon;
                break;
            case 2:
                cooldownImageMax = 22;
                mask_index = sprMetallCannon;
                break;
            case 3:
                cooldownImageMax = 6;
                mask_index = sprMetallCannon;
                break;
            case 4:
                cooldownImageMax = 10;
                mask_index = sprMetallCannonMask2;
                break;
        }

        if (cooldownImageTimer == cooldownImageMax && imageOffset < 4)
        {
            cooldownImageTimer = 0;
            imageOffset += 1 - (popUporDown * 2);
        }

        if (cooldownImageTimer == cooldownImageMax && imageOffset == 4)
        {
            cooldownImageTimer = 0;
            imageOffset = 1;
        }

        if (imageOffset == 4 && !popUporDown)
        {
            popUporDown = true;
            i = instance_create(x + image_xscale * 12,
                spriteGetYCenter() + 7, objMetCannonShot);
            i.xspeed = image_xscale * 2;
            i.image_index = col;
            playSFX(sfxMetallCannon);
        }
        if (imageOffset == 0 && popUporDown)
        {
            popUporDown = false;
            activated = false;
        }
    }
}

image_index = (7 * col) + imageOffset;
#define Other_21
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if (!(imageOffset == 1 || imageOffset == 2 || imageOffset == 3 || imageOffset == 4))
{
    other.guardCancel = 1;
}
#define Other_23
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
specialDamageValue(objHornetChaser, 1);
specialDamageValue(objGrabBuster, 2);
specialDamageValue(objTripleBlade, 1);
specialDamageValue(objWheelCutter, 4);
specialDamageValue(objSlashClaw, 4);
specialDamageValue(objSakugarne, 4);
specialDamageValue(objSuperArrow, 1);
#define Other_25
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
// Reset on spawn
event_inherited();

image_index = 0;
imageOffset = 0;
activated = false;
popUporDown = false;
mask_index = sprMetallCannon;
