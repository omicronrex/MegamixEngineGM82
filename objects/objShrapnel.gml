#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();

respawn = 0;
contactDamage = 1;
itemDrop = -1;
iFrames = -1;
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();

if (!global.frozen && !global.timeStopped)
{
    if (xcoll != 0 || ycoll != 0)
    {
        instance_create(x, y, objHarmfulExplosion);
        playSFX(sfxClassicExplosion);

        event_user(10);
    }
}
