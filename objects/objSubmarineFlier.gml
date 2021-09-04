#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();

healthpointsStart = 5;
healthpoints = healthpointsStart;
contactDamage = 3;

category = "aquatic, flying";

grav = 0;
blockCollision = true;

facePlayerOnSpawn = true;

// Enemy specific code
phase = 0;
timer = 0;

waterY = 0;
sinCounter = 0;

imgSpd = 0.2;
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
        // slower flying in a sine pattern
        case 0:
            imgIndex += imgSpd;
            if (imgIndex >= 4)
            {
                imgIndex = imgIndex mod 4;
            }
            xspeed = 0.4 * image_xscale;
            sinCounter += 0.03;
            yspeed = -(cos(sinCounter) * 0.5);
            reveal = false;
            if (healthpoints <= healthpointsStart - 2)
            {
                reveal = true;
            }
            if (!reveal && instance_exists(target))
            {
                if (target.bbox_left < bbox_right
                    && target.bbox_right > bbox_left)
                {
                    reveal = true;
                    healthpoints = healthpointsStart - 2;
                }
            }
            if (!reveal && xcoll != 0 || place_meeting(x, y, objWater))
                reveal = true;
            if (reveal)
            {
                phase = 1;
                xspeed = 0;
                imgIndex = 4;
                grav = gravAccel;
            }
            break;

        // shedding cloud animation and falling down to water
        case 1:
            if (imgIndex < 5)
            {
                imgIndex += imgSpd;
            }
            if (waterY == 0)
            {
                water = instance_place(x, y + yspeed, objWater);
                if (instance_exists(water))
                {
                    waterY = water.y - 2;
                }
            }
            else if (y >= waterY)
            {
                phase = 2;
                yspeed = 0;
                if (!place_meeting(x, y - 16, objWater))
                    y = waterY;
                imgIndex = 5;
                grav = 0;
            }
            break;

        // pause for a bit after falling into the water
        case 2:
            timer += 1;
            if (timer >= 60) // <-=1 pause time here
            {
                phase = 3;
                timer = 0;
                blockCollision = true;
            }
            break;

        // move around, shooting projectiles
        case 3:
            imgIndex += imgSpd;
            if (imgIndex >= 9)
            {
                imgIndex = 7;
            }
            if (instance_exists(target))
            {
                // turn around
                if (bbox_left > target.bbox_right)
                {
                    image_xscale = -1;
                }

                if (bbox_right < target.bbox_left)
                {
                    image_xscale = 1;
                }

                // shoot
                timer += 1;
                if (timer >= 65) // <-=1 shot wait time here
                {
                    bullet = instance_create(x, y - 12, objEnemyBullet);
                    with (bullet)
                    {
                        yspeed = -2.7;
                        grav = 0.15;

                        if (instance_exists(target))
                        {
                            xspeed = xSpeedAim(x, y, target.x, target.y, yspeed, grav);

                            // aim where the player is going to be
                            xspeed += target.xspeed;
                        }
                    }

                    timer = 0;
                }
            }
            xspeed = 1 * image_xscale;
            break;
    }
}

image_index = imgIndex div 1;
#define Other_25
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();
if (spawned)
{
    phase = 0;
    timer = 0;
    inWater = false;
    grav = 0;
    xspeed = 0;
    yspeed = 0;
    sinCounter = 0;
    image_index = 0;
}
