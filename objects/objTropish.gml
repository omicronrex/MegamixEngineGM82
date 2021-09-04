#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
// Creation code (all optional):
// col = <number>. color. 0 = green, 1 = orange
// ** FLIP IN EDITOR **

event_inherited();

healthpointsStart = 1;
healthpoints = healthpointsStart;
contactDamage = 4;
contactStart = contactDamage;

category = "aquatic, nature";

blockCollision = 0;
grav = 0;

despawnRange = 32;
respawnRange = 32;

// Enemy specific code
timer = 0;
phase = 1;

flip = 1;

col = 0;
imgOffset = 0;
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();

if (entityCanStep())
{
    timer += 1;
    switch (phase)
    {
        case 1: // wait for player
            if (instance_exists(target))
            {
                if (collision_line(x - 256, y + 8, x + 256, y + 8, target, false, true))
                {
                    if (image_xscale == 1)
                    {
                        x = view_xview;
                    }
                    else
                    {
                        x = view_xview + 256;
                    }

                    xspeed = 1.5 * image_xscale;

                    phase = 2;
                }
            }
            break;
        case 2: // Speed up
            if (abs(xspeed) < 4)
            {
                xspeed += .25 * image_xscale;
            }

            // bob up and down
            if (timer mod 10 == 0)
            {
                y += 1.5 * flip;
                flip = -flip;
            }

            // Animation
            if (timer mod 4 == 0)
            {
                imgOffset = !imgOffset;
            }
            break;
    }
}
else if (dead)
{
    timer = 0;
    phase = 1;
    imgOffset = 0;
    flip = 1;
}

visible = (phase > 1);
canHit = visible;
contactDamage = contactStart * visible;

image_index = imgOffset + (col * 2);
