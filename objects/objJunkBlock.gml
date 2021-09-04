#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();

shiftVisible = 1;

healthpoints = 3;
healthpointsStart = healthpoints;
contactDamage = 3;

despawnRange = -1;
respawnRange = -1;

faction = 4;

pierces = 0;
penetrate = 2;
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

isSolid = ground;

if (superArmHoldOwner != noone)
{
    contactDamage = 0;
    isSolid = 0;
}
#define Other_20
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
dead = 1;

instance_create(spriteGetXCenter(), spriteGetYCenter(), objExplosion);
#define Other_25
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
/// On spawn/despawn
event_inherited();

if (spawned)
{
    if (checkSolid(0, -8))
    {
        shiftObject(0, -8, true);
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
