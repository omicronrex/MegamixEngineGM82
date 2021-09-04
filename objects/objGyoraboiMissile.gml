#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();

contactDamage = 2;

blockCollision = 0;
grav = 0;

// enemy specific
xspeed = 0;
yspeed = -2;

canCollide = 0;
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();

if (!global.frozen && !global.timeStopped)
{
    if (canCollide)
    {
        if (collision_line(bbox_left, bboxGetYCenter(), bbox_right,
            bboxGetYCenter(), objSolid, false, false))
        {
            instance_destroy();
            explosion = instance_create(x, y, objHarmfulExplosion);
            explosion.contactDamage = 4;
            playSFX(sfxMM3Explode);
        }
    }
    else
    {
        if (!checkSolid(0, 0, 1, 1))
        {
            canCollide = 1;
        }
    }
}
