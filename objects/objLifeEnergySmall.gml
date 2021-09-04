#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();

image_speed = 1 / 6;
hlth = 2;

respawnupondeath = 1;
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();

if (global.pickupGraphics)
{
    sprite_index = sprLifeEnergySmallMM1;
}
else
{
    sprite_index = sprLifeEnergySmall;
}
