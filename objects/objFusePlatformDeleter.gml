#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();

healthpoints = 1;
healthpointsStart = healthpoints;

blockCollision = 0;
grav = 0;
contactDamage = 0;

alarmTime = -1;
inWater = -1;

respawnRange = 90000; // set to -1 to make infinite
despawnRange = -1; // set to -1 to make infinite
respawn = false;

dir = 'down';
alarmTimeMax = 7;
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();

canHit = false;
visible = 0;

if (entityCanStep())
{
    alarmTime += 1;

    if (alarmTime == alarmTimeMax)
    {
        if (place_meeting(x, y, objFusePlatformLeft))
        {
            dir = 'left';
        }
        if (place_meeting(x, y, objFusePlatformRight))
        {
            dir = 'right';
        }
        if (place_meeting(x, y, objFusePlatformUp))
        {
            dir = 'up';
        }
        if (place_meeting(x, y, objFusePlatformDown))
        {
            dir = 'down';
        }

        // wowie! settings changer!
        if (place_meeting(x, y, objFusePlatformStarter))
        {
            dir = instance_place(x, y, objFusePlatformStarter).startDir;
            alarmTimeMax = instance_place(x, y, objFusePlatformStarter).alarmTimeMax;
        }

        myfuse = instance_position(x + 8, y + 8, objFusePlatform);
        if (myfuse)
        {
            with (myfuse)
            {
                if (visible && !dead)
                {
                    playSFX(sfxExplosion);
                    event_user(EV_DEATH);
                }
            }
        }
        else
        {
            instance_destroy();
            exit;
        }

        // Move
        switch (dir)
        {
            case 'right':
                x += 16;
                break;
            case 'left':
                x -= 16;
                break;
            case 'up':
                y -= 16;
                break;
            case 'down':
                y += 16;
                break;
        }

        alarmTime = 0;
        if (!insideSection(x + 8, y + 8))
        {
            instance_destroy();
        }
    }
}
#define Other_21
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
other.guardCancel = 2;
