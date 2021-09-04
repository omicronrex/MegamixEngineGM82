#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
// Creation code (all optional):

// A spawner that creates Swalloweggs from the side of the screen in front of you

event_inherited();
grav = 0;
blockCollision = false;
obj = objSwallowegg;
delay = 64;
timer = delay;
col = 0;
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();
if (entityCanStep())
{
    // check which direction the target's facing, and move spawner to be in that direction

    // if there's no Swalloweggs, create a Swallowegg after a delay
    if (!instance_exists(obj))
    {
        timer++;
        if (timer >= delay)
        {
            var spawnX = view_xview;
            if (instance_exists(target))
            {
                if (target.image_xscale == 1)
                {
                    spawnX = view_xview + view_wview;
                }
                if (target.image_xscale == -1)
                {
                    spawnX = view_xview;
                }
            }

            var birb = instance_create(spawnX, y, obj);
            birb.respawn = 0;
            birb.col = col;
            birb.target = target;
            timer = 0;
        }
    }
}
else if (dead)
{
    timer = delay;
}
