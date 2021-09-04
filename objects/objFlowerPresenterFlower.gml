#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();

respawn = false;

healthpointsStart = 1;
healthpoints = healthpointsStart;
contactDamage = 0;

blockCollision = 0;
grav = 0;

despawnRange = 0;

dir = 1;

// Enemy specific code
phase = 0;
waitTimer = 0;
rotateChange = 2;
totalChange = 0;
turnTimes = 0;

spd = 1.4;
speed = 0;
xspeed = 0;
yspeed = 0;

jetTimer = 0;
imgIndex = 2;
image_speed = 0;
image_index = 0;

col = 0;
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();

if (entityCanStep())
{
    if (instance_exists(target))
    {
        // If it's changed directions more than 8 times, destroy it.
        if (turnTimes > 8)
        {
            instance_create(x, y, objExplosion);
            instance_destroy();
        }

        switch (phase)
        {
            // spawn grace period
            case 0:
                phase = 1;
                speed = spd;

                // start going straight up
                direction = 90;
                imgIndex = 2;
                break;

            // chase megaman
            case 1: // Cooldown period for each direction change
                if (waitTimer < 15)
                {
                    waitTimer += 1;
                    break;
                }

                /* this is kind of confusing, but basically we're seeing if the player is more or less than a certain angle away from where we're
                currently pointing, and if they are, increase/decrease our angle by that distance */

                /* This is a special kind of error handler that prevents the flower from moving completely straight and unable to fly towards the player
                if the player moves directly straight against the direction the flower is flying */
                pxd = target.x - x;
                pyd = target.y - y;
                pangle = 0;
                if (pxd != 0)
                {
                    pangle = point_direction(x, y, target.x, target.y);
                }
                else
                {
                    if (pyd >= 0)
                    {
                        pangle = 270;
                    }
                    if (pyd < 0)
                    {
                        pangle = 90;
                    }
                }

                // and now that we have the angle the player is facing, we take the difference of the angles
                change = direction - pangle;

                // loop degree check, so the angle isn't above 360 or below 0
                if (change > 360)
                {
                    change -= 360;
                }
                else if (change < 0)
                {
                    change += 360;
                }

                /* this is interesting. So, by subtracting it by 180 it sort of aligns change to be how far away our angle to megaman is from our own angle
                we're pointing at as if our own angle is centered at 0 */
                change -= 180;

                /* and now, we just check how off mega man is, and do stuff accordingly (and also I reuse change to become the distance we change the
                angle )*/
                if (change > rotateChange)
                {
                    change = rotateChange;
                }
                if (change < -rotateChange)
                {
                    change = -rotateChange;
                }

                // Force the direction change to always be a 45 degree change (accurate to MM9)
                if (change < 45 && change > 0)
                {
                    change = 45;
                }
                else if (change < 0 && change > -45)
                {
                    change = -45;
                }

                direction += change;
                waitTimer = 0; // set cooldown

                totalChange += abs(change);

                turnTimes += 1; // increment turn time variable

                break;
        }

        jetTimer += 1;
        if (jetTimer >= 4)
        {
            // <-- jet animation speed here
            if (sprite_index == sprFlowerPresenterFlowerOn)
            {
                sprite_index = sprFlowerPresenterFlowerOff;
            }
            else
            {
                sprite_index = sprFlowerPresenterFlowerOn;
            }

            jetTimer = 0;
        }

        imgIndex = round((direction) / 45);

        // direction = imgIndex*45;
    }
}
else
{
    if (dead)
    {
        phase = 0;
        startWaitTimer = 20;
    }
}

image_index = (imgIndex div 1) + (col * 8);
contactDamage = 3;
visible = true;
