#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
// Creation code (all optional):
event_inherited();
respawn = true;
healthpointsStart = 1;
healthpoints = healthpointsStart;
contactDamage = 3;
blockCollision = 0;
grav = 0;
category = "floating";

// Enemy specific code
phase = 0;
phaseTimer = 0;

// @cc color of the enemy. 0 = green, 1 = pink
col = 0;

imgOffset = 0;
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();
target = objMegaman;

if (entityCanStep())
{
    switch (phase)
    {
        case 0: // move towards player for 1 second
            calibrateDirection();
            imgOffset = 0;
            if (phaseTimer == 1)
            {
                if (instance_exists(target))
                {
                    var dir; dir = point_direction(x, y, target.x, target.y);
                    xspeed = cos(degtorad(dir)) * 1.5;
                    yspeed = -sin(degtorad(dir)) * 1.5;
                }
            }
            if (phaseTimer > 30)
            {
                xspeed = 0;
                yspeed = 0;
                phase = 1;
                phaseTimer = 0;
            }
            break;
        case 1: // animate open for 0.5 seconds
        // image_speed = 10 / 30;
            if (imgOffset < 9)
            {
                imgOffset += (1 / 3);
            }
            if (phaseTimer > 30)
            {
                phase = 2;
                phaseTimer = 0;
            }
            break;
        case 2: // shoot bullet at player
            imgOffset = 10;
            if (instance_exists(target) && phaseTimer == 1)
            {
                var bullet; bullet = instance_create(x, y + 4, objEnemyBullet);
                playSFX(sfxEnemyShootClassic);
                var dir; dir = point_direction(x, y, target.x, target.y);
                bullet.xspeed = cos(degtorad(dir)) * 2;
                bullet.yspeed = -sin(degtorad(dir)) * 2;
            }
            else
            {
                phase = 3;
                phaseTimer = 0;
            }
            if (phaseTimer > 2)
            {
                phase = 3;
                phaseTimer = 0;
            }
            break;
        case 3: // wait around 0.4 seconds and set animation back from shoot frame
            imgOffset = 10;
            if (phaseTimer == 1)
            {
                imgOffset = 9;
            }
            if (phaseTimer > 20)
            {
                phase = 4;
                phaseTimer = 0;
            }
            break;
        case 4: // animate closed
            if (phaseTimer == 2)
            {
                imgOffset = 6;
            }
            if (phaseTimer == 4)
            {
                imgOffset = 5;
            }
            if (phaseTimer == 6)
            {
                imgOffset = 0;
            }
            if (phaseTimer > 36)
            {
                phase = 0;
                phaseTimer = 0;
            }
            break;
    }
    phaseTimer += 1;
}
else if (dead)
{
    phase = 0;
    phaseTimer = 0;
    imgOffset = 0;
}

image_index = imgOffset + (col * 11);

// it's ya boi, MiniMacro/Quack Man(TM)!
// many thanks to NaOH for helping me make my first enemy from scratch
// it was fun and i learned a lot but i couldn't do any of it without her :D
//- MiniMacro, 1:00 AM, 27 March 2018

// QUACK YOU FORGOT THE PINK DIARN COLOR
//- SnoruntPyro, 7:53 PM, 6 July 2018
#define Other_21
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if (imgOffset <= 4)
{
    other.guardCancel = 1;
}
#define Other_23
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
specialDamageValue(objJewelSatellite, 0); // jewels are immune to jewels yeah

specialDamageValue(objGrabBuster, 2);
specialDamageValue(objTripleBlade, 2);
specialDamageValue(objWheelCutter, 2);
specialDamageValue(objSlashClaw, 2);
