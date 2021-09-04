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

isTargetable = false;

category = "aquatic";

grav = 0;

// Enemy specific code
image_speed = 0.1;

ysp = 0;

phase = 0;
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();

if (entityCanStep())
{
    if (phase == 0) // wait and look for target
    {
        if (yspeed == 0)
        {
            if (instance_exists(target) && abs(x - target.x) < 64) // Drop
            {
                yspeed = 2 * image_yscale;
                phase = 1;
            }
        }
    }
    else // Go back up
    {
        if (ycoll * image_yscale > 0)
        {
            yspeed = -1 * image_yscale;
        }

        if ((ycoll * image_yscale < 0)
            || (image_yscale > 0 && y <= ystart)
            || (image_yscale < 0 && y >= ystart))
        {
            yspeed = 0;
            phase = 0;
        }
    }
}
else if (dead)
{
    phase = 0;
    yspeed = 0;
}
#define Other_21
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
other.guardCancel = 3;
