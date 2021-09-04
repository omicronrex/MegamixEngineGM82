#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
/// This object will start looking for minibosses/bosses after a delay, once it detects none it will destroy itself
// and the solids underneath it

event_inherited();

//@cc is solid?
isSolid = true;

//@cc how long until it starts looking for minibosses/bosses
delay = 32;

active = 1;

faction = 6;

contactDamage = 0;
canHit = false;

respawnRange = -1;
despawnRange = -1;

inWater = -1;

grav = 0;
blockCollision = 0;
dieToSpikes = 0;

fnsolid = 1;
if(place_meeting(x,y,objSpike))
{
    isSolid=0;
}
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();

if (!global.frozen && !instance_exists(objSectionSwitcher))
{
    var bossThere; bossThere = 0;

    if (instance_exists(prtBoss) || instance_exists(prtMiniBoss))
    {
        bossThere = 1;
    }

    if (active)
    {
        if (bossThere)
        {
            delay = 24;
        }
        else if (insideView())
        {
            delay -= 1;
            if (!delay)
            {
                event_user(0);
            }
        }
    }
}
#define Other_10
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
for (i = 0; i < image_xscale; i += 1) // X
{
    for (j = 0; j < image_yscale; j += 1) // Y
    {
        if (tile_layer_find(1000000, x + i * 16, y + j * 16))
        {
            tile_layer_delete_at(1000000, x + i * 16, y + j * 16);
            instance_create(x + 8 + i * 16, y + 8 + j * 16, objExplosion);
        }
        var sld; sld = collision_rectangle(bbox_left + 8, bbox_top + 8, bbox_right - 8,
            bbox_bottom - 8, objSolid, 1, 1);
        while (sld!=noone) // Now delete it
        {
            with (sld)
            {
                if (image_xscale > 1 || image_yscale > 1)
                {
                    splitSolid();
                }
                else
                {
                    instance_destroy();
                }
            }
            sld = collision_rectangle(bbox_left + 8, bbox_top + 8, bbox_right - 8,
            bbox_bottom - 8, objSolid, 1, 1);
        }
        var bd; bd = collision_rectangle(bbox_left + 8, bbox_top + 8, bbox_right - 8,
            bbox_bottom - 8, prtBossDoor, 1, 1);
        while (bd!=noone) // Now delete the boss door
        {
            with (bd)
            {
                instance_destroy();
            }
            bd = collision_rectangle(bbox_left + 8, bbox_top + 8, bbox_right - 8,
            bbox_bottom - 8, prtBossDoor, 1, 1);
        }
    }
}

instance_destroy();
