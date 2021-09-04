#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();

respawn = false;

contactDamage = 3;

// enemy specific code
xspeed = 0;
yspeed = image_yscale;

image_speed = 0;
image_index = 0;
animTimer = 0;

reflectable = -1;
inWater = false;
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();

if (!global.frozen && !global.timeStopped)
{
    grav = gravAccel * image_yscale;

    if (yspeed == 0)
    {
        if (image_index == 0)
        {
            playSFX(sfxAcidDrop);
            image_index = 1;
        }
        animTimer += 1;
        if (animTimer == 6)
        {
            animTimer = 0;
            image_index += 1;
            if (image_index > 2)
            {
                instance_destroy();
            }
        }
    }
}
else
{
    image_speed = 0;
}
