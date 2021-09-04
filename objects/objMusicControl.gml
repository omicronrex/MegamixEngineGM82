#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
// FMOD Init
LoadFMOD();
FMODInit(5, false); // If you somehow have over 200 pieces of music, increase this number
global.tempSongData = -1;
global.songMemory = -1;

// GME Init

// It seems that when sending a pointer to a dll, only one argument can be defined,
// any other arguments won't work.

// Instance variables
snd_queue = noone;
buffer_gme = noone;
buffer_gme_address = 0;
buffer_gme_size = 0;
playing = false;
endReached = true;
track_number = -1;
forceReset = false;

// Buffer size in the dll is 2048 16-bit values (2 bytes per value)
// so the gms buffers need to be 4096 bytes big.
buffer_size = 1520; // 16384;

// The number of audio buffers (five buffers will be a total of 5*2048B = 10240B ~ 10KB
buffer_count = 7; // 3;

// Buffer index is used to keep track of current buffer to fill / add to queue
buffer_index = 0;

// Sample rate is hardcoded to 44100 in the dll
sample_rate = 44100;

// Create the audio buffers
for (var i = 0; i < buffer_count; i++)
{
    buf[i] = buffer_create(buffer_size, buffer_fixed, 2);
    bufPointer[i] = string(buffer_get_address(buf[i]));
    buffer_fill(buf[i], 0, buffer_u8, 0, buffer_size);
}

sound_index = noone;
trackNumber = -1;

// misc
global.levelSong = "";
global.levelSongType = "OGG";
global.levelTrackNumber = 0;

global.levelLoopStart = 0;
global.levelLoopEnd = 1;

global.levelLoop = 1;
global.levelVolume = 1;
global.songMemory = -1;

// Music volume
audio_sound_gain(sound_index, global.levelVolume * (global.musicvolume * 0.01), 0);
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
/// GME step

// The following is a check to refill audio buffers
// if playing has stopped unexpectedly from moving window etc.
if (playing && !endReached && !audio_is_playing(snd_queue))
{
    // Fill all the audio buffers with song data and add to queue
    for (var i = 0; i < buffer_count; i++)
    {
        endReached = !GameMusicEmu_Read(bufPointer[i]);
        audio_queue_sound(snd_queue, buf[i], 0, buffer_size);
        if (endReached)
        {
            break;
        }
    }

    // Play the queue
    audio_play_sound(snd_queue, 10, false);
    buffer_index = 0;

    // the GME extension got a glitch in a Game Maker Studio update that made
    // songs start a bit into the track instead of at the beginning. This is
    // a workaround for that
    if (forceReset)
    {
        // unmute after being muted in playMusic()
        for (v = 0; v <= song_voices; v++)
        {
            GME_MuteVoice(v, false);
        }

        GME_SetPosition(0);

        forceReset = false;
    }
}
#define Step_2
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
/// FMOD update
FMODUpdate();
#define Other_3
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
/// Unload possible file
if (buffer_gme != noone)
{
    GameMusicEmu_Free();
    buffer_delete(buffer_gme);
}
#define Other_5
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
/// Stop all audio
audio_stop_all();
#define Other_74
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
// Fill an audio buffer and add it to the queue

if (playing && !endReached)
{
    // Fill the buffer with audio data
    endReached = !GameMusicEmu_Read(bufPointer[buffer_index]);

    // Add the buffer to the queue
    audio_queue_sound(snd_queue, buf[buffer_index], 0, buffer_size);

    // Increase the buffer index and wrap to zero if last buffer has been queued
    buffer_index++;
    if (buffer_index >= buffer_count)
    {
        buffer_index = 0;
    }
}
