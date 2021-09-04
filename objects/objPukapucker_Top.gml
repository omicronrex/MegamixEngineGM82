#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();

healthpointsStart = 3;
healthpoints = healthpointsStart;
contactDamage = 3;

facePlayerOnSpawn = true;

// Enemy specific code
bodyInstanceStore = -1;
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();
if (iceTimer > 0)
    bodyInstanceStore = 0;
if (entityCanStep())
{
    image_index += 0.15;

    xSpeedTurnaround();

    if (ground)
    {
        yspeed = -5;
        xspeed = 2 * image_xscale;
    }

    if (instance_exists(bodyInstanceStore) && bodyInstanceStore != -1)
    {
        if (bodyInstanceStore != 0 && !bodyInstanceStore.dead)
        {
            var inst;
            inst = bodyInstanceStore;
            shiftObject(inst.x - x, 0, true);
            xspeed = 0;
            image_xscale = inst.image_xscale;
            if (y >= inst.y - 8)
            {
                yspeed = -4.5;
            }
        }

        if (bodyInstanceStore != 0 && xspeed == 0 && bodyInstanceStore.dead)
        {
            xspeed = 2 * image_xscale;
        }
        if (bodyInstanceStore == 0)
        {
            xspeed = 2 * image_xscale;
        }
    }
}
#define Other_20
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();

// if the top of the head is killed, destroy bottom half
with (bodyInstanceStore)
{
    if (!dead)
    {
        event_user(EV_DEATH);
    }
}
#define Other_25
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if (spawned)
{
    xspeed = 0;
    yspeed = 0;
    image_index = 0;
}
