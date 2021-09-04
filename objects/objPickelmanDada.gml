#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
/// A modded version of Pickelman bull, appearing in MMIII. Works nearly identically, just with slightly different movement.
event_inherited();

healthpointsStart = 7;
healthpoints = healthpointsStart;
contactDamage = 6;

category = "shielded, rocky";

facePlayerOnSpawn = true;

// Enemy specific code
image_speed = 0.3;

alarmMove = 1;
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();

if (entityCanStep())
{
    xSpeedTurnaround();

    // turn around on ledges
    if (checkFall(24 * image_xscale))
    {
        image_xscale *= -1;
        xspeed = .7 * image_xscale;
    }

    alarmMove -= 1;
    if (alarmMove == 45)
    {
        xspeed = 0;
        shake = 1;
    }
    if (alarmMove == 0)
    {
        alarmMove = choose(75, 95);
        xspeed = .7 * image_xscale;
    }

    // obnoxious stomping noises!
    if (!audio_is_playing(sfxPowerStomp))
    {
        playSFX(sfxPowerStomp);
    }
}
else if (dead)
{
    alarmMove = 1; // move on spawn
}
#define Other_21
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if (bboxGetYCenterObject(other.id) <= y - 38)
{
    exit;
}
else
{
    other.guardCancel = 1;
}
