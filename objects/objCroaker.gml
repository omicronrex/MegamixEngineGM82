#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
/// A fat frog, and a pretty ugly one, it will puke babies when none are on the screen
event_inherited();

healthpointsStart = 10;
healthpoints = healthpointsStart;
contactDamage = 4;

category = "aquatic, semi bulky, nature";

facePlayer = true;

// Enemy specific code
animTimer = 3;
actionTimer = 0;
shooting = false;
img = 0;

//@cc sets how many babies it pukes
childLimit = 3;

//@cc
spitSpeed = 4.5;
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();

if (entityCanStep())
{
    var children; children = 0;
    with (objPetitCroaker)
    {
        if (parent == other.id)
        {
            children += 1;
        }
    }

    if (children == 0 && !shooting && image_index == 0)
    {
        shooting = true;
        animTimer = -1;
        image_index = 0;
    }
    else
    {
        if (animTimer > 0)
        {
            animTimer -= 1;
        }
        if (animTimer == 0)
        {
            animTimer = 7;
            if (image_index == 0)
            {
                image_index = 1;
            }
            else
            {
                image_index = 0;
            }
            if (image_index == 1)
            {
                img += 1;
                if (img == 4)
                {
                    image_index = 2;
                    img = 0;
                }
            }
        }
    }

    if (shooting)
    {
        animTimer = -1;
        actionTimer += 1;
        if (actionTimer == 7)
        {
            image_index = 3;
        }
        if (actionTimer == 14)
        {
            for (i = 1; i <= childLimit; i += 1)
            {
                c = instance_create(x + 4 * image_xscale, y - 10, objPetitCroaker);
                c.xspeed = ((spitSpeed / childLimit) * i) * image_xscale;
                c.yspeed = -5.5;
                c.parent = id;
            }
            image_index = 4;
        }
        if (actionTimer == 23)
        {
            image_index = 3;
        }
        if (actionTimer == 30)
        {
            image_index = 0;
            animTimer = 5;
            shooting = false;
            actionTimer = 0;
            img = 0;
        }
    }
}
else if (dead)
{
    image_index = 0;
    animTimer = 5;
    shooting = false;
    actionTimer = 0;
    img = 0;
}
