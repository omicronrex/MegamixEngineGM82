#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
// The first of the floor tracking enemies. Is unique in that it can be hit by any weapon, but
// will only get killed by some - with others, it will just stop it for a short amount of time.
// As usual with the enemies, it speeds up if Mega Man is on the same y plane as it.
event_inherited();

healthpointsStart = 256; // placeholder
healthpoints = healthpointsStart;
contactDamage = 3;

facePlayerOnSpawn = true;

// Enemy specific code

//@cc 0 = red (default); 1 = orange; 2 = blue
col = 0;
init = 1;

image_speed = 0.25;

imageSpd = image_speed;
stopped = false;
alarmStop = -1;

//@cc Speed, in pixels per frame, when not aligned with target
slowSpeed = 0.5;

//@cc Speed, in pixels per frame, when aligned with target
fastSpeed = 2;
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
// set color on spawn
if (init)
{
    init = 0;
    switch (col)
    {
        case 0:
            sprite_index = sprSpine;
            break;
        case 1:
            sprite_index = sprSpineBlue;
            break;
        default:
            sprite_index = sprSpine;
            break;
    }
}

event_inherited();

if (entityCanStep())
{
    if (!stopped)
    {
        image_speed = imageSpd;

        if (xcoll != 0)
        {
            image_xscale *= -1;
        }
        else if (ground)
        {
            if (checkFall(16 * image_xscale))
            {
                image_xscale *= -1;
            }
        }

        // set slow speed as default for frame
        xspeed = slowSpeed;

        // speed up if lined up with target
        if (instance_exists(target))
        {
            if (target.bbox_bottom + 1 > bbox_bottom
                && target.bbox_bottom - 1 < bbox_bottom)
            {
                xspeed = fastSpeed;
            }
        }
        xspeed *= image_xscale; // base xspeed by direction
    }
    else
    {
        image_speed = 0;


        // decrease stop timer if it's stopped :V
        alarmStop -= 1;
        if (!alarmStop)
        {
            stopped = false;
        }
    }

    if (!ground)
    {
        xspeed = 0;
    }
}
else
{
    image_speed = 0;
}
#define Other_19
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if (global.damage == 1)
{
    healthpoints = healthpointsStart;
}
#define Other_21
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if (global.damage > 0)
{
    healthpoints = global.damage;
    playSFX(sfxEnemyHit);
}
else
{
    alarmStop = 60;
    stopped = true;
    xspeed = 0;
    playSFX(sfxEnemyHit);
    if (other.penetrate < 1)
    {
        other.dead = true;
        global.damage = 1;
    }
    else
    {
        other.guardCancel = 2;
    }
}
#define Other_23
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
// Set all weapons (objects?) to do no damage
global.damage = 0;

// Now set the weaknesses
specialDamageValue(objSolarBlaze, 2);
specialDamageValue(objThunderWool, 3);
specialDamageValue(objTopSpin, 3);
specialDamageValue(objBlackHoleBomb, 3);
specialDamageValue(objWheelCutter, 3);
specialDamageValue(objSakugarne, 3);
specialDamageValue(objGrabBuster, 3); //Literally an endless health source otherwise
specialDamageValue(objBreakDash, 3);
specialDamageValue(objThunderBeam, 3);
specialDamageValue(objTornadoBlow, 3);
specialDamageValue(objIceWall, 3);
specialDamageValue(objChillSpikeLanded, 3);
specialDamageValue(objConcreteShot, 3);
specialDamageValue(objSearchSnake, 3);
specialDamageValue(objRainFlush, 3);
specialDamageValue(objTenguDash, 3);
specialDamageValue(objSkeletuppinPakkajoe, 3);
#define Other_25
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
/// On spawn
event_inherited();
image_index = 0;
image_speed = imageSpd;
stopped = false;
alarmStop = -1;
