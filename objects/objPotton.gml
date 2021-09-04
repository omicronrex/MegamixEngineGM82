#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
/// They attack by dropping their explosive body when Mega Man passes under them.
// Afterwards they are just glass shells with propellers that fly around.
event_inherited();

healthpointsStart = 1;
healthpoints = healthpointsStart;
contactDamage = 2;

category = "flying";

grav = 0;

facePlayerOnSpawn = true;

// Enemy specific code

canDrop = true;
isDrop = false;
isDropTimer = 0;

image_speed = 0.25;
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();

if (object_index == objPottonBomb)
{
    exit;
}

if (entityCanStep())
{
    xSpeedTurnaround();

    // Dropping
    if (instance_exists(target) && canDrop)
    {
        if (x >= target.x - abs(target.xspeed) - 1
            && x <= target.x + abs(target.xspeed) + 1)
        {
            canDrop = false;
            isDrop = true;
            sprite_index = sprPottonDrop;
        }
    }

    if (isDrop)
    {
        isDropTimer += 1;
        if (isDropTimer >= 6)
        {
            isDrop = false;
            isDropTimer = 0;
            sprite_index = sprPottonShell;
            with (instance_create(x, y + 6, objPottonBomb))
            {
                image_xscale = other.image_xscale;
            }
        }
    }

    xspeed = image_xscale * (1 - isDrop);
}
else if (dead)
{
    image_index = 0;
    canDrop = true;
    isDrop = false;
    isDropTimer = 0;
    sprite_index = sprPotton;
}
