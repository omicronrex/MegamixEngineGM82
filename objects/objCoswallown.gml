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
contactDamage = 3;

category = "flying, nature";

grav = -0.1;
blockCollision = 0;
parent = noone;

facePlayerOnSpawn = true;

// Enemy specific code
image_speed = 0.4;
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
        xspeed = image_xscale * 1.2;
        yspeed = 2;
    }
}
else if (dead)
{
    image_speed = 0.4;
}
