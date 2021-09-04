#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
// Creation code (all optional):
// col = <number>. color. 0 = yellow, 1 = pink

event_inherited();

image_speed = 0;
imgSpeed = 0;
sp = 1.5;

// animation override
animTimer = 0;
imgOffset = 0;

dir = 1;

if (image_xscale == -1 || image_yscale == -1)
{
    dir = sign(dir * image_xscale * image_yscale);
}
col = 0;
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();

if (entityCanStep())
{
    // manual animation
    animTimer++;

    if (animTimer == 2)
    {
        animTimer = 0;
        imgOffset += 1;
    }

    // reset anim
    if (imgOffset > 7)
    {
        imgOffset = 0;
    }
}

image_index = imgOffset + (col * 8);
#define Other_21
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
// only tolerate these weapons
if (global.damage == 0)
{
    other.guardCancel = 3;
}
#define Other_23
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
// Set all weapons (objects?) to do no damage
global.damage = 0;

specialDamageValue(objTornadoBlow, 4);
specialDamageValue(objBlackHoleBomb, 4);
specialDamageValue(objJewelSatellite, 4);
