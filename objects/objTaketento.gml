#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();

healthpointsStart = 2;
healthpoints = healthpointsStart;
contactDamage = 3;

category = "cluster, flying, nature";

blockCollision = 0;
grav = 0;

facePlayerOnSpawn = true;

// Enemy specific code
phase = 1;
chaseWait = 50;
chaseTimer = 0;
rotateChange = 2.5;

spd = 1.15;

imgSpd = 0.2;
imgIndex = 0;
image_speed = 0.2;
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
        megax = target.x;
        megay = target.y;
    }

    switch (phase)
    {
        case 1: // flying casually
        // animation
            imgIndex += imgSpd;
            if (imgIndex >= 2)
            {
                imgIndex = imgIndex mod 2;
            }

            // wait to chase
            if (instance_exists(target))
            {
                chaseTimer += 1;
            }
            if (chaseTimer >= chaseWait)
            {
                phase = 2;
                chaseTimer = 0;
                xspeed = 0;
                yspeed = 0;
                speed = spd;
                direction = 90;
                imgIndex = 2;
                instance_create(x, y - 10, objTakentoPropeller);
            }
            break;
        case 2: // chase megaman
        /* this is kind of confusing, but basically we're seeing if the player is more or less than a certain angle away from where we're
            currently pointing, and if they are, increase/decrease our angle by that distance */
        /* This is a special kind of error handler that prevents chibee from moving completely straight and unable to fly towards the player
            if the player moves directly straight against the direction chibee is flying */
            pxd = megax - x;
            pyd = megay - y;
            pangle = 0;
            if (pxd != 0)
            {
                pangle = point_direction(x, y, megax, megay);
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

            // first though, we're going to animate faster if our angle offset is big enough
            if (!(change > 100 || change < -100))
            {
                imgIndex += imgSpd;
            }
            if (change > rotateChange)
            {
                change = rotateChange;
            }
            if (change < -rotateChange)
            {
                change = -rotateChange;
            }
            direction += change;

            // animation
            imgIndex += imgSpd;
            if (imgIndex >= 5)
            {
                imgIndex = 2 + imgIndex mod 5;
            }
            break;
    }
}
else if (dead)
{
    phase = 1;
    direction = 0;
    speed = 0;
    chaseTimer = 0;
    imgIndex = 0;
}

image_index = imgIndex div 1;
#define Other_25
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
// spawn event
event_inherited();

if (spawned)
{
    xspeed = spd * image_xscale;
}
