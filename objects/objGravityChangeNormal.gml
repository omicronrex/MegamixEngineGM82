#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();
canHit = false;

grav = 0;
image_speed = 0.25;

blink = 0;

blockCollision = 0;
bubbleTimer = -1;

gravMultiplier = 1;

shiftVisible = 1;
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if (!global.frozen)
{
    with (objMegaman)
    {
        if (place_meeting(x, y, other.id))
        {
            if (gravfactor != other.gravMultiplier)
            {
                if ((place_meeting(x, y,
                    objGravityChangeNormal) + place_meeting(x, y,
                    objGravityChangeLow) + place_meeting(x, y,
                    objGravityChangeHigh)) > 1)
                {
                    exit;
                }
                gravfactor = other.gravMultiplier;
                playSFX(sfxGravityFlip);
                other.blink = 3;

                // other.depth = -10000;
            }
        }
    }
}
