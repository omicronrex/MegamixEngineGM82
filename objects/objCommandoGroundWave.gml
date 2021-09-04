#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();
contactDamage = 5;
canHit = false;
stopOnFlash = false;
image_speed = 0.5;
playSFX(sfxCommandoBombExplode); // Placeholder until accurate sound is found
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();
if (entityCanStep())
{
    if (image_index == 2)
    {
        if (!positionCollision(x + 9 * image_xscale, y))
        {
            var i; i = instance_create(x + 9 * image_xscale, y, objCommandoGroundWave);
            i.image_xscale = image_xscale;
        }
        else
        {
            if (audio_is_playing(sfxCommandoBombExplode)) // Placeholder sound
            {
                audio_stop_sound(sfxCommandoBombExplode);
            }
            playSFX(sfxCommandoWaveEnd);
        }
    }
    else if ((image_index > 3) || (xcoll != 0))
    {
        instance_destroy();
    }
}
