#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
// Creation code (all optional):
// travelSpeed = <number>. speed the tellies will travel at the player in pixels per frame
// maxTellies = <number>. Max amount of tellies the spawner will spawn
// delay = <number>. amount of frames in between spawning tellies

event_inherited();

healthpointsStart = 1;
healthpoints = healthpointsStart;
contactDamage = 0;

blockCollision = 0;
grav = 0;

canHit = false;

// Enemy specific code
delay = 256;
shoottimer = delay / 4;

travelSpeed = 0.25;
maxTellies = 3;

// this is so it can be placed on the edge of a screen and not have tellies leak over.
despawnRange = 0;
respawnRange = 0;
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();

if (entityCanStep())
{
    shoottimer -= 1; // decrement delay timer
    if (shoottimer <= 0)
    {
        // Make sure that in total, there are never more than three spawners spawning Tellies,
        // as well as there only being up to 3 tellies onscreen.
        var tel = instance_number(objTellySpawner);
        if (tel < maxTellies)
        {
            tel = maxTellies;
        }
        if (instance_number(objTelly) < maxTellies)
        {
            i = instance_create(x, y, objTelly);
            i.respawn = 0;
            i.travelSpeed = travelSpeed;
        }

        // set delay timer
        shoottimer = delay;
    }
}
#define Draw_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
// No
