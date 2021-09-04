#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();

respawn = false;

// Default
healthpointsStart = 1;
healthpoints = healthpointsStart;
contactDamage = 3;

// enemy specific code
xspeed = 0;
yspeed = 0;

image_speed = 0;
image_index = 0;
animTimer = 0;

reflectable = 0;
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();

if (entityCanStep())
{
    if (!ground)
    {
        if (inWater)
        {
            if (yspeed > 7)
            {
                yspeed = 7;
            }
        }
        else
        {
            if (yspeed < -7)
            {
                yspeed = -7;
            }
        }
    }

    if (yspeed == 0)
    {
        yspeed = 0;
        animTimer += 1;
        if (animTimer == 6)
        {
            animTimer = 0;
            image_index += 1;
            if (image_index > 3)
            {
                instance_destroy();
            }
        }
    }
}
#define Other_20
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
dead = 1;

instance_create(bboxGetXCenter(), bboxGetYCenter(), objExplosion);
