#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();

respawn = false;

healthpointsStart = 1;
healthpoints = healthpointsStart;

contactDamage = 2;

grav = 0;
blockCollision = 0;
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();

if (entityCanStep())
{
    if (collision_line(bbox_left, bboxGetYCenter(), bbox_right,
        bboxGetYCenter(), objSolid, false, false))
    {
        instance_create(x, y, objExplosion);
        playSFX(sfxExplosion);
        instance_destroy();
    }
}
