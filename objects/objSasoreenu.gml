#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
// Creation code (all optional):
// hardcodeSpeed = <number>. If this is set, the Sasoreenu will always

depth = 0; // so it hides behind the quicksand, but is still visible above the quicksand in the editor

event_inherited();

healthpointsStart = 4;
healthpoints = healthpointsStart;
contactDamage = 4;

category = "nature";

// Enemy specific code
animTimer = 0;
inQuicksand = false;
sink = false;
sinkin = 0;

hardcodeSpeed = noone;

pregrav = grav;
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();

if (entityCanStep())
{
    // Update pregrav variable
    if (grav != 0)
    {
        pregrav = grav;
    }

    // Animation
    animTimer += 1;
    if (animTimer == (6 / (inQuicksand + 1)))
    {
        animTimer = 0;
        if (inQuicksand)
        {
            if (image_index == 2)
            {
                image_index = 3;
            }
            else if (image_index == 3)
            {
                image_index = 4;
            }
            else if (image_index == 4)
            {
                image_index = 5;
            }
            else
            {
                image_index = 2;
            }
        }
        else
        {
            if (image_index == 1)
            {
                image_index = 0;
            }
            else
            {
                image_index = 1;
            }
        }
    }

    // animation override thing
    if (inQuicksand && animTimer > 3)
    {
        animTimer = 3;
    }

    // Rise up if in quicksand
    if (place_meeting(x, y, objQuickSand)) && (objQuickSand.noRain) && (!sink)
    {
        calibrateDirection();
        inQuicksand = true;
        yspeed = -1.5;
        xspeed = 0;
    } // Above quicksand behavior
    else if (!sink)
    {
        // Stop rising if it hasn't already
        if (yspeed < 0)
        {
            yspeed = 0;
            grav = 0;
        }

        // reset inQuicksand variable
        if (!checkSolid(xspeed * 2, 0))
        {
            inQuicksand = false;
        }

        // Check if this boy hit a wall and there's quicksand below
        if (xcoll != 0 && place_meeting(x, y + 2, objQuickSand))
        {
            sink = true;
            yspeed = 1.5;
            image_index = 2;
            animTimer = 0;
            grav = pregrav;
        } // if not, set speed
        else if (xspeed == 0)
        {
            if (hardcodeSpeed != noone)
            {
                xspeed = hardcodeSpeed * image_xscale;
            }
            else
            {
                xspeed = choose(1.25, 2.5) * image_xscale;
            }
        }
    } // Rising down into quicksand code
    else
    {
        xspeed = 0;
        inQuicksand = true;
        if (ycoll != 0)
        {
            dead = true;
        }
        yspeed = 1.5;
    }
}
#define Other_25
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
/// spawn event
event_inherited();

image_index = 0;
animTimer = 0;
inQuicksand = false;
sink = false;
grav = pregrav;
