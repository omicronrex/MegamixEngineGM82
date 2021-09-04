#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
// An enemy from Toad Man's stage in MM4. It starts on the ceiling, and when the player gets
// close, it will drop down to the floor and slide there for a bit, before returning to the ceiling.

event_inherited();

healthpointsStart = 2;
healthpoints = healthpointsStart;
contactDamage = 4;

category = "grounded";

grav = -0.25;

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
            if (instance_exists(target))
            {
                calibrateDirection();
                phase = 2;
                phasetimer = 0;
            }
            break;
        case 2: // Animation for if it isn't dropping down
            if (!(phasetimer mod 8))
            {
                if (image_index < 4)
                {
                    image_index += 1;
                    if (image_index > 3)
                    {
                        image_index = 0;
                    }
                }
            }

            // Occasional slides on the ceiling
            // Slide always if on the floor
            if (image_yscale > 0)
            {
                if (!(phasetimer mod 40))
                {
                    calibrateDirection(); // face the player
                    xspeed = 1 * image_xscale;
                }
                else if (!(phasetimer mod 60))
                {
                    xspeed = 0;
                }
            }
            else
            {
                xspeed = 1 * image_xscale;
            }

            // Trigger drop
            if (((collision_rectangle(x - 48, y - 224, x + 48, y + 224, target, false, true)
                && image_yscale > 0)
                || (!collision_rectangle(x - 64, y - 224, x + 64, y + 224, target, false, true)
                && image_yscale < 0))
                && (ground))
            {
                xspeed = 0;
                yspeed = 0;
                image_index = 4;
                phase = 3;
                phasetimer = 0;
            }
            break;
        case 3:
            if (phasetimer == 8)
            {
                image_index = 5;
                grav = -grav;
                phase = 4;
                phasetimer = 0;
            }
            break;
        case 4:
            if (ground)
            {
                image_index = 6;
                image_yscale = -sign(grav);
                if (phasetimer == 8)
                {
                    image_index = 0;
                    phase = 2;
                    phasetimer = 0;
                }
            }
            else
            {
                phasetimer = 0;
            }
            break;
    }

    if (!ground)
    {
        xspeed = 0;
    }
}
else if (dead)
{
    grav = -0.25;
    image_index = 0;
    phase = 1;
    phasetimer = 0;
}
