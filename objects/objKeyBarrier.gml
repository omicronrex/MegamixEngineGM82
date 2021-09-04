#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();

/// A key barrier, it needs a key to open.

contactDamage = 0;
canHit = false;

isSolid = 1;

beingKilled = false;
killTimer = 0;

respawnRange = -1;
despawnRange = -1;

norespawn = 0;
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();

if (!global.frozen && visible)
{
    with (objMegaman)
    {
        if (global.keyNumber > 0)
        {
            with (other)
            {
                if (!beingKilled)
                {
                    if (collision_rectangle(bbox_left - 3, bbox_top,
                        bbox_right + 3, bbox_bottom, other.id, false, true))
                    {
                        playSFX(sfxWheelCutter2);
                        global.keyNumber -= 1;
                        beingKilled = true;
                        respawn = false;
                        if (norespawn)
                        {
                            with (objGlobalControl)
                            {
                                ds_list_add(pickups,
                                    string(room) + '/' + string(other.id));
                            }
                        }
                    }
                }
            }
        }
    }

    if (beingKilled)
    {
        killTimer += 1;
    }
    if (killTimer == 6 || killTimer == 12 || killTimer == 18 || killTimer == 24)
    {
        image_index += 1;
    }
    if (killTimer == 32)
    {
        instance_create(bboxGetXCenter(), bboxGetYCenter(), objExplosion);
        playSFX(sfxEnemyHit);
        instance_destroy();
    }
}
