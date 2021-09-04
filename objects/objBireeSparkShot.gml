#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();

respawn = false;
contactDamage = 2;

grav = 0;
yspeed = 2;

imgIndex = 0;
imgSpd = 0.2;
phase = 0;
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();

if (entityCanStep())
{
    imgIndex += imgSpd;

    if (imgIndex >= 3)
    {
        imgIndex = 0;
    }

    if (ground)
    {
        i = instance_create(x, y + 10, objBireeSparkGroundShot);
        i.image_xscale = image_xscale;
        with (i)
        {
            target = other.target;
            calibrateDirection();
            _dir = image_xscale;
            image_xscale = 1;
        }
        instance_destroy();
    }
}
else if (dead)
{
    instance_destroy();
}

image_index = imgIndex div 1;
#define Other_21
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if (other.object_index != objJewelSatellite)
{
    other.guardCancel = 2;
}
