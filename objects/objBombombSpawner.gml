#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();

healthpointsStart = 1;
healthpoints = healthpointsStart;
contactDamage = 0;
blockCollision = 0;
grav = 0;

// Enemy specific code

//@cc spawn interval in frames
delay = 180;
timer = -1;

//@cc 0 for blue, 1 for red
col = 0;

canHit = false;
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();

if (entityCanStep())
{
    // if (timer < 0)
    //{
    //    shoottimer = delay * 0.75;
    //}

    timer += 1;
    if (timer >= delay)
    {
        // used to spawn below the spawner? changed to spawn above spawner. -Zatsu
        i = instance_create(x, y - 8, objBombomb);
        i.col = col;
        i.respawn = 0;
        i.inWater = inWater;

        timer = 0;
    }
}
else if (dead)
{
    timer = -1;
}
#define Other_21
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
other.guardCancel = 2;
