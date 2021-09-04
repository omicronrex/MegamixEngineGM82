#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
// Creation code (all optional):

event_inherited();

contactDamage = 4;
respawn = false;
stopOnFlash = false;

grav = 0.25;
blockCollision = 1;

facePlayerOnSpawn = true;
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();

if (entityCanStep())
{
    if (yspeed == 0)
    {
        instance_create(spriteGetXCenter(), spriteGetYCenter(), objExplosion);
        instance_destroy();
    }
}
