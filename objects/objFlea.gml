#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
// An enemy that will erratically jump with two jump distances randomly chosen, made more
// manageable by their low health. Should probably be used sparingly, though.

event_inherited();

healthpointsStart = 1;
healthpoints = healthpointsStart;
contactDamage = 3;

category = "cluster";

facePlayerOnSpawn = true;

// Enemy specific code
//@cc 0 = blue; 1 = red
col = 0;
init = 1;

timer = 0;
xs = 0;
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
// Set color on spawn
if (init)
{
    init = 0;
    switch (col)
    {
        case 0:
            sprite_index = sprFlea;
            break;
        case 1:
            sprite_index = sprFleaRed;
            break;
    }
}

event_inherited();

if (entityCanStep())
{
    if (ground)
    {
        timer+=1;
    }
    if (timer >= 30)
    {
        yspeed = choose(-4, -6); // choose yspeed
        ground = 0;
        calibrateDirection();
        xs = choose(1.5, 3) * image_xscale; // choose saved xspeed variable
        xspeed = xs;
        image_xscale = 1;
        timer = 0;
    }

    if (ycoll > 0) // if it's on the ground in this frame, reset everything
    {
        xspeed = 0;
        xs = 0;
        timer = 0;
    }
    if (xs != 0)
    {
        xspeed = xs;
    }

    image_index = !ground;
}
#define Other_25
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();

image_index = 0;
timer = 0;
xs = 0;
