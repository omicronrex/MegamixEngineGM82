#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
/// This big fish makes Shrinks from his mouth, he can only be hit on his lantern.
event_inherited();

respawn = true;

healthpointsStart = 10;
healthpoints = healthpointsStart;
contactDamage = 12;
lockTransition = false;
category = "aquatic";

doesIntro = false;

image_speed = 0.15; // STOP USING THIS VARIABLE

alarmFish = 60;
deadTimer = 0;
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();

if (entityCanStep())
{
    image_speed = 0.15;
    if (alarmFish > 0)
    {
        alarmFish -= 1;
    }
    if (alarmFish == 0 && instance_number(objShrink) < 2)
    {
        alarmFish = 60;
        a = instance_create(x + (15 * image_xscale), y - 10, objShrink);
        a.respawn = false;
    }
    if (image_index >= 4)
    {
        image_index = 0;
    }
}
else
{
    image_speed = 0;
    if (dead)
    {
        image_index = 4;
    }
}
#define Other_21
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if (bboxGetYCenterObject(other.id) > y - 65)
{
    other.guardCancel = 3;
}
#define Other_25
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
/// On Spawm
alarmFish = 60;
