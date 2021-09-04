#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();

healthpointsStart = 4;
healthpoints = healthpointsStart;
contactDamage = 4;

category = "flying";

grav = 0;

// Enemy specific code
oldmask = mask_index;
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
        case 1: // Trigger dropping
            if (instance_exists(target))
            {
                if (abs(target.x - x) < 40)
                {
                    phase = 2;
                    yspeed = 1.5;
                    calibrateDirection();
                }
            }
            break;
        case 2: // Dropping / check for floor
            if (!(phasetimer mod 6))
            {
                image_index += 1;
                if (image_index > 3)
                {
                    image_index = 0;
                }
            }
            if (yspeed == 0)
            {
                image_index = 3;
                grav = 0.25;
                phase = 3;
                phasetimer = 0;
            }
            break;
        case 3: // Launch the speer of DEATH
            if (!(phasetimer mod 6))
            {
                image_index += 1;
                if (image_index == 11)
                {
                    i = instance_create(x + 28 * image_xscale, y - 8, objEnemyBullet);
                    i.sprite_index = sprUmbrella;
                    i.xspeed = 2 * image_xscale;
                }
                else if (image_index == 13)
                {
                    mask_index = sprRackaserMask;
                    phase = 4;
                    phasetimer = 0;
                }
            }
            break;
        case 4: // Move around
            if (!(phasetimer mod 6))
            {
                image_index += 1;
                if (image_index > 16)
                {
                    image_index = 13;
                }
            }

            // turning around on ledges or walls
            xSpeedTurnaround();
            if (xspeed == 0 || checkFall(16 * image_xscale))
            {
                calibrateDirection();
                xspeed = image_xscale * 1;
            }

            // don't move in midair
            if (!ground)
            {
                xspeed = 0;
            }
            break;
    }
}
else if (dead)
{
    phase = 1;
    phasetimer = 0;
    grav = 0;
    image_index = 0;
}
#define Draw_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if (phase != 1)
{
    event_inherited();
}
