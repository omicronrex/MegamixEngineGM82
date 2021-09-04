#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();

image_xscale = -1;
dir = 1;

respawn = false;

healthpointsStart = 2;
healthpoints = healthpointsStart;
contactDamage = 4;

// Enemy specific code
xspeed = 0;
yspeed = 0;
grav = 0;

mountID = -20;
phase = 0;
timer = 0;

canStep = false;

init = 0;
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
        case 0: // Hanging
            xspeed = 0;
            yspeed = 0;
            sprite_index = sprMinoanShield;
            if (mountID == -20 || !instance_exists(mountID) || mountID.dead == true)
            {
                instance_destroy();
            }
            else
            {
                y = mountID.bbox_top + 15 + floor(mountID.image_index) + sprite_yoffset;

                if (instance_exists(target))
                {
                    var dist; dist = abs(spriteGetXCenter() - spriteGetXCenterObject(target));
                    if (dist <= 5 * 16)
                    {
                        phase = 1;

                        with (mountID)
                        {
                            dead = true;
                            healthpoints = 0;
                            instance_create(spriteGetXCenter(), spriteGetYCenter(), objExplosion);
                        }
                    }
                }
            }
            break;
        case 1: // Falling
            xspeed = 0;
            grav = gravAccel;
            if (ground == true)
            {
                phase = 2;
                timer = 0;
            }
            break;
        case 2: // Waiting
            if (timer == 0)
                image_index = 0;
            xspeed = 0;
            sprite_index = sprMinoanAppear;
            image_speed = 7 / 60;
            if (image_index > image_number - 1)
                image_index = image_number - 1;
            timer += 1;
            if (timer >= 40)
            {
                timer = 0;
                phase = 3;
            }
            break;
        case 3: // Spinning in place
            if (timer == 0)
                image_index = 1;
            xspeed = 0;
            sprite_index = sprMinoanSpin;
            image_speed = 10 / 60;
            timer += 1;
            if (timer >= 15)
            {
                timer = 0;
                phase = 4;
            }
            break;
        case 4: // Spinning and moving
            if (timer == 0)
                calibrateDirection();
            timer += 1;
            sprite_index = sprMinoanSpin;
            image_speed = (10 / 60);
            if (ground == true)
            {
                xspeed = image_xscale * 1;
                if (xcoll != 0)
                {
                    image_xscale *= -1;
                    xspeed *= -1;
                }
            }
            else
            {
                xspeed = 0;
            }
            break;
    }
}
#define Other_21
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if (phase == 0)
{
    other.guardCancel = 3;
}
