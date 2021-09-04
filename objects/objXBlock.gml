#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();

canHit = false;
bubbleTimer = -1;

isSolid = 1;

pushList[0] = objSlashClaw;
pushList[1] = objBreakDash;

// super arm interaction
category = "superArmTarget";
superArmFlashTimer = 0;
superArmFlashOwner = noone;
superArmFlashInterval = 1;
superArmHoldOwner = noone;
superArmDeathOnDrop = false;
superArmThrown = false;
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if (!ground && !superArmThrown)
{
    xspeed = 0;
}

event_inherited();

if (entityCanStep())
{
    // super arm interaction
    if (superArmThrown)
    {
        if (!checkSolid(x, y))
        {
            blockCollision = true;
            if (yspeed > 0)
            {
                isSolid = true;
            }
        }
        if (ground)
        {
            grav = 0.25;

            // bounce :)
            if (abs(yspeed) > 2)
            {
                yspeed = -1.5;
            }
            else
            {
                xspeed *= 0.65;
                isSolid = true;
                blockCollision = true;
                superArmThrown = false;
            }
        }
        exit;
    }

    xspeed = decreaseMagnitude(xspeed, 0.1);

    for (i = 0; i < array_length_1d(pushList); i += 1)
    {
        if (place_meeting(x, y, pushList[i]) && xspeed == 0)
        {
            var obj = instance_place(x, y, pushList[i]);
            xspeed = 1.5 * obj.image_xscale;
            playSFX(sfxEnemyHit);
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
if (superArmFlashTimer mod (2 * superArmFlashInterval) >= superArmFlashInterval || superArmHoldOwner != noone || superArmThrown)
{
    draw_set_blend_mode(bm_add);
    draw_sprite(sprite_index, image_index, round(x), round(y));
    draw_set_blend_mode(bm_normal);
    draw_set_alpha(1);
}
