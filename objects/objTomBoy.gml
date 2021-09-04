#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();

healthpointsStart = 6;
healthpoints = healthpointsStart;
contactDamage = 6;

category = "grounded";

facePlayerOnSpawn = true;

// Enemy specific code
calibrated = 0;

actionTimer = 0;
action = 1;
first = 1;
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
        iaction = action;
        actionTimer += 1;
        switch (action)
        {
            case 1:
                if (actionTimer == 8)
                {
                    action += 1;
                    image_index = 1;
                    if (!first)
                    {
                        x += 16 * image_xscale;
                        y += pit * 16;
                        pit = 0;
                    }
                    else
                    {
                        first = 0;
                    }
                    turned = 0;

                    // Flip if wall
                    if (checkSolid(16 * image_xscale, 0, 1, 1))
                    {
                        x -= 16 * image_xscale;
                        image_xscale *= -1;
                        turned = 1;
                    }

                    // Look for ledge
                    xs = x;
                    x += 16 * image_xscale;
                    ys = y;
                    for (i = 0; i <= 2; i += 1)
                    {
                        ground = checkSolid(0, 1, 1, 1);
                        if (ground)
                        {
                            pit = i;
                            break;
                        }
                        else
                        {
                            pit = 0;
                        }
                        y += 16;
                    }
                    y = ys;
                    if (!ground && !turned)
                    {
                        xs -= 16 * image_xscale;
                        image_xscale *= -1;
                        ground = 1;
                    }
                    x = xs;
                }
                break;
            case 2:
                if (actionTimer == 8)
                {
                    action += 1;
                    image_index = 2;
                }
                break;
            case 3:
                if (actionTimer == 8)
                {
                    action += 1;
                    image_index = 3;
                }
                break;
            case 4:
                if (actionTimer == 8)
                {
                    if (!pit)
                    {
                        action = 5;
                        image_index = 4;
                    }
                    else
                    {
                        action = 6;
                        image_index = 6;
                    }
                }
                break;
            case 5:
                if (actionTimer == 8)
                {
                    // action += 1;
                    image_index = 5;
                    action = 1;
                }
                break;
            case 6:
                if (actionTimer == 8)
                {
                    action += 1;
                    image_index = 7;
                    if (pit == 2)
                    {
                        image_index += 3;
                    }
                }
                break;
            case 7:
                if (actionTimer == 8)
                {
                    action += 1;
                    image_index += 1;
                }
                break;
            case 8:
                if (actionTimer == 8)
                {
                    // action += 1;
                    image_index += 1;
                    action = 1;
                }
                break;
        }
        if (action != iaction)
        {
            actionTimer = 0;
        }
    }
}
else if (dead)
{
    actionTimer = 0;
    action = 1;
    ground = 1;
    image_index = 0;
    first = 1;
}
#define Other_20
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
dead = 1;

instance_create(bboxGetXCenter(), bboxGetYCenter() - 16, objExplosion);
