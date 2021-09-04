#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();

healthpointsStart = 2;
healthpoints = healthpointsStart;
contactDamage = 4;

category = "nature";

facePlayerOnSpawn = true;

// Enemy specific code
turn = 0;

action = 1;
actionTimer = 0;
xs = 0;
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();
if(xcoll!=0)
{
    xspeed=xcoll;
}


if (entityCanStep())
{
    if (image_index == 2)
    {
        if (ground)
        {
            if (yspeed == 0)
            {
                action = 3;
                image_index = 3;
                if (xspeed == 0)
                {
                    turn = 1;
                }
                xspeed = 0;
                xs = 0;
                playSFX(sfxCricket);
            }
        }
    }

    if (action)
    {
        actionTimer += 1;
        switch (action)
        {
            case 1:
                if (actionTimer == 30)
                {
                    action += 1;
                    actionTimer = 0;
                    image_index = 1;
                }
                break;
            case 2:
                if (actionTimer == 10)
                {
                    action = 0;
                    actionTimer = 0;
                    image_index = 2;
                    yspeed = -choose(3.5, 4.25, 5);
                    xspeed = 1 * image_xscale;
                    xs = xspeed;
                    ground = 0;
                }
                break;
            case 3:
                if (actionTimer == 10)
                {
                    action = 1;
                    actionTimer = 0;
                    image_index = 0;
                    if (turn)
                    {
                        image_xscale *= -1;
                        turn = 0;
                    }
                }
                break;
        }
    }

    if (xs != 0)
    {
        xspeed = xs;
    }
}
#define Other_25
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
/// spawn Event
event_inherited();
action = 1;
actionTimer = 0;
xs = 0;
ground = 1;
image_index = 0;
