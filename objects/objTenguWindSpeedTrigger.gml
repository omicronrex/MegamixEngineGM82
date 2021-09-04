#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
// sets the speed of the mm8 sled when mega man travels past it

// creation code (mandatory)
// windSpeed = <number>;
// windAccel = <number>; (how fast the wind changes) (don't set to not have it change)


windSpeed = 0;
windAccel = 0;

lastPlayerCount = global.playerCount;

// initialize lastPlayerX list
lastPlayerX = ds_list_create();
repeat (global.playerCount)
{
    ds_list_add(lastPlayerX, 0);
}

event_user(0); // get initial x positions
#define Destroy_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
/// Destroy lastPlayerX list
ds_list_destroy(lastPlayerX);
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if (!global.frozen)
{
    var p; for (p = 0; p < instance_number(objMegaman); p+=1)
    {
        player = instance_find(objMegaman, p);
        if (instance_exists(player))
        {
            /* show_debug_message("playerX: " + string(player.x));
            show_debug_message("lastPlayerX: " + string(ds_list_find_value(lastPlayerX, player.playerID)));
            show_debug_message ("");*/

            // if a player crosses paths with us
            if ((player.x < x && ds_list_find_value(lastPlayerX, player.playerID) >= x)
                || (player.x > x && ds_list_find_value(lastPlayerX, player.playerID) <= x))
            {
                // update tengu wind object
                if (instance_exists(objTenguWind))
                {
                    objTenguWind.maxWindSpeed = windSpeed;

                    // change accel if creation code was set
                    if (windAccel != 0)
                    {
                        objTenguWind.windAccel = windAccel;
                    }
                }
            }
        }
    }

    // update last player x positions
    event_user(0);
}
#define Other_10
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
/// update last player x positions
var p; for (p = 0; p < instance_number(objMegaman); p+=1)
{
    player = instance_find(objMegaman, p);
    if (instance_exists(player))
    {
        ds_list_replace(lastPlayerX, player.playerID, player.x);
    }
}
#define Draw_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
// nope
