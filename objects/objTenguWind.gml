#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
// creation code
// windSpeed = ;
// windAccel = ; (how fast the wind changes when a wind speed trigger is hit)

event_inherited();

canHit = false;
blockCollision = 0;
grav = 0;
despawnRange = -1;
respawnRange = -1;
bubbleTimer = -1;

activated = false;
leafTimer = 0;


// creation code stuff
windSpeed = -0.75;
maxWindSpeed = windSpeed;
startWindSpeed = maxWindSpeed;
windAccel = 0.008;
startWindAccel = windAccel;
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();

if (!global.frozen)
{
    // activate check
    if (!activated && insideSection(x, y))
    {
        activated = true;

        // don't effect the player when spawning in
        for (var p = 0; p < instance_number(objMegaman); p++)
        {
            player = instance_find(objMegaman, p);
            if (instance_exists(player))
            {
                if (player.teleporting || player.showReady)
                {
                    activated = false;
                }
            }
        }
    }

    // spawn leaves
    if (activated && windSpeed != 0)
    {
        leafTimer++;

        if (leafTimer mod 7 == 0)
        {
            spawnX = view_xview[0];
            if (windSpeed < 0)
            {
                spawnX += view_wview[0];
            }

            spawnRange = 70;
            instance_create(spawnX, view_yview[0] + view_hview[0] / 2 + 10 + irandom_range(-spawnRange, spawnRange), objTenguLeaf);
        }
    }

    // change speeds
    if (windSpeed != maxWindSpeed)
    {
        show_debug_message("before change: " + string(windSpeed));
        if (windSpeed >= maxWindSpeed - windAccel && windSpeed <= maxWindSpeed + windAccel)
        {
            // round to the max speed
            windSpeed = maxWindSpeed;
        }
        else
        {
            // accelerate
            if (windSpeed > maxWindSpeed)
            {
                windSpeed -= windAccel;
            }
            else
            {
                windSpeed += windAccel;
            }
        }

        show_debug_message("after change: " + string(windSpeed));
    }
}
else if (dead)
{
    activated = false;
    leafTimer = 0;
    maxWindSpeed = startWindSpeed;
    windSpeed = maxWindSpeed;
    windAccel = startWindAccel;
}
#define Step_1
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if (!global.frozen && activated)
{
    with (objMegaman)
    {
        /* if (isSlide)
        {
            if (xspeed > 1)
            {
                xspeed = xspeed / 2;
            }
            if (xspeed < 0 && xspeed > -3)
            {
                xspeed = -3;
            }
        }
        else */
        if (global.playerHealth[playerID] > 0 && !climbing)
        {
            shiftObject(other.windSpeed, 0, 1);
        }
    }
}
#define Other_4
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
maxWindSpeed = windSpeed;
startWindSpeed = maxWindSpeed;

startWindAccel = windAccel;
#define Draw_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
// nope
