#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
gmeCreate()

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
sound_kind_volume(1, global.levelVolume * (global.musicvolume * 0.01));

sound_index=noone
#define Other_5
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
/// Stop all audio
audio_stop_all();
