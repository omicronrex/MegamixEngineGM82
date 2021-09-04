#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();

healthpointsStart = 4;
healthpoints = healthpointsStart;
contactDamage = 6;

category = "cannons";

facePlayerOnSpawn = true;

// Enemy specific code
actionTimer = 0;
action = 1;
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();

if (entityCanStep())
{
    if (action)
    {
        switch (action)
        {
            case 1:
                if (instance_exists(target))
                {
                    if (abs(target.bbox_bottom - y) <= 16)
                    {
                        actionTimer += 1;
                    }
                    else
                    {
                        actionTimer = 0;
                    }
                }
                if (actionTimer >= 64)
                {
                    action += 1;
                    actionTimer = 0;
                    image_index += 1;
                }
                break;
            case 2:
                actionTimer += 1;
                if (actionTimer == 8)
                {
                    action -= 1;
                    actionTimer = 0;
                    image_index -= 1;
                    i = instance_create(x + 12 * image_xscale, y - 26,
                        objSuperBallMachineJrBall);
                    i.xspeed = image_xscale * 1.5;
                    i.yspeed = -1.5;
                    i.contactDamage = 2;
                }
                break;
        }
    }
}
#define Other_25
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();
actionTimer = 58;
action = 1;
image_index = 0;
