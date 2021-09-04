#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();

contactDamage = 6;


yspeed = 0;
ground = false;
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
        instance_create(spriteGetXCenter(), spriteGetYCenter(),
            objExplosion);
        instance_destroy();
        playSFX(sfxExplosion);
    }
}
