#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();

respawn = false;

healthpointsStart = 8;
healthpoints = healthpointsStart;
contactDamage = 3;

// enemy specific
dir = 0;
spd = 1;

calibrateDirection();
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();

if (entityCanStep())
{
    if (xspeed == 0)
    {
        xspeed = -dir * spd;
    }

    if (ground)
    {
        yspeed = -3;
    }

    if (xspeed!=0&&dir != sign(xspeed))
    {
        dir = sign(xspeed);
    }
}
