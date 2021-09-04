#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
// An enemy from Hornet Man's stage. It will stay still until Mega Man gets close, on which it
// will launch out a flower missile that homes in on the player. It reloads after a short cooldown.

// Creation code (all optional):
// flower = <number> (0 = yellow (default); 1 = red; 2 = green )

event_inherited();

respawn = true;

healthpointsStart = 4;
healthpoints = healthpointsStart;
contactDamage = 3;
category = "nature";

// Enemy specific code
actionTimer = -1;
state = 0;

imageOffset = 0; // Used for flower var

flower = 0;
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();

if (entityCanStep())
{
    // Don't do anything until Mega Man approaches.
    if (actionTimer == -1)
    {
        if (instance_exists(target))
        {
            // I like collision rectangle the best for this.
            if (collision_rectangle(x - (16 * 5), y - view_hview[0], x + (16 * 5), y + view_hview[0], target, false, true))
            {
                actionTimer = 0;
                state = 1;
            }
        }
    } // Fire now lol
    else
    {
        actionTimer += 1;

        switch (state)
        {
            // Waiting
            case 0: // wait for a second before restoring flower
                if (actionTimer == 95)
                {
                    imageOffset = 5;
                }
                else if (actionTimer == 100)
                {
                    imageOffset = 0;
                }
                else if (actionTimer == 145)
                {
                    actionTimer = -1; // Reset and wait for Mega Man to be in range again
                }
                break;

            // Shoot!
            case 1: // Do animation thing I guess
                if (imageOffset < 4)
                {
                    imageOffset += 0.5;
                }

                // Shoot when imageOffset == 4
                if (imageOffset == 4)
                {
                    state = 0;
                    actionTimer = 0;
                    a = instance_create(x, y, objFlowerPresenterFlower);
                    a.col = flower;
                }
                break;
        }
    }
}
else if (dead)
{
    actionTimer = -1;
    imageOffset = 0;
    state = 0;
}

image_index = (6 * flower) + imageOffset; // Modify sprite based on set flower
