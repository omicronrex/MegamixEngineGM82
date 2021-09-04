#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();

healthpointsStart = 1;
healthpoints = healthpointsStart;
contactDamage = 3;

category = "grounded";

facePlayerOnSpawn = true;

// Enemy specific code
activated = false;
radius = 80;
explod = false;
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
xs = xspeed;
event_inherited();
if (entityCanStep())
{
    if (xspeed == 0)
    {
        if (xs != 0)
        {
            explod = true;
        }
        if (yspeed == 0)
        {
            calibrateDirection();
        }
    }
    if (xspeed == 0 && yspeed == 0 && activated)
    {
        xspeed = 2 * image_xscale;
        image_index = 1;
    }
    if (yspeed != 0 && image_index == 0)
    {
        xspeed = 0;
    }
    if (instance_exists(target))
    {
        // basic AI, if Mega Man is within range, activate bounder.
        if (abs(target.x - x) <= radius)
        {
            activated = true;
        }

        // if Sonic Bill is greater than Mega Man's x co-orderinates, explode.
        if (sign(xspeed) == -sign(target.x - x))
        {
            explod = true;
        }
        if (place_meeting(x, y, target)) // if Sonic Bill HITS Mega Man, explode.
        {
            explod = true;
        }
    }
    if (explod)
    {
        instance_create(bboxGetXCenter(), bboxGetYCenter(), objHarmfulExplosion);
        playSFX(sfxMM3Explode);
        dead = true;
    }
}
else if (dead)
{
    image_index = 0;
    explod = false;
    activated = false;
}
