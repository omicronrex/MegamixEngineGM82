#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();
contactDamage = 0;
stopOnFlash = false;
image_speed = 0;
image_index = irandom(2);
xspeed = 1.5 - irandom(3);
yspeed = 1 + irandom(2);
blockCollision = false;
ground = false;
delay = 24;
playSFX(sfxGutsQuake);
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();
if (global.frozen == false)
{
    if (delay > 0)
        delay -= 1;
    if (!instance_place(x, y, objSolid) && !blockCollision && delay == 0)
        blockCollision = true;
    if (ground)
    {
        instance_create(x, y, objExplosion);
        instance_destroy();
    }
}
