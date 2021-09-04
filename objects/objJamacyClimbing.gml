#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();

healthpointsStart = 1;
healthpoints = healthpointsStart;
contactDamage = 2;

grav = 0;

// Enemy specific code
image_speed = 0.1;
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();

if (entityCanStep())
{
    if (yspeed == 0)
    {
        yspeed = 0.75;
    }
    else if (yspeed > 0)
    {
        if (!place_meeting(x, y + (bbox_bottom - bbox_top) + 2, objLadder)
            || place_meeting(x, y + 1, objJamacyClimbingTurn))
        {
            yspeed = -abs(yspeed);
        }
    }
    else if (yspeed < 0)
    {
        if (!place_meeting(x, y - (bbox_bottom - bbox_top) - 2, objLadder)
            || place_meeting(x, y - 1, objJamacyClimbingTurn))
        {
            yspeed = abs(yspeed);
        }
    }
}
else if (dead)
{
    image_index = 0;
}
