#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
// A hammerheaded enemy that smacks the ground and sends debris flying up and down. The
// debris is also affected by gravity-affecting objects, such as water and 0.5 Grav switches.

event_inherited();

healthpointsStart = 4;
contactDamage = 4;

facePlayerOnSpawn = true;
image_index = 1;

category = "rocky";

imageTimerEndpoint = 9; // 6;

// @cc - use this to change how fast Doncatch walks
moveSpeed = 1;

// @cc - use this to change how close Mega Man has to be for Doncatch to attack
dist = 54;

imagePhaseDir = 1;
imageTimer = imageTimerEndpoint;
shooting = false;
timer = 0;
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();

if (entityCanStep())
{
    if (!shooting)
    {
        if (instance_exists(target))
        {
            // Figure out how to improve positioning.
            if (ground && abs(x - target.x) <= dist) // Preparing to attack.
            {
                xspeed = 0;
                image_index = 1;
                imagePhaseDir = 1;
                shooting = true;
            }
            else // Walking along.
            {
                calibrateDirection();
                xspeed = moveSpeed * image_xscale;
                imageTimer += 1;
                if (imageTimer >= imageTimerEndpoint)
                {
                    imageTimer = 0;
                    image_index += imagePhaseDir;
                    if (image_index >= 2 || image_index <= 0)
                    {
                        imagePhaseDir = -imagePhaseDir;
                    }
                }
            }
        }
        else
        {
            if (ground) // Preparing to attack.
            {
                xspeed = 0;
                image_index = 1;
                imagePhaseDir = 1;
                shooting = true;
            }
        }
    }

    if (shooting) // Hammer time.
    {
        timer += 1;
        if (timer == 90 / 2 - imageTimerEndpoint * 2)
        {
            image_index = 3;
        }
        if (timer == 90 / 2 - imageTimerEndpoint * 1)
        {
            image_index = 4;
        }
        if (timer == 90 / 2)
        {
            image_index = 5;
            if (positionCollision(x + 10 * image_xscale, bbox_bottom + 2))
            {
                var shot1; shot1 = instance_create(x + 10 * image_xscale, bbox_bottom, objDoncatchDebris);
                var shot2; shot2 = instance_create(x + 10 * image_xscale, bbox_bottom, objDoncatchDebris);
                var shot3; shot3 = instance_create(x + 10 * image_xscale, bbox_bottom, objDoncatchDebris);
                var shot4; shot4 = instance_create(x + 10 * image_xscale, bbox_bottom, objDoncatchDebris);
                shot1.version = 1;
                shot2.version = 2;
                shot3.version = 3;
                shot4.version = 4;
            }
        }
        if (timer == 90 / 2 + imageTimerEndpoint * 1)
        {
            image_index = 4;
        }
        if (timer == 90 / 2 + imageTimerEndpoint * 2)
        {
            image_index = 3;
        }
        if (timer == 90 / 2 + imageTimerEndpoint * 3)
        {
            image_index = 1;
        }
        if (timer >= 90)
        {
            shooting = false;
            timer = 0;
        }
    }
}
else if (dead)
{
    image_index = 1;
    imagePhaseDir = 1;
    timer = 0;
    imageTimer = imageTimerEndpoint;
    shooting = false;
}
