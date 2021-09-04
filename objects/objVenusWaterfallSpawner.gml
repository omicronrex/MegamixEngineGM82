#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
// Creates a waterfall that pushes Mega Man off the stage if he's under it.
// It also knocks him off ladders if he tries moving on them while underneath it.
event_inherited();
canHit = 0;
grav = 0;
bubbleTimer = -1;

moveTimer = 0; // Time until next action is performed
waterTimer = 0; // How long to wait until stopping waterfall

waterDelay = 0; // SET IN CREATION CODE - the limit for moveTimer, controls when waterfalls start
init = 0;

start = noone;
stop = noone;

despawnRange = -1;
respawnRange = -1;
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();
if (entityCanStep() && insideSection(x, y + 1))
{
    // Set default waterDelay number if none is provided in creation code
    if (init == 0)
    {
        if (waterDelay == 0)
        {
            waterDelay = 180;
        }
        init = 1;
    }

    moveTimer++;

    if (moveTimer == floor(waterDelay / 3)) //60
    {
        instance_create(x + 16, y + 3, objVenusWaterfallDrop);
    }

    if (moveTimer == waterDelay)
    {
        var i = instance_create(x, y - 3, objVenusWaterfallStart);
        start = i.id;
        playSFX(sfxRushingWater);
    }

    if ((moveTimer > waterDelay) && (!instance_exists(start)))
    {
        waterTimer++;
        if (waterTimer == 60)
        {
            var i = instance_create(x, y + 3, objVenusWaterfallEnd);
            stop = i.id;
        }

        if ((waterTimer > 60) && (!instance_exists(stop)))
        {
            moveTimer = 0; //-60;
            waterTimer = 0;
        }
    }
}
else if (dead)
{
    moveTimer = 0;
    waterTimer = 0;
}
