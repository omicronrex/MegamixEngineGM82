#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();

myParent = noone;
init = 0;

contactDamage = 1;

penetrate = 3;
pierces = 2;

image_speed = 0.3;

playSFX(sfxExplosion2);
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();

if (init == 0)
{
    if (instance_exists(myParent))
    {
        contactDamage = myParent.contactDamage;
    }
    init = 1;
}
#define Other_7
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
instance_destroy();
#define Other_17
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
/// Ricocheting explosions?? Whose idea was this?!
