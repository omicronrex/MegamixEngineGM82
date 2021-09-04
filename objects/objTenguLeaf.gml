#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();

canHit = false;
grav = -0.05; // flies upward
blockCollision = false;
bubbleTimer = -1;
respawn = false;
despawnRange = 48;
speedMultiplier = 2 + random_range(0.5, 3);

event_user(0); // set xspeed
yspeed = 2;

xOffset = x - view_xview[0];
yOffset = y - view_yview[0];

// set random depth
if (instance_exists(target))
{
    depth = target.depth + (-3 + irandom(6));
}
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();

if (!global.frozen)
{
    event_user(0); // update xspeed

    // animate
    image_index += 0.25;
}
#define Other_10
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
/// update speeds
if (instance_exists(objTenguWind))
{
    windObj = instance_find(objTenguWind, 0);
    if (instance_exists(windObj))
    {
        xspeed = windObj.windSpeed * speedMultiplier;
        grav = 0.06; // if wind speed is low enough, the leaves will fall instead
        grav -= abs(windObj.windSpeed) / (0.75 / (grav + 0.05)); // scale how fast the leaves fly up with how fast the wind is

        // update direction facing
        if (xspeed < 0)
        {
            image_xscale = -1;
        }
        else if (xspeed > 0)
        {
            image_xscale = 1;
        }
    }
}
