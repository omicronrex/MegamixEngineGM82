#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
// sets the speed of the mm8 sled when mega man travels past it

// creation code (mandatory)
// maxSpeed = <number> (cannot be negative)

maxSpeed = 0;
triggered = false;
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if (!global.frozen && instance_exists(objMegaman))
{
    // if on screen
    if (insideView() && !triggered)
    {
        // get players
        players = collisionRectangleList(view_xview[0], view_yview[0], view_xview[0] + view_wview[0], view_yview[0] + view_hview[0], objMegaman, false, false);
        if (players != noone)
        {
            // check all players
            var i;
            for (i = 0; i < ds_list_size(players); i++)
            {
                // if one is on a sled
                playerRef = ds_list_find_value(players, i);
                if (instance_exists(playerRef))
                {
                    if (instance_exists(playerRef.vehicle))
                    {
                        triggered = true;

                        /* speed up all active sleds on screen */

                        // get all sleds
                        sleds = collisionRectangleList(view_xview[0], view_yview[0], view_xview[0] + view_wview[0], view_yview[0] + view_hview[0], objMegaman8Sled, false, false);
                        if (sleds != noone)
                        {
                            // go through each sled
                            var j;
                            for (j = 0; j < ds_list_size(sleds); j++)
                            {
                                sledRef = ds_list_find_value(sleds, j);
                                if (instance_exists(sledRef))
                                {
                                    // speed up
                                    sledRef.maxSpeed = maxSpeed;
                                }
                            }

                            ds_list_destroy(sleds);
                        }
                    }
                }
            }

            ds_list_destroy(players);
        }
    }
    else if (!insideView())
    {
        // reset
        triggered = false;
    }
}
#define Other_4
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if (maxSpeed == 0)
{
    printErr(
        "A speed for the MM8 sled was not set in objMegaman8SledSpeedTrigger.");
}
