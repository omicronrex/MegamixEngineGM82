#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
/// A simple destructible block
event_inherited();

isSolid = 1;

grav = 0;
blockCollision = 1;
bubbleTimer = -1;

healthpoints = 1;
healthpointsStart = healthpoints;
contactDamage = 0;

shiftVisible = 1;

// super arm interaction
category = "superArmTarget";
superArmFlashTimer = 0;
superArmFlashInterval = 1;
superArmFlashOwner = noone;
superArmHoldOwner = noone;
superArmDeathOnDrop = true;
superArmThrown = false;
#define Other_20
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
dead = 1;

instance_create(spriteGetXCenter(), spriteGetYCenter(), objExplosion);
#define Other_21
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if (other.penetrate < 2 && other.pierces < 2 && other.object_index != objBusterShotCharged)
{
    other.penetrate = 0;
    other.pierces = 0;
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
