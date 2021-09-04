#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();
canHit = false;

blockCollision = 0;
grav = 0;

// how much of a heads up to give
warningTime = 45;

blinkTimer = 0;
despawnRange = -1;
respawnRange = -1;
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();

if (entityCanStep())
{
    // blink
    visible = ((blinkTimer) mod 20 > 5);blinkTimer+=1

    // sign
    prev_index = image_index;
    image_index = 2;

    var checkX; checkX = x + 8;

    // adjacent signs join together
    if (place_meeting(x - 16, y, object_index))
        checkX -= 8;
    if (place_meeting(x + 16, y, object_index))
        checkX += 8;

    with (instance_nearest(x + 8, y, objNitroTruck))
    {
        if (!dead && slowdeath_timer == 0 && spd > 0)
            if (image_xscale * x < image_xscale * checkX)
                if (abs(x - checkX) / spd < other.warningTime)
                    other.image_index = image_xscale == 1;
    }

    if (prev_index != image_index)
        blinkTimer = 0;
}
