#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();

respawn = false;

healthpointsStart = 2;
healthpoints = healthpointsStart;
contactDamage = 3;
itemDrop = -1;
stopOnFlash = false;

blockCollision = 0;
grav = 0;
inWater = -1;

// Enemy specific code
phase = 0;
timer = 2; // initial wait time
counter = 0;

spd = 3;

image_speed = 0.3;
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
        // starting movement
        case 0:
            if (abs(xstart - x) < 23)
            {
                xspeed = spd * image_xscale;
            }
            else
            {
                xspeed = 0;
                x = xstart + 23 * image_xscale;

                timer -= 1;
                if (timer <= 0)
                {
                    timer = 0;
                    xspeed = 0;
                    phase+=1;
                }
            }
            break;

        // pause briefly
        case 1:
            timer += 1;
            if (timer >= 28)
            {
                timer = 0;
                phase+=1;

                if (instance_exists(target))
                {
                    direction = point_direction(x, y, target.x, target.y);
                }
                else
                {
                    // just go straight if there's no player
                    direction = 180 * (image_xscale == -1);
                }

                calibrateDirection();
            }
            break;

        // move towards the player
        case 2:
            speed = spd;
            timer += 1;
            if (counter < 3 && timer > 28)
            {
                timer = 0;
                speed = 0;
                counter+=1;
                phase-=1;
            }
            break;
    }
}
else if (dead)
{
    phase = 0;
    timer = 0;
    xspeed = 0;
    speed = 0;
}
else
{
    // don't move when we're not suppose to be able to do anything
    speed = 0;
}
#define Other_23
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
specialDamageValue(objBusterShot, 1);
specialDamageValue(objBusterShotHalfCharged, 1);
specialDamageValue(objBusterShotCharged, 2);
specialDamageValue(objPharaohShot, 2);
specialDamageValue(objPharaohShot, max(2, global.damage / 5));
specialDamageValue(objSolarBlaze, 3);
specialDamageValue(objChillShot, 3);
specialDamageValue(objChillSpikeLanded, 3);
