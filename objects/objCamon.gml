#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();

healthpointsStart = 1;
healthpoints = healthpointsStart;
contactDamage = 3;

category = "grounded";

facePlayerOnSpawn = true;

// Enemy specific code
image_speed = 0.125;
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();

if (entityCanStep())
{
    if (!ground)
    {
        xspeed = 0;
    }

    if (xspeed == 0 && yspeed == 0 && ground)
    {
        xspeed = 1.5 * image_xscale;
    }

    xSpeedTurnaround();
}
else if (dead)
{
    xspeed = 0;
    yspeed = 0;
    image_index = 0;
}
#define Other_25
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();

if (spawned)
{
    xspeed = 1.5 * image_xscale;
}
