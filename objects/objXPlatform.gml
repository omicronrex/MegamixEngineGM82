#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();
canHit = false;

isSolid = 1;
blockCollision=false;

respawnRange = -1;
despawnRange = -1;
bubbleTimer = -1;

grav = 0;
moved = false;
partner = noone;
with (object_index)
{
    if (id != other.id)
    {
        if (floor(y / 224) == floor(other.y / 224))
        {
            if (abs(other.x - x) < 128)
            {
                other.partner = id;
                break;
            }
        }
    }
}

alarm[0] = 1;

manualPartnerX = noone;
manualPartnerY = noone;

ontop = 0;
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();
/*if (entityCanStep())
{
    if (yspeed != 0)
    {
        image_index += 0.25;
    }
    else
    {
        image_index = 0;
    }
}
#define Step_1
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();
if (entityCanStep())
{
    if (manualPartnerX != noone && manualPartnerY != noone)
    {
        myPartner = instance_place(manualPartnerX, manualPartnerY, object_index);
        partner = myPartner.id;
        myPartner.partner = id;
        manualPartnerX = noone;
        manualPartnerY = noone;
    }

    moved = false;
    with (target)
    {
        if (ground)
        {
            if (place_meeting(x, y + gravDir - other.yspeed, other.id))
            {
                other.yspeed = 0.35 * gravDir;
                other.moved = true;
                other.image_index += 0.25;
            }
        }
    }
    if (moved)
    {
        with (partner)
        {
            if (!moved)
            {
                yspeed = -other.yspeed;
                image_index += 0.25;
            }
            else
            {
                other.moved = false;
                moved = false;
                other.yspeed = 0;
                yspeed = 0;
            }
        }
    }
    else
    {
        var stop; stop = true;
        with (partner)
        {
            if (moved)
                stop = false;
        }
        if (stop)
        {
            yspeed = 0;
            image_index = 0;
            with (partner)
            {
                yspeed = 0;
                image_index = 0;
            }
        }
    }
    if (yspeed != 0)
    {
        if (place_meeting(x, y + yspeed * 2, objXPlatformStop) || ground)
        {
            yspeed = 0;
            with (partner)
            {
                yspeed = 0;
            }
            moved = false;
        }
    }
}
