#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();

healthpointsStart = 6;
healthpoints = healthpointsStart;
contactDamage = 4;

category = "semi bulky";

facePlayer = true;

// Enemy specific code
shooting = false;
animTimer = 0;
bulletID = -10;
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();

if (entityCanStep())
{
    if (!instance_exists(bulletID) && insideView())
    {
        calibrateDirection();
        shooting = true;
        animTimer = 0;
        image_index = 2;
        bulletID = instance_create(x + (15 + 4) * image_xscale, y - 2, objColtonBullet);
        bulletID.image_xscale = image_xscale;
        playSFX(sfxColtonShoot);
    }

    if (shooting)
    {
        animTimer += 0.15;

        if (animTimer >= 1)
        {
            animTimer = 0;
            switch (image_index)
            {
                case 2:
                    image_index = 3;
                    break;
                case 3:
                    image_index = 4;
                    break;
                case 4:
                    shooting = false;
                    image_index = 0;
                    break;
            }
        }
    }
    else
    {
        animTimer += 0.05;
        if (animTimer >= 1)
        {
            animTimer = 0;
            switch (image_index)
            {
                case 0:
                    image_index = 1;
                    break;
                case 1:
                    image_index = 0;
                    break;
            }
        }
    }
}
else if (dead)
{
    shooting = false;
    animTimer = 0;
    image_index = 0;
}
