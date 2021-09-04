#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
// Creation code (all optional):
// col = <number> (0 = green (default); 1 = orange;)

event_inherited();

respawn = true;

healthpointsStart = 2;
healthpoints = healthpointsStart;
contactDamage = 4;
category = "cannons";

blockCollision = 0;
grav = 0;

facePlayerOnSpawn = true;

// AI variables
radius = 92;
activated = false;

// image variables
cooldownImageTimer = 0;
cooldownImageMax = 7;
popUporDown = false;
imageOffset = 0;

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
    if (imageOffset == 0)
        calibrateDirection();

    image_index = (6 * col) + imageOffset;

    // basic AI, if Mega Man is within range, activate gun.
    if (instance_exists(target))
    {
        if (activated == false && abs(target.x - x)
            <= radius && abs(target.y - y) <= 4)
            activated = true;
    }

    // rest of events follow whilst gun is activated.
    if (activated == true)
    {
        cooldownImageTimer += 1;

        // animation timer setup;
        switch (imageOffset)
        {
            case 0:
                cooldownImageMax = 20;
                break;
            case 1:
                cooldownImageMax = 7;
                break;
            case 2:
                cooldownImageMax = 7;
                break;
            case 3:
                cooldownImageMax = 20;
                break;
            case 4:
                cooldownImageMax = 7;
                break;
        }

        if (cooldownImageTimer == cooldownImageMax)
        {
            cooldownImageTimer = 0;
            imageOffset += 1 - (popUporDown * 2);
        }

        if (imageOffset == 5 && popUporDown == false)
        {
            popUporDown = true;
            var ID;
            ID = instance_create(x + image_xscale * 6,
                spriteGetYCenter() - 3, objEnemyBullet);
            {
                ID.xspeed = image_xscale * 2;
                ID.contactDamage = 4;
            }
            playSFX(sfxEnemyShootClassic);
        }
        if (imageOffset == 0 && popUporDown == true)
        {
            popUporDown = false;
            activated = false;
        }
    }
}
else if (dead == true)
{
    calibrateDirection();
    xspeed = 0;
    yspeed = 0;
    image_index = 0;
    imageOffset = 0;
    activated = false;
    popUporDown = false;
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
specialDamageValue(objWheelCutter, 2);
specialDamageValue(objSlashClaw, 2);
specialDamageValue(objSakugarne, 2);
specialDamageValue(objSuperArrow, 2);
