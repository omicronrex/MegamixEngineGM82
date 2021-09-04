#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
// Falling icicle gimmick from the Dr Wily's Revenge.
// creation code:
// appearTime -=1 the amount of time it takes before the icicle begins to form.

event_inherited();

canHit = false;
contactDamage = 0;

isSolid = false;
appearTime = 90;
appearTimer = 0;

grav = 0;
blockCollision = false;
noFlicker = true;
bubbleTimer = -1;
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();

if (entityCanStep())
{
    depth = 0;

    appearTimer+=1;
    if (appearTimer <= appearTime)
    {
        // not forming yet
        visible = false;
    }
    else if (appearTimer <= appearTime + 25 * 3)
    {
        // forming
        image_index = 2 + (appearTimer - appearTime - 1) div 25;
        visible = true;
        contactDamage = 6;
    }
    else if (!ground)
    {
        // falling
        grav = 0.25 * image_yscale;
        image_index = 0;
        isSolid = 0;
        blockCollision = true;
    }
    else
    {
        // landed
        grav = 0;
        gravDir = image_yscale;
        image_index = 1;

        // landing sound
        if (ycoll != 0)
            playSFX(sfxChillBreak);

        depth = y / room_height + 8;

        // become solid once mega man leaves
        // (possible concern for co-op?)

        if (!isSolid)
        {
            isSolid = 2;
        }
        if (!place_meeting(x, y, objMegaman))
        {
            isSolid = 1;
        }
    }

    // crush enemies
    if (grav != 0)
    {
        with (prtEntity)
        {
            if (object_index != objMegaman && object_get_parent(object_index) != prtPlayerProjectile)
            {
                if (canHit && !dead)
                {
                    if (place_meeting(x, y, other))
                    {
                        event_user(EV_DEATH);
                        playSFX(sfxEnemyHit);
                    }
                }
            }
        }
    }
}
#define Other_25
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();

isSolid = false;
appearTimer = 0;
contactDamage = 0;
grav = 0;
blockCollision = false;
visible = false;
