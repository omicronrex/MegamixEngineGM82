#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();

healthpointsStart = 4;
healthpoints = healthpointsStart;
contactDamage = 3;

category = "fire, semi bulky";

facePlayer = true;

// enemy specific code
phase = 0;
shootTimer = 0;

imgSpd = 0.15;
imgIndex = 0;
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();

if (entityCanStep())
{
    switch (phase)
    {
        // wait
        case 0:
            shootWait = random_range(30, 120); // <-- time waiting inbetween shots here
            phase = 1;
            break;

        // throw fire
        case 1: // animation
            imgIndex += imgSpd;
            if (imgIndex >= 2)
            {
                imgIndex = imgIndex mod 2;
            }

            // wait to fire
            if (instance_exists(target))
            {
                shootWait -= 1;
                if (shootWait <= 0)
                {
                    phase = 2;
                    shootWait = 30;
                    imgIndex = 2;
                    instance_create(x, y - sprite_height / 2, objFireBoyShot);
                }
            }
            break;

        // wait
        case 2:
            shootWait -= 1;
            if (shootWait <= 0)
            {
                phase = 0;
                imgIndex = 0;
            }
            break;
    }
}
else if (dead)
{
    phase = 0;
    shootTimer = 0;
    imgIndex = 0;
}

image_index = imgIndex div 1;
