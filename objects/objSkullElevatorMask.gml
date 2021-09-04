#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
// general-purpose moving platform

event_inherited();

canHit = false;
isSolid = 1;
blockCollision = 0;
grav = 0;
bubbleTimer = -1;

despawnRange = -1;
respawnRange = -1;

parent = -1;
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();

if (instance_exists(parent))
{
    if (entityCanStep() || parent.active)
    {
        isSolid = !(global.flag[parent.myFlag] == 0);

        // move up
        with (parent)
        {
            if (global.flag[myFlag] > 0 && global.flag[myFlag] < 1)
            {
                if (global.flagParent[myFlag].active)
                {
                    other.yspeed = -0.5;
                }
                else
                {
                    other.yspeed = 0.5;
                }
            }
            else
            {
                other.yspeed = 0;
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
if (!global.frozen)
{
    draw_sprite_part_ext(parent.sprite_index, 1, 0, 0, 52,
        sprite_height * global.flag[parent.myFlag],
        round(x) - sprite_xoffset, round(y) - sprite_yoffset - (3 * global.flag[parent.myFlag] <= .93), image_xscale, image_yscale, image_blend, image_alpha);
}
