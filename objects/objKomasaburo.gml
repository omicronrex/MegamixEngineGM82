#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
/// hey shoot large tops from their body. They usually shoot three at a time,
// and wait for a top to be destroyed before shooting another.
event_inherited();

healthpointsStart = 6;
healthpoints = healthpointsStart;
contactDamage = 6;

category = "semi bulky";

facePlayer = true;

animEndme = 0;
shootTimer = 0;

top[1] = 0;
top[2] = 0;
top[3] = 0;
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();

if (entityCanStep())
{
    animEndme += 1;
    if (animEndme >= 6)
    {
        if (image_index == 0)
        {
            image_index = 1;
        }
        else if (image_index == 1)
        {
            image_index = 0;
        }
        animEndme = 0;
    }

    shootTimer += 1;
    for (i = 1; i <= 3; i += 1)
    {
        if (top[i])
        {
            if (!instance_exists(top[i]))
            {
                top[i] = 0;
            }
        }
        if (shootTimer == 60 && !top[i])
        {
            image_index = 2;
            top[i] = instance_create(x + 1 * image_xscale, y - 16, objTop);
            top[i].image_xscale = image_xscale;
            break;
        }
    }
    if (shootTimer == 80)
    {
        image_index = 0;
        shootTimer = 0;
    }
}
#define Other_25
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
/// On spawn
shootTimer = 0;
animEndme = 0;
image_index = 0;
