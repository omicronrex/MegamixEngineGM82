#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
// The classic met. It also appears in MM9. It simply shoots 3 shots out when Mega Man is within 4 blocks of it -
// nothing else special with it. Set xscale manually.

event_inherited();

healthpointsStart = 1;
healthpoints = healthpointsStart;
contactDamage = 1;

category = "mets";

// Enemy specific code
radius = 4 * 16; // Four blocks; the radius that MM needs to enter to trigger the shooting of the met
timer = 0;
phase = 1;
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();

if (entityCanStep())
{
    calibrateDirection();

    if (phase == 1)
    {
        if (target)
        {
            // check if target is in range; if it is, trigger shooting code
            if (distance_to_object(target) <= radius)
            {
                phase = 2;
                image_index = 1;
            }
        }
    }
    else // shooting code
    {
        timer += 1; // action timer
        if (timer == 17)
        {
            // for loop used to make more efficent code
            for (i = -1; i <= 1; i += 1)
            {
                ID = instance_create(x + image_xscale * 8, spriteGetYCenter(), objMM1MetBullet);
                ID.dir = 45 * i;
                ID.xscale = image_xscale;
            }
            playSFX(sfxEnemyShootClassic);
        }
        else if (timer == 30)
        {
            image_index = 0;
        }
        else if (timer >= 80) // return to helmet down after 80 frames (roughly a little over a second)
        {
            phase = 1;
            timer = 0;
        }
    }
}
else if (dead)
{
    timer = 0;
    phase = 1;
    image_index = 0;
}
#define Other_21
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
// if image index == 0 (under helmet frame), reflect any bullet objects.
if (image_index == 0)
{
    other.guardCancel = 1;
}
