#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();

healthpointsStart = 1;
healthpoints = healthpointsStart;
contactDamage = 4;

category = "aquatic, nature";

grav = 0;
blockCollision = 0;

facePlayerOnSpawn = true;

// Enemy specific code
phase = 1;
phasetimer = 0;
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();

if (entityCanStep())
{
    phasetimer += 1;
    switch (phase)
    {
        case 1:
            if (phasetimer == 30)
            {
                calibrateDirection();
                xspeed = image_xscale;
                yspeed = -7;
                grav = 0.25;
                image_index += 2;
                phase = 2;
            }
            break;
        case 2:
            if (y > ystart)
            {
                y = ystart;
                yspeed = 0;
                grav = 0;
                image_index = 0;
                phase = 3;
            }
            break;
    }

    if (phasetimer mod 6 == 0)
    {
        if (image_index mod 2 == 0)
        {
            image_index += 1;
        }
        else
        {
            image_index -= 1;
        }
    }

    blockCollision = inWater; // yeah
    if (blockCollision)
    {
        xSpeedTurnaround();
    }
}
else if (dead)
{
    phase = 1;
    phasetimer = 0;
    image_index = 0;
}
#define Other_25
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
// spawn event
event_inherited();

if (spawned)
{
    if (instance_exists(target))
    {
        xspeed = image_xscale * 2;
    }
}
