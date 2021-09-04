#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();

respawn = true;

healthpointsStart = 2;
healthpoints = healthpointsStart;
contactDamage = 4;
category = "aquatic, joes";

facePlayerOnSpawn = true;

// Enemy specific code
waterDelay = 0;
cooldownTimerMax = 60;
cooldownTimer = cooldownTimerMax - 5;
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();

if (entityCanStep())
{
    xspeed = 2 * image_xscale;
    cooldownTimer += 1;

    if (cooldownTimer == cooldownTimerMax)
    {
        i = instance_create(x + image_xscale * 8, spriteGetYCenter() + 7,
            objEnemyBullet);
        i.xspeed = 4 * image_xscale;
        i.xscale = image_xscale;
        playSFX(sfxEnemyShootClassic);
        cooldownTimer = 0;
    }

    // Check water:
    var myWater;
    myWater = instance_place(x, y + yspeed, objWater);
    if (myWater && yspeed > 0)
    {
        y += yspeed;
        while (place_meeting(x, y, myWater))
        {
            y -= 1;
        }
        ground = true;
        water = true;
        waterDelay = 3;
        yspeed = 0;
        image_index += 0.25;
    }

    waterDelay -= 1;

    if (waterDelay < 0)
    {
        image_index = 0;
    }
}
else if (dead)
{
    image_index = 0;
    cooldownTimer = cooldownTimerMax - 5;
    waterDelay = 0;
}
#define Other_23
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
specialDamageValue(objHornetChaser, 3);
specialDamageValue(objJewelSatellite, 3);
specialDamageValue(objGrabBuster, 3);
specialDamageValue(objTripleBlade, 3);
specialDamageValue(objSlashClaw, 3);
