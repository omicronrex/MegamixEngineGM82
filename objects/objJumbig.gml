#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();

healthpointsStart = 14;
healthpoints = healthpointsStart;
contactDamage = 7;

category = "big eye, bulky";

facePlayerOnSpawn = true;

// enemy specific
actionTimer = 0;
dummyTimer = 0;
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
    actionTimer += 1;
    if (actionTimer == 30)
    {
        dummyTimer = 0;
        image_index = 1;
        if (irandom(1))
        {
            xspeed = 1 * image_xscale;
            yspeed = -2.5;
        }
        else
        {
            xspeed = 1.5 * image_xscale;
            yspeed = -4.5;
        }
        xs = xspeed;
    }
    if (actionTimer > 35)
    {
        if (ground && image_index == 1)
        {
            image_index = 2;
            xspeed = 0;
            calibrateDirection();
            actionTimer = -40;
        }
    }
    if (ground && image_index > 1)
    {
        dummyTimer += 1;
        if (dummyTimer == 5)
        {
            image_index = 3;
        }
        if (dummyTimer == 10)
        {
            image_index = 0;
        }
    }

    if (image_index == 1)
    {
        xspeed = xs;
    }
}
else if (dead)
{
    actionTimer = 0;
    dummyTimer = 0;
    image_index = 0;
}
