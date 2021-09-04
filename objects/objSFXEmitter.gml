#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
//@cc the sound effect to play
sfx = noone;

//@cc the interval between playing the sound.
//@cc if -1, then loop.
//@cc if 0, play once (reset off-screen)
interval = -1;

timer = 0;
play = false;
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if (sfx != noone)
{
    play = insideSection(x + 8, y + 8) && insideView();

    // positive interval: play periodically
    if (!global.frozen && interval > 0)
    {
        timer++;
        if (timer >= interval && play)
        {
            playSFX(sfx);
            timer = 0;
        }
        if (!play)
        {
            timer = 0;
        }
    }

    // 0 interval: play once
    if (!global.frozen && interval == 0)
    {
        if (!play)
        {
            timer = -1;
        }
        else if (timer == 0)
        {
            playSFX(sfx);
            timer = -1;
        }
    }

    // -1 interval: loop
    if (interval == -1)
    {
        play &= !global.frozen;
        if (play)
        {
            if (!audio_is_playing(sfx))
            {
                loopSFX(sfx);
            }
        }
        else
        {
            // don't stop if another emitter is playing it
            var skipStop = false;
            with (object_index)
            {
                if (play && id != other.id && sfx == other.sfx)
                    skipStop = true;
            }

            // stop sfx
            if (!skipStop)
            {
                stopSFX(sfx);
            }
        }
    }
}
