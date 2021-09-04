#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
// Creation code (all optional):
// dir = 1/-1 (1 = ground (default); -1 = ceiling)

event_inherited();

respawn = true;

healthpointsStart = 2;
healthpoints = healthpointsStart;
contactDamage = 3;
category = "grounded, nature";

facePlayerOnSpawn = true;

// Enemy specific code
calibrated = 0;

dir = 1;
init = 1;

phase = 0;
boost = false;
cooldown = -1;

normalSpd = 1.75;
boostSpd = 1.75;
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if (init)
{
    init = 0;
    if (dir == 1)
    {
        image_yscale = 1;
    }
    else
    {
        image_yscale = -1;
        y += 16;
        ystart += 16;
    }
}

event_inherited();

if (entityCanStep())
{
    switch (phase)
    {
        case 0:
            calibrateDirection();
            xspeed = normalSpd * image_xscale;
            phase = 1;
            break;
        // stuff (note: I use image_yscale to add/subtract values in a way that changes the value in the right direction depending on if it's on the ground or ceiling)
        case 1:
            if ((xspeed == 0 && cooldown == -1
                || !checkSolid((sprite_get_width(sprite_index) / 2) * image_xscale, image_yscale * 2, 1)) && cooldown == -1)
            {
                cooldown = 24;
                xspeed = 0;
            }

            if (cooldown > 0)
            {
                cooldown -= 1;
            }

            if (cooldown == 0)
            {
                image_xscale = -image_xscale;
                xspeed = normalSpd * image_xscale;
                cooldown = -1;
            }
    }

    image_index += 0.20;
}
else if (dead)
{
    phase = 0;
    cooldown = -1;
    image_index = 0;
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
specialDamageValue(objTripleBlade, 1);
specialDamageValue(objWheelCutter, 2);
specialDamageValue(objSlashClaw, 2);
specialDamageValue(objSakugarne, 2);
specialDamageValue(objSuperArrow, 1);
specialDamageValue(objWireAdapter, 2);
