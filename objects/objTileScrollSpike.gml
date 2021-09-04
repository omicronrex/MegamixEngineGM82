#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();

contactDamage = 28;
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();

// actual shifting
if (!global.frozen && !global.timeStopped && tileID > 0)
{
    with (prtEntity)
    {
        if (blockCollision && grav != 0)
        {
            // var gravDir = sign(grav);

            with (other)
            {
                if (!other.dieToSpikes || other.iFrames || !other.canHit)
                {
                    isSolid = 1;
                }
                else
                {
                    isSolid = 0;
                }
            }
        }
    }
}
