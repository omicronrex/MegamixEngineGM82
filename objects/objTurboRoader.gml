#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();

healthpointsStart = 2;
healthpoints = healthpointsStart;
contactDamage = 3;

category = "grounded";

facePlayerOnSpawn = true;

despawnRange = 32;

// Enemy specific code
phase = 0;
actionTimer = 0;
loops = 0;

turn = false;

image_speed = 0;
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();

if (entityCanStep())
{
    // increment AI timer
    actionTimer+=1;

    switch (phase)
    {
        // Spin around like a doofus
        case 0: // turn right
            if (actionTimer == 8)
            {
                xspeed = (xspeed / 2);
                image_index = 2;
            }

            // stop, turn around
            if (actionTimer == 18)
            {
                xspeed = -2 * image_xscale;
                image_index = 3;
            }

            // turn left
            if (actionTimer == 26)
            {
                xspeed = (xspeed / 2);
                image_index = 4;
            }
            if (actionTimer == 36)
            {
                if (loops > 2)
                {
                    actionTimer = 0;
                    loops = 0;
                    phase = 1;
                    image_index = 0;
                    calibrateDirection();
                    xspeed = 3.25 * image_xscale;
                }
                else
                {
                    xspeed = 2 * image_xscale;
                    image_index = 5;

                    actionTimer = 0;
                    loops += 1;
                }
            }
            break;

        // tracking the player
        case 1: // chug chug chug
            if (actionTimer mod 3 == 0 && image_index != 2)
            {
                image_index = !image_index;
            }

            // turn around on screen boundary
            if (((x < view_xview + 32 && image_xscale == -1) || (x > view_xview + 256 - 32 && image_xscale == 1)
                || xcoll != 0) && (!turn))
            {
                actionTimer = 0;
                image_index = 2;
                xspeed = (xspeed / 2);
                turn = true;
            }

            // turn around animation
            if (turn)
            {
                if (actionTimer == 15)
                {
                    xspeed = 0;
                    image_index = 0;
                    image_xscale = -image_xscale;
                }

                // charge
                if (actionTimer == 30)
                {
                    // it's slower on other goarounds for some reason
                    xspeed = 2.75 * image_xscale;
                }

                // this is later for cooldown reasons
                if (actionTimer == 40)
                {
                    turn = false;
                }
            }
            break;
    }
}
#define Other_25
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
/// On spawn
event_inherited();

phase = 0;
actionTimer = 0;

image_index = 5;
xspeed = 2 * image_xscale;

loops = 0;
turn = false;
