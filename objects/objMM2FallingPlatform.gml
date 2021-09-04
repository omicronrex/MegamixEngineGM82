#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();
canHit = false;

isSolid = 2;

grav = 0;
blockCollision = 0;
bubbleTimer = -1;

timer = 0;
droptimer = 16;
dir = 0;

// super arm interaction
category = "superArmTarget";
superArmFlashTimer = 0;
superArmFlashInterval = 1;
superArmFlashOwner = noone;
superArmHoldOwner = noone;
superArmDeathOnDrop = true;
superArmThrown = false;
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();

if (!global.frozen && !dead && !global.timeStopped)
{
    if (timer >= droptimer)
    {
        grav = 0.25 * dir;
    }
    else
    {
        ontop = 0;
        with (target)
        {
            if (ground)
            {
                if (place_meeting(x, y + gravDir, other.id)
                    && !place_meeting(x, y, other.id))
                {
                    other.timer += 1;
                    other.dir = gravDir;
                    other.ontop = 1;
                }
            }
        }
        if (!ontop)
        {
            timer = 0;
        }
    }
}
else if (dead)
{
    grav = 0;
    timer = 0;
}
#define Draw_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();

// super arm flash
if (superArmFlashTimer mod (2 * superArmFlashInterval) >= superArmFlashInterval || superArmHoldOwner != noone || superArmThrown)
{
    draw_set_blend_mode(bm_add);
    draw_sprite(sprite_index, image_index, round(x), round(y));
    draw_set_blend_mode(bm_normal);
    draw_set_alpha(1);
}
