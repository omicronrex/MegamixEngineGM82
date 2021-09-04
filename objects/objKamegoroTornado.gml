#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();

contactDamage = 0;
canHit = false;

respawn = false;
grav = 0;
isSolid = 0;
spd = 1;

attackTimer = 0;
parentID = noone;
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();
if (!global.frozen && !dead && !global.timeStopped)
{
    image_index += 0.35;
    bubbleTimer = 0;
    attackTimer += 1;
    if (sprite_index == sprKamegoroTornado)
    {
        yspeed = spd * (image_yscale);
        if (instance_exists(parentID))
            x = parentID.x + 8;
        with (instance_place(x, y + yspeed * 2, objMegaman))
        {
            if (place_meeting(x, y + other.yspeed * 2, objSolid) || other.isSolid == 0)
            {
                other.isSolid = 0;
                other.attackTimer = 0;
                if (!place_meeting(x, other.y - 32, objSolid) && !place_meeting(x, y - 16, objKamegoroTornadoMakerH))
                {
                    while (place_meeting(x, y + 4, other))
                        y -= 1;
                }
                else if (!place_meeting(x, other.y + 32, objSolid) && !place_meeting(x, y + 16, objKamegoroTornadoMakerH))
                {
                    while (place_meeting(x, y - 1, other))
                        y += 1;
                }
                else if (!place_meeting(x - 16, y, objSolid) && !place_meeting(x - 16, y, objKamegoroTornadoMakerH))
                {
                    while (place_meeting(x, y, other))
                        x -= 1;
                }
                else if (!place_meeting(x + 16, y, objSolid) && !place_meeting(x + 16, y, objKamegoroTornadoMakerH))
                {
                    while (place_meeting(x, y, other))
                        x += 1;
                }
            }
        }
        if (ycoll != 0)
            instance_destroy();
    }
    else
    {
        xspeed = spd * image_xscale;
        if (instance_exists(parentID))
            y = parentID.y + 8;
        with (instance_place(x + xspeed * 2, y, objMegaman))
        {
            if (place_meeting(x + other.xspeed * 2, y, objSolid) || other.isSolid == 0)
            {
                other.isSolid = 0;
                other.attackTimer = 0;
                if (!place_meeting(x, y - 16, objSolid))
                {
                    while (place_meeting(x, y, other))
                        y -= 1;
                }
                else if (!place_meeting(x, y + 16, objSolid))
                {
                    while (place_meeting(x, y, other))
                        y += 1;
                }
            }
        }
        if (xcoll != 0)
            instance_destroy();
    }
    if (!place_meeting(x + 24 * xspeed, y + 24 * yspeed, objWater))
        instance_destroy();
    if (!place_meeting(x, y, objMegaman) && attackTimer >= 1)
        isSolid = 1;
}
