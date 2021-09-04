#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();

respawn = false;

healthpointsStart = 1;
healthpoints = healthpointsStart;
contactDamage = 2;

facePlayerOnSpawn = true;

// enemy specific
dir = 0;
spd = 1;
timer = 0;
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();

if (entityCanStep())
{
    if (ground)
    {
        image_index = 0;
        if (timer < 30)
        {
            timer += 1;
            xspeed = 0;
        }
        else
        {
            yspeed = -6;
            xspeed = -dir * spd;
            timer = 0;
        }
    }
    else
    {
        image_index = 1;
    }

    if (xspeed!=0&&dir != sign(xspeed))
    {
        dir = sign(xspeed);
    }

    image_xscale = dir;
}
