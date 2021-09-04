#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
/// They scurry about on the ground, climbing down ladders in their path.
event_inherited();

respawn = true;

healthpointsStart = 1;
healthpoints = healthpointsStart;
contactDamage = 2;

facePlayerOnSpawn = true;

// Enemy specific code
image_speed = 0.1;

climbing = 0;
ground = 1;
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();

if (entityCanStep())
{
    xSpeedTurnaround();

    // Get from ladder on ground
    if (climbing)
    {
        if (ycoll * image_yscale > 0)
        {
            climbing = 0;
            sprite_index = sprJamacy;
        }
    }

    // Dismount Ladder
    if (climbing)
    {
        yspeed = 1.5;
        if (!place_meeting(x, y, objLadder))
        {
            climbing = 0;
            sprite_index = sprJamacy;
            yspeed = 0;
        }
    } // Mount Ladder
    else if (!(position_meeting(round(bbox_left) + abs(xspeed), bbox_bottom + 1, objSolid)
        && position_meeting(round(bbox_right) - abs(xspeed), bbox_bottom + 1, objSolid)))
    {
        if (position_meeting(round(bbox_left) /*+ abs(xspeed )*/ , bbox_bottom + 1, objLadder)
            && position_meeting(round(bbox_right) /*- abs(xspeed )*/ , bbox_bottom + 1, objLadder))
        {
            climbing = 1;
            y += 1;
            sprite_index = sprJamacyClimbing;
            yspeed = 1.5;
        }
    }

    // Set speed
    if (!ground || climbing)
    {
        xspeed = 0;
    }
    else
    {
        xspeed = image_xscale * 1.5;
    }

    if (climbing)
    {
        grav = 0;
    }
    else
    {
        grav = 0.25;
    }
}
else if (dead)
{
    grav = 0.25;
    climbing = 0;
    sprite_index = sprJamacy;
    image_index = 0;
}
