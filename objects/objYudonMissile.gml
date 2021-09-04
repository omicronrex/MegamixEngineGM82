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
contactDamage = 4;

blockCollision = 0;
grav = 0;

// Enemy specific code
moveDir = 180;
turnSpeed = 2;
cooldownTimer = 0;
cooldownMax = 24;
storeID = -1;
phase = 0;

moveSpeed = 2;
missileID = -1;

chaseTimer = 0;
startWait = 0;
startWaitTimer = startWait;
rotateChange = 45;

spd = 1.50;

pangle = 0;
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
    if (col == 0
        && ((2 * round(direction / 45)) + ((cooldownTimer mod 4) / 16))
        <= 15)
        image_index = ((2 * round(direction / 45))
            + ((cooldownTimer mod 4) / 16));
    else if (col == 0
        && ((2 * round(direction / 45)) + ((cooldownTimer mod 4) / 16))
        > 15)
        image_index = ((cooldownTimer mod 4) / 16);

    if (col == 1
        && ((2 * round(direction / 45)) + ((cooldownTimer mod 4) / 16))
        <= 15)
        image_index = (16 + (2 * round(direction / 45))
            + ((cooldownTimer mod 4) / 16));
    else if (col == 1
        && ((2 * round(direction / 45)) + ((cooldownTimer mod 4) / 16))
        > 15)
        image_index = (16 + (cooldownTimer mod 4) / 16);

    cooldownTimer += 1;
    if (instance_exists(target))
    {
        switch (phase)
        {
            // spawn grace period
            case 0:
                startWaitTimer -= 1;
                if (startWaitTimer <= 0)
                {
                    phase = 1;
                    speed = spd;
                    direction = point_direction(x, y, target.x, target.y);
                }
                break;

            // chase megaman
            case 1:
                if (cooldownTimer == cooldownMax)
                {
                    /* this is kind of confusing, but basically we're seeing if the player is more or less than a certain angle away from where we're
                currently pointing, and if they are, increase/decrease our angle by that distance */

                    /* This is a special kind of error handler that prevents missile from moving completely straight and unable to fly towards the player
                if the player moves directly straight against the direction missile is flying */
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

                    direction += change;
                    cooldownTimer = 0;
                }
                break;
        }
    }
}
else if (dead)
{
    phase = 0;
    startWaitTimer = 20;
}
