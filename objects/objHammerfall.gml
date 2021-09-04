#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
// Creation code (all optional):
// radius = <number> // the distance between where Hammerfall detects Mega Man. default is 32
event_inherited();
respawn = true;
healthpointsStart = 5;
healthpoints = healthpointsStart;
category = "aquatic, nature";
contactDamage = 4;
blockCollision = 0;
grav = 0;
facePlayerOnSpawn = true;

// Enemy specific code
startY = y;
delay = 0;

// AI variables
radius = 32;
activated = false;
falling = false;
imageOffset = 0;
cooldownMax = 40;
cooldownSmashed = 64;
cooldownTimer = cooldownMax - 8;
ground = false;
direct = 0;
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
    // animation setup
    if (!ground && delay == 0)
        image_index = 0;
    else
        image_index = 1;
    if ((activated == true || y > startY) || ground)
        cooldownTimer += 1;
    if (instance_exists(target))
    {
        // basic AI, if Mega Man is within range, activate Hammerfall.
        if (abs(target.x - x) <= radius)
            activated = true;
        else
            activated = false;
    }

    // when activated, Hammerfall falls if he's in his original position.
    if (activated == true && y == startY && cooldownTimer >= cooldownMax)
        falling = true;

    // whilst falling, activate gavity collision and detect whether or not Hammerfall has hit the ground.
    if (falling == true)
    {
        blockCollision = 1;
        grav = gravAccel;
        if (yspeed > 4)
            yspeed = 4;

        // if Hammerfall has hit the grund, create debris.
        if (ground == true)
        {
            falling = false;
            delay = cooldownSmashed;

            // despite running the loop 5 times, the third iteraion is skipped, so only 4 projectiles are created.
            var i; for ( i = 0; i < 5; i += 1)
            {
                if (i != 2)
                {
                    var inst;
                    inst = instance_create(x, y + 24, objNewShotmanBullet);
                    inst.grav = 0.25;
                    inst.xspeed = -1.25 + (0.625 * i);
                    inst.yspeed = -4;
                    inst.sprite_index = sprHammerfallProjectile;
                }
            }
            playSFX(sfxClamp);
        }
    }
    else
    {
        // if falling is false, turn off gravity and collision
        grav = 0;
        blockCollision = 0;
    }
    if (delay > 0)
        delay -= 1;

    // reverse fall if falling is false. this does not require Hammerfall to be activated to work.
    if (falling == false && y > startY && delay == 0)
    {
        yspeed -= 0.5;
        ground = false;
        if (yspeed < -4)
            yspeed = -4;
    }

    // reset Hammerfall.
    if (y <= startY)
    {
        y = startY;
        delay = 0;
        if (yspeed < 0)
        {
            cooldownTimer = 0;
            yspeed = 0;
        }
        if (activated == false)
            cooldownTimer = cooldownMax - 8;
    }
}
#define Other_23
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
specialDamageValue(objJewelSatellite, 3);
specialDamageValue(objWheelCutter, 3);
specialDamageValue(objSlashClaw, 5);
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

image_index = 0;
cooldownTimer = cooldownMax - 8;
falling = false;
activated = false;
imageOffset = 0;
blockCollision = 0;
grav = 0;
