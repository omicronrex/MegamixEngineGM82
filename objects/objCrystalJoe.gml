#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();

image_xscale = -1;

respawn = true;

healthpointsStart = 3;
healthpoints = healthpointsStart;
contactDamage = 6;
category = "joes";

blockCollision = 1;
grav = gravAccel;

facePlayerOnSpawn = true;

// Enemy specific code
shooting = false;
animTimer = 0;
bulletID = -10;
image_speed = 0;
image_index = 0;
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();

if (entityCanStep())
{
    if (!instance_exists(bulletID))
    {
        calibrateDirection();
        shooting = true;
        animTimer = 0;
        image_index = 2;
        bulletID = instance_create(x + 21 * image_xscale, y,
            objCrystalJoeBullet);
        bulletID.image_xscale = image_xscale;
    }
    else if (shooting)
    {
        if (animTimer < 1)
        {
            animTimer += 0.5;
        }
        else
        {
            if (image_index == 0)
            {
                image_index = 1;
            }
            else
            {
                image_index = 0;
            }
            animTimer = 0;
        }
        if (bulletID.xspeed != 0)
        {
            shooting = false;
            animTimer = 0;
        }
    }
    else
    {
        animTimer += 1;
        if (animTimer == 5)
        {
            x += image_xscale;
        }
        if (animTimer == 10)
        {
            x -= image_xscale;
        }
        image_index = 2;
    }
}
else if (dead)
{
    shooting = false;
    animTimer = 0;
    image_index = 0;
}
#define Other_21
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if (image_index <= 1)
{
    other.guardCancel = 1;
}
