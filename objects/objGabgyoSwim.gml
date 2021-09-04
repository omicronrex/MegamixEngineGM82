#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
// Creation code (all optional):
// col = <number> (0 = red (default); 1 = yellow)

event_inherited();

healthpointsStart = 1;
healthpoints = healthpointsStart;
contactDamage = 3;
despawnRange=8;

category = "aquatic, nature";

grav = 0;

facePlayerOnSpawn = true;

// Enemy specific code
col = 0;
init = 1;

timer = 0;

imgIndex = 0;
imgSpd = 0.16;
startXDir=image_xscale;
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if (init)
{
    init = 0;
    if (col == 1)
    {
        sprite_index = sprGabgyoSwimYellow;
    }
}

event_inherited();

if (entityCanStep())
{
    // animation
    imgIndex += imgSpd;
    if (imgIndex >= 4)
    {
        imgIndex = imgIndex mod 4;
    }

    // AI
    range = 48; // <-- movement area width here
    if (xspeed == 0 || x < xstart - range || x > xstart + range)
    {
        image_xscale = -image_xscale;
    }

    xspeed = 1.6 * image_xscale;
}

image_index = imgIndex div 1;
#define Other_25
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if(spawned)
{
    timer = 0;
    image_xscale = startXDir;
    imgIndex = 0;
}
