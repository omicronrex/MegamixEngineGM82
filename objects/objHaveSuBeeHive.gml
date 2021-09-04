#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();

contactDamage = 2;

reflectable = 0;
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();

if (!global.frozen && !global.timeStopped)
{
    if (ycoll != 0)
    {
        explosion = instance_create(x, y, objHarmfulExplosion);
        explosion.contactDamage = 2;
        playSFX(sfxMM3Explode);

        d = 15;
        chibee = instance_create(x - d, y - d, objChibee);
        chibee.respawn = false;
        chibee = instance_create(x + d, y - d, objChibee);
        chibee.respawn = false;
        chibee = instance_create(x, y, objChibee);
        chibee.respawn = false;
        chibee = instance_create(x - d, y + d, objChibee);
        chibee.respawn = false;
        chibee = instance_create(x + d, y + d, objChibee);
        chibee.respawn = false;

        instance_destroy();
    }
}
