#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
// These can only be destroyed by objBokazurahBall

event_inherited();

isSolid = 1;

grav = 0;
blockCollision = 1;
canHit = false;
bubbleTimer = -1;

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

if (entityCanStep())
{
    if (collision_rectangle(x, y, x + sprite_width, y + sprite_height,
        objBokazurahBall, false, true))
    {
        with (collision_rectangle(x, y, x + sprite_width, y + sprite_height,
            objBokazurahBall, false, true))
        {
            if (!dead)
            {
                instance_create(x, y, objExplosion);
                dead = 1;
                with (other)
                {
                    instance_create(x + 8, y + 8, objExplosion);
                    instance_destroy();
                }
            }
        }
    }
}
#define Draw_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();

// super arm flash
if (superArmFlashTimer mod (2 * superArmFlashInterval) >= superArmFlashInterval || superArmThrown || superArmHoldOwner != noone)
{
    draw_set_blend_mode(bm_add);
    drawSelf();
    draw_set_blend_mode(bm_normal);
    draw_set_alpha(1);
}
