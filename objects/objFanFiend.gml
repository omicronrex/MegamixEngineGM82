#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
/// An enemy from Air Man's stage. Whenever it's onscreen, it will push away (or pull, if you set it to that)
// Mega Man. You must set the image_xscale of this enemy manually.

event_inherited();

healthpointsStart = 5;
healthpoints = healthpointsStart;
contactDamage = 6;

category = "semi bulky";

// Enemy specific code
animTimer = 0;
img = 1;

//@cc The speed at which Mega Man will be pushed. positive for pushing away, negative for pulling towards.
blowSpeed = 0.5;
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();

if (entityCanStep())
{
    animTimer += 1;
    if (animTimer == 4)
    {
        animTimer = 0;
        if (image_index == 0)
        {
            image_index = 1;
        }
        else if (image_index == 1)
        {
            image_index = 0;
        }
        img += 1;
        if (img == 16)
        {
            image_index = 2;
        }
        if (img == 17)
        {
            img = 0;
            image_index = 0;
        }
    }

    with (objMegaman)
    {
        if ((x <= other.x && other.image_xscale == -1)
            || (x >= other.x && other.image_xscale == 1))
            playerBlow(other.blowSpeed * other.image_xscale);
    }
}
