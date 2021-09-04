#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();
respawn = false;
stopOnFlash = false;
calibrateDirection();
healthpointsStart = 1;
healthpoints = healthpointsStart;
contactDamage = 4;
destroyTimer = 250;
itemDrop = -1;
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();
if (entityCanStep())
{
    image_index += 0.24;
    if (destroyTimer > 0)
        destroyTimer -= 1;
    else
        event_user(EV_DEATH);
}
#define Other_20
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
dead = 1;
visible = 0;
instance_create(bboxGetXCenter(), bboxGetYCenter(), objHarmfulExplosion);
playSFX(sfxBalladeCrackerExplosion);
#define Draw_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if (destroyTimer > 32 || destroyTimer <= 32 && destroyTimer mod 2 == 0)
    event_inherited();
