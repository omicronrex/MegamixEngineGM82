#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
//@cc the path of the music file inside the music folder
fileName = "Showcase.ogg";

//@cc "OGG" for ogg files, "VGM" for raw audio
musicType = "OGG";

//@cc VGM
trackNumber = 0;

//@cc OGG
loopPoint = 0;
songLength = 1;
songVolume = 1;
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
// Change music
if (place_meeting(x, y, objMegaman))
{
    if (fileName == "")
    {
        stopMusic();
    }
    else
    {
        if (global.levelSong != fileName || (musicType == "VGM" && trackNumber != global.levelTrackNumber))
        {
            playMusic(fileName, musicType, trackNumber, loopPoint, songLength, true, songVolume);
        }
    }
}
