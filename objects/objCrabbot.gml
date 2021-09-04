#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
/// This enemy will move around and turn on ledges, if his shell falls off he will get mad and move faster
event_inherited();

healthpointsStart = 2;
healthpoints = healthpointsStart;
contactDamage = 4;

category = "grounded, nature";

facePlayerOnSpawn = true;

// Enemy specific code
hasShell = true;
animTimer = 0;
calibrated = 0;
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();

if (entityCanStep())
{
    if (ground)
    {
        if (checkFall(16 * image_xscale)
            || xcoll != 0)
        {
            image_xscale = -image_xscale;
        }
    }

    animTimer += 1;
    if (animTimer == 5)
    {
        animTimer = 0;
        if (image_index == 0 || image_index == 2)
        {
            image_index += 1;
        }
        else
        {
            image_index -= 1;
        }
    }
    if (hasShell)
        xspeed = 0.5 * image_xscale;
    else
        xspeed = 1.5 * image_xscale;
}
#define Other_21
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if (hasShell && other.object_index != objSparkShock)
{
    image_index += 2;
    hasShell = false;

    i = instance_create(x, y, objCrabbotShell);
    i.image_xscale = image_xscale;
}
#define Other_25
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();

/// On spawn
image_index = 0;
animTimer = 0;
hasShell = true;
