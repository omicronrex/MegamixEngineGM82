#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
/// This snake will shoot at Megaman's position after it blinks.
event_inherited();

respawn = true;

healthpointsStart = 2;
healthpoints = healthpointsStart;
contactDamage = 4;

category = "nature";

shootTimer = 0;

// respawnRange = 90000; // set to -1 to make infinite
// despawnRange = -1; // set to -1 to make infinite
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();

if (entityCanStep())
{
    grav *= image_yscale; // for ceiling snakies

    if (instance_exists(target))
    {
        if (abs(target.x - x) > 16)
        {
            calibrateDirection();
            if (image_xscale == -1)
            {
                x = xstart - 16;
            }
            if (image_xscale == 1)
            {
                x = xstart;
            }
        }
    }

    if (insideView())
    {
        shootTimer += 1;
        if (shootTimer == 40)
        {
            image_index = 1;
        }
        if (shootTimer == 50)
        {
            image_index = 0;
        }
        if (shootTimer == 60)
        {
            image_index = 2;
            a = instance_create(x + 4 * image_xscale, y + 8, objSnakeyBullet);
        }
        if (shootTimer == 70)
        {
            image_index = 0;
            shootTimer = -60;
        }
    }
}
else if (dead)
{
    shootTimer = 0;
    image_index = 0;
}
#define Other_20
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();

mypillar = instance_position(bboxGetXCenter(), bbox_bottom + 8,
    objPetitSnakeyPillar);
if (mypillar)
{
    with (mypillar)
    {
        if (object_index == objPetitSnakeyPillar)
        {
            instance_create(x, y, objPetitSnakeyPillarDeleter);
        }
    }
}
