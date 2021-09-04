#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
// Creation code (all optional):
// col = <number> (0 = green (default); 1 = orange;)

event_inherited();

healthpointsStart = 1;
healthpoints = healthpointsStart;
contactDamage = 4;

category = "mets";

facePlayer = true;

// Enemy specific code
radius = 78;
activated = false;

// Image variables
cooldownImageTimer = 0;
cooldownImageMax = 5;

preventFiring = 0;
preventFiringMax = 60;

hasFired = false;
imageOffset = 0;
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();


if (entityCanStep())
{
    if (preventFiring)
    {
        preventFiring -= 1;
    }

    // basic AI, if Mega Man is within range, activate gun.
    if (instance_exists(target) && !preventFiring)
    {
        if (!activated && abs(target.x - x) <= radius && abs(target.y - y) <= 4)
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
                cooldownImageMax = 5;
                break;
            case 1:
                cooldownImageMax = 5;
                break;
            case 2:
                cooldownImageMax = 5;
                break;
            case 3:
                cooldownImageMax = 20;
                break;
        }

        if (cooldownImageTimer >= cooldownImageMax)
        {
            cooldownImageTimer = 0;
            imageOffset += 1 - (hasFired * 2);
        }

        if (imageOffset == 3 && !hasFired)
        {
            hasFired = true;
            var ID;
            ID = instance_create(x + image_xscale * 4,
                spriteGetYCenter() + 2, objMM2MetBullet);
            ID.dir = 45;
            ID.image_xscale = image_xscale;
            ID.sprite_index = sprEnemyBullet;
            ID = instance_create(x + image_xscale * 4,
                spriteGetYCenter() + 2, objMM2MetBullet);
            ID.dir = 0;
            ID.image_xscale = image_xscale;
            ID.sprite_index = sprEnemyBullet;
            ID = instance_create(x + image_xscale * 4,
                spriteGetYCenter() + 2, objMM2MetBullet);
            ID.dir = -45;
            ID.image_xscale = image_xscale;
            ID.sprite_index = sprEnemyBullet;
            //playSFX(sfxEnemyShoot);
        }
        if (imageOffset == 0 && hasFired)
        {
            hasFired = false;
            activated = false;
            preventFiring = preventFiringMax;
        }
    }
}

image_index = imageOffset;
#define Other_20
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();

for (i = -1; i <= 1; i += 1)
{
    MET = instance_create(spriteGetXCenter(), spriteGetYCenter(),
        objBabyMetall);
    MET.respawn = false;
    MET.xspeed = i * 0.25;
    MET.yspeed = -choose(2.5, 3, 3.5);
}
#define Other_21
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
// guard if helmet is down
if (image_index == 0)
{
    other.guardCancel = 1;
}
else
{
    // Stop charge shot (accurate to MM5)
    if (other.object_index == objBusterShotCharged)
    {
        with (other)
        {
            instance_destroy();
        }
    }
}
#define Other_23
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
/// Damage tables
specialDamageValue(objHornetChaser, 1);
specialDamageValue(objGrabBuster, 2);
specialDamageValue(objTripleBlade, 1);
specialDamageValue(objWheelCutter, 2);
specialDamageValue(objSlashClaw, 2);
specialDamageValue(objSuperArrow, 2);
#define Other_25
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();

imageOffset = 0;
hasFired = false;
activated = false;
preventFiring = 0;
popUporDown = false;
cooldownImageTimer = 0;
