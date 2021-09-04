#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();

healthpointsStart = 1;
healthpoints = healthpointsStart;
contactDamage = 4;

category = "cluster, floating";

grav = 0;
blockCollision = 0;

facePlayerOnSpawn = true;

// Enemy specific code
image_speed = 0.15;

megax = -1;
megay = -1;
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();

if (entityCanStep())
{
    image_speed = 0.15;
    megax = -1;
    if (instance_exists(target))
    {
        megax = bboxGetXCenterObject(target);
        megay = bboxGetYCenterObject(target);
    }
    if (megax != -1)
    {
        if (speed == 0)
        {
            speed = 0.5;
        }
        correctDirection(point_direction(bboxGetXCenter(), bboxGetYCenter(), megax, megay), 2);
    }
}
else
{
    image_speed = 0;
    if (dead)
    {
        megax = -1;
        megay = -1;
    }

    speed = 0;
}
#define Other_25
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
/// spawn event
event_inherited();

if (spawned)
{
    image_index = 0;
    if (instance_exists(target))
    {
        direction = 60;
        if (image_xscale == -1)
        {
            direction += 60;
        }

        megax = bboxGetXCenterObject(target);
        megay = bboxGetYCenterObject(target);
    }
}
