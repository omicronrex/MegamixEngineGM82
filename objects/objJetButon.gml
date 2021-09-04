#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();

healthpointsStart = 2;
healthpoints = healthpointsStart;
contactDamage = 3;

category = "flying, nature";

grav = 0;
blockCollision = false;

facePlayerOnSpawn = true;

// Enemy specific code
phase = 0;

image_speed = 0.4;
#define Other_25
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();

if (spawned)
{
    xspeed = 2.5 * image_xscale;
}
