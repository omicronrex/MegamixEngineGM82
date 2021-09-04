#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
/// A cannon that aims gradually based on megaman's position, it shoots in fixed directions
// It can be placed on ceilings if image_yscale is -1(if gravity points down)

// Note: the rest is in objNewClassicalCannon
event_inherited();
old = true;

greenSprite = sprClassicalCannon;
blueSprite = sprClassicalCannonBlue;
yellowSprite = sprClassicalCannonYellow;
redSprite = sprClassicalCannonRed;
