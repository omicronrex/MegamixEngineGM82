#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();

/*
animLength = how many frames
animTime = interval before change
animID# = background frame (Note # goes up from 0 to animLength)
animateOnTransition = will stop animations during the transition

animationLayer = Layer animated tiles start at (your animated tiles should start on this layer)

Note: This only works for tiles on a 16x16 grid

see the example level for how to set this up.
*/

animLength = 1;

for (i = 1; i <= animLength; i += 1)
{
    animTime[i - 1] = 1;
}

animationLayer = 1;
animateOnTransition = false;

timer = 0;
tileID = 0;
#define Step_1
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if (global.frozen)
{
    if (!instance_exists(objSectionSwitcher))
    {
        exit;
    }
    else if (!animateOnTransition)
    {
        exit;
    }
}

if (timer < animTime[tileID])
{
    timer += 1;
}
else
{
    timer = 0;
    if (tileID < animLength - 1)
    {
        tile_layer_hide(animationLayer + tileID);
        tileID += 1;
        tile_layer_show(animationLayer + tileID);
    }
    else
    {
        tile_layer_hide(animationLayer + tileID);
        tileID = 0;
        tile_layer_show(animationLayer + tileID);
    }
}

/*
animLength = how many frames
animTime = interval before change
animID# = background frame (Note # goes up from 0 to animLength)
animateOnTransition = will stop animations during the transition

animationLayer = Layer animated tiles start at (your animated tiles should start on this layer)
#define Draw_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
// it's time to stop
