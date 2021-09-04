#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
// Creation code (all optional):
// col = <number> (0 = red (default); 1 = green; 2 = purple;)

event_inherited();

respawn = true;

healthpointsStart = 3;
healthpoints = healthpointsStart;
contactDamage = 4;

blockCollision = 0;
grav = 0;

facePlayerOnSpawn = true;

// Enemy specific code
startY = y;
delay = 0;

// AI variables
radius = 116;
activated = false;
falling = false;
imageOffset = 0;
cooldownMax = 234;
cooldownTimer = cooldownMax - 8;
shootAngle = 30;
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
    if (y == startY && activated == 0)
        imageOffset = 0;
    else if (y == startY && activated == 1)
        imageOffset = 1;
    else if (y > startY && delay <= 0)
        imageOffset = 1;
    else
        imageOffset = 2;

    image_index = (3 * col) + imageOffset;

    if (activated == true || y > startY)
    {
        cooldownTimer += 1;
        if (cooldownTimer >= cooldownMax)
        {
            // Shoot
            cooldownTimer = 0;
            var getAngle;

            // If megaman exists, grab his angle, otherwise grab some random different angle.
            if (instance_exists(target))
            {
                getAngle = point_direction(x, y, target.x, target.y);
                direct = -1;
            }
            else
            {
                getAngle = point_direction(x, y, x + (45), 45);
                direct = -1;
            }

            var ID;
            ID = instance_create(x, spriteGetYCenter(), objMM5AimedBullet);
            {
                ID.dir = getAngle + shootAngle;
                ID.xscale = direct;
                ID.spd = 1.65;
            }
            ID = instance_create(x, spriteGetYCenter(), objMM5AimedBullet);
            {
                ID.dir = getAngle - shootAngle;
                ID.xscale = direct;
                ID.spd = 1.65;
            }
            playSFX(sfxEnemyShootClassic);
        }
    }


    if (instance_exists(target))
    {
        // basic AI, if Mega Man is within range, activate bounder.
        if (abs(target.x - x) <= radius)
            activated = true;
        else
            activated = false;
    }

    // when activated, Bounder falls if he's in his original position.
    if (activated == true && y == startY)
        falling = true;

    // whilst falling, activate gavity collision and detect whether or not bounder has hit the ground.
    if (falling == true)
    {
        blockCollision = 1;
        grav = 0.4;
        if (ground == true)
        {
            falling = false;
            delay = 10;
        }
    }
    else
    {
        grav = 0;
        blockCollision = 0;
    }

    if (delay > 0)
        delay -= 1;

    // reverse fall if falling is false. this does not require bounder to be activated to work.
    if (falling == false && y > startY && delay == 0)
    {
        if (yspeed >= 0)
            yspeed = -2;
        yspeed -= 0.6;
        ground = false;
        if (yspeed < -14)
            yspeed = -14;
    }

    // reset bounder.
    if (y <= startY)
    {
        y = startY;
        delay = 0;
        if (yspeed < 0)
            yspeed = 0;
        if (activated == false)
            cooldownTimer = cooldownMax - 8;
    }
}
else if (dead == true)
{
    xspeed = 0;
    yspeed = 0;
    image_index = 0;
    cooldownTimer = cooldownMax - 8;
    falling = false;
    activated = false;
    imageOffset = 0;
    blockCollision = 0;
    grav = 0;
}
#define Other_23
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
specialDamageValue(objJewelSatellite, 3);
specialDamageValue(objWheelCutter, 3);
specialDamageValue(objSlashClaw, 3);
specialDamageValue(objSakugarne, 3);
specialDamageValue(objSuperArrow, 3);
specialDamageValue(objWireAdapter, 3);
