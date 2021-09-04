#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
/// Gimmick from Napalm Man's stage in Mega Man IV. When objFusePlatformStarter explodes,
// it'll start a chain reaction that destroys the fuse platforms according to how you
// place the direction changers.

// It's literally the same thing as the Petit Snakey pillars.

// If you place this in a chain, the chain will adopt this platform's current settings.

event_inherited();

sprite_index = sprFusePlatform;

// @cc the amount of frames until this explodes, starting the chain reaction
timeUntilDeath = 30;

// @cc the interval in frames that the chain reaction destroys blocks
alarmTimeMax = 7;

// @cc the starting direction of the chain reaction
startDir = 'down';
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();

if (entityCanStep())
{
    if (timeUntilDeath >= 0)
    {
        timeUntilDeath-=1;

        // tick down to death
        if (timeUntilDeath == 0)
        {
            a = instance_create(x, y, objFusePlatformDeleter);
            a.dir = startDir;
            a.alarmTimeMax = alarmTimeMax;
        }
    }
}
