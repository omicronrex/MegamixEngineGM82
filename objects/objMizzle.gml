#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
// Creation code (all optional):

event_inherited();

respawn = true;

healthpointsStart = 10;//36
healthpoints = healthpointsStart;
contactDamage = 1;
category = "flying";

blockCollision = 0;
grav = 0;

// Enemy specific code
xspeed = 0;
yspeed = 0;

phase = 0;
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
    if (bbox_top < global.sectionTop)
    {
        instance_deactivate_object(id);
    }

    switch (phase)
    {
        case 0: // Look for mega
            if (instance_exists(objMegaman))
            {
                if (abs(instance_nearest(x, y, objMegaman).x - x) < 48)
                {
                    yspeed = -6 * image_yscale;
                    ys = y;
                    phase = 1;
                }
            }
            break;
        case 1: // Stop when reaching point
            if (y < view_yview + 96)
            {
                y = view_yview + 96;
                yspeed = 0;
                phase = 2;
            }
            break;
        case 2: // wait
            phasetimer += 1;
            if (phasetimer == 48)
            {
                yspeed = 1.25 * image_yscale;
                phase = 3;
                image_speed = 0.2;
            }
            break;
        case 3: // Descend
            if (y > ys)
            {
                y = ys;
                yspeed = 0;
                phasetimer = 0;
                phase = 0;
                image_speed = 0;
                image_index = 0;
                healthpoints = healthpointsStart;
            }
            break;
    }
}
else if (dead)
{
    image_index = 0;
    image_speed = 0;
    phase = 0;
    phasetimer = 0;
}
