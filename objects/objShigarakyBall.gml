#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();

respawn = false;

calibrateDirection();

healthpointsStart = 1;
healthpoints = healthpointsStart;
contactDamage = 3;

// enemy specific
variation = -1;
killTimer = 0;

xspeed = 0;
yspeed = 0;
grav = 0.2;

animBack = false;
imgSpd = 0.2;
imgIndex = 0;
image_speed = 0;
image_index = 0;
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();
if(xcoll!=0)
{
    xspeed=xcoll;
}


if (entityCanStep())
{
    // BOING gubye wall
    if (xspeed == 0)
    {
        image_xscale = -image_xscale;
    }

    // do teh ting (woop woop)
    if (ground)
    {
        yspeed = -2.7;
    }

    if (variation == 0)
    {
        xspeed = 2 * image_xscale;
    }
    else if (variation == 1)
    {
        xspeed = 1 * image_xscale;
    }

    // ded temer
    killTimer += 1;
    if (killTimer >= 130)
    {
        instance_create(x, y, objExplosion);
        instance_destroy();
    }
}

// do dem bettar dan game mekar staets (if you can't tell, I'm getting bored)
image_index = imgIndex div 1;
#define Other_25
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();

if (variation == -1)
{
    variation = choose(0, 1);
}
