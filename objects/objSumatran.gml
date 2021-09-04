#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
// Creation code (all optional):
// col = <number> (0 = orange (default); 1 = white;)
event_inherited();

healthpointsStart = 3;
healthpoints = healthpointsStart;
contactDamage = 6;

category = "nature";

blockCollision = 1;

facePlayerOnSpawn = true;

// Enemy specific code
yJump = -4.5;
xJump = 2.5;

// AI variables
cooldownMax = 64;
cooldownTimer = cooldownMax - 10;
radius = 80;
doubleJump = 0;

animStorage = 0;
animTimer = 0;

col = 0;
init = 1;
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if (init)
{
    init = 0;
    switch (col)
    {
        case 0:
            sprite_index = sprSumatran1;
            break;
        case 1:
            sprite_index = sprSumatran2;
            break;
        default:
            sprite_index = sprSumatran1;
            break;
    }
}

event_inherited();

if (entityCanStep())
{
    // animation

    animTimer += 1;
    switch (animStorage)
    {
        case 0:
            image_index = 0 + (floor(animTimer / 10) mod 2);
            break;
        case 1:
            image_index = 2;
            break;
        case 2:
            image_index = 3 + ((animTimer / 10));

            if (animTimer >= 10 && doubleJump == false)
            {
                animTimer = 0;
                animStorage = 0;
                cooldownTimer = 0;
            }
            if (animTimer >= 10 && doubleJump == true)
            {
                animTimer = 0;
                animStorage = 0;
                cooldownTimer = cooldownMax;
            }
            break;
    }

    // move tigger
    xSpeedTurnaround();
    x = ceil(x);

    // if tigger is near mega man, add to timer.
    if (instance_exists(target))
    {
        if (abs(x - target.x) <= radius && animStorage == 0)
        {
            calibrateDirection();
            cooldownTimer += 1;
        }

        // whether or not tigger is near mega man determines wheter or not it goes on a rampage.
        if (abs(x - target.x) <= radius)
            doubleJump = false;
        else
            doubleJump = true;
    }

    // when countdown timer is met, jump. also jump if fire is pressed and tigger is on ground.
    if (instance_exists(target))
    {
        if ((animStorage == 0 && cooldownTimer >= cooldownMax)
            || (animStorage == 0 && global.keyShootPressed[target.playerID]))
        {
            xspeed = xJump * image_xscale;
            yspeed = yJump;
            playSFX(sfxTigerRoar);
            cooldownTimer = 0;
            animStorage = 1;
        }
    }

    // when tigger hits the ground, reset variables
    if (ground && yspeed >= 0 && animStorage == 1)
    {
        xspeed = 0;
        animTimer = 0;
        animStorage = 2;
        cooldownTimer = 0;
    }
}
else if (dead)
{
    xspeed = 0;
    yspeed = 0;
    image_index = 0;
    animStorage = 0;
    animTimer = 0;
    cooldownTimer = cooldownMax - 10;
    doubleJump = false;
}
#define Other_23
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
specialDamageValue(objHornetChaser, 1);
specialDamageValue(objJewelSatellite, 2);
specialDamageValue(objGrabBuster, 2);
specialDamageValue(objTripleBlade, 1);
specialDamageValue(objWheelCutter, 3);
specialDamageValue(objSlashClaw, 3);
specialDamageValue(objSakugarne, 1);
specialDamageValue(objSuperArrow, 3);
