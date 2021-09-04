#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
// Creation code (all optional):
// col = <number> (0 = orange (default); 1 = green; 2 = blue; 3 = red;)

event_inherited();

healthpointsStart = 1;
healthpoints = healthpointsStart;
contactDamage = 2;

category = "cluster, floating";

blockCollision = 0;
grav = 0;

// Enemy specific code
imageOffset = 0;
lastLocationX = 0;
lastLocationY = 0;

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
    if (instance_exists(target))
    {
        lastLocationX = target.x;
        lastLocationY = target.y;
    }
    mp_linear_step(lastLocationX, lastLocationY, 0.5, false);

    imageOffset += 0.20;
    if (imageOffset == 5)
    {
        imageOffset = 0;
    }
}

image_index = (6 * col) + imageOffset;
